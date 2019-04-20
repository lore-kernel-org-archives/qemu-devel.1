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
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 21 Apr 2019 00:41:01 +0200
Message-ID: <1736754.y8mDa9Bjs0@silver>
In-Reply-To: <3754934.J2WuGLFlGG@silver>
References: <3205397.r2gctG0f81@silver> <20190330174751.1eb8e298@bahia.lan>
	<3754934.J2WuGLFlGG@silver>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Subject: Re: [Qemu-devel] virtfs/9p duplicate inodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Antonios Motakis <antonios.motakis@huawei.com>, Greg Kurz <groug@kaod.org>

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
