Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CABC3A59D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 01:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B4C2077C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 01:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lists.sr.ht header.i=@lists.sr.ht header.b="f+XFY/sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B4C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lists.sr.ht
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyn9o-00054J-GD
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 21:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <extsmtp@sr.ht>) id 1hymDx-0000Zu-NV
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 20:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <extsmtp@sr.ht>) id 1hymDw-0005m6-NF
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 20:05:37 -0400
Received: from mail.sr.ht ([173.195.146.137]:46868)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <extsmtp@sr.ht>) id 1hymDw-0005lw-J3
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 20:05:36 -0400
Received: from lists.my.domain (unknown [173.195.146.144])
 by mail.sr.ht (Postfix) with ESMTPSA id B83A3400F1
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2019 00:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lists.sr.ht; s=srht;
 t=1566000335; bh=mxEbhZU1+qSGknyPGIoh5POTHchOtvpCHYUZlJlhwdU=;
 h=To:From:In-Reply-To:Subject:Reply-To:Date;
 b=f+XFY/sfaKi/YKQicGr/b1Qw+7+dvvmJ73Dc0U2jq9YqK+DbT4R35LN+DqWElC3Bg
 1BDHpusoX3zFlI8PfWuVKwJIgHtw/mJ1rL86b35n96zJhg2DA0LoWslcTttIIWfm7l
 mtN8aNy5k5+hQgsdtLXuSNmtWcYWrOtlyplaygHHhBfF/3S4b3RRJrEoo57yO50dQo
 SLieVVFHVR5Hbf/gRxWwz813a+ne2Mw2gqxxAzNDlLBUfzdtJJpZPyDliOYzW2+K6p
 OYPYHwmnFZojbQGy1xETDwOUeIwRG35zpVR4HzyIRL1V7DQvm0Jg7SndOHke5smc0U
 kBJdDKl5Jx8pg==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Shu-Chun Weng via Qemu-devel <qemu-devel@nongnu.org>
From: mailer@lists.sr.ht
In-Reply-To: <CAF3nBxiu9i8=07+1QqHj2bWiBmHkwCGyg2Y+bK6eVrhhroiJzw@mail.gmail.com>
Auto-Submitted: auto-replied
Date: Sat, 17 Aug 2019 00:05:35 -0000
Message-ID: <156600033562.27960.9602028956329290680@lists.my.domain>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 173.195.146.137
X-Mailman-Approved-At: Fri, 16 Aug 2019 21:04:12 -0400
Subject: Re: [Qemu-devel] [PATCH] Add support for ethtool via
 TARGET_SIOCETHTOOL ioctls.
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
Reply-To: Drew DeVault <sir@cmpwn.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Shu-Chun Weng via Qemu-devel!

We received your email, but were unable to deliver it because it
contains content which has been blacklisted by the list admin. Please
remove your application/pkcs7-signature attachments and send again.

You are also advised to configure your email client to send emails in
plain text to avoid additional errors in the future:

https://useplaintext.email

If you have any questions, please reply to this email to reach the mail
admin. We apologise for the inconvenience.

