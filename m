Received: from eggs.gnu.org ([2001:4830:134:3::10]:53793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1dYbo5-0008E6-U4
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1dYbo0-0004Nd-U8
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:33:41 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Fri, 21 Jul 2017 17:23:24 +0000
Message-ID: <DM2PR21MB0060502DD5939A4A46FB527D9EA40@DM2PR21MB0060.namprd21.prod.outlook.com>
References: <20170721102059.14663-1-famz@redhat.com>
	<20170721102059.14663-3-famz@redhat.com>
In-Reply-To: <20170721102059.14663-3-famz@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/2] file-posix: Do runtime check for ofd
 lock API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>

> From: Fam Zheng [mailto:famz@redhat.com]
> Sent: Friday, 21 July 2017 3:21
>=20
> It is reported that on Windows Subsystem for Linux, ofd operations fail
> with -EINVAL. In other words, QEMU binary built with system headers that
> exports F_OFD_SETLK doesn't necessarily run in an environment that
> actually supports it:
>=20
> $ qemu-system-aarch64 ... -drive file=3Dtest.vhdx,if=3Dnone,id=3Dhd0 \
>     -device virtio-blk-pci,drive=3Dhd0
> qemu-system-aarch64: -drive file=3Dtest.vhdx,if=3Dnone,id=3Dhd0: Failed t=
o unlock
> byte 100
> qemu-system-aarch64: -drive file=3Dtest.vhdx,if=3Dnone,id=3Dhd0: Failed t=
o unlock
> byte 100
> qemu-system-aarch64: -drive file=3Dtest.vhdx,if=3Dnone,id=3Dhd0: Failed t=
o lock
> byte 100
>=20
> Let's do a runtime check to cope with that.
>=20
> Reported-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

If it helps:
Tested-By: Andrew Baumann <andrew.baumann@microsoft.com>

Thanks!
Andrew
