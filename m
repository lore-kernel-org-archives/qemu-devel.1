Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD95C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 19:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB702082E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 19:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i398sPCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB702082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOQxJ-0000gK-Gd
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 15:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOQwS-00008R-6F
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 15:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOQwQ-0008Ba-TK
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 15:09:51 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:46264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOQwQ-0008Af-HD
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 15:09:50 -0400
Received: by mail-ot1-x32d.google.com with SMTP id w12so766465otm.13
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=EKGr9Q3ST9+BOYSdlELqUDT5FtKpf4qfvLCQeCSyeTs=;
 b=i398sPCJmrS1eGnVZxf+2BKZKwEGGNiM6a61uh6EefqVbHnbE6d0AVvDFRk8Jccb9Y
 HvqoxXuW4agQxhdzE9dJ9y5WD15+EZH3EtDomoNo6dl5rwT2LtzFkIlCLy8jauJpmS/L
 An5uuLPeMJnoZcdnYZDQVj7mksJo5ehb1SJua9DgFTXeb5tamH1UMhNvnQlsWFVlg6uP
 t3dj6ZIdz5CqBHpjpS5sjQHwZFYsvNqZ/R9I82RESrgfgThBomNK+XsdCj1UXTkhJu1z
 altnNPtMtITKxndIauuJhU0dR5BlQ3zG7JiHCStbn9HAgKdz1kATTR1pUJUL0zSjsrbu
 NhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=EKGr9Q3ST9+BOYSdlELqUDT5FtKpf4qfvLCQeCSyeTs=;
 b=fDVeKE/x/zz2P8Osc4F60P7vdsDidpmnsUpireRoXXPhT7tThX4/H4JNFrv/FToJCB
 v01qZSy+iy933fedZySR1ySFTx+cFvKcx5TY8WD7v3HU9kWHbo8kvvRc5USoim1RGFiv
 Fpb9B3pR7XoTyyVD4BIyeVQYsd9tHDYHbzM+jCZW1bP7pML9ZHDhQpSa8DBF96nxRNhq
 LlwE+qF7Ce14mxmWKyplznvVdP0Z9CHbmbxe3iKbrl+0D3hOdVCS9N/C37YxS6Wphnr0
 Izmb/PIDCsk2VyseoLdHMpYX468JnaMrrMiZ65BzfC0Vx74wd8ev++7f7BGL2874CWl+
 8OLg==
X-Gm-Message-State: AGi0PuZW0D5jMqf5S4GGIT/5xmksFx2d7hBc76/o7s1JXn4dJmKR5SIp
 B3SsmuYgCd0wm7f7+un4shw62pt4vB2IuYVMCwXH0ENIFbw=
X-Google-Smtp-Source: APiQypKuqhLgx1u5fQIn3nLNmcVzywQLpIkPwhRFy2mBUVzjXeCl2s4MzDocrd4WV8d9tDJAxcr0CJSmDmDSRTGzmOw=
X-Received: by 2002:a4a:4886:: with SMTP id p128mr19842792ooa.63.1586891389194; 
 Tue, 14 Apr 2020 12:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200414162613.4479-1-peter.maydell@linaro.org>
In-Reply-To: <20200414162613.4479-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2020 20:09:37 +0100
Message-ID: <CAFEAcA_hc=wj7p5b92-eJB=FvaPRqr3A8-+Aaxoy_y292rbnXA@mail.gmail.com>
Subject: Re: [PULL 00/12] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Apr 2020 at 17:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Almost nothing in here is arm-related, but the target-arm
> queue was convenient for these last minute bits and pieces
> for 5.0...
>
> thanks
> -- PMM
>
> The following changes since commit 14e5526b51910efd62cd31cd95b49baca975c83f:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-04-13 15:42:51 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200414
>
> for you to fetch changes up to 84f82ddcbb4ac4ed04c8675e85155329f23184f0:
>
>   Deprecate KVM support for AArch32 (2020-04-14 17:20:22 +0100)
>
> ----------------------------------------------------------------
> patch queue:
>  * Fix some problems that trip up Coverity's scanner
>  * run-coverity-scan: New script automating the scan-and-upload process
>  * docs: Improve our gdbstub documentation
>  * configure: Honour --disable-werror for Sphinx
>  * docs: Fix errors produced when building with Sphinx 3.0
>  * docs: Require Sphinx 1.6 or better
>  * Add deprecation notice for KVM support on AArch32 hosts
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

