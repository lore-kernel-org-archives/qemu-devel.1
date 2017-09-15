Received: from eggs.gnu.org ([2001:4830:134:3::10]:40230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsryf-0004FN-1B
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dsryZ-0003h4-Ew
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:52:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dsryZ-0003gj-9Z
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:52:15 -0400
Date: Fri, 15 Sep 2017 22:52:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170915145208.GB21852@lemon.lan>
References: <20170913030119.3957-1-famz@redhat.com>
	<20170913030119.3957-13-famz@redhat.com>
	<87tw0482fo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87tw0482fo.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 12/13] tests: Add README for vm tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Fri, 09/15 15:24, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/vm/README | 63 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> >  1 file changed, 63 insertions(+)
> >  create mode 100644 tests/vm/README
> >
> > diff --git a/tests/vm/README b/tests/vm/README
> > new file mode 100644
> > index 0000000000..7d2fe4ac8d
> > --- /dev/null
> > +++ b/tests/vm/README
> > @@ -0,0 +1,63 @@
> > +=3D=3D=3D VM test suite to run build in guests =3D=3D=3D
> > +
> > +=3D=3D Intro =3D=3D
> > +
> > +This test suite contains scripts that bootstrap various guest images=
 that have
> > +necessary packages to build QEMU. The basic usage is documented in M=
akefile
> > +help which is displayed with "make vm-test".
> > +
> > +=3D=3D Quick start =3D=3D
> > +
> > +Run "make vm-test" to list available make targets.
>=20
> Running make vm-build-netbsd I get several prompts for pass-phrase and
> password:
>=20
>     Enter passphrase for key './vm-test-QdFtLJ.tmp/id_rsa':
>     Password for qemu@:
>     Enter passphrase for key './vm-test-QdFtLJ.tmp/id_rsa':
>     Password for qemu@:
>     ar: creating libfdt/libfdt.a
>=20
> Which seems odd considering the private key isn't protected by a
> passphrase and the build tools know what the password is.

Yeah, this version also has a corrupted private key file (the first byte,=
 '-',
is somehow deleted). Sorry for the mess. :(

>=20
> We should also mention the images are added to ${QEMU_SRC}/tests/vm/

OK, will do. Also as Peter and Daniel have pointed out, the hostfwd and v=
nc
should listen on a local address rather than 0.0.0.0. I will send v8 with=
 all of
them fixed.

Fam
