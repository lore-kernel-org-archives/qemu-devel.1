Received: from eggs.gnu.org ([2001:4830:134:3::10]:37080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cykYk-0007fK-FR
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 15:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cykYj-0001qY-M4
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 15:37:38 -0400
References: <20170412164445.23039-1-berrange@redhat.com>
	<20170412164445.23039-2-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aafba9c5-2bc7-d12c-6c39-52cc837b20e8@redhat.com>
Date: Thu, 13 Apr 2017 21:37:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170412164445.23039-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OeiHj18m5lvq4VlBG85HNj5WwuTQgGDQ9"
Subject: Re: [Qemu-devel] [PATCH v4 1/4] qemu-img: add support for --object
 with 'dd' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OeiHj18m5lvq4VlBG85HNj5WwuTQgGDQ9
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <aafba9c5-2bc7-d12c-6c39-52cc837b20e8@redhat.com>
Subject: Re: [PATCH v4 1/4] qemu-img: add support for --object with 'dd'
 command
References: <20170412164445.23039-1-berrange@redhat.com>
 <20170412164445.23039-2-berrange@redhat.com>
In-Reply-To: <20170412164445.23039-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.04.2017 18:44, Daniel P. Berrange wrote:
> The qemu-img dd command added --image-opts support, but missed
> the corresponding --object support. This prevented passing
> secrets (eg auth passwords) needed by certain disk images.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--OeiHj18m5lvq4VlBG85HNj5WwuTQgGDQ9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljv03cSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A3zMIAJNmcQXNeujvqdVz1vgdT5AMd2EFRiUt
SqyN0AaF1/wxvEyVspnGa8NvQMWqv+KzgANrs83WyLBuNR8Gk1bfhLD+OaYWIM18
3bC6moZ0kqEeyvbqoH2e901kw6vqDGFaa34r/cDcwOAAJR9EwetvJzlPhHKUBFz/
arQRuIyfIwn04tgwJxsNODf2JAHsOULmnJ1pOzBKj6sniTWsO9R+NwCR/yLVCWvz
jRshutUZqF/4ZWl4mbOeuJm9IH+aGkZhiEUN3c7W8gH5HLSz8+yY2ZF6S0dwvDVV
txE1fKk2Mx8jM7uH+SLB1jOQ2FpjscMr181qWLGbDdYmVXKHvWEC+eM=
=SP9R
-----END PGP SIGNATURE-----

--OeiHj18m5lvq4VlBG85HNj5WwuTQgGDQ9--
