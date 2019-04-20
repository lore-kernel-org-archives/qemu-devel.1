Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95CBC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 22:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DF82087F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 22:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ERJ5UmJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DF82087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46289 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHywH-0006If-7m
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 18:58:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hHyv1-0005VC-5i
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 18:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hHyfg-0000mT-DL
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 18:41:22 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:52915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
	id 1hHyfg-0000l6-0j
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 18:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xXb7A/Xl7ItDo6mvl5g3oHhFX3voF+Is0UwPoyWDa6c=;
	b=ERJ5UmJ+NUvCfMA+lczWzAAKEm
	XW7/Cmwpri8wxHQxDx9qbDYnGHzzXYZmdxQxrzh2wfBr1kHFWVXBoPZr5gOoGX4XoTtYH3nw1J673
	SBi3HUjdtwFKsfGPxMe5zvXNcWfmvuT0/Hx44fKiP6M+sFb1G6eKhNJL817qyuwsSg2nV/9gaRZ+r
	6RacBm17+ftiaYHtovNlHgQ6zqTgCKf4g5jXKRWNw4ciX/CKZeJqnzon+MMmHvzaEyRlI0XYOu4JB
	sIKqg8s0meglGAAdQeyte9wemiy8dvP1UVYd8yPKA6fnFvogAvaOpkYzzQeWcXuAESRIY3EIOclD0
	mVBMagrA==;
To: qemu-devel@nongnu.org
Date: Sun, 21 Apr 2019 00:41:01 +0200
Message-ID: <1736754.y8mDa9Bjs0@silver>
In-Reply-To: <3754934.J2WuGLFlGG@silver>
References: <3205397.r2gctG0f81@silver> <20190330174751.1eb8e298@bahia.lan>
	<3754934.J2WuGLFlGG@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
User-Agent: KMail
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
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
Message-ID: <20190420224101.PdFIT18KZBjwx73oYIk1NwpRrDOC3f4Rss5Y1kyVGmU@z>

On Samstag, 30. M=E4rz 2019 21:01:28 CEST Christian Schoenebeck wrote:
> On Samstag, 30. M=E4rz 2019 17:47:51 CET Greg Kurz wrote:
> > Maybe have a look at this tentative to fix QID collisions:
> >=20
> > https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02283.html
[snip]
> Question: so far I just had a look at that patch set, but haven't tried it
> yet. Am I correct that the inode numbers (of the same file) would actually
> change on guest side with every reboot (i.e. depending on the precise
> sequence individual files would be accessed by guest after each reboot)?

I intended to extend Antonios' patch set regarding 9p QID collisions with t=
he=20
goal to make the ids constant beyond reboots by storing the qpp_table as fs=
=20
xattr.

My plan was to load the qpp_table in v9fs_device_realize_common() and save =
the=20
table only once in v9fs_device_unrealize_common(), instead of storing the=20
table on every new insertion. The problem though is that none of the 9p=20
unrealize functions is called on guest shutdowns.

Is there any callback that is guaranteed to be called on guest shutdowns?

Best regards,
Christian Schoenebeck

