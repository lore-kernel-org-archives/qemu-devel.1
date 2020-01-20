Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351A9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDED62073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAXGqFCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDED62073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUNN-0002pa-Gw
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itULg-0001Um-Hx
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itULf-0000GE-CB
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:32:00 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:32774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itULf-0000Fc-4W
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:31:59 -0500
Received: by mail-ot1-x332.google.com with SMTP id b18so28274890otp.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 02:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bHoyQ6QQamteaj2PV9wjHYpZO9SYiaEIkJ2iMzPdl6I=;
 b=AAXGqFCNKXcS3pVRHNKvxvPE+vc2+rRuJkVlZ3mRTgm+53hAdL6SD4Dh1MJ+0CnKDt
 Ly/XozTeaPuYeGjFEMtgPTI9kCeaiE4mby9iw04GEsFECsmNGRXsQEZxlnTdTloBm8pH
 Nd09SJGcsX9o6E3pT5dWSIRrkk/3R3KspyOvzN/BpQAx1mHOgMFRHPx/dfhq2PI8LIxW
 +i+2+quMn6/1igSDxJof0NtHs0s7p3y3wQW7EY4awHfA98d8cXKDmEQZ3zuPtxkcgeIm
 5y/IRA1sn56nNXs3dS6PfkHS1Lq92CBCQ38P8H92anuQRhqyrIDI38VvY9W7a+TIPHz8
 SqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bHoyQ6QQamteaj2PV9wjHYpZO9SYiaEIkJ2iMzPdl6I=;
 b=arTKwdloS/ZYHz+sQkJ11rBAVaDn79OJO1e+A7WS9Jm0giXgQnQxzbZiWCobFcbbpv
 nVK9mAUytmlYAHmbHnHNK1iXUPToppZa1ZldCAZv1GoKMvIq+whky7Q4iIG19cY7n0zX
 ExXOPOBUe2hr+qRLgj+tBeDEYVhHMQhWbz4fRUHBTG0RgzNZbosSzrO5YBojg7aBmNWj
 kent7+4Cq2zDmeUOI46S8Yo/J3blmCdRyjTZYRYGOQMp1wMgM37NNow6eIGXTfXUviYm
 8RO2LDM1FUgMmUJTQmNQKywC1xKFr3zQVN8yTPFgQDDywj6CCcmMdX3aZoOQPZgznz1J
 tRyw==
X-Gm-Message-State: APjAAAW0eDY8S0+ejKLGScpmUovteEQAy/Lwfay4RA4Uk9pkL0M4Lbeh
 fK9xoUkHOkttlVGM9/5P7Z4jaJga3Og6c3DTXch04w==
X-Google-Smtp-Source: APXvYqxCCnqO2YIMIZpgD8UWHUylDd7m4V7RcmI/zbAmS0ZsqitjoKSW7u7ZHrEse2O4TDT57QoUAwNUyhJRVOtuOOU=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr15694160ota.232.1579516317971; 
 Mon, 20 Jan 2020 02:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20200113103550.1133-1-alex.bennee@linaro.org>
 <2331e0b7-cad9-7b53-3d30-7fb88d692c8a@redhat.com>
 <20200115111042.GA163546@stefanha-x1.localdomain>
In-Reply-To: <20200115111042.GA163546@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jan 2020 10:31:47 +0000
Message-ID: <CAFEAcA9kVwANWnz4CDMpRYViC+7dFSZtxX6W0tH3Rvor3zYcbQ@mail.gmail.com>
Subject: Re: [qemu-web PATCH] documentation: update links to readthedocs
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jan 2020 at 11:11, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> It's good that we got ownership of the readthedocs.org account for QEMU.
> I don't know if rtd will be capable of building QEMU's hodgepodge of
> different documentation systems.  It supports Sphinx and Mkdocs but
> that's not enough.

I think that as we continue to convert to rST format we should
end up somewhere where rtd can build everything. In particular
I realised last week that by using Sphinx extensions we don't
need to have our makefiles run necessarily to generate fragments
of document to include, the way we do for texinfo today, so
it should be possible to have the whole docset built just by
invoking Sphinx directly.

thanks
-- PMM

