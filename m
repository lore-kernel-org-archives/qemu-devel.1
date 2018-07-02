Received: from eggs.gnu.org ([2001:4830:134:3::10]:42323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fZwjo-0000jb-Lg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fZwjm-0002DK-2M
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:11:20 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:54827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fZwjl-0002Ag-QE
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:11:17 -0400
Received: from player732.ha.ovh.net (unknown [10.109.108.13])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 2EA38B900F
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 13:11:16 +0200 (CEST)
References: <20180619140729.21949-1-clg@kaod.org>
	<20180619140729.21949-2-clg@kaod.org>
	<eb1ad8ca-89f7-b059-3a3c-412375871113@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bc3ec7a5-a6c5-2a0d-7ac1-6583a182807b@kaod.org>
Date: Mon, 2 Jul 2018 13:11:09 +0200
MIME-Version: 1.0
In-Reply-To: <eb1ad8ca-89f7-b059-3a3c-412375871113@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 07/02/2018 12:03 PM, C=C3=A9dric Le Goater wrote:
>> --- a/hw/ppc/spapr_vio.c
>> +++ b/hw/ppc/spapr_vio.c
>> @@ -436,6 +436,9 @@ static void spapr_vio_busdev_reset(DeviceState *qd=
ev)
>>      }
>>  }
>> =20
>> +/* TODO : poor VIO device indexing ... */
>> +static uint32_t vio_index;
>=20
> I think we could also use (dev->reg & 0xff) as an index for=20
> the VIO devices.
>=20
> The unit address of the virtual IOA is simply allocated using=20
> an increment of bus->next_reg, next_reg being initialized at
> 0x71000000.
>=20
> I did not see any restrictions in the PAPR specs or in QEMU=20
> that would break the above.

That was until I discovered this macro :=20

  #define DEFINE_SPAPR_PROPERTIES(type, field)           \
        DEFINE_PROP_UINT32("reg", type, field.reg, -1)


so 'reg' could have any value. We can not use it ...

C.
