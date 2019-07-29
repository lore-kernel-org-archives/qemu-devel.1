Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF852C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C13B2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="uUnopwiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C13B2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7AK-0000WZ-Ji
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37809)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs77D-00048F-IW
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hs779-0004WY-Jk
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 10:59:07 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:47824)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hs76y-0004LL-Rb; Mon, 29 Jul 2019 10:58:53 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 57B8196F52;
 Mon, 29 Jul 2019 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564412329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bbKIOzndvJvjGPCRQi73dk81BuTtK2CbU1pDEiN/02Q=;
 b=uUnopwiS0kBeBxatAwXRWOlbLfXe41phQv8GehOTtDAtVXOMWb/c61JcEmPUlG0fvi3CtJ
 irPBJ5NzqHvK6aVpsucDvjZ33QN0MnzLXlHCnAWk3DCxDwGNvoXzTP6Q8y3QduD+2pmjyf
 PLY8WDBtb3mCPvggGFBMPulZ8hx0WIs=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 16:56:21 +0200
Message-Id: <20190729145654.14644-1-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564412329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bbKIOzndvJvjGPCRQi73dk81BuTtK2CbU1pDEiN/02Q=;
 b=a2uN0GUyre3imf42Jx8WT4hfqjEN3vYnvHX5AOcZTlmlF3LLJokF3lJAqvF/DIg48RsVw4
 HK9BOUSQlyBc4qo2bP3+SKjh68niL0bTgCbuta1yALXxPpyvkOQfFDUpSj5bjmojKQBSoS
 OMXeo8JV56lyVrdsmc+SdeDcCxcX31Y=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564412329; a=rsa-sha256; cv=none;
 b=3YNduc5NhAT7iL7mYlfJ04ojE9RDJ0v70q8M7ka50AJL4XAq9+TFiZs2he7zaE/4GaEWf+
 bOLusSnXsALqd39pzMWKAIlvtfotfR24e4RoCwo9Fih+78reeVV6SDsPcunXzqnypp25GZ
 EHfgRJypzdjmjhpkl9yl1ruJe3y0cro=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v3 00/33] Multi-phase reset mechanism
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, peter.maydell@linaro.org, walling@linux.ibm.com,
 dmitry.fleytman@gmail.com, mst@redhat.com, mark.cave-ayland@ilande.co.uk,
 kraxel@redhat.com, edgar.iglesias@xilinx.com, hare@suse.com,
 qemu-block@nongnu.org, david@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 thuth@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, jsnow@redhat.com,
 david@gibson.dropbear.id.au, Damien Hedde <damien.hedde@greensocs.com>,
 berrange@redhat.com, cohuck@redhat.com, mark.burton@greensocs.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

Here's the third version of the multi-phase reset proposal patches. I've =
dropped
the RFC tag. Previous version can be found here:
https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg00504.html

The purpose of this series is to split the current reset procedure into 3
phases. We need 2 phases to separate what's local from what's doing exter=
nal
side effects (IO for example). And we need a 3rd additional phase to hand=
le
staying in reset state.

This serie has side-effects on ~20 files calling reset qdev/device api. I=
n
consequence there is a lot of people in the CC list, most of them because=
 of 2=20
simple patches.

# Overview

The phases are:
INIT PHASE: Reset the object internal state, put a resetting flag and do =
the
    same for the reset subtree. No side effect on other devices to guaran=
tee
    that, in a reset domain, everything get initialized first. This corre=
sponds
    mostly to what is currently done in the device/bus reset method.

HOLD PHASE: This phase allows to control a reset with a IO. When a IO con=
trol
    reset procedure based on the IO level (not edge), we may need to asse=
rt
    the reset, wait some time, and finally de-assert the reset. The conse=
quence
    is that such a device can stay in a "resetting state" and may need to=
 show
    this state to other devices through its outputs. For example, a clock
    controller will typically shutdown its clocks when it is in resetting=
 state.

EXIT PHASE: This phase sets outputs to state after reset. For a clock con=
troller
     it starts the clocks. It also clears the "resetting" flag. A device =
should
     not react to inputs until this flag has been cleared. During this ph=
ase,
     outputs are propagated.

The reset use a new QOM interface: "Resettable". It is detailed in the ad=
ded
documentation. Here's an overview, it contains the following methods:
  - 3 methods corresponding to the 3 phases, to be implemented by special=
ized
    objects.
  - others methods do handle the reset mechanics, implemented by base cla=
sses:
    + reset_count getter/modifier methods to know when we enter or leave =
reset
      if multiple reset sources are enabled at the same time.
    + set_cold method to handle warm/cold reset
    + foreach_child to do something on reset children. This method allow =
to
      build some reset hirearchy.

The reset order of the phase is the following
  - reset assertation
    1. init phases in parent-to-child order
    2. hold phases in child-to-parent order
  - reset de-assertation
    3. exit phases in child-to-parent order

# Reset deprecation

The switch to multi-phase reset deprecates the current way of handling re=
set
(for users or developers of Devices). It used a reset method in both
DeviceClass and BusClass.

1. qdev/qbus_reset_all

Theses functions are deprecated by this series and are replaced by includ=
ed
patches without change of behavior.

2. old's device_reset

There was a few call to this function, I renamed it *device_legacy_reset*=
 to
handle the transition. This function allowed to reset only a given device=
=20
(and not its eventual qbus subtree). This behavior is not possible with
the Resettable interface. I changed existing calls. Most of the time ther=
e is
no change of behavior because devices have no sub-buses.
Here the summary after checking each one (I've reproduced the list made b=
y
Peter with some additional commentary of myself):

 hw/audio/intel-hda.c
  -- used by the HDA device to reset the HDACodecDevice, which I think ha=
s
     no child buses
 hw/hyperv/hyperv.c
  -- resets the SynICState, which I think has no child buses
 hw/i386/pc.c
  -- resets the APIC, which has no child buses. (This reset is only
     done as a workaround for lack of reset phases: the whole machine
     is reset and then the APIC is re-reset last to undo any changes
     that other devices might have made to it. Probably making the APIC
     support phased reset would allow us to drop this hack.)
 hw/ide/microdrive.c
  -- called here to reset the MicroDriveState object. It does have
     a child bus, but it seems to me that potential children (ide-cd,
     ide-hd or ide-drive) have no implementation of the reset method.
 hw/intc/spapr_xive.c
  -- resets the SpaprXive device, which I think has no child buses
 hw/ppc/pnv_psi.c
  -- resets a XiveSource, which I think has no child buses
 hw/ppc/spapr_pci.c
  -- resets every QOM child of the SpaprPhbState. This one will
     require closer checking, but my guess is that if there's a child
     with a child bus then failure to reset the bus would be a bug.
 hw/ppc/spapr_vio.c
  -- resets an SpaprTceTable, which I think has no child buses.
 hw/s390x/s390-pci-inst.c
  -- resets the S390PCIBusDevice Needs S390 expertise, but probably
     either no child buses or failure to reset them is a bug.
 hw/scsi/vmw_pvscsi.c
  -- resets an individual SCSIDevice. Specialization of this class ("gene=
ric"
     or "disks") don't have child buses I think.
 hw/sd/omap_mmc.c
  -- resetting an SDState, which has no child bus
 hw/sd/pl181.c
  -- resetting an SDState, which has no child bus

In my opinion only hw/ppc/spapr_pci.c and hw/s390x/s390-pci-inst.c may im=
ply
behavior changes.

3. DeviceClass's reset and BusClass's methods

This is the major change. The method is deprecated because, methods are n=
ow
located in the interface class. In the series, I make the exit phase redi=
rect
to the original reset method of DeviceClass (or BusClass). There a lot of=
 use
of the method and transitioning to 3-phases only reset will need some wor=
k I
did not address in this series.

# Migration

For devices, I've added a patch to automate the addition of reset related
subsection. In consequence it is not necessary to explicetely add the
reset subsection in every device specialization requiring it. Right know
this is kind of a hack into qdev to dynamically modify the vmsd before th=
e
registration. There is probably a much cleaner way to do this but I prefe=
red
to demonstrate it by keeping modification local to qdev.
As far as I can tell it's ok to dynamically add subsections at the end. T=
his
does not prevent from further adding subsections in the orignal vmsd: the
subsections order in the array is irrelevant from migration point-of-view=
.
The loading part just lookup each subsection in the array by name uppon
reception.

For buses, I handle them in the parent parent post_load. It has some limi=
tation
but should work pretty well for most of cases (if we hold reset qdev/qbus
subtree starting from a device not a bus). If we consider holding part of=
 a soc
under reset goes through gpio, it have to be a device.

# Change in qdev/qbus hiearchy

It is possible to change the parent bus of a device with the
qdev_set_parent_bus function. We could add some code to adapt the resetti=
ng
count of the device if old and new bus have different reset state. I did =
not do
it right now because it doesnt not fill the right place do this: as long =
as reset
hiearchy follows the qdev hiearchy this would be fine place, but there is
nothing enforcing that with Resettable.

Given that, there is actually no bus help in reset. The only case when it=
 can
happen is during the reset of a bus. Running the qom-test which test ever=
y
machine (with the initial main reset) gives one case where it happens: th=
e raspi
because sd-card is moved during the reset. IMO, during reset, it's hazard=
ous to
change qdev/qbus hierarchy since reset follows it so I'll try to address =
this on
a separate patch.

# Test

I tested this using the xilinx-zynq-a9 machine. Reset gpio and migration =
during
reset works.

# Changes since v2

  - don't call device implementations of reset phase functions multiple t=
imes.
  - init phase are executed parent-to-children order, legacy reset method=
 is
    mapped on exit phase in order to keep the legacy order.
  - migration: poc of automatic addition of subsection.
  - migration: basic support for sub-buses.
  - qdev/qbus_reset_all & device_reset replacement

The series is organised as follow:
  - Patch   1 adds Resettable interface
  - Patches 2 and 3 rename device_reset function by device_legacy_reset t=
o
    prepare the transition.
  - Patches 4 to 8 makes the changes in Device and Bus classes.
  - Patche 9 adds some doc
  - Patches 10 to 17 replace qdev/qbus_reset calls
  - Patches 18 to 27 replace device_reset calls
  - Patch 28 cleans remaining legacy reset API
  - Patches 29 to 33 modify the xilinx_zynq to add 3-phases reset support=
 in the
    uart and the slcr (the reset controller of the soc).

Thanks,
Damien

Damien Hedde (33):
  Create Resettable QOM interface
  add temporary device_legacy_reset function to replace device_reset
  Replace all call to device_reset by call to device_legacy_reset
  make Device and Bus Resettable
  Switch to new api in qdev/bus
  add the vmstate description for device reset state
  automatically add vmstate for reset support in devices
  Add function to control reset with gpio inputs
  add doc about Resettable interface
  vl.c: remove qbus_reset_all registration
  hw/s390x/ipl.c: remove qbus_reset_all registration
  hw/pci/: remove qdev/qbus_reset_all call
  hw/scsi/: remove qdev/qbus_reset_all call
  hw/s390x/s390-virtio-ccw.c: remove qdev_reset_all call
  hw/ide/piix.c: remove qdev_reset_all call
  hw/input/adb.c: remove qdev_reset_all call
  hw/usb/dev-uas.c: remove qdev_reset_all call
  hw/audio/intel-hda.c: remove device_legacy_reset call
  hw/sd/pl181.c & omap_mmc.c: remove device_legacy_reset call
  hw/hyperv/hyperv.c: remove device_legacy_reset call
  hw/intc/spapr_xive.c: remove device_legacy_reset call
  hw/ppc/pnv_psi.c: remove device_legacy_reset call
  hw/scsi/vmw_pvscsi.c: remove device_legacy_reset call
  hw/ppc/spapr: remove device_legacy_reset call
  hw/i386/pc.c: remove device_legacy_reset call
  hw/s390x/s390-pci-inst.c: remove device_legacy_reset call
  hw/ide/microdrive.c: remove device_legacy_reset calls
  qdev: Remove unused deprecated reset functions
  hw/misc/zynq_slcr: use standard register definition
  convert cadence_uart to 3-phases reset
  Convert zynq's slcr to 3-phases reset
  Add uart reset support in zynq_slcr
  Connect the uart reset gpios in the zynq platform

 Makefile.objs                  |   1 +
 docs/devel/reset.txt           | 165 ++++++++++
 hw/arm/xilinx_zynq.c           |  14 +-
 hw/audio/intel-hda.c           |   2 +-
 hw/char/cadence_uart.c         |  77 ++++-
 hw/core/Makefile.objs          |   2 +
 hw/core/bus.c                  |  85 ++++++
 hw/core/qdev-vmstate.c         | 101 ++++++
 hw/core/qdev.c                 | 169 ++++++++--
 hw/core/resettable.c           | 220 +++++++++++++
 hw/core/trace-events           |  39 +++
 hw/hyperv/hyperv.c             |   2 +-
 hw/i386/pc.c                   |   2 +-
 hw/ide/microdrive.c            |   8 +-
 hw/ide/piix.c                  |   2 +-
 hw/input/adb.c                 |   2 +-
 hw/intc/spapr_xive.c           |   2 +-
 hw/misc/zynq_slcr.c            | 543 ++++++++++++++++++---------------
 hw/pci/pci.c                   |   6 +-
 hw/pci/pci_bridge.c            |   2 +-
 hw/ppc/pnv_psi.c               |   2 +-
 hw/ppc/spapr_pci.c             |   2 +-
 hw/ppc/spapr_vio.c             |   2 +-
 hw/s390x/ipl.c                 |   6 +-
 hw/s390x/s390-pci-inst.c       |   2 +-
 hw/s390x/s390-virtio-ccw.c     |   2 +-
 hw/scsi/lsi53c895a.c           |   4 +-
 hw/scsi/megasas.c              |   2 +-
 hw/scsi/mptsas.c               |   8 +-
 hw/scsi/spapr_vscsi.c          |   2 +-
 hw/scsi/virtio-scsi.c          |   6 +-
 hw/scsi/vmw_pvscsi.c           |   6 +-
 hw/sd/omap_mmc.c               |   2 +-
 hw/sd/pl181.c                  |   2 +-
 hw/usb/dev-uas.c               |   2 +-
 include/hw/char/cadence_uart.h |  10 +-
 include/hw/qdev-core.h         | 158 +++++++++-
 include/hw/resettable.h        | 126 ++++++++
 stubs/Makefile.objs            |   1 +
 stubs/device.c                 |   7 +
 tests/Makefile.include         |   1 +
 vl.c                           |   6 +-
 42 files changed, 1470 insertions(+), 333 deletions(-)
 create mode 100644 docs/devel/reset.txt
 create mode 100644 hw/core/qdev-vmstate.c
 create mode 100644 hw/core/resettable.c
 create mode 100644 hw/core/trace-events
 create mode 100644 include/hw/resettable.h
 create mode 100644 stubs/device.c

--=20
2.22.0


