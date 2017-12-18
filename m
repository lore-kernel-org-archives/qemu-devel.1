Received: from eggs.gnu.org ([2001:4830:134:3::10]:49363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eQkMV-0005WP-MP
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 20:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eQkMS-0000pA-GF
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 20:36:59 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2298 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eQkMS-0000dc-58
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 20:36:56 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Mon, 18 Dec 2017 01:36:36 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB08FA5@DGGEMM505-MBS.china.huawei.com>
References: <1511426872-13980-1-git-send-email-jianjay.zhou@huawei.com>
	<20171205195816.GH2405@work-vm> <20171215122139.GC11724@redhat.com>
	<20171215151504.GC2358@work-vm>
In-Reply-To: <20171215151504.GC2358@work-vm>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] docs/devel/migration.txt: keep functions
 consistent with the code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com" <quintela@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>

> -----Original Message-----
> From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> Sent: Friday, December 15, 2017 11:15 PM
> To: Daniel P. Berrange <berrange@redhat.com>
> Cc: Zhoujian (jay) <jianjay.zhou@huawei.com>; qemu-devel@nongnu.org;
> quintela@redhat.com; Huangweidong (C) <weidong.huang@huawei.com>; wangxin
> (U) <wangxinxin.wang@huawei.com>
> Subject: Re: [PATCH] docs/devel/migration.txt: keep functions consistent
> with the code
>=20
> * Daniel P. Berrange (berrange@redhat.com) wrote:
> > On Tue, Dec 05, 2017 at 07:58:16PM +0000, Dr. David Alan Gilbert wrote:
> > > * Jay Zhou (jianjay.zhou@huawei.com) wrote:
> > > > Since the commit 11808bb0c422134bf09119f4aa22c59b0ce84bf3 removed
> > > > the put_buffer callback and using an iovec based write handler
> > > > instead, the docs should be sync with the code too.
> > > >
> > > > Signed-off-by: Jay Zhou <jianjay.zhou@huawei.com>
> > >
> > > Lets check with Dan (added to cc) since he wrote 11808bb; it might
> > > be best just to rever to migration/qemu-file.h for an explanation of
> > > each function.
> >
> > The updates look ok, but I tend to think this entire section of
> > migrate.txt should be deleted, in favour of the inline APIs
> > docs in mijgration/qemu-file.h   As a developer the header file
> > is where I would look for this kind of API description. The
> > migration.txt can just point epople to the header file for API docs.

Yes, agreed.

>=20
> OK, I'll do that on top of my rework to rst.
>=20

It's OK for me. :)

Regards,
Jay
