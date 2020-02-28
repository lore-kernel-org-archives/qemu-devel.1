Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2BEC3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB65720658
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 11:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ho0vDzmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB65720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7dgu-0001UD-Vn
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 06:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7dgG-0000xG-E3
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7dgF-00049b-Ag
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:19:44 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45594)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7dgF-00049I-6Z
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 06:19:43 -0500
Received: by mail-oi1-x241.google.com with SMTP id v19so2455466oic.12
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 03:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/41nq/s1Zf55rfLl2V9ZXClj6+IQ6ILd/tEc3fKBv1w=;
 b=ho0vDzmJbQ9Bdn4jkV6SZT2cdMc0y2aoZEmzi7PZifw7+mQD79ysvfNug/bkUMYC8C
 mjLBW1F2GDlm+rcrh0B5VPQTZtnQfZfognVkPM69jtpZoCdYDA4wKPvXCFahupuzRK0I
 OnT4Hsz1CHaxuFD8Vv9MmX/4xfQ8K2PmPSfx/7/g+Fnq77vLex031iJ9vSkfZOUaK6Gt
 KujVzWdWwHYWXP9r1jbkcfHSPo8FEzUmSa0ImneaTwbaX2TuFtfgeGwMqqwEqDvjdkWE
 BtLR+SlseatPVGk9Gnda4cP4erVP3B+5y8bqJG3O0b9dx5HNsQXslFUXq9ET6/+o5aS6
 1Wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/41nq/s1Zf55rfLl2V9ZXClj6+IQ6ILd/tEc3fKBv1w=;
 b=OqG0FeoxVRxSFCk4Wc8f0p4GnWgUmuEQpAtRDVIdSaQDmgeBXmrF76cVOtMUBXT2R+
 LYf0iMTHpRaCioGcpwRMmjPUdXt8ZVWVSnmnFKFs/KB266t4ol3AtTRecOafsBA4sLfs
 bJ2nH/6ihX/G13sxqn7Fx6mCktaSXwMsRXqC/k9k0ESj8Gvb+Qm3ThOvNDEt8/7eWTdv
 13g1mP+sEkTVbh/Sb50YHlM1yj+7WdnGKTA006VV4l4A8SZcIEnfpXDuWdq+i67ZYWRI
 7DtAhiVk1SNG6ePXZfzwShEfu4KVu03TxAfZf3Dsj895783FKYn+E8gEqiri056PQWeP
 KJmw==
X-Gm-Message-State: APjAAAVkC7+f5EcuVawAOv6eRu3yRb0n443+MIQY3Sl6iNQcjd8kNW3v
 G1MmsWJyqi2ZtAcvPNUSbtTLDtefl7leY8BeagyJDA==
X-Google-Smtp-Source: APXvYqwN7UFS1OPGuIHSdFJfG9v4cI73cxPvD8tJDAKhaXtKdsbFbCf/fghZEIao4BSdbJHkxicVvGcrcgA/iqtExq0=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr2646050oie.146.1582888782411; 
 Fri, 28 Feb 2020 03:19:42 -0800 (PST)
MIME-Version: 1.0
References: <20200227121645.2601280-1-anthony.perard@citrix.com>
In-Reply-To: <20200227121645.2601280-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Feb 2020 11:19:31 +0000
Message-ID: <CAFEAcA_QBM5YUZGVFZ3oH3_Sry3Z5p0PyqR+DV2Vk-pcqEURWQ@mail.gmail.com>
Subject: Re: [PULL 0/3] Xen queue 2020-02-27
To: Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: "open list:X86" <xen-devel@lists.xenproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 at 12:16, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> The following changes since commit db736e0437aa6fd7c1b7e4599c17f9619ab6b837:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-02-25 13:31:16 +0000)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20200227
>
> for you to fetch changes up to 5d4c954931ba62661c6a1bc16ce604a012a10007:
>
>   Memory: Only call ramblock_ptr when needed in qemu_ram_writeback (2020-02-27 11:50:30 +0000)
>
> ----------------------------------------------------------------
> Xen queue 2020-02-27
>
> * fix for xen-block
> * fix in exec.c for migration of xen guest
> * one cleanup patch
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

