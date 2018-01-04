Received: from eggs.gnu.org ([2001:4830:134:3::10]:47251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX8U9-0001Kh-OE
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eX8U6-0006Lr-Ld
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:35:17 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180104144046.30793-1-f4bug@amsat.org>
	<20180104144046.30793-3-f4bug@amsat.org>
	<20180104162400.GB2618@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <44abdde4-4543-f5a4-aca3-d6549497bd7b@amsat.org>
Date: Thu, 4 Jan 2018 13:34:53 -0300
MIME-Version: 1.0
In-Reply-To: <20180104162400.GB2618@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="IMIMlEpK339LLWUaM8A7z63exhsJNsl39"
Subject: Re: [Qemu-devel] [RFC PATCH 2/6] hw/net/e1000: real device name is
 'e1000-82540em', 'e1000' is an alias
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Sascha Silbe <silbe@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Fam Zheng <famz@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IMIMlEpK339LLWUaM8A7z63exhsJNsl39
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sascha Silbe <silbe@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
 Fam Zheng <famz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <44abdde4-4543-f5a4-aca3-d6549497bd7b@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH 2/6] hw/net/e1000: real device name is
 'e1000-82540em', 'e1000' is an alias
References: <20180104144046.30793-1-f4bug@amsat.org>
 <20180104144046.30793-3-f4bug@amsat.org> <20180104162400.GB2618@work-vm>
In-Reply-To: <20180104162400.GB2618@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi David,

On 01/04/2018 01:24 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daud=C3=A9 (f4bug@amsat.org) wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  hw/net/e1000.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
>> index 05a00cba31..2280f7fdf9 100644
>> --- a/hw/net/e1000.c
>> +++ b/hw/net/e1000.c
>> @@ -1648,6 +1648,7 @@ typedef struct E1000Info {
>>      uint16_t   device_id;
>>      uint8_t    revision;
>>      uint16_t   phy_id2;
>> +    const char **aliases;
>>  } E1000Info;
>> =20
>>  static void e1000_class_init(ObjectClass *klass, void *data)
>> @@ -1695,10 +1696,11 @@ static const TypeInfo e1000_base_info =3D {
>> =20
>>  static const E1000Info e1000_devices[] =3D {
>>      {
>> -        .name      =3D "e1000",
>> +        .name      =3D "e1000-82540em",
>>          .device_id =3D E1000_DEV_ID_82540EM,
>>          .revision  =3D 0x03,
>>          .phy_id2   =3D E1000_PHY_ID2_8254xx_DEFAULT,
>> +        .aliases   =3D (const char * []) {"e1000", NULL},
>>      },
>>      {
>>          .name      =3D "e1000-82544gc",
>> @@ -1725,6 +1727,7 @@ static void e1000_register_types(void)
>> =20
>>          type_info.name =3D info->name;
>>          type_info.parent =3D TYPE_E1000_BASE;
>> +        type_info.aliases =3D info->aliases;
>>          type_info.class_data =3D (void *)info;
>>          type_info.class_init =3D e1000_class_init;
>>          type_info.instance_init =3D e1000_instance_init;
>=20
> Can you just check that this doesn't break migration compatibility
> either way please;  I think there's some alias code somewhere but I
> can't remember the details.

Good point.

Something related to qdev-monitor.c?

> One thing I do remember that broke when it previously changed was
> entries in PC_COMPAT_* tables like the one in hw/i386/pc_piix.c's
> PC_COMPAT_1_3 - so check with an 'info qtree' that the property is OK.

Ok, I'll verify and think about a qtest for that.

I took this device because I wanted to test another arch than ARM (which
strongly use FDT).
If there is an issue migrating this particular device we can drop this
patch for this only device, and the series still stands for the ARM/FDT.

Regards,

Phil.


--IMIMlEpK339LLWUaM8A7z63exhsJNsl39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpOV60ACgkQ4+MsLN6t
wN7r7RAApE+zrGk2w6iVqwut6wBuXlzxOqISa1i0YilJCrd0dNKaWmWjlRwtlXA8
OM3w3Xgnr2+EXFGbVnM3LBn4ZBkARd1pOSEqSI2sovOWiv64z7MY8EmNNHP+9hcE
Yiiiv7xxNCvHrYf9bAe/yBOuAFPKXYOLovtmZDYfkrzKRR1LrifeI1Rr08Ma7IuX
qQkxPrUqtZgvjJFI4Kyvl+VtsU2dH4QdvHnTPMgMku5StQdC++WTm3eGCwTCG8nm
LmUdLFtvweQrsQVgJTzPBXkMQUcQ6X7QE0yQfugKoKczOXinjkKfdoi1bjOILzU1
U/VqZpU9I3QZ8KtI/sr7FZ+uazrP63ijitqe/4Vk2rsZqiqLrUhzldCofJZeH7Tr
NXJabRfHAuWMRJ6TvvesuwcNPHTVg7UQSu58+zyhyoBvbadTgvKj2ZHAc0Ae9I8Q
THxVBIUh+ItuF/9AgfRDVvhEWyc7AqDt3jaBC/saDNIWCqoMxcXp0BcVtESZ+Gjs
LwHgiuTDFqwgKut9kbU0qIbRw37BArCHsbxZKCuGgmA3LP7i943gFeZx5ODKtV4G
+3zQO9IAFzRq1b8X2E/7VmaE5sBgEMLX0a2Sr/gPRh//jbeQgFA9oTngYNTgpDWB
vJBT/Qn0qTDKPYlf4RBd9zD8CNNAn9LC0N/8oLZsYZhonJSM3p8=
=Yfjd
-----END PGP SIGNATURE-----

--IMIMlEpK339LLWUaM8A7z63exhsJNsl39--
