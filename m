Received: from eggs.gnu.org ([2001:4830:134:3::10]:36254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEeyM-0006ty-Ly
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEeyL-000733-Pd
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:58:22 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:36051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEeyL-00072r-Gr
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:58:21 -0400
Received: by mail-ot0-x229.google.com with SMTP id m11-v6so19246927otf.3
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 10:58:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180504171540.25813-1-peter.maydell@linaro.org>
References: <20180504171540.25813-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 May 2018 18:58:00 +0100
Message-ID: <CAFEAcA8byYVNaQDttBtN5SjO3Bih1gZ2YtBiAuFnTLEvaV3qnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>

On 4 May 2018 at 18:15, Peter Maydell <peter.maydell@linaro.org> wrote:
> target-arm queue: Eric's SMMUv3 patchset, and an array
> of minor bugfixes and improvements from various others.
>
> thanks
> -- PMM
>
> The following changes since commit c8b7e627b4269a3bc3ae41d9f420547a47e6d9=
b9:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-05-04' i=
nto staging (2018-05-04 14:42:46 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-=
20180504
>
> for you to fetch changes up to 5680740c92993e9b3f3e011f2a2c394070e33f56:
>
>   hw/arm/virt: Introduce the iommu option (2018-05-04 18:05:52 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Emulate the SMMUv3 (IOMMU); one will be created in the 'virt' board
>    if the commandline includes "-machine iommu=3Dsmmuv3"
>  * target/arm: Implement v8M VLLDM and VLSTM
>  * hw/arm: Don't fail qtest due to missing SD card in -nodefaults mode
>  * Some fixes to silence Coverity false-positives
>  * arm: boot: set boot_info starting from first_cpu
>    (fixes a technical bug not visible in practice)
>  * hw/net/smc91c111: Convert away from old_mmio
>  * hw/usb/tusb6010: Convert away from old_mmio
>  * hw/char/cmsdk-apb-uart.c: Accept more input after character read
>  * target/arm: Make MPUIR write-ignored on OMAP, StrongARM
>  * hw/arm/virt: Add linux,pci-domain property

Oops, 32-bit compile failures for format string issues;

hw/arm/trace.h: In function =E2=80=98_nocheck__trace_smmu_ptw_level=E2=80=
=99:
hw/arm/trace.h:215:18: error: format =E2=80=98%lx=E2=80=99 expects argument=
 of type
=E2=80=98long unsigned int=E2=80=99, but argument 7 has type =E2=80=98size_=
t {aka unsigned
int}=E2=80=99 [-Werror=3Dformat=3D]
         qemu_log("%d@%zd.%06zd:smmu_ptw_level " "level=3D%d
iova=3D0x%"PRIx64" subpage_sz=3D0x%lx baseaddr=3D0x%"PRIx64" offset=3D%d =
=3D>
pte=3D0x%"PRIx64 "\n",
                  ^
hw/arm/trace.h: In function =E2=80=98_nocheck__trace_smmuv3_write_mmio_idr=
=E2=80=99:
hw/arm/trace.h:606:18: error: format =E2=80=98%lx=E2=80=99 expects argument=
 of type
=E2=80=98long unsigned int=E2=80=99, but argument 5 has type =E2=80=98uint6=
4_t {aka long long
unsigned int}=E2=80=99 [-Werror=3Dformat=3D]
         qemu_log("%d@%zd.%06zd:smmuv3_write_mmio_idr " "write to
RO/Unimpl reg 0x%lx val64:0x%lx" "\n",
                  ^
hw/arm/trace.h:606:18: error: format =E2=80=98%lx=E2=80=99 expects argument=
 of type
=E2=80=98long unsigned int=E2=80=99, but argument 6 has type =E2=80=98uint6=
4_t {aka long long
unsigned int}=E2=80=99 [-Werror=3Dformat=3D]
hw/arm/trace.h: In function =E2=80=98_nocheck__trace_smmuv3_find_ste_2lvl=
=E2=80=99:
hw/arm/trace.h:721:18: error: format =E2=80=98%lx=E2=80=99 expects argument=
 of type
=E2=80=98long unsigned int=E2=80=99, but argument 5 has type =E2=80=98uint6=
4_t {aka long long
unsigned int}=E2=80=99 [-Werror=3Dformat=3D]
         qemu_log("%d@%zd.%06zd:smmuv3_find_ste_2lvl "
"strtab_base:0x%lx l1ptr:0x%"PRIx64" l1_off:0x%x, l2ptr:0x%"PRIx64"
l2_off:0x%x max_l2_ste:%d" "\n",
                  ^

size_t arguments need %zx, not %lx, and uint64_t arguments need
%"PRIx64", not %lx. I'll squash in the changes to the relevant patches.

thanks
-- PMM
