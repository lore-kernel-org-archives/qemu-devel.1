Received: from eggs.gnu.org ([2001:4830:134:3::10]:51357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw3xY-00060g-Do
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw3xU-00088Y-ER
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:44:08 -0400
Date: Thu, 6 Apr 2017 10:10:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406091010.GA21261@stefanha-x1.localdomain>
References: <CAO_EM_=wECMYRRaDyPtY8sKFZF8owp0u2sE4k_oeS=BLF9B2Mw@mail.gmail.com>
	<20170403165755.GF3539@stefanha-x1.localdomain>
	<87zifw9s6f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <87zifw9s6f.fsf@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-block] New iotest repros failures on virtio
 external snapshot with iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Ed Swierk <eswierk@skyportsystems.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 04, 2017 at 03:13:44PM +0100, Alex Benn=E9e wrote:
>=20
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> > On Wed, Mar 29, 2017 at 07:01:38PM -0700, Ed Swierk wrote:
> >> Parts of qemu's block code have changed a lot in recent months but are
> >> not well exercised by current tests.
> <snip>
> >
> > 4. How to automate tests with real Linux guests?  This is a complex
> > topic and probably what we should discuss in this email thread.
> >
> > The buildroot + busybox approach is good for a small set of sanity
> > tests.  There was a similar attempt here:
> > https://github.com/stsquad/qemu-jeos
> >
> > Building from source becomes a challenge when other people want to add
> > software to test other areas of QEMU.  The process also requires
> > attention to maintain the image over time (e.g. as host build
> > environments change).
> >
> > There are image builder tools like virt-builder and mkosi for building
> > bootable virtual machine images based on standard Linux distros:
> > http://libguestfs.org/virt-builder.1.html
> > https://github.com/systemd/mkosi
> >
> > This eliminates the build-from-source hassles and gives us a full Linux
> > guest environment.  Booting is very fast with mkosi so the advantage to
> > custom building a minimal image is negligible.
>=20
> Does it entirely? If your building a ARM guest on x86 how do you ensure
> the cross-compilers are correct for the kernel and userspace?

virt-builder and mkosi install binary distros like Debian or Fedora.
They do not compile from source.

virt-builder supports cross-arch image building so it's a good starting
point for QEMU guest images.

> > My suggestion is:
> >
> > Let's pick an image builder tool like virt-builder and keep a single
> > build script per guest architecture (e.g.  build-test-os-x86_64.sh).
> > All tests for that architecture run against the same disk image.
> >
> > It's easy to add additional software to the disk image by modifying the
> > build script.
> >
> > A Makefile ensures that the image file gets rebuilt if the build script
> > has changed.
>=20
> I have experimented building LTP for foreign guests inside docker
> images. I expect the docker build image could be extended to build full
> kernel and file-systems in a known environment, possibly using
> virt-builder to do it.

My concern with building from source is that extending and maintaining
the infrastructure does not scale.  These efforts fizzle out like
qemu-jeos because no one really has time to maintain them.  Few people
want to extend them because they are complex and brittle.

Image builder tools skip the complexity of build-from-source.  You start
with something like a Dockerfile or virt-builder command-line.  It's
much easier for people to contribute and there is much less that can go
wrong at image build time.

Stefan

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5gXyAAoJEJykq7OBq3PIZjUH/iwRi7yiTN6nMc6Cf60P+oDR
IDycvt2CBCRNWOVhauErPsCHwtqr4eGl/iyvAvs58YpkqF7zWnoHV8TAhebOjzcs
tpkdnE8e5DD+OC9NQ7ShQDU/UzoBylpvBJkwusZQE/bobMv4JpciaEbt16xsghXm
BiGEPDLPbWk17mVDxzWq49yeE3N4vuwvt6qBFvxviJ3LCMPuZFbYwyftqUfupWYF
0NagqhThQqY8ZVQqvRJ1hGLGFbqU/GC70IxvJoYlEopFBCrvs/zJwqGqxrO9iIIX
+ZVCJ0OqqBOVKbM26MIwmv06xIPOOjOsVWIajy9BNo+Kwg7F2/xLvbaAr/FPoUs=
=R6PR
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
