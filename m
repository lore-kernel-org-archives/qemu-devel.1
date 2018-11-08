Received: from eggs.gnu.org ([2001:4830:134:3::10]:41342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKhUS-0001UJ-9g
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gKhUD-0007Wj-LI
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:24:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48663)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gKhUC-0007Vm-Em
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:24:29 -0500
Date: Thu, 8 Nov 2018 10:24:18 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181108102418.GE17083@stefanha-x1.localdomain>
References: <20181105181353.39804-1-mst@redhat.com>
	<20181105181353.39804-3-mst@redhat.com>
	<a21e8e21-d056-1e9a-3726-54f8ce24a162@redhat.com>
	<20181106091147-mutt-send-email-mst@kernel.org>
	<4b68930c-1fc3-9462-8f9e-671b414e712d@redhat.com>
	<2913be5b-f03e-b42c-1128-8f73ae7054f7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
In-Reply-To: <2913be5b-f03e-b42c-1128-8f73ae7054f7@redhat.com>
Subject: Re: [Qemu-devel] [PULL 02/33] tests: Move
 tests/hex-loader-check-data/ to tests/data/hex-loader/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Su Hang <suhang16@mails.ucas.ac.cn>, Paolo Bonzini <pbonzini@redhat.com>


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2018 at 05:16:14PM +0100, Laurent Vivier wrote:
> On 06/11/2018 16:15, Philippe Mathieu-Daud=E9 wrote:
> > On 6/11/18 15:13, Michael S. Tsirkin wrote:
> >> On Tue, Nov 06, 2018 at 02:27:18PM +0100, Philippe Mathieu-Daud=E9 wro=
te:
> >>> On 5/11/18 19:14, Michael S. Tsirkin wrote:
> >>>> From: Peter Maydell <peter.maydell@linaro.org>
> >>>>
> >>>> Currently tests/hex-loader-check-data contains data files used
> >>>> by the hexloader-test, and configure individually symlinks those
> >>>> data files into the build directory using a wildcard.
> >>>>
> >>>> Using a wildcard like this is a bad idea, because if a new
> >>>> data file is added, nothing causes configure to be rerun,
> >>>> and so no symlink is added for the new file. This can cause
> >>>> tests to spuriously fail when they can't find their data.
> >>>> Instead, it's better to symlink an entire directory of
> >>>> data files. We already have such a directory: tests/data.
> >>>>
> >>>> Move the data files from tests/hex-loader-check-data/ to
> >>>> tests/data/hex-loader/, and remove the unnecessary symlinking.
> >>>>
> >>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >>>
> >>> I reviewed/tested this patch too.
> >>
> >>
> >> Thanks a lot Philippe!
> >> It is unfortunately too late to update this patch info in git
> >> commit history, however your help is still greatly appreciated!
> >=20
> > No worry, I'm not mad at all, but there might be an issue in your git PR
> > workflow, this series also missed your maintainer S-o-b.
> >=20
> > Peter: Can you add a such check in your scripts? (during next merge
> > window, no hurry).
> >=20
> > Rather than your scripts, this should be in scripts a maintainer can run
> > locally, such ./scripts/checkpatch.pl --maintainer or
> > ./scripts/checkseries.xx.
>=20
> I think such tool already exists: with git-publish you can configure a
> "pre-publish-send-email" hook, and check your S-o-B is present.

For making my own commits .git/hooks/pre-commit is useful:
http://blog.vmsplice.net/2011/03/how-to-automatically-run-checkpatchpl.html

For sending patch series, git-publish is useful:
https://github.com/stefanha/git-publish/blob/master/hooks/pre-publish-send-=
email.example
https://github.com/stefanha/git-publish/

Stefan

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJb5A7SAAoJEJykq7OBq3PIzp4H/2eXfAi6gthHVx2nWsyZ5s/G
KEokIzno8st0isdgu0KAmd8WnNSCFvfg8Z77VugNkGnEhVcdAUnfLqbV+Yyrbfxg
KNi0Erq75pN/FeD6cFVKmMgiyZR6FSIXz9B2vxUOBkUMk7xPPg3s+/W000CWsd9B
zXSNzygDWCg3fbOgOjjpiz1Rxm/5nBpTvcvWIsjHjoFS1ZNx3+xvH8xXdSKl2Fr5
0EY9j0zmCvIVQXHCnjW1o/gQvXW6/MkeC8OCVafrR0ZpZ5cjZGy+g5F2wgScRgdp
Uo0bIA2H1Ix56mTrCxdvJPEMof9/aZQp9HDEgWxfZrRwLeIFDqs4hl5FyoGo5MI=
=LdVy
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
