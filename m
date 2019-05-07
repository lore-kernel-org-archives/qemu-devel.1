Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F403C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:49:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A577206BF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="KKTx4CUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A577206BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47153 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO0Th-0007V6-Ex
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 09:49:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hO0Sm-0007BT-53
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hO0Sk-0001eF-6d
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:48:56 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:48211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
	id 1hO0Si-0001Xw-9T
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O0ydUdcZGLO4pE0OqG0OLi579G8c7v1O83O1upHB11k=;
	b=KKTx4CUa7v1bb+9k7NXbKldBQz
	NpCdfwMIcq8nzxdsIShusp85diSN5xG2iUEnEeuyLObJFHj9v+HZoVBaO6lOFUPHTk8xjryogiyjZ
	BhDhRgWV10xdpuY2xbaLDYbsBl37O1F8fd7d+4dMTMs2Ge6OaqDCf0rrTnmZARZ3EJuctIZAM82mN
	YVi3zdCUDiYl3kU1AnRz1caxn4v+bXxKnv59L1v2xHA2Y8sKu2Z6zyVFpS5gwFTGd84sLZUZ048fR
	sVdvj2KZRQzVI1CZZw4rJ2VITCLE65nmmcKfeFcDupDU4NUeuffxuF0kt6dQFq/xd4W8nO0qohnpD
	cG8y1c7da/HdY58Xz5dhYYft6jnz/LlzpQYb+hiHXxQ1gsmnzGl6HY2KLgwFVZagS3foVrJV6RJgu
	PzUTvBMYy3KxJBUp3C6sgWtO9h1XpgOHzlMCK0JwVr+Wl2dtKGYoHcyhZkQOQI/tqhMdWD2xpqe9J
	HDy6etdqqm2xU2LiJw+Lerv65PCPWuVUT89wQ0C7me0lfnLpU1rkBPuYLMViOU09iav/+ymVLHhfx
	xmTCxyoDeqLUHJnEsRqS+HSfilePf+aYgxWwfn7Cp1vjTByreJAK5bK9keJUzmlqGEDDlzGZ0zo0m
	18MhGK0d6U9j64gG51Yp0jNqWMazllbVtxZwQw93g=;
To: qemu-devel@nongnu.org
Date: Tue, 07 May 2019 15:48:47 +0200
Message-ID: <1985409.cXXgv05A0a@silver>
In-Reply-To: <20190507125756.GP27205@redhat.com>
References: <590216e2666653bac21d950aaba98f87d0a53324.1557093245.git.qemu_oss@crudebyte.com>
	<1895198.u98Sn5qOsY@silver> <20190507125756.GP27205@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
Subject: Re: [Qemu-devel] [libvirt patch] qemu: adds support for virtfs 9p
 argument 'vii'
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

On Dienstag, 7. Mai 2019 13:57:56 CEST Daniel P. Berrang=E9 wrote:
> >       ...
> >       <filesystem type=3D'mount' accessmode=3D'mapped'>
> >      =20
> >         <source dir=3D'/vm/fs'/>
> >         <target dir=3D'root'/>
> >         <important path=3D'/var/shares'/>
> >         <important path=3D'/tmp'/>
> >      =20
> >       </filesystem>
> >    =20
> >     </devices>
> >  =20
> >   </domain>
> >=20
> > Like with the vii qemu virtfs command line argument, the order of the
> > "important" tag defines which one gets the highest inode namespace
> > (smallest generated suffix) on guest side.
>=20
> Do we think anyone is likely to use this feature in the real world ?

I don't know if other people need it, that's one of the reasons why I am=20
asking for a coarse high level feedback of the current v3 patch set before=
=20
getting into the details.

The only thing I can say right now is that I must use this feature when=20
running Samba to avoid all kinds of serious problems. And I could imagine=20
inode namespace control to become more of an issue once nested virtualizati=
on=20
becomes more popular.

> I'm not really a fan of the representation, because this is affecting
> guest ABI via a side effect of the ordering which is the kind of thing
> that has got us in trouble before.  If we need control over the IDs
> used for each mount point, then I tend to think we need to represent
> it explicitly such that the mgmt app sets the exact ID used.
>=20
>      <pathid dir=3D"/var/shares" id=3D"0x1"/>
>      <pathid dir=3D"/tmp" id=3D"0x3"/>
>=20
> this ensures that the IDs are still stable when adding or removing
> paths

Well, that would lead to the exact opposite of what you asked for. Because=
=20
allowing admins to configure an exact ID (which I think you mean should be =
used=20
as exact inode suffix by 9p then) would expose implementation details insid=
e=20
9pfs to config space, which are subject to change, might collide with=20
implementation details, and requires implementation knowledge and extreme c=
are=20
by admins so they would pick appropriate IDs with "suffix-free" property wh=
ich=20
are guaranteed to create unique numbers in all cases:

https://en.wikipedia.org/wiki/Prefix_code

Also keep in mind that one fs device might end up having multiple suffixes.

Hence my suggestion was to only expose the bare minimum to config space=20
regarding this issue: Asking (if required at all) admins which ones are the=
=20
most critical pathes regarding inode namespace for their use cases, and 9p=
=20
would then automatically generate appropriate suffixes for those mentioned =
by=20
admin to achieve the highest inode namespace appropriately and in a safe wa=
y.

Plus for the "important path=3D" semantics I suggested you don't have have =
to=20
use mount points BTW. You can use subdirs and even individual files and 9pf=
s=20
would then automatically resolve the appropriate fs device of the given pat=
h.=20
So e.g. when using nested virtualization, an admin inside a lower level gue=
st=20
does not even need to know the exact mount points on a higher level / host.

Best regards,
Christian Schoenebeck

