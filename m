Received: from eggs.gnu.org ([2001:4830:134:3::10]:50005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dAaHS-0006U3-F2
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dAaHP-0000eQ-RT
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:04:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dAaHP-0000dz-L4
	for qemu-devel@nongnu.org; Tue, 16 May 2017 07:04:39 -0400
Date: Tue, 16 May 2017 12:04:30 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170516110430.GG9105@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170515134753.28412-1-stefanha@redhat.com>
	<87a86erypz.fsf@linaro.org>
	<20170516104556.GD27093@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170516104556.GD27093@stefanha-x1.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] .gdbinit: load QEMU sub-commands when gdb
 starts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Tue, May 16, 2017 at 11:45:56AM +0100, Stefan Hajnoczi wrote:
> On Mon, May 15, 2017 at 03:17:28PM +0100, Alex Benn=C3=A9e wrote:
>=20
> > How would it work for out-of-tree builds?
>=20
> ./.gdbinit assumes your current working directory is the root of the
> QEMU source tree.  If gdb is launched outside this directory then
> nothing will happen (e.g. from arm-softmmu/ or from an out-of-tree
> build).
>=20
> I'm not sure if there is a simple way of making ./.gdbinit work from
> out-of-tree build directories.

Just add a Makefile rule, as a pre-requisite of qemu system arch
build, that symlinks $srcdir/.gdbinit into $builddir, or something
like that.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
