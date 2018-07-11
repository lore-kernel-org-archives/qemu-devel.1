Received: from eggs.gnu.org ([2001:4830:134:3::10]:55353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdFSt-0008Sy-Ed
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdFSq-0007Ct-7W
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:47:31 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdFSq-0007Ci-19
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:47:28 -0400
Received: by mail-qk0-x242.google.com with SMTP id t79-v6so13541656qke.4
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 06:47:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1528877995-5043-1-git-send-email-dimastep@yandex-team.ru>
	<1528877995-5043-3-git-send-email-dimastep@yandex-team.ru>
	<20180619141216.GA16512@dimastep-nix>
	<20180711083431.GA5085@dimastep-nix>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <69f9565f-e5f9-54f3-03dd-e610bea47ddc@amsat.org>
Date: Wed, 11 Jul 2018 10:47:18 -0300
MIME-Version: 1.0
In-Reply-To: <20180711083431.GA5085@dimastep-nix>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="Eb7cBT6D1LQrU2ijMe9G4LhQxd2UrPbhh"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] memory: fix possible NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dima Stepanov <dimastep@yandex-team.ru>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, wrfsh@yandex-team.ru

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Eb7cBT6D1LQrU2ijMe9G4LhQxd2UrPbhh
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Dima Stepanov <dimastep@yandex-team.ru>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, wrfsh@yandex-team.ru
Message-ID: <69f9565f-e5f9-54f3-03dd-e610bea47ddc@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] memory: fix possible NULL pointer
 dereference
References: <1528877995-5043-1-git-send-email-dimastep@yandex-team.ru>
 <1528877995-5043-3-git-send-email-dimastep@yandex-team.ru>
 <20180619141216.GA16512@dimastep-nix> <20180711083431.GA5085@dimastep-nix>
In-Reply-To: <20180711083431.GA5085@dimastep-nix>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Dima,

On 07/11/2018 05:34 AM, Dima Stepanov wrote:
> Gentle ping. CCing Paolo Bonzini.
>=20
> Regards, Dima.
>=20
> On Tue, Jun 19, 2018 at 05:12:16PM +0300, Dima Stepanov wrote:
>> Ping.
>>
>> Regards, Dima.
>>
>> On Wed, Jun 13, 2018 at 11:19:55AM +0300, Dima Stepanov wrote:
>>> In the memory_region_do_invalidate_mmio_ptr() routine the section
>>> variable is intialized by the memory_region_find() call. The section.=
mr
>>> field can be set to NULL.
>>>
>>> Add the check for NULL before trying to drop a section.
>>>
>>> Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
>>> ---
>>>  memory.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/memory.c b/memory.c
>>> index 3212acc..bb45248 100644
>>> --- a/memory.c
>>> +++ b/memory.c
>>> @@ -2712,7 +2712,7 @@ static void memory_region_do_invalidate_mmio_pt=
r(CPUState *cpu,
>>>      /* Reset dirty so this doesn't happen later. */
>>>      cpu_physical_memory_test_and_clear_dirty(offset, size, 1);
>>> =20
>>> -    if (section.mr !=3D mr) {
>>> +    if (section.mr && (section.mr !=3D mr)) {

section.mr can't be NULL here.

You can give the static analyzer a hint using "assert(section.mr);"

>>>          /* memory_region_find add a ref on section.mr */
>>>          memory_region_unref(section.mr);
>>>          if (MMIO_INTERFACE(section.mr->owner)) {
>>> --=20
>>> 2.7.4
>>>

Regards,

Phil.


--Eb7cBT6D1LQrU2ijMe9G4LhQxd2UrPbhh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAltGCmYACgkQ4+MsLN6t
wN59gA//VKH5pHH2vq/RpppH+4TZk22kXKhM08IrOo2203JzOpgHOm9D7IO0P+6Q
U39EUVUax7rvmzh3jQQuEPaE7Aomboa1dXYLImx21BReCY+D0PKjDD9YnJFR3StO
AK31ByHO5SyPKHrORvZkbREzIkqYRanaU4wcSMVijV6sdm3v+t01QnwFxyjMNl3L
/c5DO5FYpx79sCWYOuXVZlGORfkldasL0gDQvMPhxarbBwysMicAWZrxA1QZiZJZ
mb3yJBZqBSZ3cZGl7qWH7t/JffuoS98PtWR6I4HIMkYb9H/5unOMZc8CVq6bYnbr
8bq1bfQMdEfbbwc/g60Oy1E6UGDixkzFvj8UAchlHx4OLkez4HcemNXim4BmDJfb
sq8xldlXNUgjNV2qsNiyo8SAGMI/fJWZ7qmIc9chLF+tNXBa3MZ5W+1px6zUVX0d
uTwq++buv2cPMBRAqhKSkiMASe3IfuCyw3q8mjjXyiC7tLs6MSPbcW8uzbObWlIU
MOuLyiH/6FGs7lJs0wEIXFYnbYaG8sfUG5XRcdrpEH7aRiVM7KnPDr1e3wNeXGqj
xzrwKP9MFCNQoqM5wkM7UCpAY+enc6HYqIU0peyHwi99kQ2x6ZUrtw+HdsH6bET5
hBxWywkus+9g6pbEnmqBh7r19vGpk8mSTRUWy5H8lVpssjzYwmY=
=/gXS
-----END PGP SIGNATURE-----

--Eb7cBT6D1LQrU2ijMe9G4LhQxd2UrPbhh--
