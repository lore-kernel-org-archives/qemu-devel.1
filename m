Received: from eggs.gnu.org ([2001:4830:134:3::10]:46346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cp4Xn-0005SL-RG
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 22:56:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cp4Xm-0008TC-V1
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 22:56:39 -0400
References: <20170317104541.28979-1-stefanha@redhat.com>
	<20170317104541.28979-4-stefanha@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aa011644-070f-356b-1156-de9a3793444b@redhat.com>
Date: Sat, 18 Mar 2017 03:56:27 +0100
MIME-Version: 1.0
In-Reply-To: <20170317104541.28979-4-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O2qgxd3qLBsqHaGJ3g3kwPKfcFK5aHNTc"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qemu-img: print short help on
 getopt failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O2qgxd3qLBsqHaGJ3g3kwPKfcFK5aHNTc
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <aa011644-070f-356b-1156-de9a3793444b@redhat.com>
Subject: Re: [PATCH v2 3/3] qemu-img: print short help on getopt failure
References: <20170317104541.28979-1-stefanha@redhat.com>
 <20170317104541.28979-4-stefanha@redhat.com>
In-Reply-To: <20170317104541.28979-4-stefanha@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 17.03.2017 11:45, Stefan Hajnoczi wrote:
> Printing the full help output obscures the error message for an invalid=

> command-line option or missing argument.
>=20
> Before this patch:
>=20
>   $ ./qemu-img --foo
>   ...pages of output...
>=20
> After this patch:
>=20
>   $ ./qemu-img --foo
>   qemu-img: unrecognized option '--foo'
>   Try 'qemu-img --help' for more information
>=20
> This patch adds the getopt ':' character so that it can distinguish
> between missing arguments and unrecognized options.  This helps provide=

> more detailed error messages.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qemu-img.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++---=
--------
>  1 file changed, 97 insertions(+), 20 deletions(-)

Uh, right, this was pretty much pre-existing. Then even more so thanks
for this patch. :-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--O2qgxd3qLBsqHaGJ3g3kwPKfcFK5aHNTc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljModsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AckAIAMQmd+7bL/kUJKdZW5KpDfCvIkPcHBSS
BKUeK5dOGwmht43fz30Si1RC/EpUi3Qb7322ZOjQcxC4SMRajCYvnHz83rTyKV6Q
/OWU1DWgE+lhqqBE6UDOkMRbh0L/mVsamaDxBYEOR5+wvKPXk60JmTJa9pxCZLfM
5kyAJhjCWyMh37VF4eHenY8jkQNFHLLbG5gdZhC4uRNESDk8TcPS1zGyi4JPlbWU
/5xaZkt2fu4fUb5DreCQrmo56e/ZhIv6EGpxn0XCzv5lipYl8/06jkLPzmtGenVx
e+cuB2Z10s4IWuRIQsP46RmmysFXd2hOIGmKCDdkG2XeSYLpc67kjcU=
=5KL2
-----END PGP SIGNATURE-----

--O2qgxd3qLBsqHaGJ3g3kwPKfcFK5aHNTc--
