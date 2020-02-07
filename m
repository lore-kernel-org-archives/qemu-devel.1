Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159A5C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9215B2465D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmCAy2b4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9215B2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05Kr-0006kz-P8
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:14:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j058E-0000iA-Bn
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j0588-0003JN-7R
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:22 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:37896)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j0587-0003Ed-SD
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:01:16 -0500
Received: by mail-oi1-x22a.google.com with SMTP id l9so2237682oii.5
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 07:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lmKHRLOMLiulq5XOV3jUR+8JbZpGp8iUux1+j2rpVlA=;
 b=UmCAy2b4L0d/MiGR9dcs2dEcFsArDRGOHEudwuElQ99ShjbFHd2nwC45Af7E2B4y4n
 jSBPhDj6r/zT0zNr4Fu6GN+AUUK7jYBPCjVGatFmbeYhx8bVeE88OBRemREyXzdNTPLZ
 vUE03NECGeGbTgh5LKXiM+VS5U6QTOCKdic9ClqBrpsLADRQLhCoHG9ty7LBL9o+2VHN
 +oL/sJxwH03+u9Pj9+CYmGzM8YM3iBsjOj+lV0lQmy/6mNQoqClbnwffT1w6xmu1K+1y
 OHK/gkUg/HiEVUje1JmLYb8ekbS8J8WTLEHbjv0RAWcsdtO89VICS1OX5wVw1qsgTktf
 3HeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lmKHRLOMLiulq5XOV3jUR+8JbZpGp8iUux1+j2rpVlA=;
 b=qsENsT/RJujY5SquFLKHH6O7z7bIvSr6e53ubcOQJ0q8Shx1JqUemlfU3CRJ/GvNx4
 qyUb+OUR+f9WydCxA5eUthz4C6Kx5WLKnYcJKWGoJSe04SPJv5YwmkS9sfXMnZi7z4D6
 VLZslVfKRksgR1SFakHMx/+L0uxtb6fyhmMKjqcDyl0W+bQl3o3oxckS0mdiCyU5x8NO
 3amZtG0vugQ5eNzA+qnWYwi0juO31SVQfkY3NlYKTcwxBFfcfm4MkoSxjfwhmGHSKIKa
 F2T+D8YxlD+29MpWT+zKEhPMnATjWPiCbDawFymFSRfcMqDFiPauM5b04o8EXfie8MTo
 dHJQ==
X-Gm-Message-State: APjAAAXRs7H1oNyIvmjjrZINecorJVOhhFiraZMdyYor7FXF7fZYQNgQ
 f7iHf6bACHTXZAkrRDPXXxHhMKUpe7mroPyA2Cc8qw==
X-Google-Smtp-Source: APXvYqz2c2DPD0d/PGHRD2tWrbFL78xTkKTV4/sftf/L0w+6cThlO+3fKYk968XBNSrm2SAGAbrhKMKL3spDD60Wuqs=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2417588oiy.170.1581087674999; 
 Fri, 07 Feb 2020 07:01:14 -0800 (PST)
MIME-Version: 1.0
References: <20200207074557.26073-1-kraxel@redhat.com>
In-Reply-To: <20200207074557.26073-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 15:01:04 +0000
Message-ID: <CAFEAcA8ni9V3=qzXTFu3djXGGLkXS+BJmVqfTbK4E9HZq6CeVg@mail.gmail.com>
Subject: Re: [PULL 00/12] Audio 20200207 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 at 07:47, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 928173659d6e5dc368284f73f90ea1d129e1f57d:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200130' into staging (2020-01-30 16:19:04 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20200207-pull-request
>
> for you to fetch changes up to ed2a4a794184df3dbd5ee4cc06e86fe220663faf:
>
>   audio: proper support for float samples in mixeng (2020-02-06 14:35:57 +0100)
>
> ----------------------------------------------------------------
> audio: bugfixes, mostly audio backend rewrite fallout
>
> ---------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

