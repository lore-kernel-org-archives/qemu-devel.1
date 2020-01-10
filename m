Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF98C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 17:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB2820838
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 17:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCRJ9FpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB2820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipxwe-00050c-CG
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 12:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ipxtx-0003fJ-AP
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 12:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ipxtv-0000v9-Tj
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 12:16:49 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:37757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ipxtv-0000rc-LD
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 12:16:47 -0500
Received: by mail-oi1-x22c.google.com with SMTP id z64so2498658oia.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 09:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DQatA2wdxx8d2nDEQi7Qi9+rVSbVnds5mRP6MWMWiDA=;
 b=kCRJ9FpGTCQQo/uLFtoGKLAUYnU2Yi+YG2SIvkRmSEE5WDevAaijo4a9Ax26mLIZRC
 1+2Y5+u0IQBPvjrCrMk9hAFYhDu80GmEphdSrx6pMtaU3RhzM1tUJtNjXo65o0wYsRmu
 wEdEO8V/ISZswruOQNqp6Kj0SAJ5Mx9QdKS4hs0KCODR4p26/ChwczfRKr3UkYkgcgYn
 Wkec360BiYabQJTNA3pvTRG1zWbDcSOc0OIe/Q9xbUJ7l3UXO7bK3Rl/ODW23Cu2oyt+
 r7zKCMH68Prdqmno88++dGF/0tcaLVr6d/4RNQl0k5zDyEQQZRoSWlqVjNptSoDu+wLJ
 RJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DQatA2wdxx8d2nDEQi7Qi9+rVSbVnds5mRP6MWMWiDA=;
 b=Pl2JloqYAS+fcRqeDreBMTitYGU9WieBQEEghowD68kwELORE3C9L7xUfiEayYPfsN
 qyXmNQWw0dzpmYFi/ne5ZybyZkaYQvyq3AraasFX73vTfBf5gMoCmzeGtrH2w8e3VH9G
 2RswDlDY05z9FQbG0BntnmTpnvIIRXa8bAEUbUxz0jbECoDI3NGuVZdSo1L/6c+UTowj
 8Oq0xYuD7xiIeWvv2bwxoo8msrPQDXK/swJ6tovL7Lv5/D9nCJZgPfpIPI+0anKk+LNX
 TR+g5bEOW2RsitvVxLiuovTRqhrZs1SzSPGtB+kO/v/dNLF/nJzOXkPTIInU9ZS88+43
 AoMg==
X-Gm-Message-State: APjAAAWpUI9KhCc8mbw30avX+cwkMfdGRY4QLR4CzdyowKDXBELmWmFk
 bkHXEUqucZQ7Mb65ZzW3pHrCSdguFV/00KVJR4ss+g==
X-Google-Smtp-Source: APXvYqyGQ1bF6Uc+R+CovUh8vQgSusM8JVBgWTpuiClHYPrbo90Sq2r7PvsRksENT82JPhhJTjpoPGxaSzDxCaM+wnQ=
X-Received: by 2002:aca:3182:: with SMTP id x124mr3163612oix.170.1578676606759; 
 Fri, 10 Jan 2020 09:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2020 17:16:36 +0000
Message-ID: <CAFEAcA80iRbGAPiXMfPNWtQ70gq8w83GZtsH-50eQ77m4aa39Q@mail.gmail.com>
Subject: Re: [PULL 00/26] ppc-for-5.0 queue 20200108
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jan 2020 at 05:23, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 035eed4c0d257c905a556fa0f4865a0c077b4e7f:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/q800-for-5.0-pull-request' into staging (2020-01-07 17:08:21 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200108
>
> for you to fetch changes up to fc2527fb024abf92719952c939d751739455bd6b:
>
>   ppc/pnv: fix check on return value of blk_getlength() (2020-01-08 12:01:14 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2020-01-08
>
> Here's another pull request for qemu-5.0 of ppc related changes.
> Highlights are:
>  * First parts of support for POWER Secure VMs
>  * Rework to clean up how we pass context information to the various
>    components of the pnv machine (reduces usage of qdev_get_machine())
>  * Assorted cleanups and bugfixes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

