Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6015AC282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1DC23CBA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 16:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="mUZLusKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1DC23CBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYCNj-0007FL-5a
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 12:33:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCFv-0000Y6-NR
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1hYCFt-0003YN-Vs
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 12:25:47 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:40456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
	id 1hYCFq-0003Ql-9y; Tue, 04 Jun 2019 12:25:42 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.17.10.6])
	by beetle.greensocs.com (Postfix) with ESMTPSA id 2A49C96F54;
	Tue,  4 Jun 2019 16:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
	s=mail; t=1559665539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding;
	bh=uJ6C3ng+tjsvvk5Wlyu369WDLSueUY8QLWtJ9tMogNk=;
	b=mUZLusKHA5b5AhUuPn+DE2B3anuorJzHlypr7T5IiGlNP6xQwu6qFht9lnrZ8nJiiqlLUR
	O/3umlnC+NgkwYyM8y9EbEir/ZOACGRHU8I/FZKubS6aFjXllOn2MvSBhtjvTuAEP2M8ep
	dCxY4me02wjTxXfrnW4kkLDnImNgnts=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 18:25:14 +0200
Message-Id: <20190604162526.10655-1-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
	s=mail; t=1559665539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding;
	bh=uJ6C3ng+tjsvvk5Wlyu369WDLSueUY8QLWtJ9tMogNk=;
	b=2YyEDKxe5LQDuTegO8bsxWL76ikWdVocmpEYxTFLdTD02Q//tn+FQP5HV3Tb+iGysb7squ
	uWQsvRE4yi1E/Ulnx4xRiBcE7yN9ghiat7mIQe/k/+OPRPQnPIdgWPbH/exPOO3kZ+vnlM
	/pA53jTkxgXa3Dsjb86rq2+/1ce3KrY=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1559665539; a=rsa-sha256; cv=none;
	b=J/RFUhgMi7kIw3QUsoZo5wIdFeV99uZyIwrFha0Sa8FCU8rxYMYKYLWJAcMua0vNym8v7k
	KolwsyAWM07QOD63nOnnpooAB8UgKPUvge7UuV6Mi8nN+BgxEotHkHgjqsABFTe8fA+yqo
	5eiucvT1y/JsfDyGhTiaEiWN5jgyIAM=
ARC-Authentication-Results: i=1; ORIGINATING;
	auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [RFC PATCH v2 00/12] Multi-phase reset
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org,
	marc.burton@greensocs.com, alistair@alistair23.me,
	qemu-arm@nongnu.org, Damien Hedde <damien.hedde@greensocs.com>,
	marcandre.lureau@redhat.com, pbonzini@redhat.com,
	philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

Here's the second version of the multi-phase reset proposal patches.

# DESCRIPTION

Basically the reset procedure is split in 3 parts:
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

The Resettable interface is detailed in the added doc in patch 7.

# CHANGE SINCE V1

The series now focus only on the Resettable interface (no more ResetDomai=
n).
Proposed changed have been applied:
 - reset_count getter/modifier methods
 - a foreach_child method

This last method allows some flexibility on what is the hierarchy of rese=
t.
There is some discussion ongoing about this point. Althought the series d=
oes
not aim to modify the qdev/qbus-centric reset behavior, it is not fixed. =
An
object specialization can override it.

# RESET DEPRECATION

There is 3 changes in the current way of handling reset (for users or
developers of Devices)

1. qdev/qbus_reset_all

Theses functions are deprecated by this series and should be replaced by
direct call to device_reset or bus_reset. There is only a few existing ca=
lls
so I can probably replace them all and delete the original functions.

2. old's device_reset

There is a few call to this function, I renamed it *device_legacy_reset* =
to
handle the transition. This function allowed to reset only a given device=
=20
(and not its eventual qbus subtree). This behavior is not possible with
the Resettable interface. At first glance it seemed that it is used only =
on=20
device having no sub-buses so we could just use the new device_reset.
But I need to look at them more closely to be sure. If this behavior is r=
eally
needed (but why would we not reset children ?), it's possible to do a spe=
cific
function for Device to to 3-phases reset without the children.

3. DeviceClass's reset and BusClass's methods

This is the major change. The method is deprecated because reset methods =
are
now located in the interface class. In the series, I make the init phase
redirect to the original reset method of DeviceClass (or BusClass). There=
 a
lot of use of the method and transitioning to 3-phases only reset will ne=
ed
some work.

# MIGRATION

Bus reset state migration is right now not handled.

Regarding "migration-during-reset should Just Work, without necessarily
needing any specific changes for a device". The included patch define a v=
msd
subsection which must to be added to every device main vmsd structure for
migration-during-reset of theses devices to work. I tried to find a way t=
o
avoid that but really don't see how to achieve that.

So in the current state of this series, migration can only be supported f=
or
leaf device (in term of qdev/qbus) where we add the subsection.

I'm not sure the migration is the problem here. I doubt a device will
support staying in reset state (which is a new feature) without manual
intervention. So migration of this unsupported state without any specific
change may not be a real asset.

The series is organised as follow:
 - Patch   1 adds Resettable interface
 - Patches 2 and 3 rename device_reset function by device_legacy_reset to=
 prepare
   the transition.
 - Patches 4 to 6 make the changes in Device and Bus classes.=20
 - Patches 7 add some doc
 - Patches 8 to 12 modify the xilinx_zynq to add 3-phases reset support i=
n the
   uart and the slcr (the reset controller).

Thank you for your feedback,
Damien

Damien Hedde (12):
  Create Resettable QOM interface
  add device_legacy_reset function to do the transition with
    device_reset
  replace all occurences of device_reset by device_legacy_reset
  make Device and Bus Resettable
  Add function to control reset with gpio inputs
  add vmstate description for device reset state
  add doc about Resettable interface
  hw/misc/zynq_slcr: use standard register definition
  convert cadence_uart to 3-phases reset
  Convert zynq's slcr to 3-phases reset
  Add uart reset support in zynq_slcr
  Connect the uart reset gpios in the zynq platform

 docs/devel/reset.txt           | 151 +++++++++
 hw/arm/xilinx_zynq.c           |  14 +-
 hw/audio/intel-hda.c           |   2 +-
 hw/char/cadence_uart.c         |  81 ++++-
 hw/core/Makefile.objs          |   2 +
 hw/core/bus.c                  |  60 ++++
 hw/core/qdev-vmstate.c         |  34 +++
 hw/core/qdev.c                 | 124 +++++++-
 hw/core/resettable.c           | 121 ++++++++
 hw/hyperv/hyperv.c             |   2 +-
 hw/i386/pc.c                   |   2 +-
 hw/ide/microdrive.c            |   8 +-
 hw/intc/spapr_xive.c           |   2 +-
 hw/misc/zynq_slcr.c            | 543 ++++++++++++++++++---------------
 hw/ppc/pnv_psi.c               |   2 +-
 hw/ppc/spapr_pci.c             |   2 +-
 hw/ppc/spapr_vio.c             |   2 +-
 hw/s390x/s390-pci-inst.c       |   2 +-
 hw/scsi/vmw_pvscsi.c           |   2 +-
 hw/sd/omap_mmc.c               |   2 +-
 hw/sd/pl181.c                  |   2 +-
 include/hw/char/cadence_uart.h |  10 +-
 include/hw/qdev-core.h         | 112 ++++++-
 include/hw/resettable.h        | 104 +++++++
 tests/Makefile.include         |   1 +
 25 files changed, 1105 insertions(+), 282 deletions(-)
 create mode 100644 docs/devel/reset.txt
 create mode 100644 hw/core/qdev-vmstate.c
 create mode 100644 hw/core/resettable.c
 create mode 100644 include/hw/resettable.h

--=20
2.21.0


