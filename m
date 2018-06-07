Received: from eggs.gnu.org ([2001:4830:134:3::10]:50273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQkd4-0005gf-LL
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 22:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQkd3-0001oX-Q5
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 22:26:22 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180606152128.449-1-f4bug@amsat.org>
	<20180606152128.449-5-f4bug@amsat.org>
	<20180607021658.GB3166@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6dd6bc7b-739d-0824-644c-36f3e7d6056b@amsat.org>
Date: Wed, 6 Jun 2018 23:26:04 -0300
MIME-Version: 1.0
In-Reply-To: <20180607021658.GB3166@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="8au7FAvUjXr7iuYnGmfCaATqAYtjROO7R"
Subject: Re: [Qemu-devel] [PATCH 04/11] ppc/pnv: Add trailing '\n' to
 qemu_log() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8au7FAvUjXr7iuYnGmfCaATqAYtjROO7R
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, qemu-ppc@nongnu.org
Message-ID: <6dd6bc7b-739d-0824-644c-36f3e7d6056b@amsat.org>
Subject: Re: [PATCH 04/11] ppc/pnv: Add trailing '\n' to qemu_log() calls
References: <20180606152128.449-1-f4bug@amsat.org>
 <20180606152128.449-5-f4bug@amsat.org>
 <20180607021658.GB3166@umbus.fritz.box>
In-Reply-To: <20180607021658.GB3166@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/06/2018 11:16 PM, David Gibson wrote:
> On Wed, Jun 06, 2018 at 12:21:21PM -0300, Philippe Mathieu-Daud=E9 wrot=
e:
>> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> I'm not really sure what series this was part of, but I've applied it
> to ppc-for-3.0 anyway.

I did an effort to split the series, then add all the recipients to the
cover but I missed your mail indeed, sorry!

here is the cover:
http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg01266.html

Thanks!

>=20
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>=20
>> ---
>>  hw/ppc/pnv_core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
>> index cbb64ad9e7..13ad7d9e04 100644
>> --- a/hw/ppc/pnv_core.c
>> +++ b/hw/ppc/pnv_core.c
>> @@ -97,7 +97,7 @@ static uint64_t pnv_core_xscom_read(void *opaque, hw=
addr addr,
>>          val =3D 0x24f000000000000ull;
>>          break;
>>      default:
>> -        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=3D0x%" HWADDR_=
PRIx,
>> +        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=3D0x%" HWADDR_=
PRIx "\n",
>>                    addr);
>>      }
>> =20
>> @@ -107,7 +107,7 @@ static uint64_t pnv_core_xscom_read(void *opaque, =
hwaddr addr,
>>  static void pnv_core_xscom_write(void *opaque, hwaddr addr, uint64_t =
val,
>>                                   unsigned int width)
>>  {
>> -    qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=3D0x%" HWADDR_P=
RIx,
>> +    qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=3D0x%" HWADDR_P=
RIx "\n",
>>                    addr);
>>  }
>> =20
>=20


--8au7FAvUjXr7iuYnGmfCaATqAYtjROO7R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsYl78ACgkQ4+MsLN6t
wN51SRAAwZLVBTOkFWqyol3YmxtzWVHBNrM9xmxaum1iDhk8vHBNZSzkPk/Znev2
TmkIfyBhr2Xkh1sU4nXTv0ZxnHIirQL4vMreihjQ24gEkedwqjuNn6qUJbZBaJSZ
cST9fNXlNqyrroZKrWQ1ZwlMDGCcjQg8/sSP1PLzq0kG1we8QXBX7ZNbZqXly8s3
6tCmSZBcioT+jmFz7wyMLAmh6Y6iPyWC1A8zKPjpUOYSY/zBWcPcGxrsY1s53i5Z
ajeo0TNWzlLdYmiaO2jBav7qNHFZRKT3NRc+KBHcurSM6Hh8BjocfUU4i7rgMe7w
Ea8wiF/9fsT0xyIYIVEn28OXxpGgaxTSLPrM9qGmuvGPysrhj5s6W+Ki17Re2cYI
aJz8R6xzpi4pb3o+M1BErbVH0Gf/ApgKVwkOXIZ+0dcRVUdOZqZdtiwMAXtIL7GE
qIIReWd1GNI9kH4yvvldp/NsKlPRDbkvWuae/K4JhMClS/TrRpiP6rrthhI27XEJ
/Ho0NOCsbsO8mB05LsQWzqI3hCCnYa9YTVS4EfBCdoS4z1PAwLU9I/8byht3Qk5X
GVmVU46TfHmRarfHeVFDXkfED6QdwP7bS/yd0yp6chG3aNWr88jgOJ2vEiJqmmnW
lDTF3Hcffel4XhsUu9JA3R37kpJtousARUGu1RDRLZcLzm1cHI4=
=Pi7U
-----END PGP SIGNATURE-----

--8au7FAvUjXr7iuYnGmfCaATqAYtjROO7R--
