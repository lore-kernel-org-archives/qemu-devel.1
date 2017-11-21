Received: from eggs.gnu.org ([2001:4830:134:3::10]:59816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH7IH-00019l-Fo
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:04:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH7ID-0008HO-Ap
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:04:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eH7ID-0008HH-4l
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:04:45 -0500
Date: Tue, 21 Nov 2017 10:16:47 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171121101647.GB23759@stefanha-x1.localdomain>
References: <20171120142248.16432-1-stefanha@redhat.com>
	<20171120142248.16432-2-stefanha@redhat.com>
	<CAFEAcA-A4T_q5+AMuAmEAGCHA+BXaXXUqLiu2tvK6MOCiniZBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-A4T_q5+AMuAmEAGCHA+BXaXXUqLiu2tvK6MOCiniZBQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] Use qemu.org domain name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Daniel Berrange <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2017 at 02:26:15PM +0000, Peter Maydell wrote:
> On 20 November 2017 at 14:22, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > The owner of qemu.org has delegated authority to modify DNS records to
> > the QEMU Project.  This has allowed us to use the domain name without
> > worries about IP address changes or technical issues disrupting service.
> > The issues described in commit 859389810910f232188675d2f10b15f1aad77660
> > ("Use qemu-project.org domain name") have therefore been mitigated.
> >
> > This patch switches back to consistently using qemu.org instead of
> > qemu-project.org.
> >
> > Note that git-submodule(1) does not detect URL changes.  The following
> > commands clean up all submodules to ensure you will use the latest URLs:
> >
> >   $ git submodule deinit . # you'll be warned if you have local changes
> >   $ rm -rf .git/modules    # also clear cached .git/ directories
>=20
> Are we really sure we want to do this in the middle of
> a release? I'd be rather happier if we fixed the documentation
> now and saved messing around with .gitmodules until afterwards...

Will send v2 for QEMU 2.11.

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaE/0PAAoJEJykq7OBq3PIdvkH/RjKR3DtRz8UGEUR6xSpJ4jz
1EglcIU5mcGMUF5KEAVZ7VsO7qWDbb6vWGV5t/y4pNlssE61iEW3pZR9kzjNybMb
7A+9qKpf/u4Cp2yaDS7c7xUrl382uv9syRGDKm5+ARHRN5V0qdtWVK8U4vcgcoKg
a6X5B2UCGZDTHPPGbZalCtFs4OGrSGghLJtqt+smb+oMdttIQGAT43D+yjTTznk2
yEvsNGBckGi9yHUkdtPSr4XAmRLShhP71b+YbdiPibeBvK5kpI7qtXvrR/xm3GEZ
VIxYyGDvaiI+6dYUwZoj/CcTDXEIbXZvYYymBsSPfqoN684fYaFS2JWW95vcnJE=
=8yxQ
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
