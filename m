Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FDBC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743F420811
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743F420811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52279 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hItrx-00029f-OB
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 07:45:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hItr7-0001ep-M2
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hItr6-0003Ve-Ef
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:44:57 -0400
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:37449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hItr6-0003RB-8u
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:44:56 -0400
Received: from player793.ha.ovh.net (unknown [10.109.143.24])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id EE1BB16BC21
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 13:44:46 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player793.ha.ovh.net (Postfix) with ESMTPSA id E571251AEEED;
	Tue, 23 Apr 2019 11:44:43 +0000 (UTC)
Date: Tue, 23 Apr 2019 13:44:42 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190423134442.0549f427@bahia.lan>
In-Reply-To: <1736754.y8mDa9Bjs0@silver>
References: <3205397.r2gctG0f81@silver> <20190330174751.1eb8e298@bahia.lan>
	<3754934.J2WuGLFlGG@silver> <1736754.y8mDa9Bjs0@silver>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 18063375159005911360
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrgeekgdeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.76.26
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
Cc: qemu-devel@nongnu.org, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423114442.6ZdAIzRpzms4cXbKFcxW_HvAGIVWFAfFdr7a3Q1wgN0@z>

Hi Christian,

Sorry for the late response. I'm quite busy on other topics these days...

On Sun, 21 Apr 2019 00:41:01 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Samstag, 30. M=C3=A4rz 2019 21:01:28 CEST Christian Schoenebeck wrote:
> > On Samstag, 30. M=C3=A4rz 2019 17:47:51 CET Greg Kurz wrote: =20
> > > Maybe have a look at this tentative to fix QID collisions:
> > >=20
> > > https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02283.html =
=20
> [snip]
> > Question: so far I just had a look at that patch set, but haven't tried=
 it
> > yet. Am I correct that the inode numbers (of the same file) would actua=
lly
> > change on guest side with every reboot (i.e. depending on the precise
> > sequence individual files would be accessed by guest after each reboot)=
? =20
>=20

I have not checked.

> I intended to extend Antonios' patch set regarding 9p QID collisions with=
 the=20
> goal to make the ids constant beyond reboots by storing the qpp_table as =
fs=20
> xattr.
>=20

Hmm... why would you do that ? Even if some filesystems do have persistant
inode numbers, it isn't mandatory AFAIK.

> My plan was to load the qpp_table in v9fs_device_realize_common() and sav=
e the=20
> table only once in v9fs_device_unrealize_common(), instead of storing the=
=20
> table on every new insertion. The problem though is that none of the 9p=20
> unrealize functions is called on guest shutdowns.
>=20

The unrealize function is called when the device is unplugged from
it's parent bus. It isn't related to guest shutdown.

> Is there any callback that is guaranteed to be called on guest shutdowns?
>=20

There's no such thing.

> Best regards,
> Christian Schoenebeck

Cheers,

--
Greg

