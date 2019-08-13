Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33119C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F263320673
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9JjoYRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F263320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxT31-0004m2-BK
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 05:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52308)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hxT2K-0003dN-2r
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hxT2I-0001C6-Pc
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:24:12 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:37522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hxT2I-0001AX-Jg
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:24:10 -0400
Received: by mail-ot1-x32d.google.com with SMTP id f17so34531319otq.4
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 02:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vLdoO4EAZfJ7x5Oz59KFzZylv7OwHHtS+v4png2bMy0=;
 b=J9JjoYRKCVwxBAdmpT+iFEbT/0jV8tnAz8n268tIiCz7Xw768HxS4On1oY6kNU94On
 awXWzcP/UhD1TizgPubN/hTH2Le1GC5B9rqDA+Tdz22qLDqfg9C1N5mTfZiTQaKaneIY
 AakZDKSkrmKVPEfdF/pnYxxd1bm5dYHhnZd71iTlejcgDO9oILwdxC2fMNDETcNLPDJr
 UuuHBY1xxCoLaOeAFObZJ88RJzZ9jvrBob0c+L7jTCqMa000GwPQGnoof+bbdEN5MhE7
 JVHPYEnlMW4Ew09RU43tRVIcSzur6UK+svtz5sjYMM0GtVifHFWBP0onmd423jM110Tv
 1Dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vLdoO4EAZfJ7x5Oz59KFzZylv7OwHHtS+v4png2bMy0=;
 b=F4k42OHZf91m1cBEOoEh23WtlA1/j0OAiY14fwmkNSjyS+KQle3hwVJWUffnYHyioh
 nSImAHJo7TqTb7A3qlrP1GzeXO/+0Ow3/mdCly4tYKggb6cr4WCHfysO2pqHim9f3fw1
 o6jcJMgDXJrZpn4ovqcZ1vtPz3LRpAHqBELmCsQ5bf44f/5iR55Hz9AxJxWaL/pOr8gn
 yRsPQfsvifs0EZmjYAGJjOTazPmk2IsWTzlhuPQ8EN3mqTOr1FJOXDsaKI3llCxllJRR
 hGtFZeN1MdtnPPVRUbwBkBVSZevAxQbUlLHrEPN0OvbupS3l8kfPNNCWMHv7+PbrKlaA
 MdBA==
X-Gm-Message-State: APjAAAWa+Q5+OOYlKpDLhD24C7pwSIaE2rxy2go5X5A1nHA4sjEQFaE5
 1ydYZbAA1cnYByT+RM15tTaKOCvvUTGRIu0Rs8rXKA==
X-Google-Smtp-Source: APXvYqwP/u/YtmSbQCyluu4FHv5kVIQ/+geHFee7nTbDywjCmq52VwBDFs44EUYnvnszMtkvkq2ttuk3zFzyOeq+7eY=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr34974548oti.91.1565688248697; 
 Tue, 13 Aug 2019 02:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190813065920.23203-1-david@gibson.dropbear.id.au>
In-Reply-To: <20190813065920.23203-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Aug 2019 10:23:57 +0100
Message-ID: <CAFEAcA9-oo-LCrhUdCzV7MZvwyTeT6sxQFt9B0JEaT7FE4tidA@mail.gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
Subject: Re: [Qemu-devel] [PULL 0/2] ppc-for-4.1 queue 20190813
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
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 13 Aug 2019 at 07:59, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 5e7bcdcfe69ce0fad66012b2cfb2035003c37eef:
>
>   display/bochs: fix pcie support (2019-08-12 16:36:41 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.1-20190813
>
> for you to fetch changes up to 310cda5b5e9df642b19a0e9c504368ffba3b3ab9:
>
>   spapr/xive: Fix migration of hot-plugged CPUs (2019-08-13 16:50:30 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-08-13 (last minute qemu-4.1 fixes)
>
> Here's a very, very last minute pull request for qemu-4.1.  This fixes
> two nasty bugs with the XIVE interrupt controller in "dual" mode
> (where the guest decides which interrupt controller it wants to use).
> One occurs when resetting the guest while I/O is active, and the other
> with migration of hotplugged CPUs.
>
> The timing here is very unfortunate.  Alas, we only spotted these bugs
> very late, and I was sick last week, delaying analysis and fix even
> further.
>
> This series hasn't had nearly as much testing as I'd really like, but
> I'd still like to squeeze it into qemu-4.1 if possible, since
> definitely fixing two bad bugs seems like an acceptable tradeoff for
> the risk of introducing different bugs.

Are these regressions? Are they security issues?

We are going to have an rc5 today, but my intention was to only put in
the security-fix bug in the bochs display device, and then have
a final release Thursday.

thanks
-- PMM

