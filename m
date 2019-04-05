Received: from eggs.gnu.org ([209.51.188.92]:42307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hCOEg-00013n-3T
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hCOEe-0006NF-Tv
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:46:21 -0400
Date: Fri, 5 Apr 2019 14:46:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190405124608.GA4597@linux.fritz.box>
References: <20190328182810.21497-1-kwolf@redhat.com>
	<20190405103247.GG25152@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20190405103247.GG25152@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/2] file-posix:
 query-qemu-features for auto-read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, armbru@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 05.04.2019 um 12:32 hat Stefan Hajnoczi geschrieben:
> On Thu, Mar 28, 2019 at 07:28:08PM +0100, Kevin Wolf wrote:
> > auto-read-only=3Don changed its behaviour in file-posix for the 4.0
> > release. This change cannot be detected through the usual mechanisms
> > like schema introspection.
> >=20
> > I took Stefan's patch 'qmp: add query-qemu-capabilities', removed the
> > feature that he originally wanted this for and addressed the review
> > comments. The introduction of the file-posix-dynamic-auto-read-only
> > feature is a separate patch.
> >=20
> > Stefan, I kept you as the author of the first patch and also your
> > Signed-off-by. Is this okay with you or would you prefer a change?
>=20
> Sorry I was unresponsive.  I'm fine with the authorship and
> Signed-off-by: but won't be offended if either or both are removed when
> the patch is reworked (my code is trivial).

The plan is now that we integrate features in the QAPI schema (attached
to struct definitions), so they will be available with the normal schema
introspection. Obviously, this will be a completely new patch series
that isn't based on this patch any more.

Kevin

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcp04QAAoJEH8JsnLIjy/Wr+gP/1DVOdxvZnHw/UvD6eB9Ioay
HSr3pthwSk/ClsVtyu9+rTnpmgIlxhVf/PKU1Xhwohv5dk5RRQtfUqY+FQRj9uW9
eUlVAcuQ96xDg1pEjM0DWLSUBph0FvXD1xLChNMkt6LRxsaCj4Uqg4jPZvAWEg9s
PEyE2Z2WEESlgsOvRGJG3KpgxW4hLFnNDpuDvm71JgysO2j2U2Huwpj38m0NQ91o
Q/YvG6yBg2PtmKsCyH2+IwoWz/Gy8OYZBjq+WGbXSEo+QrhD18WYm83yqKbvfYx9
R4MbDIO1vIaJy7i6thWmq5ssYBbxp1I7yZRXaPacVHVKnQRyACLpMgi6h7d5Ykju
BrbwkAXQDJA5WF8VUbs10WGr/8umkDJb+43vr/6d/KUcfUiw13cs46PlcsCHTAT+
tw1soH6UfmhABaByyWq+TEmh0m/VR1EbqQ6RxI8c8FBFvkvTeB+6SHayUfCO/8wN
qO30sDI/J3z2fysWRo0gxE8sPANm5xzWSrL48Ep3mpShycqHaXXTUalME5+24Cdk
+9e1xhChEk8gXONnYZa+mf5p2ZcaolF4BoGvMPJsna017S7SnuHeLUQIuat1Hg9V
+A5pMItHeQxHRRfjIcoL+3w6gIRSvb1i//YJSjtgXX97iEMfYpIp1EuAni8fimIa
Ry9j8hilGNeHQdUTOiwb
=8iFh
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
