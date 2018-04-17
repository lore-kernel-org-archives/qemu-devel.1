Received: from eggs.gnu.org ([2001:4830:134:3::10]:60233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f8KwL-0007CY-Gn
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f8KwI-0002XU-8D
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:22:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36242 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1f8KwI-0002XL-42
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 03:22:06 -0400
Date: Tue, 17 Apr 2018 15:22:01 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180417072201.GK10770@stefanha-x1.localdomain>
References: <1523861081-3600-1-git-send-email-thuth@redhat.com>
	<1523861081-3600-3-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBYU9MM4gf8jKg2V"
Content-Disposition: inline
In-Reply-To: <1523861081-3600-3-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 for-2.13 2/3] net: Get rid of 'vlan'
 terminology and use 'hub' instead in the source files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>


--gBYU9MM4gf8jKg2V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2018 at 08:44:40AM +0200, Thomas Huth wrote:
> 'vlan' is very confusing since it does not mean something like IEEE
> 802.1Q, but rather emulated hubs, so let's switch to that terminology
> instead.
>=20
> Buglink: https://bugs.launchpad.net/qemu/+bug/658904
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  net/hub.c   | 7 +++----
>  net/slirp.c | 8 ++++----
>  net/tap.c   | 4 ++--
>  3 files changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gBYU9MM4gf8jKg2V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa1aCZAAoJEJykq7OBq3PIqPkH/1+F3QyLBGlF1ES2tPY0jssp
WtZnSh3FyztM38Oqjx5I2k+nfqlIWM9HAOiHOQ8/WB/+d0MEsgB4/kFyyt08TPMj
PdWF/qvE8urJ2g56PSRjNMErvX1/GdL8uX2IlHBqxMAJsu+H1CJgzCIp+mt2Ldry
bBsyTgZDKKeWielOKR2cpB3tkSdMyTJ7leVTxvxAT28Onak8/ffl2Qq0J2lTNpft
ttLSDMoGsqHXsJTzsHQmcv52TioOTNQU+jMC3W4aUsAC4N8mTfK1d3brLj5vGypu
DebRsPp71N/toATAr+T7RT9fd/A9xcHao0Mm4rB0EWl1VeouJWgqVlhW08p+voc=
=7vgE
-----END PGP SIGNATURE-----

--gBYU9MM4gf8jKg2V--
