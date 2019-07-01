Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2397C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:38:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EB7208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lf3toSQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EB7208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhyjT-0001FN-Uo
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 12:00:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51795)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhyi3-0000Db-35
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhyhz-0005sz-RG
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:59:13 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:45666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhyhz-0005s6-ME
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 11:59:11 -0400
Received: by mail-oi1-f176.google.com with SMTP id m206so10354328oib.12
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hOfILo+Out7yLuZlBq8jtp74qr2lfEuGoO95HYEcZ3M=;
 b=Lf3toSQ5pQrGNKF7WtUq0ZCNA9v96O/wvcYq3wZht60mJDFgt5Ef2h06RmqfD4f7HA
 SJH97xP2tSeNZvI9JHSoGy9B4wJd/kU8aaxe34FH6rP+LcrzofRlOm1p2xZ/atIm2M5Q
 UCv959hapspQTPBy5RoaXDScMg/u8cp5ip63ZVttE1aekUa73C6VoQVlS+P28M+8DANZ
 dh7nZRut5Ms/JSMMhRHSVMRFY6aD0kBmTrkKnjdViWrAGYmixIzKvjyNaaA/sbyxqWru
 B8KNSUlruE71Qrsfw7k+cJFyQK+GwgYPGXKC0EWabilrPj25QaIWTIkWRmaF94m5PzEF
 GZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hOfILo+Out7yLuZlBq8jtp74qr2lfEuGoO95HYEcZ3M=;
 b=FTKz0EElzicCWndpOohE5TJH0ODeYDwacPTsBxlgzxGlKjuQno81/0L1ivmdPHGPZr
 4jEQgpxgm3G6A1Y3Z7s7TLvn9iWyj2EKsZRlm5ibARyIcTLLXR6cqxtiu+Mknhd5vpdw
 IuXo46hFARU60PLeFsvWzt5UTtxMFJ84e8Zw5qJds7chTkmSUJfoiQpCoy9xzGyYuVxb
 IYLvneGqmHiG525iUjdc27v8WR9NHhNuyWJRRwW20aO2BwXXwoqh/PgxgSQgNMyw59Zj
 iir5FhV15dFwznVM+4LxYYiXJ8s2V3bhqxI+eXhO2hKRPEyRJe4XD8bnZ5BRTfTduyB0
 bFdQ==
X-Gm-Message-State: APjAAAW/WhOt2z5oB9SmkNJiWdDvjps/5hzAGUtmbzG7gDb0R7mIxce7
 v6dV7BtsdCYDP5Bn5oPvu05QPGSUCznlm1AnQb6AyA==
X-Google-Smtp-Source: APXvYqxDIdq4ObNK9uKLZnXucR/PPntJ5SeV46d1qyBXM5rGvOBE9WeiPGz2xpbxhONfy0yo3j5vyFjZ4dxq0ml1Lmk=
X-Received: by 2002:a05:6808:8c2:: with SMTP id k2mr15479oij.98.1561996750800; 
 Mon, 01 Jul 2019 08:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190626121139.19114-1-laurent@vivier.eu>
In-Reply-To: <20190626121139.19114-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 16:59:00 +0100
Message-ID: <CAFEAcA8C5ZW6yCsNFXGwvDTjn2+2gXGt_ADK3wkKhEpE56xKYQ@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.176
Subject: Re: [Qemu-devel] [PULL 0/6] Linux user for 4.1 patches
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019 at 13:18, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request
>
> for you to fetch changes up to b50d1e42a4a7dc746ecd42c34c386d81a997759c:
>
>   linux-user: set default PPC64 CPU (2019-06-24 23:10:36 +0200)
>
> ----------------------------------------------------------------
> Update ppc64 feature and default CPU
> next setsockops() options
> Improve "-L" option
> Another fix for 5.2-rc1 headers
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

