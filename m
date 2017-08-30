Received: from eggs.gnu.org ([2001:4830:134:3::10]:32839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dn02V-0001p5-6k
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dn02Q-0000bT-8l
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:16:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dn02Q-0000a7-1t
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:15:58 -0400
Date: Wed, 30 Aug 2017 18:15:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170830101551.GM4208@lemon.lan>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-4-famz@redhat.com>
	<9658452f-c89f-43d2-07ff-5d620fd471a9@amsat.org>
	<20170830032949.GC4208@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170830032949.GC4208@lemon.lan>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Wed, 08/30 11:29, Fam Zheng wrote:
> On Tue, 08/29 09:15, Philippe Mathieu-Daud=E9 wrote:
> > > +        self._args =3D [ \
> > > +            "-nodefaults", "-m", "2G",
> > > +            "-cpu", "host",
> > > +            "-netdev", "user,id=3Dvnet,hostfwd=3D:0.0.0.0:0-:22",
> >=20
> > Testing with debian/unstable:
> >=20
> > $ make vm-build-netbsd V=3D1
> > ./tests/vm/netbsd  --debug   --image "tests/vm/netbsd.img" --build-qe=
mu .
> > DEBUG:root:Creating archive /tmp/qemu-vm-PxfXNv/data-3a52c.tar for da=
ta dir:
> > .
> > DEBUG:root:QEMU args: -nodefaults -m 2G -cpu host -netdev
> > user,id=3Dvnet,hostfwd=3D:0.0.0.0:0-:22 -device virtio-net-pci,netdev=
=3Dvnet -vnc
> > :0,to=3D20 -serial file:/tmp/qemu-vm-PxfXNv/serial.out -smp 4 -enable=
-kvm
> > -device VGA -drive
> > file=3Dtests/vm/netbsd.img,snapshot=3Don,if=3Dnone,id=3Ddrive0,cache=3D=
writeback
> > -device virtio-blk,drive=3Ddrive0,bootindex=3D0 -drive file=3D/tmp/qe=
mu-vm-PxfXNv/data-3a52c.tar,if=3Dnone,id=3Ddata-3a52c,cache=3Dwriteback,f=
ormat=3Draw
> > -device virtio-blk,drive=3Ddata-3a52c,serial=3Ddata-3a52c,bootindex=3D=
1
> > Failed to prepare guest environment
>=20
> Can you please look into the stderr of the QEMU command line to see wha=
t
> arguments went wrong? (I hope the qemu.py improvement patches on the li=
st can
> give a better error message in such cases.)

I've tested with Fedora 26's qemu-system-x86-2.9.0-5.fc26.x86_64 and got =
the
failure due to the hostfwd syntax:

qemu-system-x86_64: -netdev user,id=3Dvnet,hostfwd=3D:0.0.0.0:0-:22: inva=
lid host forwarding rule ':0.0.0.0:0-:22'
qemu-system-x86_64: -netdev user,id=3Dvnet,hostfwd=3D:0.0.0.0:0-:22: Devi=
ce 'user' could not be initialized

But it makes sense to use dynamic port allocation to avoid collision.

Since it's about developing QEMU, using cutting edge QEMU features is not=
 that
bad. Let's keep this one.

Fam
