Received: from eggs.gnu.org ([209.51.188.92]:56954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1wJS-0000Gv-9l
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1wJR-0007iq-Gm
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:56:06 -0500
Date: Thu, 7 Mar 2019 17:55:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190307165554.GM5786@linux.fritz.box>
References: <20190307151046.15086-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190307151046.15086-1-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/2] qemu-iotests: Add dependency to
 qemu-block tools
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>

Am 07.03.2019 um 16:10 hat Philippe Mathieu-Daud=E9 geschrieben:
> Hi Kevin, Max, John.
>=20
> Two trivial fixes I encountered while trying to run QEMU test suite on
> a distribution which doesn't has the qemu-tools distrib-wide installed,
> see https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08415.html=
:
>=20
>   $ make vm-build-ubuntu.i386
>   Traceback (most recent call last):
>     File "source/qemu/tests/vm/basevm.py", line 236, in main
>       return vm.build_image(args.image)
>     File "tests/vm/ubuntu.i386", line 67, in build_image
>       subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
>   OSError: [Errno 2] No such file or directory
>   tests/vm/Makefile.include:23: recipe for target 'tests/vm/ubuntu.i386=
.img' failed
>   make: *** [tests/vm/ubuntu.i386.img] Error 2
>=20
> All patches are reviewed.

Thanks, applied to the block branch.

Kevin
