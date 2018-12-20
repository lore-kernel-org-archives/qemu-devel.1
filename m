Received: from eggs.gnu.org ([2001:4830:134:3::10]:43521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gZzeR-00041k-7g
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gZzeM-000228-8z
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:50:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gZzeM-00021N-1L
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:50:10 -0500
Date: Thu, 20 Dec 2018 15:49:59 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181220154959.4a598d84@Igors-MacBook-Pro.local>
In-Reply-To: <CAFEAcA-mzqQ+tt+43LVnruBj9Mgf2q7MaCgV5o2BPz3GJT+i+A@mail.gmail.com>
References: <20181218161008.3882-1-mst@redhat.com>
	<CAFEAcA-mzqQ+tt+43LVnruBj9Mgf2q7MaCgV5o2BPz3GJT+i+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 00/30] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, 19 Dec 2018 19:15:26 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 18 Dec 2018 at 16:11, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Changes from v1:
> >     Drop
> >         intel_iommu: turn on IR by default
> >
> > The following changes since commit f163448536e5f7ae8905b14547eab37a41a75f6c:
> >
> >   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20181216' into staging (2018-12-17 13:04:25 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to d4ea2be7e8718ad6c1e5810bee6bdf5a0b8f31b8:
> >
> >   hw/i386: Remove deprecated machines pc-0.10 and pc-0.11 (2018-12-18 11:09:02 -0500)
> >
> > ----------------------------------------------------------------
> > pci, pc, virtio: fixes, features
> >
> > VTD fixes
> > ACPI refactoring
> > new names for virtio devices
> > multiple pcie link width/speeds
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Hi; I'm afraid I get conflicts in some files which look
> too complicated for me to want to try to resolve at this end:
> Auto-merging tests/vmgenid-test.c
> CONFLICT (content): Merge conflict in tests/vmgenid-test.c
> Auto-merging tests/bios-tables-test.c
> CONFLICT (content): Merge conflict in tests/bios-tables-test.c
> Auto-merging tests/acpi-utils.h
> CONFLICT (content): Merge conflict in tests/acpi-utils.h
> Auto-merging tests/acpi-utils.c
> CONFLICT (content): Merge conflict in tests/acpi-utils.c
> Removing include/hw/smbios/ipmi.h

I'm working on fixing conflicts due to 29/30 and will include conflicting patch in my acpi tests cleanup on respin

Meanwhile could you drop 29/30 and apply the rest of pull request (which applies just fine)?

> 
> Please can you rebase and resend?
> 
> thanks
> -- PMM
> 
