Received: from eggs.gnu.org ([2001:4830:134:3::10]:46989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fR8UG-0003Oa-3Y
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 23:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fR8UF-0006g9-7q
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 23:54:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180607144645.10187-1-f4bug@amsat.org>
	<20180607144645.10187-3-f4bug@amsat.org>
	<20180608030319.GE3344@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <83125664-91ec-3274-e6d3-6c5ccfd95297@amsat.org>
Date: Fri, 8 Jun 2018 00:54:36 -0300
MIME-Version: 1.0
In-Reply-To: <20180608030319.GE3344@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="FWtUHwIfmEAwSQMsGLBYwpdEOGcwldsAz"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] hw/ppc/spapr_drc: Replace
 error_setg(&error_abort) by abort()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FWtUHwIfmEAwSQMsGLBYwpdEOGcwldsAz
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: David Gibson <david@gibson.dropbear.id.au>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org
Message-ID: <83125664-91ec-3274-e6d3-6c5ccfd95297@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] hw/ppc/spapr_drc: Replace
 error_setg(&error_abort) by abort()
References: <20180607144645.10187-1-f4bug@amsat.org>
 <20180607144645.10187-3-f4bug@amsat.org>
 <20180608030319.GE3344@umbus.fritz.box>
In-Reply-To: <20180608030319.GE3344@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi David,

On 06/08/2018 12:03 AM, David Gibson wrote:
> On Thu, Jun 07, 2018 at 11:46:43AM -0300, Philippe Mathieu-Daud=E9 wrot=
e:
>> Use abort() instead of error_setg(&error_abort),
>> as suggested by the "qapi/error.h" documentation:
>>
>>     Please don't error_setg(&error_fatal, ...), use error_report() and=

>>     exit(), because that's more obvious.
>>     Likewise, don't error_setg(&error_abort, ...), use assert().
>>
>> Use abort() instead of the suggested assert() because the assertion is=

>> already verified by the switch case.
>=20
> I think g_assert_not_reached() would be the right thing here.

I try to follow Eric advice (who recalled Markus).
As I understand:
http://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03605.html

"glib-Testing [...] should not be used outside of tests/."

I can respin if you prefer.

>>
>> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>> ---
>>  hw/ppc/spapr_drc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
>> index 8a045d6b93..b934b9c9ed 100644
>> --- a/hw/ppc/spapr_drc.c
>> +++ b/hw/ppc/spapr_drc.c
>> @@ -366,7 +366,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, =
const char *name,
>>              break;
>>          }
>>          default:
>> -            error_setg(&error_abort, "device FDT in unexpected state:=
 %d", tag);
>> +            abort(); /* device FDT in unexpected state */
>>          }
>>          fdt_offset =3D fdt_offset_next;
>>      } while (fdt_depth !=3D 0);
>=20


--FWtUHwIfmEAwSQMsGLBYwpdEOGcwldsAz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlsZ/fwACgkQ4+MsLN6t
wN5GJQ/9EnvxK702eu9ba/JqGHUM4U9FGSYmh5JA1S58xNEgzxqzzzaSvmhxxNGo
BWpuHdOVZ2OfNLhZzXfAGEPki0uixfFOi7224VshK7MezF+JGq8xYRB4L7ET/s+p
TthxRpzkxXU2g26caleSfjzV7ay46CLQ58OeReFhcHrTblmQ8Ftrts/Njcr8pwoQ
JQivZt+jaVuM7vaJbRCTWml+oif/51U2LucXLkjlrt+9GN4SAYR7ChKv+yQMcznm
9BqHc1fxnD+WorDXrMlaOr6kxTUjM32yQaw9gP9vgVv+YXSdRwxCbuocP+n03zgt
CWnTNfKY3zbh0C55dzV2mCcvBqsbtYRb85XsSAyfBZho/Ekp6oxTAeAUKYqEZRGO
KK2qzcV6AR+/tydp2V7eWaUrGveMR8blu5aT2QoKaQHC8A0NaVPWnbucosdG6a6w
2YURQg31f7LT3MGGd/YiygkMRvkLFqqkhotFjavxvkR5FHM0aEPK6W97z8+d+x/9
sQwaFWQATvLDpSLWZXJaUgM172Qf2WsVAZ2H+PXM/p9Cth1dm6a+iQFOVHYnFRgz
7keRknsbrrhBRUcY0X4skFdmfhvCgVZyy1VVVZwTV7+cnnSeTza2Kamqx8vQyNup
VP11OtaJOKWfUnAqKnFUrH1yOvFc6rlbwbilZ01ygwdPjJUE73o=
=kjTa
-----END PGP SIGNATURE-----

--FWtUHwIfmEAwSQMsGLBYwpdEOGcwldsAz--
