Received: from eggs.gnu.org ([2001:4830:134:3::10]:34226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fFM5P-0003fN-Rh
	for qemu-devel@nongnu.org; Sun, 06 May 2018 12:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fFM5L-0002us-S2
	for qemu-devel@nongnu.org; Sun, 06 May 2018 12:00:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fFM5L-0002sk-LR
	for qemu-devel@nongnu.org; Sun, 06 May 2018 12:00:27 -0400
References: <20180504171540.25813-1-peter.maydell@linaro.org>
	<CAFEAcA8byYVNaQDttBtN5SjO3Bih1gZ2YtBiAuFnTLEvaV3qnQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f771377e-605e-de7e-a300-1d80c3d66968@redhat.com>
Date: Sun, 6 May 2018 18:00:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8byYVNaQDttBtN5SjO3Bih1gZ2YtBiAuFnTLEvaV3qnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/24] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 05/04/2018 07:58 PM, Peter Maydell wrote:
> On 4 May 2018 at 18:15, Peter Maydell <peter.maydell@linaro.org> wrote:
>> target-arm queue: Eric's SMMUv3 patchset, and an array
>> of minor bugfixes and improvements from various others.
>>
>> thanks
>> -- PMM
>>
>> The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e=
6d9b9:
>>
>>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04=
' into staging (2018-05-04 14:42:46 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-a=
rm-20180504
>>
>> for you to fetch changes up to 5680740c92993e9b3f3e011f2a2c394070e33f5=
6:
>>
>>   hw/arm/virt: Introduce the iommu option (2018-05-04 18:05:52 +0100)
>>
>> ----------------------------------------------------------------
>> target-arm queue:
>>  * Emulate the SMMUv3 (IOMMU); one will be created in the 'virt' board
>>    if the commandline includes "-machine iommu=3Dsmmuv3"
>>  * target/arm: Implement v8M VLLDM and VLSTM
>>  * hw/arm: Don't fail qtest due to missing SD card in -nodefaults mode
>>  * Some fixes to silence Coverity false-positives
>>  * arm: boot: set boot_info starting from first_cpu
>>    (fixes a technical bug not visible in practice)
>>  * hw/net/smc91c111: Convert away from old_mmio
>>  * hw/usb/tusb6010: Convert away from old_mmio
>>  * hw/char/cmsdk-apb-uart.c: Accept more input after character read
>>  * target/arm: Make MPUIR write-ignored on OMAP, StrongARM
>>  * hw/arm/virt: Add linux,pci-domain property
>=20
> Oops, 32-bit compile failures for format string issues;
>=20
> hw/arm/trace.h: In function =E2=80=98_nocheck__trace_smmu_ptw_level=E2=80=
=99:
> hw/arm/trace.h:215:18: error: format =E2=80=98%lx=E2=80=99 expects argu=
ment of type
> =E2=80=98long unsigned int=E2=80=99, but argument 7 has type =E2=80=98s=
ize_t {aka unsigned
> int}=E2=80=99 [-Werror=3Dformat=3D]
>          qemu_log("%d@%zd.%06zd:smmu_ptw_level " "level=3D%d
> iova=3D0x%"PRIx64" subpage_sz=3D0x%lx baseaddr=3D0x%"PRIx64" offset=3D%=
d =3D>
> pte=3D0x%"PRIx64 "\n",
>                   ^
> hw/arm/trace.h: In function =E2=80=98_nocheck__trace_smmuv3_write_mmio_=
idr=E2=80=99:
> hw/arm/trace.h:606:18: error: format =E2=80=98%lx=E2=80=99 expects argu=
ment of type
> =E2=80=98long unsigned int=E2=80=99, but argument 5 has type =E2=80=98u=
int64_t {aka long long
> unsigned int}=E2=80=99 [-Werror=3Dformat=3D]
>          qemu_log("%d@%zd.%06zd:smmuv3_write_mmio_idr " "write to
> RO/Unimpl reg 0x%lx val64:0x%lx" "\n",
>                   ^
> hw/arm/trace.h:606:18: error: format =E2=80=98%lx=E2=80=99 expects argu=
ment of type
> =E2=80=98long unsigned int=E2=80=99, but argument 6 has type =E2=80=98u=
int64_t {aka long long
> unsigned int}=E2=80=99 [-Werror=3Dformat=3D]
> hw/arm/trace.h: In function =E2=80=98_nocheck__trace_smmuv3_find_ste_2l=
vl=E2=80=99:
> hw/arm/trace.h:721:18: error: format =E2=80=98%lx=E2=80=99 expects argu=
ment of type
> =E2=80=98long unsigned int=E2=80=99, but argument 5 has type =E2=80=98u=
int64_t {aka long long
> unsigned int}=E2=80=99 [-Werror=3Dformat=3D]
>          qemu_log("%d@%zd.%06zd:smmuv3_find_ste_2lvl "
> "strtab_base:0x%lx l1ptr:0x%"PRIx64" l1_off:0x%x, l2ptr:0x%"PRIx64"
> l2_off:0x%x max_l2_ste:%d" "\n",
>                   ^
>=20
> size_t arguments need %zx, not %lx, and uint64_t arguments need
> %"PRIx64", not %lx. I'll squash in the changes to the relevant patches.

OK. Thank you for taking this in charge!

Eric
>=20
> thanks
> -- PMM
>=20
