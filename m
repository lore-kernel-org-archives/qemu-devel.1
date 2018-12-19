Received: from eggs.gnu.org ([2001:4830:134:3::10]:44891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZhJm-0000DX-RG
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZhJk-0007GY-KE
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:15:42 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:44088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gZhJk-0007D8-28
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 14:15:40 -0500
Received: by mail-ot1-x335.google.com with SMTP id f18so20093622otl.11
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 11:15:38 -0800 (PST)
MIME-Version: 1.0
References: <20181218161008.3882-1-mst@redhat.com>
In-Reply-To: <20181218161008.3882-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Dec 2018 19:15:26 +0000
Message-ID: <CAFEAcA-mzqQ+tt+43LVnruBj9Mgf2q7MaCgV5o2BPz3GJT+i+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/30] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 18 Dec 2018 at 16:11, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Changes from v1:
>     Drop
>         intel_iommu: turn on IR by default
>
> The following changes since commit f163448536e5f7ae8905b14547eab37a41a75f6c:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20181216' into staging (2018-12-17 13:04:25 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to d4ea2be7e8718ad6c1e5810bee6bdf5a0b8f31b8:
>
>   hw/i386: Remove deprecated machines pc-0.10 and pc-0.11 (2018-12-18 11:09:02 -0500)
>
> ----------------------------------------------------------------
> pci, pc, virtio: fixes, features
>
> VTD fixes
> ACPI refactoring
> new names for virtio devices
> multiple pcie link width/speeds
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Hi; I'm afraid I get conflicts in some files which look
too complicated for me to want to try to resolve at this end:
Auto-merging tests/vmgenid-test.c
CONFLICT (content): Merge conflict in tests/vmgenid-test.c
Auto-merging tests/bios-tables-test.c
CONFLICT (content): Merge conflict in tests/bios-tables-test.c
Auto-merging tests/acpi-utils.h
CONFLICT (content): Merge conflict in tests/acpi-utils.h
Auto-merging tests/acpi-utils.c
CONFLICT (content): Merge conflict in tests/acpi-utils.c
Removing include/hw/smbios/ipmi.h

Please can you rebase and resend?

thanks
-- PMM
