Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032C4C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:52:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C089A20835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 09:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="klPDu/2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C089A20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCL1O-0004X3-Db
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 05:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iCKzd-00039a-Oe
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iCKzc-0003Ak-GS
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:50:53 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:54605)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iCKzc-00039G-2k
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 05:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=uKDRbKJfOa5TqPEE9WaK9P7d9roXqodrrBQGJmXm+3Q=; b=klPDu/2VS6MtbH4QAYbsLDrAYn
 bPI2PFQhss+2A+AitFdNqWXgPqmtGvtFVnL213pZGS4hlaxOQPR2ws7EBqYUSMzIbiAQQzHebQCqF
 RMpBZPb2u7KJQVGTTMr9FKmhXzYKIafAW/ntmVkkH3AhK+PW/iik6IUz3Qs5ItsakipCa3oNX0Nxv
 WqYmcE1LMhh92Nh851e5+PGG7Ekfi3x6gdE6SqNFiNXn7NM+kWXLY7YaBUJ/TPUdTyI+KaWXXggPw
 Dmx6Xct01YBNSvrT1R2b89p3K1Sqx7yxQsb+QSP+FeTsRG4NCLxe/cTQHY45sJvTlzgX6qD3Ffsct
 eA63TD2cGHT30zDSMMYOBUodaAks37JcVZiOwsYj6FwIOstO19iCoV/QNCmoOyHqs4sGGfi+sl0as
 hnKjPViXPDeFiul286M+hI21mlKligFbjpRlAT2RxwAvGmUMyWqLEcmu0701NR5mwd0TdiQ4mlFys
 rkoa5qb1PJfO/wKO0OtqAykU98iH6pXcdId0wUTYPumA3Sj/e+spYlObpQnsDd1k1PK7n+ZucXI3k
 hme201QI2Ur/fixTRy7rS7rHO46Onjbova19LtLyaysKfQx9Zktxv433y3lWHMTwE0QdFK4PgK+79
 d8soTXj7y7nB68AKjjvQYWiw5S65V59r65lbr4dpo=;
To: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [PATCH v7 0/3] 9p: Fix file ID collisions
Date: Mon, 23 Sep 2019 11:50:46 +0200
Message-ID: <2376196.qMJLftDnS9@silver>
In-Reply-To: <20190913190157.651fc3a6@bahia.lan>
References: <cover.1567680121.git.qemu_oss@crudebyte.com>
 <20190913190157.651fc3a6@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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
Cc: Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Christian Schoenebeck <qemu_oss@crudebyte.com>
From: Christian Schoenebeck via <qemu-devel@nongnu.org>

On Freitag, 13. September 2019 19:01:57 CEST Greg Kurz wrote:
> So I did some changes in 1/3 and pushed everything to 9p-next. 

I've reviewed your changes. Some notes:

Patch 1:
https://github.com/gkurz/qemu/commit/9295011c5a961603959b966c8aa6ad9840fe6db2

* Typo 1:

	error_append_hint(&local_err, "Valide options are: multidevs="

	Valide -> Valid

* Typo 2 in log comment:

	[groug: - Moved "multidevs" parsing the local backend.
	->
	[groug: - Moved "multidevs" parsing to the local backend.

> I'll do some
> more manual testing and issue a PR when I'm confident enough.

That would be highly appreciated! So far I am the only one ever having tested 
this patch set at all!

> It would be nice to have some sort of automated test for that in 'make
> check'. My first thought is to simulate a cross-device setup with the synth
> backend, because it might be difficult to do this on a real filesystem
> without requiring elevated privileges.

Hmm, since I neither haven't used the synth backend before, nor added qemu 
test cases so far, I am yet missing the complete picture here. My initial 
suggested approach would have been using loopback devices for simulating two 
file systems, but yes that's probably not viable due to required permissions. 
How would the synth backend help here? I mean you would need to simulate 
specific inode numbers and device numbers in some way for the test cases.




