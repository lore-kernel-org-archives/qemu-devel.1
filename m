Received: from eggs.gnu.org ([2001:4830:134:3::10]:42533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cHtae-0007XO-5k
	for Qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cHtaZ-0006aC-BQ
	for Qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:34:28 -0500
References: <20161216054723.96055-1-haoqf@linux.vnet.ibm.com>
	<20161216054723.96055-2-haoqf@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b70a8f66-81e9-6e3b-0245-2eab3ec27d0f@redhat.com>
Date: Fri, 16 Dec 2016 08:34:19 -0600
MIME-Version: 1.0
In-Reply-To: <20161216054723.96055-2-haoqf@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TQ3CF31PXsxWAXVg6AjXLmpP4OoUN1IVG"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v1 1/1] iotests: Fix a problem
 in common.filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-block@nongnu.org
Cc: cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, qemu-trivial <qemu-trivial@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TQ3CF31PXsxWAXVg6AjXLmpP4OoUN1IVG
From: Eric Blake <eblake@redhat.com>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-block@nongnu.org
Cc: cornelia.huck@de.ibm.com, borntraeger@de.ibm.com,
 "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>,
 qemu-trivial <qemu-trivial@nongnu.org>
Message-ID: <b70a8f66-81e9-6e3b-0245-2eab3ec27d0f@redhat.com>
Subject: Re: [Qemu-block] [PATCH v1 1/1] iotests: Fix a problem in
 common.filter
References: <20161216054723.96055-1-haoqf@linux.vnet.ibm.com>
 <20161216054723.96055-2-haoqf@linux.vnet.ibm.com>
In-Reply-To: <20161216054723.96055-2-haoqf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding qemu-devel, ALL patches should include the main list]

On 12/15/2016 11:47 PM, QingFeng Hao wrote:
> If TEST_DIR is set to /tmp, test case 144 will fail. The reason is that=

> TEST_DIR duplicates with 144's test image name tmp.qcow2.

s/duplicates with/resembles/

> when 144 is testing $TEST_DIR/tmp.qcow2, it wants to replace
> $TEST_DIR/tmp.qcow2 to TEST_DIR/tmp.qcow2, but actually it will fail
> and get TEST_DIRTEST_DIR.qcow2 in this case.
> The fix is just to modify the code to replace $TEST_DIR/ with TEST_DIR/=
=2E
>=20
> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> ---
>  tests/qemu-iotests/common.filter | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/comm=
on.filter
> index 240ed06..d29e965 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -35,7 +35,7 @@ _filter_generated_node_ids()
>  # replace occurrences of the actual TEST_DIR value with TEST_DIR
>  _filter_testdir()
>  {
> -    sed -e "s#$TEST_DIR#TEST_DIR#g"
> +    sed -e "s#$TEST_DIR\/#TEST_DIR\/#g"

Why do you need \/?  It should be sufficient to use / without escaping.

But overall I agree with including the / in the pattern.  It's too late
to include this in 2.8, but with the commit message grammar improved and
\ escape removed, I'm fine with:

Reviewed-by: Eric Blake <eblake@redhat.com>

I'm also adding qemu-trivial in cc, in case we want to take it through
that tree instead of the usual qemu-iotests.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--TQ3CF31PXsxWAXVg6AjXLmpP4OoUN1IVG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYU/trAAoJEKeha0olJ0NqQcAH/0/citGr1oIuV0fuVoHetev0
sDAI8T6J8zIMqZiCQ0zKz6oPcYWznwWor80a2Fg9/hZsohWxmnL/ZbzHngIyXlCR
bHpd/jYVAZy3qt03Mrkvs4aZTzIUU9psqR+QYb/LmarhCv+5kGWPnGFwZLkPn/29
HGVhJBvWIzv2xecckQapQcWz6DAwsGGLYuzrtL7B/ulm1e0IAXpBNrnkyi05X37W
O3QQdK4EWxMjxie1alnTdzFOmI6mx06+AAyDgxey1zxBMxi6kn9/5JanIoCFKi7j
DWxtzBiPUzWoyBtZPXbVqz8C/xBkQWNFuN9LWo+eOQn9XEZuVIsCIgH7726iGA8=
=7rJU
-----END PGP SIGNATURE-----

--TQ3CF31PXsxWAXVg6AjXLmpP4OoUN1IVG--
