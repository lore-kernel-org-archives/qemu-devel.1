Received: from eggs.gnu.org ([2001:4830:134:3::10]:50224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fT6wJ-0007fR-3S
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fT6wF-0003Pp-OH
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:39:59 -0400
Received: from mout.web.de ([212.227.15.3]:38815)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1fT6wF-0003Jn-DY
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 10:39:55 -0400
References: <f6aa6ac8-3c3c-bf90-6273-3d584f4707c8@web.de>
	<a2198ea1-e0f6-6b04-63a8-fd04b40c9ff2@web.de>
	<20180613172438-mutt-send-email-mst@kernel.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <7dd2b33f-0ed1-e2c8-d363-f4905948a5c1@web.de>
Date: Wed, 13 Jun 2018 16:39:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180613172438-mutt-send-email-mst@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="10tL98TzVBGWj3twF5YZEEGrcS5vivyF9"
Subject: Re: [Qemu-devel] [PATCH] hw/i386: Fix IVHD entry length for AMD
 IOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--10tL98TzVBGWj3twF5YZEEGrcS5vivyF9
From: Jan Kiszka <jan.kiszka@web.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <7dd2b33f-0ed1-e2c8-d363-f4905948a5c1@web.de>
Subject: Re: [PATCH] hw/i386: Fix IVHD entry length for AMD IOMMU
References: <f6aa6ac8-3c3c-bf90-6273-3d584f4707c8@web.de>
 <a2198ea1-e0f6-6b04-63a8-fd04b40c9ff2@web.de>
 <20180613172438-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180613172438-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-13 16:26, Michael S. Tsirkin wrote:
> On Tue, May 22, 2018 at 09:06:56AM +0200, Jan Kiszka wrote:
>> On 2018-03-29 14:51, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> Counting from the IVHD ID field to the all-devices entry, we have 28
>>> bytes, not 36.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>  hw/i386/acpi-build.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index deb440f286..a0cda71411 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -2561,7 +2561,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker =
*linker)
>>>                               (1UL << 7),  /* PPRSup       */
>>>                               1);
>>>      /* IVHD length */
>>> -    build_append_int_noprefix(table_data, 0x24, 2);
>>> +    build_append_int_noprefix(table_data, 28, 2);
>>>      /* DeviceID */
>>>      build_append_int_noprefix(table_data, s->devid, 2);
>>>      /* Capability offset */
>>>
>>
>> Waiting to be merged.
>>
>> Jan
>=20
> I'll queue this but you really should Cc maintainers :)
>=20

Sorry, wasn't clear to me that you are also maintaining the AMD IOMMU cod=
e.

Thanks,
Jan


--10tL98TzVBGWj3twF5YZEEGrcS5vivyF9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlshLK4ACgkQitSsb3rl5xSk6gCgnqtxUHJnZC76J6aE7n/BhecJ
72QAoN9UNaJCumGB358wDFllySpBOuzQ
=uIoL
-----END PGP SIGNATURE-----

--10tL98TzVBGWj3twF5YZEEGrcS5vivyF9--
