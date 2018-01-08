Received: from eggs.gnu.org ([2001:4830:134:3::10]:33878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYc9n-0003GQ-8l
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:28:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYc9k-00046J-5a
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:28:23 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYc9k-00045n-0e
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 13:28:20 -0500
Received: by mail-qk0-x244.google.com with SMTP id d21so4355561qkj.3
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 10:28:19 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180108180231.21122-1-f4bug@amsat.org>
	<20180108180231.21122-7-f4bug@amsat.org>
	<78a9d2fc-d027-9857-ce4e-b7c186960609@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e38bca8c-2b03-2a8e-b042-c585c8eaa62a@amsat.org>
Date: Mon, 8 Jan 2018 15:28:13 -0300
MIME-Version: 1.0
In-Reply-To: <78a9d2fc-d027-9857-ce4e-b7c186960609@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="OqZZR3J6r0fthUpVDnoPaUXbWnq6DDItW"
Subject: Re: [Qemu-devel] [RFC PATCH 6/7] net/eepro100: reduce alignment to
 DWORD (32bit)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Stefan Weil <sw@weilnetz.de>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OqZZR3J6r0fthUpVDnoPaUXbWnq6DDItW
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>,
 Stefan Weil <sw@weilnetz.de>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
Message-ID: <e38bca8c-2b03-2a8e-b042-c585c8eaa62a@amsat.org>
Subject: Re: [RFC PATCH 6/7] net/eepro100: reduce alignment to DWORD (32bit)
References: <20180108180231.21122-1-f4bug@amsat.org>
 <20180108180231.21122-7-f4bug@amsat.org>
 <78a9d2fc-d027-9857-ce4e-b7c186960609@redhat.com>
In-Reply-To: <78a9d2fc-d027-9857-ce4e-b7c186960609@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/08/2018 03:10 PM, Paolo Bonzini wrote:
> On 08/01/2018 19:02, Philippe Mathieu-Daud=C3=A9 wrote:
>>      /* Data in mem is always in the byte order of the controller (le)=
=2E
>>       * It must be dword aligned to allow direct access to 32 bit valu=
es. */
>> -    uint8_t mem[PCI_MEM_SIZE] QEMU_ALIGNED(8);
>> +    uint8_t mem[PCI_MEM_SIZE] QEMU_ALIGNED(4);
>=20
> It's actually not needed at all, since accesses go through ld*_le_p and=

> st*_le_p (commit 4d9be25, "hw/net/eepro100.c: Don't use cpu_to_*w() and=

> *_to_cpup()", 2016-06-16).

Cool, I'll update this.

Thank you,

Phil.


--OqZZR3J6r0fthUpVDnoPaUXbWnq6DDItW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpTuD0ACgkQ4+MsLN6t
wN7Tdg/+NFUJglmTBL4iZsEmMu4YeiEcsRh3o2X9vGFfaz6QBBhAeCK6ZoyvUivu
OLoJbaeYpjf7jAPy1L2tc82JWRavuUYEndJl1dD338vKR6+XrIY1Vq8Cjow+xBs9
ZmRPEAd/6QsoT8Gy1RwPTzexiLJP0IUsQQ3rwPNxZ6vER3PFOTFuaul2WbFDuOsb
2uPEpHGqnuuLnhhRcdXIKzKt/HzRCPfdFl2OOOIDZd00N+NTjibKV2s+ppWv+9iy
XA1DrohXGVYV9MlatOaura1NhGTcSO4KUBUKhdc9sn9V0DH4aCrHACcU6zCqHZIg
KKIcy9nTj2cpu0Axmxpx+LCfswDNbH4s29AsZgWE4WLOn+MtORl3OuiyRrRwxnqK
y4PHeYDeb5GFESm1xZXlKHl8d4MnRxSRTAtlw93FKiXZaRnw8FFqxOGW8QdU25+E
FYuNyn3UF/oth0bMOFr72C2xe0Nepd+/nxiGuSXsi4yztg8HElb3i+W018bh8wvs
+UaDFRHgVj5VmHTNW70dST/6cO4YPKTER14jpqtC8/19G1vul8Qad1NiqP5Gicfg
xNymqcqHgDR2A5QX5svzEyVNEJeMF0a/1iakFGjfrzJwcZvo46yGXRdSMDegVBbw
rJWJp8K6DpQPe06kSEEpl0rILycprbl/vy98wCsP0q5kgxRTz90=
=znuk
-----END PGP SIGNATURE-----

--OqZZR3J6r0fthUpVDnoPaUXbWnq6DDItW--
