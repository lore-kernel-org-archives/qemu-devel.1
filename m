Received: from eggs.gnu.org ([2001:4830:134:3::10]:49345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtuli-0002MH-AP
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dtulc-0001T3-7Y
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:03:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dtulb-0001SW-Vj
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:03:12 -0400
Date: Mon, 18 Sep 2017 20:03:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170918120300.GM15551@lemon.lan>
References: <20170918024402.3265-1-famz@redhat.com>
	<20170918024402.3265-13-famz@redhat.com>
	<87d16ojq9g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87d16ojq9g.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 12/13] tests: Add README for vm tests
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

On Mon, 09/18 10:43, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  tests/vm/README | 85 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
> >  1 file changed, 85 insertions(+)
> >  create mode 100644 tests/vm/README
> >
> > diff --git a/tests/vm/README b/tests/vm/README
> > new file mode 100644
> > index 0000000000..fa30a79ea7
> > --- /dev/null
> > +++ b/tests/vm/README
> > @@ -0,0 +1,85 @@
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
> > +Run "make vm-test" to list available make targets. Invoke a specific=
 make
> > +command to run build test in an image. For example, "make vm-build-f=
reebsd"
> > +will build the source tree in the FreeBSD image. The command can be =
executed
> > +from either the source tree or the build dir; if the former, ./confi=
gure is not
> > +needed. The command will then generate the test image in ./tests/vm/=
 under the
> > +working directory.
> > +
> > +=3D=3D QEMU binary =3D=3D
> > +
> > +By default, qemu-system-x86_64 is searched in $PATH to run the guest=
. If there
> > +isn't one, or if it is older than 2.10, the test won't work. In this=
 case,
> > +provide the QEMU binary in env var: QEMU=3D/path/to/qemu-2.10+.
> > +
> > +=3D=3D Make jobs =3D=3D
> > +
> > +The "-j$X" option in the make command line is not propagated into th=
e VM,
> > +specify "J=3D$X" to control the make jobs in the guest.
> > +
> > +=3D=3D Debugging =3D=3D
> > +
> > +Add "DEBUG=3D1" and/or "V=3D1" to the make command to allow interact=
ive debugging
> > +and verbose output. If this is not enough, see the next section.
> > +
> > +=3D=3D Manual invocation =3D=3D
> > +
> > +Each guest script is an executable script with the same command line=
 options.
> > +For example to work with the netbsd guest, use $QEMU_SRC/tests/vm/ne=
tbsd:
> > +
> > +    $ cd $QEMU_SRC/tests/vm
> > +
> > +    # To bootstrap the image
> > +    $ ./netbsd --build-image --image /var/tmp/netbsd.img
> > +    <...>
> > +
> > +    # To run an arbitrary command in guest (the output will not be e=
choed unless
> > +    # --debug is added)
> > +    $ ./netbsd --debug --image /var/tmp/netbsd.img uname -a
> > +
> > +    # To build QEMU in guest
> > +    $ ./netbsd --debug --image /var/tmp/netbsd.img --build-qemu
> > $QEMU_SRC
>=20
> This doesn't work:
>=20
> 10:41:38 [alex@zen:~/l/q/q/t/vm] review/fam-vmbuild-v8(+2/-2) =B1 ./net=
bsd --debug --image netbsd.img --build-qemu /home/alex/lsrc/qemu/qemu.git=
/
> DEBUG:root:Creating archive ./vm-test-9yVAeh.tmp/data-9b5f9.tar for src=
_dir dir: /home/alex/lsrc/qemu/qemu.git/
> ./scripts/archive-source.sh: 27: ./scripts/archive-source.sh: cannot cr=
eate ./vm-test-9yVAeh.tmp/data-9b5f9.tar.list: Directory nonexistent
> Failed to prepare guest environment
> Traceback (most recent call last):
>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/basevm.py", line 234, in=
 main
>     vm.add_source_dir(args.build_qemu)
>   File "/home/alex/lsrc/qemu/qemu.git/tests/vm/basevm.py", line 140, in=
 add_source_dir
>     stdout=3Dself._stdout, stderr=3Dself._stderr)
>   File "/usr/lib/python2.7/subprocess.py", line 541, in check_call
>     raise CalledProcessError(retcode, cmd)
> CalledProcessError: Command '['./scripts/archive-source.sh', './vm-test=
-9yVAeh.tmp/data-9b5f9.tar']' returned non-zero exit status 2
>=20
> Either adjust the call to be from QEMU_SRC or make the call to
> archive-source smarter.

Yup, I failed to verify manual invocations since the revision which intro=
duced
archive-source.sh.. I would use absolute path for tmpdir everywhere, by
squashing in this:

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 77d07b161d..cbaa061c72 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -43,7 +43,9 @@ class BaseVM(object):
     name =3D "#base"
     def __init__(self, debug=3DFalse, vcpus=3DNone):
         self._guest =3D None
-        self._tmpdir =3D tempfile.mkdtemp(prefix=3D"vm-test-", suffix=3D=
".tmp", dir=3D".")
+        self._tmpdir =3D os.path.realpath(tempfile.mkdtemp(prefix=3D"vm-=
test-",
+                                                         suffix=3D".tmp"=
,
+                                                         dir=3D"."))
         atexit.register(shutil.rmtree, self._tmpdir)

         self._ssh_key_file =3D os.path.join(self._tmpdir, "id_rsa")

Fam
