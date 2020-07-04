Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91813C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 09:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5516F20739
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 09:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Li0JJdwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5516F20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jreEB-0004Hm-Hu
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 05:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jreDO-0003s7-IZ
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 05:12:06 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:43031)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jreDJ-0000y4-TI
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 05:12:06 -0400
Received: by mail-oi1-x22b.google.com with SMTP id x83so20783148oif.10
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 02:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IeZkaApmAvhf0UXjKxPCyIO6mk6z5LO9BYKfGjHppqs=;
 b=Li0JJdwdaXYajzDsDpB6j1zOAeGltjpERnvi9eAnhAtviOoZzWWFCMGxfyikpvbqkr
 gNuTG0xKnpdzAWPEucDFRJ2uaEWZsO+ZJRQeDjzBbj7to5GAn/ZxSPYHYmDsGDxcZcAE
 Hvks0hM89E2Av1JoA5FkPrTPOfnw51tJCF25tTuwuWnhzLRXplBMZ7K8S/7vAzAODmeK
 KkOaG7VXtYebaMRDk/eXpRdxK4Tjv2bwB/NdwjcKzz9Jg1eJusoAm3dFokjwDuvKCdm2
 vi5oOOGuUuQSLEQ7jOX0rTCbod3iyNDkXe6zpPZStjd3N81ER/sZzBChlPQyDNLLGsrx
 7xcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IeZkaApmAvhf0UXjKxPCyIO6mk6z5LO9BYKfGjHppqs=;
 b=cgCUwSU5hu2s+C60hnqnN+3N3xeT3yXotQSpRwD4OJ8cx5pV377Ll40nZElzuMoymJ
 gaKRhuhXoFdWpfaDENfEesuuhZQJw5ddmXXAcPbsPSq1Z1H3Z98KW5UGVihjZhRqegTL
 vd6IYEii4VqOkKOUnsZIMLvJW9jhmnVM3XalExGCcAjxhC4BRXtrlKp1eTb9zJ3L2rxL
 8EMhKtxIlM6M5GA1HF1wiuQCYMKYM75OSsySamFxKm0LzUyJwNR22BPDORvpK6oLUIsk
 TwBnC/Rkn+ngJFlS99q+98l2VWOby4DXMDgh3d8WNholUuNftfjlSaKTSxa+WLbFqRJ8
 CXcw==
X-Gm-Message-State: AOAM531hfGOzSkSlnM3Ij0AXorFudEgZxwb3X4oPVbSdiuG/voxWs9nD
 lIP0HHJ56poRLj7AurKWeol2ivU8OVWaQn8rIzDlYw==
X-Google-Smtp-Source: ABdhPJxC2FzCuN5oa1M4ge8IE8SkJ0Hpa46NAq/eC5ft04kisVxZ0ARZgdxx0xhz6lHOE9qV/bsibmxHIMxn/Ef2lO8=
X-Received: by 2002:aca:2819:: with SMTP id 25mr23673163oix.48.1593853919678; 
 Sat, 04 Jul 2020 02:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200702143955.678-1-thuth@redhat.com>
 <5EFE07BC.6040407@mindspring.com>
 <1e699fdc-639e-ef8a-313f-7e665cad868c@redhat.com>
 <5EFE5291.6030300@mindspring.com>
 <975b5072-43de-da16-bf62-fc7e5a7a87f5@redhat.com>
 <5EFF5DFC.2060006@mindspring.com>
 <CAFEAcA81y59yaOCW=QONy9EKv6Fdkkwb=XGJ786-N5du2+P9NQ@mail.gmail.com>
 <5EFF7DD7.1000605@mindspring.com> <5EFFA499.7050008@mindspring.com>
 <601a18a7-d564-b9d7-7187-53a05d819551@amsat.org>
In-Reply-To: <601a18a7-d564-b9d7-7187-53a05d819551@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Jul 2020 10:11:47 +0100
Message-ID: <CAFEAcA8-ECTRrFayHYP1wnf19pn05UXwuxvWobBy9V6qUVJ9aw@mail.gmail.com>
Subject: Re: gmake in Solaris 11.4: TFR missing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Peter Tribble <peter.tribble@gmail.com>,
 Michele Denber <denber@mindspring.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 22:55, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> On 7/3/20 11:35 PM, Michele Denber wrote:
> >   What is TFR?
>
> TFR() is defined in include/qemu-common.h:

Yep; adding #include "qemu-common.h" to tap-solaris.c should fix
this (I think we missed tap-solaris.c in the header cleanup of
commit a8d2532645cf5ce4).

thanks
-- PMM

