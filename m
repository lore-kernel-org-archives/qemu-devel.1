Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F729C282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D6020685
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="POcFD8DV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D6020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54833 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIwcU-0008De-30
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 10:42:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hIwba-0007Cc-VR
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hIwbZ-0007uZ-Dr
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:41:06 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:44557)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
	id 1hIwbY-0007r2-DT
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lTwAhPYs1k6FeyM2Vjmta7vwxEp6q8oU6csJ33B9fio=;
	b=POcFD8DVOze2QU2wWpVriODAbz
	kDsqq3NAuJm6Q+IaHJbEBHavYGnphhVvy9ItXz6S5jOOc27v733GQRlWLHpPt518/ariGMnY6mk4E
	d0+TV5o6Z2ujG19Gblxpd0Ja5JhXYei/PeeUPebRBYTVuGClCwVtI7QG1bI9/qUSWxHqmvQ0U0cd7
	SkS4GRaDa82jSu+UDpjb169y5HuwkuaYRx+T3K86nH5xxIBQvqkwIXPBBFwYgf0lxacdUATns0jGX
	Y1W35Z4fOh7QJLSlmdEbk8pMU/t9mUNYqQBB6PwAxkEM5otAA+/JnToQQUgn52BhU9bhr7YWEl9GR
	Ybkw3wb2hOUza7ImSx5nXC5ah1n/s8SMg6iywj7E78whB5Ifz/t9zBUSL8Yd8FlyRBhHA+PRp4X8f
	fyPP/axEZxgbcopUUmn74qN7AkImq7EW7KPEf05xdn612pTurqOoPbLtmGMkxyn3hNaJzFpeAEEca
	eWA8yiEvn6ueIpv40+uPlZMVCo1ZjAqLWKrTfrGrUkhP+JmftZ6eS5Q/Ag/Yr5cn8SxQl7pjqFKhi
	bGYE0hfjJA63SfXogXfhlkYZSXiEYZ7YNbB90MzwzEXqQm2VksYZYFHIPN9loHSw++uYUUqqEuFtS
	NQI7Bf7L50ScXnRHQPHGbLyTc0IyKYrKcCiuTwG9E=;
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 16:40:57 +0200
Message-ID: <7519361.8GXJqb1B4Y@silver>
In-Reply-To: <20190423134442.0549f427@bahia.lan>
References: <3205397.r2gctG0f81@silver> <1736754.y8mDa9Bjs0@silver>
	<20190423134442.0549f427@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Spam_score: -0.0
X-Spam_score_int: 0
X-Spam_bar: /
X-Spam_report: Spam detection software,
	running on the system "kylie.crudebyte.com", 
	has NOT identified this incoming email as spam.  The original
	message has been attached to this so you can view it or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Dienstag,
	23. April 2019 13:44:42 CEST Greg Kurz wrote:
	> Hi Christian, > > Sorry for the late response. I'm quite busy on other
	topics these days... Absolutely no problem. We probably all share the
	same
	fate of constant work load on endless battle fields popping up
	everywhere. :-) 
	Content analysis details:   (-0.0 points, 5.0 required)
	pts rule name              description
	---- ----------------------
	--------------------------------------------------
	0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
	blocked.  See
	http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
	for more information. [URIs: gnu.org]
	-0.0 NO_RELAYS Informational: message was not relayed via SMTP
	-0.0 NO_RECEIVED Informational: message has no Received headers
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] virtfs/9p duplicate inodes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Greg Kurz <groug@kaod.org>, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423144057.EYa3O2OeECcH9dzsEtxNy73Gy0LXDpStS9d2kBXCpT4@z>

On Dienstag, 23. April 2019 13:44:42 CEST Greg Kurz wrote:
> Hi Christian,
> 
> Sorry for the late response. I'm quite busy on other topics these days...

Absolutely no problem. We probably all share the same fate of constant work 
load on endless battle fields popping up everywhere. :-)

> > I intended to extend Antonios' patch set regarding 9p QID collisions with
> > the goal to make the ids constant beyond reboots by storing the qpp_table
> > as fs xattr.
> 
> Hmm... why would you do that ? Even if some filesystems do have persistant
> inode numbers, it isn't mandatory AFAIK.

Mja, unfortunately I found that necessary, see my comment in patch 3 for the 
background / reason:

https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03755.html

And sorry that my patch set did not go out as one thread today. I vow 
emendation. ;-)

Best regards,
Christian Schoenebeck

