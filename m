Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13192C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 18:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00C820838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 18:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lists.sr.ht header.i=@lists.sr.ht header.b="BSarVNAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00C820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lists.sr.ht
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6JSI-0003UW-2Q
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 14:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <extsmtp@sr.ht>) id 1i6JOK-0008NX-Gd
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 14:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <extsmtp@sr.ht>) id 1i6JOJ-0007ky-8z
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 14:55:28 -0400
Received: from mail.sr.ht ([173.195.146.137]:52882)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <extsmtp@sr.ht>) id 1i6JOJ-0007jk-2u
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 14:55:27 -0400
Received: from lists.my.domain (unknown [173.195.146.144])
 by mail.sr.ht (Postfix) with ESMTPSA id 582E4400B2
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2019 18:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lists.sr.ht; s=srht;
 t=1567796126; bh=mxEbhZU1+qSGknyPGIoh5POTHchOtvpCHYUZlJlhwdU=;
 h=To:From:In-Reply-To:Subject:Reply-To:Date;
 b=BSarVNAYn7bMt2aHIJIlHcFTWmJCVW4NxqcsZpXFK0UitoVJmZEJwMvZ2Pae2k3Kt
 0PKonF7oL5YoWMy/P4+CJvJxR6dsH/WOu6y2s6NXsFzM/3qRCCeE+yDRSmoqu+9Y7t
 GJEI/frj8dXjwP2b0JXIH0xXST913G9OxfoHSn0RL+fBHME8aJvJx2EJ8tJg4qrwTb
 hWaA56zbqe4t+ck1Wm4ntTZ+0Oi5NFmFfbqLgAEpObeDMZ40iZqHJgr1nZwRZ8H1Gp
 z5S0p41fTisgBXZWMjIkmC8HKX8fgj+P/PW/VPR8jG3M1QrSJZPQeaQ3gXlm827x0y
 /ViBwkcENoLiQ==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Shu-Chun Weng via Qemu-devel <qemu-devel@nongnu.org>
From: mailer@lists.sr.ht
In-Reply-To: <CAF3nBxh2uk0_kUMWNnq799BZKKqXSWctvJ+E=T2aqpFcARXNNw@mail.gmail.com>
Auto-Submitted: auto-replied
Date: Fri, 06 Sep 2019 18:55:26 -0000
Message-ID: <156779612610.17741.17950988708648455608@lists.my.domain>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 173.195.146.137
Subject: Re: [Qemu-devel] [PATCH] linux-user: hijack open() for thread
 directories
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

