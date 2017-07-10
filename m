Received: from eggs.gnu.org ([2001:4830:134:3::10]:42681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUbMV-0001IU-VP
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUbMS-0003KL-0W
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:16:39 -0400
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-2-pbonzini@redhat.com>
	<20170710132121.GF14195@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <906526d4-218b-6a19-09cd-9dbaa014261d@redhat.com>
Date: Mon, 10 Jul 2017 18:16:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170710132121.GF14195@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ShIQrs53MDe8liOPw66bjp1bdR9hRBouD"
Subject: Re: [Qemu-devel] [PATCH 01/11] block: prepare write threshold code
 for thread safety
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ShIQrs53MDe8liOPw66bjp1bdR9hRBouD
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org
Message-ID: <906526d4-218b-6a19-09cd-9dbaa014261d@redhat.com>
Subject: Re: [PATCH 01/11] block: prepare write threshold code for thread
 safety
References: <20170706163828.24082-1-pbonzini@redhat.com>
 <20170706163828.24082-2-pbonzini@redhat.com>
 <20170710132121.GF14195@stefanha-x1.localdomain>
In-Reply-To: <20170710132121.GF14195@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/07/2017 15:21, Stefan Hajnoczi wrote:
> On Thu, Jul 06, 2017 at 06:38:18PM +0200, Paolo Bonzini wrote:
>> Code refactoring only.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  block/write-threshold.c | 28 ++++++++++++++++------------
>>  1 file changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/block/write-threshold.c b/block/write-threshold.c
>> index 0bd1a01c86..c8ebc32b4d 100644
>> --- a/block/write-threshold.c
>> +++ b/block/write-threshold.c
>> @@ -37,18 +37,22 @@ static void write_threshold_disable(BlockDriverSta=
te *bs)
>>      }
>>  }
>> =20
>> +static uint64_t exceeded_amount(const BdrvTrackedRequest *req,
>> +                                uint64_t thres)
>=20
> Not a reason to respin, but I would prefer a more specific name so the
> intent of the code is easier to understand: exceeded_threshold() instea=
d
> of exceeded_amount().
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

It's the amount by which the request exceeds threshold...  Not sure what
name would be best.

Paolo


--ShIQrs53MDe8liOPw66bjp1bdR9hRBouD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlljqE0ACgkQv/vSX3jH
roNhHQgAg5zO5EnHZjbpt2+mJN68yn9UUPhA/nncM/bXN+pyoDlgSAbfkO3Qon3y
6mKlz4evULCgqtCvUBWJuht3JRKitbbVo23Pm7J1dzkIOTCJhp6yNPQUasL4yFfr
nI56e+MOOG+WwmuIW4xoxr+Vck6lR5tlCCwKBpZHrTFoWpxrzLug/ALBcPY20C7k
LxOxRGjhXq/WLj5/X0QfXMzEAhsq22G0PyKgW6rikz81QEpXk0TtbGTS+CwPCFyd
gTA0mvZZfiY+2QTmm2W7r6Yjic3zjEccltjFys/z4+Uwpxgq4y/ADX3Y0bCgt7cv
8BFdub3lv1rSvMWpftgjOS332jZXGw==
=v5P9
-----END PGP SIGNATURE-----

--ShIQrs53MDe8liOPw66bjp1bdR9hRBouD--
