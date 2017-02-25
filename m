Received: from eggs.gnu.org ([2001:4830:134:3::10]:58738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chbXt-0002k0-NI
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 07:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chbXt-00085m-0L
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 07:33:53 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-42-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <15c97cd8-1aac-c42d-ab2f-cf636cd5c33e@redhat.com>
Date: Sat, 25 Feb 2017 13:33:45 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-42-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3c2IsiU43utPliFCm5UH9VDiRT4XjtF59"
Subject: Re: [Qemu-devel] [PATCH 41/54] block: Allow backing file links in
 change_parent_backing_link()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3c2IsiU43utPliFCm5UH9VDiRT4XjtF59
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <15c97cd8-1aac-c42d-ab2f-cf636cd5c33e@redhat.com>
Subject: Re: [PATCH 41/54] block: Allow backing file links in
 change_parent_backing_link()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-42-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-42-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Now that the backing file child role implements .attach/.detach
> callbacks, nothing prevents us from modifying the graph even if that
> involves changing backing file links.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--3c2IsiU43utPliFCm5UH9VDiRT4XjtF59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixeakSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ad1cH/jEz5eka/Anvzp2IP1Z6ut1T/9+GpMsD
WIIKjxrV/hmmJ/ubqaSaR2c0k8ExkMEJC3PfvFsSeyCPrpljwzP8ZFZ8x3PWCLuS
yPVUrI5DobKOplKyQH5O9mHbn8lNkgTpZfXaofYJej59AWz5NUUD7w/K/5FMbunP
7QL7fPk5AS66aa20NWyK65vHmVDCItMDr12Wc9D7LPp1cQgkS3NxIwJHZcUeFk/c
raLAzttnP/wlmPF1Bs8gOqtBBEDp0akXM8L14w/9UHc/XT3EwtNGesvjcpOaOEy5
/DKvCNqjbirUoQqa7xZVjmXRrlUPQrFqrdbIB7NSB6JsHbItt1o5XxA=
=tSmC
-----END PGP SIGNATURE-----

--3c2IsiU43utPliFCm5UH9VDiRT4XjtF59--
