Received: from eggs.gnu.org ([2001:4830:134:3::10]:34389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fAdrx-0004RU-QU
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fAdrr-0005Up-US
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:59:09 -0400
Received: from mout.web.de ([212.227.15.14]:53447)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1fAdrr-0005UO-JI
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:59:03 -0400
References: <3301c5bc-7b47-1b0e-8ce4-30435057a276@web.de>
	<CAFEAcA9KSUppGGom-ipX+N49j0gDJH3KDY8oyqT8cVOU0Mn8Rw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <685b5673-beac-e29b-a336-1082260073fa@web.de>
Date: Mon, 23 Apr 2018 17:58:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9KSUppGGom-ipX+N49j0gDJH3KDY8oyqT8cVOU0Mn8Rw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="GYQI4WZlbLRPt0wAZwfcVMEmwTfsHd76F"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: Add linux, pci-domain property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Andrew Jones <drjones@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GYQI4WZlbLRPt0wAZwfcVMEmwTfsHd76F
From: Jan Kiszka <jan.kiszka@web.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Andrew Jones <drjones@redhat.com>
Message-ID: <685b5673-beac-e29b-a336-1082260073fa@web.de>
Subject: Re: [PATCH] hw/arm/virt: Add linux,pci-domain property
References: <3301c5bc-7b47-1b0e-8ce4-30435057a276@web.de>
 <CAFEAcA9KSUppGGom-ipX+N49j0gDJH3KDY8oyqT8cVOU0Mn8Rw@mail.gmail.com>
In-Reply-To: <CAFEAcA9KSUppGGom-ipX+N49j0gDJH3KDY8oyqT8cVOU0Mn8Rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-23 15:11, Peter Maydell wrote:
> On 23 April 2018 at 06:18, Jan Kiszka <jan.kiszka@web.de> wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This allows to pin the host controller in the Linux PCI domain space.
>> Linux requires that property to be available consistently or not at al=
l,
>> in which case the domain number becomes unstable on additions/removals=
=2E
>> Adding it here won't make a difference in practice for most setups as =
we
>> only expose one controller.
>>
>> However, enabling Jailhouse on top may introduce another controller, a=
nd
>> that one would like to have stable address as well. So the property is=

>> needed for the first controller as well.
>=20
> Am I right in thinking that for ACPI the PCI domain number is
> communicated via the _SEG method? If so, looks like we already
> set that, and we set it to 0, which matches what we're doing here
> in the DT, so that's good.

Looking at the related arm64 kernel code (not the spec), it seems __SEG
is involved, yet.

Jan

>=20
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  hw/arm/virt.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 94dcb125d3..943371b75e 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1023,6 +1023,7 @@ static void create_pcie(const VirtMachineState *=
vms, qemu_irq *pic)
>>      qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "pci")=
;
>>      qemu_fdt_setprop_cell(vms->fdt, nodename, "#address-cells", 3);
>>      qemu_fdt_setprop_cell(vms->fdt, nodename, "#size-cells", 2);
>> +    qemu_fdt_setprop_cell(vms->fdt, nodename, "linux,pci-domain", 0);=

>>      qemu_fdt_setprop_cells(vms->fdt, nodename, "bus-range", 0,
>>                             nr_pcie_buses - 1);
>>      qemu_fdt_setprop(vms->fdt, nodename, "dma-coherent", NULL, 0);
>> --
>=20
> Drew -- is minor changes to the DTC something we can do without
> having to condition it on machine version? I forget...
>=20
> thanks
> -- PMM
>=20



--GYQI4WZlbLRPt0wAZwfcVMEmwTfsHd76F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlreAr4ACgkQitSsb3rl5xR54QCg7BiFo2uGj+AfBHA5TMWoCC5c
3eQAoLzLyTZWVRZTYgZD4tLpf2VoozGr
=87BN
-----END PGP SIGNATURE-----

--GYQI4WZlbLRPt0wAZwfcVMEmwTfsHd76F--
