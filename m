Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D989C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384D3222D1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHwtwZMr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384D3222D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6Ws-0001UM-1O
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX6PZ-0004G1-92
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX6PX-0004Dq-P2
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:31:28 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:36304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX6PX-0004DH-FK
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:31:27 -0500
Received: by mail-ot1-x32c.google.com with SMTP id f10so18424192oto.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=l9wu0M5zd+KF4q7p7oPLk37/B4i7iS5pvOEE295yzBQ=;
 b=CHwtwZMraCfr5BfSBJNUdkC1EQvoZSNnz+lZpFPeEfwT5ADIqL5voGT9wwG6i8gl1w
 YBGf79iytrIkmaf3UFBR3ruFhr2ybI6qHP6MBcyafe0nUQDEqveIkbbFbUMzz21XJW9L
 SKJdeXzh+DW1GBjEKr90rTWX2aGu2OZXTr3hUrH0ClDoMmWmrFm+ZJwB4dtKstE2AcUj
 gQhCqAHjBooOfLhd+FI/P5fBuDsb+DSPzUpNl156ji6GamFGYhwQ09IzmL9q3yLkJ6HS
 m0XmFVpSaRlSD6wRsGkY7IbXAL/BOztT0d5rv4Oo8TyMVtF9IbZdliBXY5W5NgBTdlby
 zGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=l9wu0M5zd+KF4q7p7oPLk37/B4i7iS5pvOEE295yzBQ=;
 b=V6GR+woK/rYKJrJPuWsC55qEEKMGs8yRNI6wvVmH8GwzSC8g5jp1TRMabK17kfucgD
 yUHAcFTLP4EPh9dmlBujnpNqMMU1q92OQpsOYIAQkM41w9qP5icO2syMfLSf1PwuGxle
 amdbkKvrKTZ0RgEdPx55AlmlICNyBMu7y/NpbXx7Giwn2Ys8dxcPkWNAy3nwcN06qEfB
 lCcCrPqNc875RsU3jbdjTbvPrzVPfAVql011+o8YiAumVxzz7EYRToPJ21hrn9EOYLUh
 rcVsXSDNwVTwDHPUr770PdzED0rw5juTQJLfmgGIkj72lM7E15v6AUgsvEt+NrQt5umY
 EQIQ==
X-Gm-Message-State: APjAAAXeHh07dRdG4HXZybJp1RlcQOqTqqYNHmj+s48OG9E4akyuCW4O
 XABNM5GcAnHbK1XW9ggXDnRWiPv/hlA4UzeBAUWUlQ==
X-Google-Smtp-Source: APXvYqyQhQKRXNLwgPVUeyvspzM0GXDxwy9sqzCrOVQd7V0vj001d+h1KE0v4oqiCPPBM/wTSyV4Y2o/OMQEGqzQ+ls=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr4131885oto.97.1574181086425; 
 Tue, 19 Nov 2019 08:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20191119140043.28539-1-philmd@redhat.com>
In-Reply-To: <20191119140043.28539-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2019 16:31:13 +0000
Message-ID: <CAFEAcA8P8zrkXB2E+PfD=uVweK9t=yB=gRSGazMWz4Z=gwv+fg@mail.gmail.com>
Subject: Re: [PULL 0/2] mips-next patches for 4.2-rc2
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
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
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 at 14:02, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> This pull fixes a regression with the SystemTap trace backend,
> see https://bugs.launchpad.net/qemu/+bug/1844817
>
> The following changes since commit 385e43e6638464009e09cfaec254012e531f63=
42:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-11-19' i=
nto staging (2019-11-19 09:17:24 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/mips-next-20191119
>
> for you to fetch changes up to abc7cf36559f953777faf27d2e0dfb561ac533a5:
>
>   hw/mips/gt64xxx: Remove dynamic field width from trace events (2019-11-=
19 14:46:01 +0100)
>
> ----------------------------------------------------------------
> The DTrace via SystemTap backend can not support the dynamic '*' width
> format. We failed at noticing it for the 4.1 release, and LP#1844817
> was opened to track it. Fix this regression for the next release.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

