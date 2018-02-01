Received: from eggs.gnu.org ([2001:4830:134:3::10]:58199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehCOH-00013v-UA
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehCOE-0002rA-1P
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:46:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ehCOD-0002qi-R7
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:46:45 -0500
Date: Thu, 1 Feb 2018 10:46:39 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180201104639.GB5783@stefanha-x1.localdomain>
References: <20180131053318.13109-1-famz@redhat.com>
	<CAJ+F1C+v8B4STJS6v7ujGfu83oYFG6x9gcbu4D3T5VaDg382kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+v8B4STJS6v7ujGfu83oYFG6x9gcbu4D3T5VaDg382kg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Fam Zheng <famz@redhat.com>, QEMU <qemu-devel@nongnu.org>


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2018 at 11:06:05AM +0100, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Wed, Jan 31, 2018 at 6:33 AM, Fam Zheng <famz@redhat.com> wrote:
> > git-publish [1] is a convenient tool to send patches and has been
> > popular among QEMU developers.  Recently it has been made available in
> > Fedora official repo thanks to Stefan's work.
> >
> > One nice feature of the tool is a per-project configuration with
> > profiles, especially in which the cccmd option is a handy method to
> > create the Cc list.
> >
> > [1]: https://github.com/stefanha/git-publish
>=20
> It would be worth to update README "Submitting patches" with an example

Good idea!

The workflow for a new patch series is:

  $ git checkout -b my-feature
  ...work on feature...
  $ git publish

Your patch series has been tagged as my-feature-v1 if you need to refer
back to it in the future.

Sending v2:

  $ git checkout my-feature # same topic branch
  ...work on feature...
  $ git publish

Your patch series has been tagged as my-feature-v2.

> >
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  .gitpublish | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 .gitpublish
> >
> > diff --git a/.gitpublish b/.gitpublish
> > new file mode 100644
> > index 0000000000..2099c1520f
> > --- /dev/null
> > +++ b/.gitpublish
> > @@ -0,0 +1,57 @@
> > +#
> > +# Common git-publish profiles that can be used to send patches to QEMU=
 upstream.
> > +#
> > +# See https://github.com/stefanha/git-publish for more information
> > +#
> > +[gitpublishprofile "qemu"]

Please rename the "qemu" profile to "default".  This way no --profile
needs to be given:

  $ git publish

The default profile settings can be overridden by command-line options
and branch-specific settings.

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJacvAPAAoJEJykq7OBq3PIC4wH/jWwhjYmgisZBdWhW3ReBvnb
e4cGjG7xW9eCX0D/8HtKMuLkXX2Ef5kbpxC5vvuxCEsap4dgoUCPJrh/TIiwVP8J
qDiBijwM0vI4w0ZHHjK0iPh5AS2TSNdpxo1B8kiKJQ2370wcYRMSptIIEAiyM1RP
4mJ3dMcoX3fsa4oyNnZ4oIaCBdUV/PSoJMI+3yBuWa+BZORfHdCHE+tVqq/Ms7Q+
RTbxEIg12jaP87vJSW/fAh/9Kt4v4vgiS1VTWK+ZlrAC9p3seNILiYY+gwSPyP6T
CFTI7TmFryQEoKILF8+AVX/VXJL385L9ZTZxghNMDfJc20MagCEBxXKHN1R8KhM=
=cqi9
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
