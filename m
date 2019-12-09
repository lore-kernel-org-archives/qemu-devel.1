Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFFCC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36862068E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 13:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nAVLGJVw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36862068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieIy9-0001Ca-Gr
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 08:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ieIwN-00082I-PA
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ieIwM-0005NG-AL
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:19:07 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:36722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ieIwM-0005MY-3C
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 08:19:06 -0500
Received: by mail-oi1-x22c.google.com with SMTP id c16so6263664oic.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 05:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7JqAHOmqEdDenrPs1Cp9c/waHGR9qeTGg3kl3N1qszc=;
 b=nAVLGJVwMronNB/3uzqtkr34kHfM0pZRm4p1x70rUGiS+zlqygqmduvp/bb5tVpuH4
 syyOx8wE7O07w8oZSa9czQ9NdTFRz6hMWs9qlpMoqDfBBByzHR8y23lUQgUIHccFqc+/
 A7mJHwjOtMRaCARPIsf2kS3752zcYFkGDvwsQD3aJlzgjD3hlrxKW+DHJAp1atsmzr9D
 GmzUklkEK4MGsq2nXPbFbH5uRVTAOS75BXdl6m84sZsDYiDj879bEfFW5vkYLIe9V2E9
 S8eaQJ8uVtSCUGYtDTOs5JW2y+Mi4Uw9+JQTsWEX5hZ/s7JF+afqXDU3EqACvlu8HXRz
 /Hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7JqAHOmqEdDenrPs1Cp9c/waHGR9qeTGg3kl3N1qszc=;
 b=k5HUzwxhpVHrHxgMQFxNEjlIhuyXM6qScPqUo+wsk+lbt5RsebWgrW5/K7VSk9XM0P
 cbT0CILDTR/bI5Gq46iLAio8+ATv0VpWrR/7cjQvShwO7VfcqsDvadZch5HbJCDB/DDl
 iwjKFcsvw2HV7h2EdovYF5KMfyEHMaVr8+vf4pKDvonHSH65AQHaetlmUItWRKAImYYm
 PmC2k5mB2MGraBnU8YNtBEFNIfNA6Mn97xhaZarRGngOlNp+oMKJd3VJCE8q8QKRuj3Q
 WiRPYeoNjb5Tn3B6eILagcD6GEs4DsGM5ZB9FOEVbxNRs/T0RkP85sGqqOp7YPcCPaaj
 +DBA==
X-Gm-Message-State: APjAAAXmPci8RC/8y3PukdlsLmKdAcl0PkjcWBSb1aO1LQDWCIqljZAu
 7z43i9RSp0ifVzDySO4nvwxgVMQBocycTJbN1BHIZQ==
X-Google-Smtp-Source: APXvYqyMzwty+mqbe55Ld1RaNxSaFOgYHLVB97i2/WAnFJR2LIq38MbXEORXfZSubTiRIdX1IMqduNcpovGakWEZ+6c=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr22969415oic.146.1575897544973; 
 Mon, 09 Dec 2019 05:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20191209065928.204264-1-david@gibson.dropbear.id.au>
In-Reply-To: <20191209065928.204264-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Dec 2019 13:18:53 +0000
Message-ID: <CAFEAcA93RzcW+JdhraP+-8h=RamLp6_UDN+hYvBgP0g_rvB0Tg@mail.gmail.com>
Subject: Re: [PULL 0/1] ppc-for-4.2 queue 2019-12-06
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Dec 2019 at 06:59, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 02f9c885edefae66d787847758d13ed60c0f539e:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2019-12-06 15:05:20 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.2-20191209
>
> for you to fetch changes up to a2fad86497b981426dc720236c15f2a99ca674a9:
>
>   pseries: Update SLOF firmware image (2019-12-09 12:16:26 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-12-09
>
> This is a last minute pull request for ppc-for-4.2.  It fixes a
> regression: a bad interaction between the new qemu and SLOF device
> tree construction code means that SLOF will crash if PCI to PCI
> bridges are included in the system.
>
> This PR supersedes ppc-for-4.2-20191206.  This one has only a more
> minimal change to the firmware addressed only at fixing this bug and
> not incorporating some other unrelated changes that happened in the
> meantime.
>
> This is very late, maybe too late.  However, since there appears to be
> an -rc5 in the works for other reasons, I figured it was worth
> submitting this in case.
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

