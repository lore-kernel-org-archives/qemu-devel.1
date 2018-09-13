Received: from eggs.gnu.org ([2001:4830:134:3::10]:41278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Suravee.Suthikulpanit@amd.com>) id 1g0N7X-0001zW-4f
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Suravee.Suthikulpanit@amd.com>) id 1g0N7T-0003j0-0t
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:37:03 -0400
Received: from mail-eopbgr700067.outbound.protection.outlook.com
	([40.107.70.67]:35872
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Suravee.Suthikulpanit@amd.com>)
	id 1g0N7R-0003gh-LI
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:36:58 -0400
References: <1536684589-11718-1-git-send-email-brijesh.singh@amd.com>
	<1536684589-11718-7-git-send-email-brijesh.singh@amd.com>
	<20180912045233.GE3829@xz-x1>
	<60537599-37af-9a2b-9ddf-f6155624259f@amd.com>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <8ba3b14e-7045-2a05-da02-d6b704ddd19a@amd.com>
Date: Thu, 13 Sep 2018 15:36:28 +0700
MIME-Version: 1.0
In-Reply-To: <60537599-37af-9a2b-9ddf-f6155624259f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] x86_iommu/amd: Enable Guest virtual
 APIC support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <Thomas.Lendacky@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Brijesh/Peter,

On 9/13/18 4:14 AM, Brijesh Singh wrote:
>=20
>=20
> On 09/11/2018 11:52 PM, Peter Xu wrote:
> ...
>=20
>>>
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index 5c2c638..1cbc8ba 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -2565,7 +2565,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *l=
inker)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_append_int_noprefix(table_data,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (48UL << 30) | /* HATS=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (48UL << 28) | /* GATS=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (1UL << 2),=C2=A0=C2=A0=C2=A0 /* GTSup=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (1UL << 2)=C2=A0=C2=A0 | /* GTSup=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (1UL << 6),=C2=A0=C2=A0=C2=A0 /* GASup=C2=A0 */
>>
>> Sorry if I misunderstood - is this for nested?
>>
>> I'm a bit confused here... IIUC in your previous patches you didn't
>> really implement guest_mode=3D=3D1 case in IRTEs.=C2=A0 So if you have t=
his set
>> then the guest should be able to setup IRTEs with guest_mode=3D=3D1?=C2=
=A0 How
>> did it work?
>>
>=20
> Yes, sometime spec can be confusing ;) let me see if I can explain it.
>=20
> Suravee, please correct me if I misunderstood something
>=20
> - A legacy interrupt remap support is available on all IOMMU versions.
>=20
>  =C2=A0 Guest OS makes the decision whether to use the feature. Guest OS
>  =C2=A0 sets the IV bit in DTE to indicate when there is a valid interrup=
t
>  =C2=A0 map (See Table 7 DTE definition).
>=20
>  =C2=A0 In this mode, IRTE is 32-bit. The field details are available
>  =C2=A0 in Table 20 - Section 2.2.5.2. The third patch in this series
>  =C2=A0 implements the support for this case.

This is correct.

>=20
> - When AVIC is used in the guest, the intr remap logic is different.
>=20
>  =C2=A0 Based on the guest_mode, IOMMU and AVIC may need to work together
>  =C2=A0 to remap the interrupts (IOMMU spec refers this as Guest Virtual =
APIC
>  =C2=A0 Enabled -- Section 2.2.5.3).
>=20
>  =C2=A0 The GASup bit in extended feature register and IVHD IOMMU feature
>  =C2=A0 reporting field in IVRS are used to tell whether the IOMMU suppor=
ts
>  =C2=A0 intr remap when AVIC is enabled in the guest.
>=20
>  =C2=A0 In this mode, the IRTE is 128-bit.

GASup is a prereq for GAMSup and several other features in the future.

>=20
>  =C2=A0 To make things interesting, there is a GAMSup bit in extended
>  =C2=A0 feature register. It is used by IOMMU to tell the AVIC supported
>  =C2=A0 modes:
>=20
>  =C2=A0 a) 0 =3D intr_remap only (i.e IOMMU can remap the interrupt on it=
s own)
>  =C2=A0 b) 1 =3D Both guest AVIC and IOMMU will work together to remap th=
e intr
>=20
>  =C2=A0 The patch 5 in the series implements the intr_remap (#a)
>=20
>  =C2=A0 I have not implemented the mode=3D1. I am not sure if its worth
>  =C2=A0 implementing this mode for the emulated IOMMU case.
>=20
>  =C2=A0 See Table 21 for control knobs from IOMMU. This patch series
>  =C2=A0 implements the first three rows.

GAMSup is guest virtual APIC mode (aka AVIC), and for vIOMMU case,
would be used for nested VM. This is not currently supported for vIOMMU,

Regards,
Suravee

>=20
> -Brijesh
