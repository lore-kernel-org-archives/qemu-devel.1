Received: from eggs.gnu.org ([2001:4830:134:3::10]:37805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmthW-0006TX-5z
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmthT-0007cj-2t
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:29:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dmthS-0007cC-Ru
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 23:29:54 -0400
Date: Wed, 30 Aug 2017 11:29:49 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170830032949.GC4208@lemon.lan>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-4-famz@redhat.com>
	<9658452f-c89f-43d2-07ff-5d620fd471a9@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9658452f-c89f-43d2-07ff-5d620fd471a9@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 03/10] tests: Add vm test lib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Tue, 08/29 09:15, Philippe Mathieu-Daud=E9 wrote:
> > +        self._args =3D [ \
> > +            "-nodefaults", "-m", "2G",
> > +            "-cpu", "host",
> > +            "-netdev", "user,id=3Dvnet,hostfwd=3D:0.0.0.0:0-:22",
>=20
> Testing with debian/unstable:
>=20
> $ make vm-build-netbsd V=3D1
> ./tests/vm/netbsd  --debug   --image "tests/vm/netbsd.img" --build-qemu=
 .
> DEBUG:root:Creating archive /tmp/qemu-vm-PxfXNv/data-3a52c.tar for data=
 dir:
> .
> DEBUG:root:QEMU args: -nodefaults -m 2G -cpu host -netdev
> user,id=3Dvnet,hostfwd=3D:0.0.0.0:0-:22 -device virtio-net-pci,netdev=3D=
vnet -vnc
> :0,to=3D20 -serial file:/tmp/qemu-vm-PxfXNv/serial.out -smp 4 -enable-k=
vm
> -device VGA -drive
> file=3Dtests/vm/netbsd.img,snapshot=3Don,if=3Dnone,id=3Ddrive0,cache=3D=
writeback
> -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -drive file=3D/tmp/qemu=
-vm-PxfXNv/data-3a52c.tar,if=3Dnone,id=3Ddata-3a52c,cache=3Dwriteback,for=
mat=3Draw
> -device virtio-blk,drive=3Ddata-3a52c,serial=3Ddata-3a52c,bootindex=3D1
> Failed to prepare guest environment

Can you please look into the stderr of the QEMU command line to see what
arguments went wrong? (I hope the qemu.py improvement patches on the list=
 can
give a better error message in such cases.)

Fam
