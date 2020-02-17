Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED6DC7619F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFEB206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/1LDNQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFEB206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3dAv-0007LX-Oj
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j3dAI-0006kl-Ol
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j3dAH-0004eO-Eu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:58:10 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:37335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j3dAH-0004dq-A1
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:58:09 -0500
Received: by mail-ot1-x330.google.com with SMTP id l2so9322114otp.4
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 01:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b1q59jPNypXERMzVjoXBySLZ7EFDYU1VWc+pCmn2vMA=;
 b=t/1LDNQY/XQCK2n3S+8wE8G3XbSzUU6ie/VgmYEBGjW9Ca1bXoKUvXoKVI0DXIlvxE
 Bw2yFNPAlqLaIPEJhd9a9EHT1gVMIWRzbMWtOQHRYYdxrs4laCcPfvi9KPrjeZS3nt8w
 wTtzFXQl1MGZZXMQPCASFfTR+izJaVqWYXCKw1k87a3frGxX+YyR78il3LqsZWMqT6mj
 fWqA1HnvcpXC7rjJtuSc77Yb5BE2Y4ydVYLS4rjX0eBQ9aZt0MficgxjGPUO+ZRd2k7E
 aVpbBoHqKBTj6+s8gclwEYUGc6I+Kv5xInof01XFF11AP1MkcaUjoZFiZP5ZIxpTUgPQ
 ty4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b1q59jPNypXERMzVjoXBySLZ7EFDYU1VWc+pCmn2vMA=;
 b=g71eZMJVwDUl/E6Du8dCaVpmNQxS2MFmLapt0968JjEkYIS0QA/xe2o4eCPqmquULm
 i04JF+d50D5g2W9KsYGvkvn9WcZnpB32VO8f99kHKfJx05KHe4isddzEbQkMK2vuHQ7e
 8iKxkr1HguTq11KjcHZQuZ2iTh/gZ0GpTnT7nf5pnIbnTlTt8ijxR8NlXdB1ahHLSIsa
 irg0nTOS3kq3QReWSvqvLwzjnrzMsr4bwpcI4UeQCPTc61oZYWyOLSBK/aF+IDsefA32
 8BC3M919s9CTKmi8GvirRnTEKIhrgfWBPcitVIq0gH4DHa62RKjU08LMeTMoqUDLjeqT
 Xsfg==
X-Gm-Message-State: APjAAAVrpA5M5mOnwQIzUMqrZAZvVwit8u8SlM1/JXAhcrYLdA3fSdKG
 oQu+Av3wuzBdCYfkC4cKIKCKQT775YCscsjaUeFCFw==
X-Google-Smtp-Source: APXvYqyojsiifjpI1WP8FjYr4Eo0GR1zLZeabN7uNB9A9wsoYRDkDwgnzoT2clgLraW6i9IUKxJDf8OK+vCW2azBisk=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr10801417otq.97.1581933488367; 
 Mon, 17 Feb 2020 01:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20200215114133.15097-1-armbru@redhat.com>
In-Reply-To: <20200215114133.15097-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Feb 2020 09:57:57 +0000
Message-ID: <CAFEAcA9C8H08So01rR=+AkXqimrtrnZHbbq_40zSoi=2jf+2Vg@mail.gmail.com>
Subject: Re: [PULL 00/18] QAPI patches for 2020-02-15
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 15 Feb 2020 at 11:42, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 517c84cef759a453cfb8f51498aebc909a5f3b39:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200213-pull-request' into staging (2020-02-13 18:55:57 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-02-15
>
> for you to fetch changes up to bb5ccf225e81d2801c03e63d16c371f0617270e8:
>
>   qapi: Delete all the "foo: dropped in n.n" notes (2020-02-15 11:41:50 +0100)
>
> ----------------------------------------------------------------
> QAPI patches for 2020-02-15
>
> * QAPI schema doc comment fixes and cleanups, most of them in
>   preparation of the upcoming switch to rST
>
> * A Make dependency typo fix
>
> * configure improvements for sphinx-build
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

