Received: from eggs.gnu.org ([2001:4830:134:3::10]:48059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fiHNf-0002oM-Ht
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fiHNc-0003kM-Jw
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:50:55 -0400
Date: Wed, 25 Jul 2018 11:50:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180725105040.GA2366@work-vm>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Hongbo Zhang <hongbo.zhang@linaro.org>, peter.maydell@linaro.org, radoslaw.biernacki@linaro.org, ard.biesheuvel@linaro.org, qemu-devel@nongnu.org, leif.lindholm@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org

* Andrew Jones (drjones@redhat.com) wrote:
> On Wed, Jul 25, 2018 at 01:30:52PM +0800, Hongbo Zhang wrote:
> > For the Aarch64, there is one machine 'virt', it is primarily meant to
> > run on KVM and execute virtualization workloads, but we need an
> > environment as faithful as possible to physical hardware, for supporting
> > firmware and OS development for pysical Aarch64 machines.
> >=20
> > This patch introduces new machine type 'Enterprise' with main features:
> >  - Based on 'virt' machine type.
> >  - Re-designed memory map.
> >  - EL2 and EL3 are enabled by default.
> >  - GIC version 3 by default.
> >  - AHCI controller attached to system bus, and then CDROM and hard disc
> >    can be added to it.
> >  - EHCI controller attached to system bus, with USB mouse and key board
> >    installed by default.
> >  - E1000E ethernet card on PCIE bus.
> >  - VGA display adaptor on PCIE bus.
> >  - Default CPU type cortex-a57, 4 cores, and 1G bytes memory.
> >  - No virtio functions enabled, since this is to emulate real hardware.
>=20
> In the last review it was pointed out that using virtio-pci should still
> be "real" enough, so there's not much reason to avoid it. Well, unless
> there's some concern as to what drivers are available in the firmware and
> guest kernel. But that concern usually only applies to legacy firmwares
> and kernels, and therefore shouldn't apply to AArch64.

I think the difference from last time is Ard's comments earlier in this
thread:

    The purpose of the SBSA machine is not to provide a minimal
    configuration. It is intended to exercise all the moving parts one
    might find in a server firmware/OS stack, including pieces that are
    not usually found on x86 machines, such as DRAM starting above 4 GB
    and SATA/USB controllers that are not PCIe based.

that suggests that the intent of this board is to provide everything
which a firmware writer might want to test;  that's quite different
=66rom forming the basis of a virtualised machine for real use.

Dave


> >  - No paravirtualized fw_cfg device either.
> >=20
> > Arm Trusted Firmware and UEFI porting to this are done accordingly.
> >
>=20
> How will UEFI get the ACPI tables from QEMU without fw-cfg? I didn't
> see any sort of reserved ROM region in the patch for them.
>=20
> Thanks,
> drew
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
