Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215DBC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4CA20722
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DnDfRf/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4CA20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY7Hm-0000OS-3Z
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 08:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jY7H8-0008Mi-Su
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:11:15 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:42213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jY7H6-0008GG-Hn
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:11:14 -0400
Received: by mail-lj1-x243.google.com with SMTP id d21so1509101ljg.9
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GdNuiku3XquO8gSrCKqyMbKztJL0QytnUlyWT6raGI0=;
 b=DnDfRf/vMPCqAltmE3l0StzDqo+yu6gnBYyKE4Xb3rMdYKd9TG1+A21OSqa3esRiat
 eN4YBU4qOvjSVBCjkDtincmxTTPfGUdVIab8vqfi04MWVtVsYMUZuhkjIhxoCpAnn4Wj
 I6sHV4oajta5cXI3KYq5H7kdm1hDJWV8KO9bxdXZHyhUwos6sgoW1e/tw3iIVYyjAcVG
 PK/ZC/24y0/0Co96pXocPVhC+aPrBdFaeREdaDoEkPvMuCvk+myABY6eFjlSF2fgzXrX
 Zi7YgEYQGpCwYESCGEEDDAeqlLSLhYxtSJUmLEpBvSkXu6dsScFnGjC/YGt4hp07W1z4
 g2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GdNuiku3XquO8gSrCKqyMbKztJL0QytnUlyWT6raGI0=;
 b=IzRE2F4HTsIfixZlngCefGXdvYNElKALalQg2GmoNvj6EGhYMvLfyjj5QkdxdWTyOn
 wK2XENQi0pX9js1o+ZRyRoBcJ0j6IbovHpCu9ajGydZzhLyptQCo3EKQNe/WdBTnfVLk
 jBmJfaFAY1QvG2K1b6E9b4gRgH/D1z9YoOUlZkEu4PTwD8XeZyItQ1XzrMe6A2S34RJI
 kNMLTIrgtydkOvf7dsc+hrMFkTG1afEaq1UHF3YzTkJpL/h7VUDR8dEmCkNVbrXNFapR
 eKy+d3TDcUOsZVNYL27zamA92pUny9NLGk6u6a0jvnLu5fuSZmdSNRf7vsOflxMCvWX5
 Tsjw==
X-Gm-Message-State: AOAM531vU4VqDfBDb85/aiu8tw3qbiONrUM624uzeh5c3zvjx9TBOU5/
 2B/xUhWIyQPLCUVoapO+LcM9QNd3Lqntai04Pde5hA==
X-Google-Smtp-Source: ABdhPJxTlB7zF424uLpDiUkKPRSYbba+k/+YtteTBuYPIjObjFYTocHkN75uCmRsUuQZod0igebMSLfen74FWQSBg4g=
X-Received: by 2002:a2e:9942:: with SMTP id r2mr281170ljj.283.1589199070461;
 Mon, 11 May 2020 05:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200312142728.12285-1-robert.foley@linaro.org>
 <87h7wmrfnm.fsf@linaro.org>
In-Reply-To: <87h7wmrfnm.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 11 May 2020 08:11:03 -0400
Message-ID: <CAEyhzFuuV1MruAK4DKgsLpZzE6bHRF8xTvhsG3iAisXWc9jKqg@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] tests/vm: Add support for aarch64 VMs
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 May 2020 at 05:21, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Robert Foley <robert.foley@linaro.org> writes:
>
> > This is version 4 of the patch series to
> > add support for aarch64 VMs in the vm-build infrastructure.
> >  - Ubuntu 18.04 aarch64 VM
> >  - CentOS 8 aarch64 VM
> Hi Robert,
>
> Sorry I didn't get to this in the run up to 4.0. I've tried applying the
> series to the current master but I ran into conflicts pretty early on. I
> think the first patch conflicts with f01454ad17 because I had already
> cherry picked some of the cleanups to gen_cloud_init_iso and then had to
> fix it up. Skipping it caused the next patch to fail to apply so I
> decided to back away from misapplying the series.
>
> Would you be able to re-spin on current master please?

Sure, I will respin.  There is a v5 out for this series from 4/30 with
some additional minor fixes, but I will update the series from the
current master with the change around removing BOOT_CONSOLE and
putting it under DEBUG=3D1.

Thanks & Regards,
-Rob

