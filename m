Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BF3C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 10:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C112082F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 10:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lists.sr.ht header.i=@lists.sr.ht header.b="R+Y83BKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C112082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lists.sr.ht
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD4SZ-0000jt-Ph
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 06:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <extsmtp@sr.ht>) id 1iD4R1-00080L-Tu
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <extsmtp@sr.ht>) id 1iD4R0-0006yq-V9
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:22:11 -0400
Received: from mail.sr.ht ([173.195.146.137]:58082)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <extsmtp@sr.ht>) id 1iD4R0-0006yQ-Qa
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 06:22:10 -0400
Received: from lists.my.domain (unknown [173.195.146.144])
 by mail.sr.ht (Postfix) with ESMTPSA id D9A42400C6
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 10:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lists.sr.ht; s=srht;
 t=1569406929; bh=Vhm/zUQpTv7MxXfD9C/nclUgwVKpKwWkYuG9ZuaJhdU=;
 h=To:From:In-Reply-To:Subject:Reply-To:Date;
 b=R+Y83BKm2zXRFmKBN2n+IBBV/atJwuRLFAwjY07yRlUS1lKBl1Z1yap8fmZ5/5GFs
 es4rCAipQ7j8ny+Ef2iCSQCoIKbo1hw99Xcolsf6o8oUYU7PjIBToPeSebkJQcAac7
 Yf37qUdHohSfzfdciWpgLBPt6lh8odeCIN7Uw1ToFeoJxNJ6Ej1dNQjqVUYSskLX64
 wM5uT9pYz9oFV70sJDBVbBIFNQ+H/W9aIGRlv4OwNQFETljdZvcLEq+EWeX8gi9kRS
 tP0YqsyDk4jA1Gdbv+RYFunzld98C30hFx2soDOgPt2W0Z0BWuxsgGJ2JvnvsV/IY6
 BKIk1ul4bLoqg==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Sam Eiderman via <qemu-devel@nongnu.org>
From: mailer@lists.sr.ht
In-Reply-To: <CAFr6bUkb2RB2rP0xjZb7mDEVFCeYoFLhavheNx2C=OBVXz-qFQ@mail.gmail.com>
Auto-Submitted: auto-replied
Subject: Re: Re: [Qemu-block] [PATCH v6 0/8] Add Qemu to SeaBIOS LCHS interface
Date: Wed, 25 Sep 2019 10:22:09 -0000
Message-ID: <156940692975.28310.17013540794113599859@lists.my.domain>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 173.195.146.137
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

Hi Sam Eiderman via!

We received your email, but were unable to deliver it because it
contains HTML. HTML emails are not permitted. The following guide can
help you configure your client to send in plain text instead:

https://useplaintext.email

If you have any questions, please reply to this email to reach the mail
admin. We apologise for the inconvenience.

