Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7868C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3AE1216F4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJKn/FRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AE1216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaiZD-0003wr-ST
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 10:52:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iaiTH-0007vZ-3F
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iaiTB-0006jm-Nt
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:46:11 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:41485)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iaiSA-0003bh-9l
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 10:46:09 -0500
Received: by mail-ot1-x329.google.com with SMTP id r27so10627146otc.8
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 07:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2bFMa6yuo3vxrq8boL8zGhd6D54DrKvC6NtwvjUCuS8=;
 b=xJKn/FRN5A8l1oMzRqFePTVp15EXe4vUeOSlVNmP+iC18jj6i1hBpbw5bOghUHry9E
 xEOiyBh1A2ViNsrb7GftK/FRVDxgxs+RMifRd/yz+GJW2TJdB2Wx9xl6gkB7DaS0mTXQ
 6BS1ppeEECIAeVVq72wr6d6VVx0mr9cFoXDN5JOH205s5WXTMb4b+jP7mlNEHMgkkakF
 Fg4JrAXPohxMoh6DzpEo8p9LRHFjPx10O5Ds8O+PddgX129N3CKQYtJ102ym3ok7EnKB
 r+C/h78Qo5qZJzMaIW7YcYr4tM7AxbnVJIdHqIfDJ71nOnvrslc/JZu7vBFSIpBp3nt/
 Bt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2bFMa6yuo3vxrq8boL8zGhd6D54DrKvC6NtwvjUCuS8=;
 b=jBT6v4DpKYpRbf+PWTgm7UnD5Ukmuaxj8ZLAam7kZ33lNS4orLcdTGVQmn77lX4uHA
 /v6FQtq+hadnJQIjG6GLYWiv4MuNnt8kSQDsBoDWdM1qLEZ1GNvK8Md5v+KKiWlgBLjQ
 +2rR7ygUIq/myRqOsRJf3jGy1jbVJqz4pC64YAA85Ti9e77WFwzT88LI+dBrV6LPdtWw
 MZbDiDqWL8P0UclQqnUCTRmM+N+G6PSS6J0adrkM7dpH3vq9ul1fTe6KJmQ+Mk4Ktvoq
 IcMunPGX4htil5epd1G6GBdGEzFYeXfqkkhHg9yJufiZaoyGW0iE2j17mJ1XPqij2C4F
 JNzQ==
X-Gm-Message-State: APjAAAXISDyI0kGX9SDqQuPk5/VAgauc8aMN9zUFCwg4SOqd+5AFY66p
 J0pWCRDl3CaMXEvC8vGBRsWA/1ndVSWyIHrFCbVG0Q==
X-Google-Smtp-Source: APXvYqy5HPWCYzqziwCSo2D3i6BTE8WpBrVHxAsN+TZpSNaQRE4svx3wFxCkD2vJj5NAGoj5SbcMWIIqJwIiA9Jvl1E=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr12045438otg.232.1575042301400; 
 Fri, 29 Nov 2019 07:45:01 -0800 (PST)
MIME-Version: 1.0
References: <20191129100835.21734-1-thuth@redhat.com>
In-Reply-To: <20191129100835.21734-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 15:44:50 +0000
Message-ID: <CAFEAcA97BPGG7v0BBdoFwR-xTx8JEg-QNFNB+S7UeciF4MxopA@mail.gmail.com>
Subject: Re: [PULL 0/2] Fix for the s390-ccw bios
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 Nov 2019 at 10:08, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 1a61a081ac33ae6cb7dd2e38d119a572f416c7f7:
>
>   Update version for v4.2.0-rc3 release (2019-11-26 21:52:26 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-11-29
>
> for you to fetch changes up to bf876a688c9319b506d5ff1175ba7189cd933d91:
>
>   pc-bios/s390: Update firmware image with the "fix sclp_get_loadparm_ascii" patch (2019-11-29 10:12:33 +0100)
>
> ----------------------------------------------------------------
> A fix for regression in the s390-ccw bios
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

