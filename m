Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F83AC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38E520758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWY3I6CV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38E520758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbU5-0001Rg-2A
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbTM-0000LY-8j
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:43:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbTJ-0008CS-9f
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fRlYLbc9zHK5rDuw+XIkRaWceHtEHyftTw23lCFH6IM=;
 b=AWY3I6CVtlE+Y9Ia6eJru5/JL3Lla65/3kyqQhPVLZPnk3YuR22aD/itjNgVo2GMbSomsE
 5x9PJwEF74UXk12fRIGJp2epyOmKeNRiMGZJAkFXsxvu+Ua5sSEl/EMxh5SzaJtiy63wvu
 sfbVlFybwUxENq06/tJX45alPlynRqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-Krc5UJy0NaG4XRlXhNdz3A-1; Wed, 02 Sep 2020 18:43:12 -0400
X-MC-Unique: Krc5UJy0NaG4XRlXhNdz3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11F2A1DE00
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 22:43:12 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB18419C71;
 Wed,  2 Sep 2020 22:43:11 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/63] qom: Rename macros for consistency
Date: Wed,  2 Sep 2020 18:42:08 -0400
Message-Id: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 16:25:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reducing boilerplate QOM code using the new OBJECT_DEFINE_* and=0D
OBJECT_DECLARE_* macros is quite difficult when there are=0D
multiple ways a TYPE_* constant name is written.=0D
=0D
This series renames many type checking macros and/or TYPE_*=0D
constants to make sure they are consistent.=0D
=0D
This series is based on machine-next and can be fetched from:=0D
=0D
  https://github.com/ehabkost/qemu-hacks work/qom-rename-macros=0D
=0D
Eduardo Habkost (63):=0D
  gpex: Fix type checking function name=0D
  chardev: Rename TYPE_CHARDEV_* to TYPE_*_CHARDEV=0D
  chardev: Rename TYPE_BRAILLE_CHARDEV to TYPE_BAUM_CHARDEV=0D
  chardev: Rename TYPE_MSMOUSE_CHARDEV to TYPE_MOUSE_CHARDEV=0D
  ap-device: Rename AP_DEVICE_TYPE to TYPE_AP_DEVICE=0D
  dev-smartcard-reader: Rename CCID_DEV_NAME to TYPE_USB_CCID_DEV=0D
  rdma: Rename PVRDMA_HW_NAME to TYPE_PVRDMA_DEV=0D
  vfio: Rename VFIO_AP_DEVICE_TYPE to TYPE_VFIO_AP_DEVICE=0D
  vmcoreinfo: Rename VMCOREINFO_DEVICE to TYPE_VMCOREINFO=0D
  vmgenid: Rename VMGENID_DEVICE to TYPE_VMGENID=0D
  edu: Rename TYPE_PCI_EDU_DEVICE to TYPE_EDU=0D
  etrax: Rename TYPE_ETRAX_FS_SERIAL to TYPE_ETRAX_SERIAL=0D
  etrax: Rename TYPE_ETRAX_FS_TIMER to TYPE_ETRAX_TIMER=0D
  i8254: Rename TYPE_I8254 to TYPE_PIT=0D
  i8259: Rename TYPE_I8259 to TYPE_PIC=0D
  i8259: Rename TYPE_KVM_I8259 to TYPE_KVM_PIC=0D
  intel-hda: Rename TYPE_INTEL_HDA_GENERIC to TYPE_INTEL_HDA=0D
  mips: Rename TYPE_MIPS_BOSTON to TYPE_BOSTON=0D
  mptsas: Rename TYPE_MPTSAS1068 to TYPE_MPT_SAS=0D
  pc87312: Rename TYPE_PC87312_SUPERIO to TYPE_PC87312=0D
  pxb: Rename TYPE_PXB_DEVICE to TYPE_PXB_DEV=0D
  pxb: Rename TYPE_PXB_PCIE_DEVICE to TYPE_PXB_PCIE_DEV=0D
  ramfb: Rename TYPE_RAMFB_DEVICE to TYPE_RAMFB=0D
  scsi: Rename TYPE_AM53C974_DEVICE to TYPE_PCI_ESP=0D
  scsi: Rename TYPE_DC390_DEVICE to TYPE_DC390=0D
  sun4m: Rename TYPE_SUN4M_MEMORY to TYPE_SUN4M_RAM=0D
  sun4u: Rename TYPE_SUN4U_MEMORY to TYPE_SUN4U_RAM=0D
  tusb6010: Rename TYPE_TUSB6010 to TYPE_TUSB=0D
  versatile: Rename TYPE_VERSATILE_PCI_HOST to TYPE_PCI_VPB_HOST=0D
  versatile: Rename TYPE_VERSATILE_PCI to TYPE_PCI_VPB=0D
  virtio-console: Rename TYPE_VIRTIO_CONSOLE_SERIAL_PORT to=0D
    TYPE_VIRTIO_CONSOLE=0D
  ahci: Rename ICH_AHCI to ICH9_AHCI=0D
  net/can: Rename TYPE_CAN_CPI constants=0D
  can: Rename KVASER_PCI_DEV to KVASER_PCI=0D
  can: Rename MIOe3680_PCI_DEV to MIOE3680_PCI=0D
  can: Rename PCM3680i_PCI_DEV to PCM3680_PCI=0D
  ccid-card-emulated: Rename EMULATED_CCID_CARD to EMULATED_CCID=0D
  ccid-card-passthru: Rename PASSTHRU_CCID_CARD to CCID_PASSTHRU=0D
  esp: Rename ESP_STATE to ESP=0D
  filter-rewriter: Rename FILTER_COLO_REWRITER to FILTER_REWRITER=0D
  lance: Rename SYSBUS_PCNET to LANCE=0D
  lasi_i82596: Rename SYSBUS_I82596 to LASI_82596=0D
  pvpanic: Rename ISA_PVPANIC_DEVICE to PVPANIC=0D
  renesas: Rename RCMT to RENESAS_CMT=0D
  renesas: Rename RSCI to RENESAS_SCI=0D
  renesas: Rename RTMR to RENESAS_TMR=0D
  rs6000_mc: Rename RS6000MC_DEVICE to RS6000MC=0D
  sabre: Rename SABRE_DEVICE to SABRE=0D
  stm32f205: Rename STM32F2XXTIMER to STM32F2XX_TIMER=0D
  tpm_crb: Rename CRB to TPM_CRB=0D
  tpm_spapr: Rename VIO_SPAPR_VTPM to TPM_SPAPR=0D
  usb: Rename USB_REDIRECT to USB_REDIR=0D
  usb: Rename USB_SERIAL_DEV to USB_SERIAL=0D
  usb: Rename USB_STORAGE_DEV to USB_STORAGE=0D
  vfio: Rename PCI_VFIO to VFIO_PCI=0D
  vmxnet3: Rename VMXNET3_DEVICE* to VMXNET3*=0D
  xen: Rename XENBACKEND_DEVICE to XENBACKEND=0D
  hvf: Rename HVF_STATE to HVF_ACCEL=0D
  kvm: Rename KVM_STATE to KVM_ACCEL=0D
  tcg: Rename TCG_STATE to TCG_ACCEL=0D
  tests: Rename TYPE_DUMMY to TYPE_DUMMY_OBJECT=0D
  tests: Rename DYNAMIC_TYPE to DYNAMIC_PROPS=0D
  tests: Rename STATIC_TYPE to STATIC_PROPS=0D
=0D
 chardev/chardev-internal.h          |  4 ++--=0D
 hw/rdma/vmw/pvrdma.h                |  4 ++--=0D
 hw/scsi/mptsas.h                    |  4 ++--=0D
 hw/vfio/pci.h                       |  2 +-=0D
 include/chardev/char-fd.h           |  4 ++--=0D
 include/chardev/char-win-stdio.h    |  2 +-=0D
 include/chardev/char-win.h          |  4 ++--=0D
 include/chardev/char.h              | 30 ++++++++++++++---------------=0D
 include/chardev/spice.h             |  8 ++++----=0D
 include/hw/acpi/vmgenid.h           |  6 +++---=0D
 include/hw/char/renesas_sci.h       |  2 +-=0D
 include/hw/display/ramfb.h          |  2 +-=0D
 include/hw/ide/ahci.h               |  2 +-=0D
 include/hw/isa/pc87312.h            |  4 ++--=0D
 include/hw/misc/vmcoreinfo.h        |  6 +++---=0D
 include/hw/net/lance.h              |  2 +-=0D
 include/hw/net/lasi_82596.h         |  2 +-=0D
 include/hw/pci-host/gpex.h          |  2 +-=0D
 include/hw/pci-host/sabre.h         |  2 +-=0D
 include/hw/s390x/ap-device.h        |  4 ++--=0D
 include/hw/scsi/esp.h               |  2 +-=0D
 include/hw/timer/i8254.h            |  4 ++--=0D
 include/hw/timer/renesas_cmt.h      |  2 +-=0D
 include/hw/timer/renesas_tmr.h      |  6 +++---=0D
 include/hw/timer/stm32f2xx_timer.h  |  2 +-=0D
 include/hw/xen/xen-legacy-backend.h |  2 +-=0D
 include/sysemu/hvf.h                |  2 +-=0D
 include/sysemu/kvm.h                |  2 +-=0D
 accel/kvm/kvm-all.c                 | 18 ++++++++---------=0D
 accel/tcg/tcg-all.c                 | 14 +++++++-------=0D
 chardev/baum.c                      |  6 +++---=0D
 chardev/char-console.c              |  4 ++--=0D
 chardev/char-fd.c                   |  2 +-=0D
 chardev/char-file.c                 |  6 +++---=0D
 chardev/char-mux.c                  |  2 +-=0D
 chardev/char-null.c                 |  2 +-=0D
 chardev/char-parallel.c             |  4 ++--=0D
 chardev/char-pipe.c                 |  6 +++---=0D
 chardev/char-pty.c                  |  4 ++--=0D
 chardev/char-ringbuf.c              |  8 ++++----=0D
 chardev/char-serial.c               |  6 +++---=0D
 chardev/char-socket.c               |  4 ++--=0D
 chardev/char-stdio.c                |  6 +++---=0D
 chardev/char-udp.c                  |  4 ++--=0D
 chardev/char-win-stdio.c            |  4 ++--=0D
 chardev/char-win.c                  |  2 +-=0D
 chardev/char.c                      |  2 +-=0D
 chardev/msmouse.c                   |  6 +++---=0D
 chardev/spice.c                     | 10 +++++-----=0D
 chardev/testdev.c                   |  6 +++---=0D
 chardev/wctablet.c                  |  6 +++---=0D
 gdbstub.c                           |  6 +++---=0D
 hw/acpi/vmgenid.c                   |  6 +++---=0D
 hw/arm/sysbus-fdt.c                 |  2 +-=0D
 hw/arm/virt.c                       |  2 +-=0D
 hw/audio/intel-hda.c                | 10 +++++-----=0D
 hw/char/etraxfs_ser.c               |  6 +++---=0D
 hw/char/renesas_sci.c               | 18 ++++++++---------=0D
 hw/char/virtio-console.c            |  8 ++++----=0D
 hw/display/ramfb-standalone.c       |  4 ++--=0D
 hw/display/vhost-user-gpu.c         |  2 +-=0D
 hw/dma/sparc32_dma.c                |  2 +-=0D
 hw/i386/kvm/i8259.c                 | 10 +++++-----=0D
 hw/i386/pc_piix.c                   |  2 +-=0D
 hw/i386/pc_q35.c                    |  2 +-=0D
 hw/ide/ahci.c                       |  4 ++--=0D
 hw/ide/ich.c                        |  8 ++++----=0D
 hw/intc/i8259.c                     | 10 +++++-----=0D
 hw/isa/pc87312.c                    |  2 +-=0D
 hw/m68k/q800.c                      |  2 +-=0D
 hw/mips/boston.c                    |  8 ++++----=0D
 hw/mips/jazz.c                      |  2 +-=0D
 hw/misc/edu.c                       |  6 +++---=0D
 hw/misc/pvpanic.c                   |  6 +++---=0D
 hw/misc/vmcoreinfo.c                |  6 +++---=0D
 hw/net/can/can_kvaser_pci.c         | 16 +++++++--------=0D
 hw/net/can/can_mioe3680_pci.c       | 16 +++++++--------=0D
 hw/net/can/can_pcm3680_pci.c        | 16 +++++++--------=0D
 hw/net/lance.c                      |  6 +++---=0D
 hw/net/lasi_i82596.c                |  8 ++++----=0D
 hw/net/vmxnet3.c                    |  6 +++---=0D
 hw/pci-bridge/pci_expander_bridge.c | 12 ++++++------=0D
 hw/pci-host/sabre.c                 |  8 ++++----=0D
 hw/pci-host/versatile.c             | 16 +++++++--------=0D
 hw/ppc/rs6000_mc.c                  |  4 ++--=0D
 hw/rdma/vmw/pvrdma_main.c           |  2 +-=0D
 hw/rx/rx62n.c                       |  2 +-=0D
 hw/s390x/ap-device.c                |  2 +-=0D
 hw/scsi/esp-pci.c                   | 14 +++++++-------=0D
 hw/scsi/esp.c                       |  6 +++---=0D
 hw/scsi/mptsas.c                    |  2 +-=0D
 hw/sparc/sun4m.c                    | 10 +++++-----=0D
 hw/sparc64/sun4u.c                  | 10 +++++-----=0D
 hw/timer/etraxfs_timer.c            |  6 +++---=0D
 hw/timer/i8254.c                    |  4 ++--=0D
 hw/timer/renesas_cmt.c              |  4 ++--=0D
 hw/timer/renesas_tmr.c              |  6 +++---=0D
 hw/timer/stm32f2xx_timer.c          |  6 +++---=0D
 hw/tpm/tpm_crb.c                    | 14 +++++++-------=0D
 hw/tpm/tpm_spapr.c                  | 14 +++++++-------=0D
 hw/usb/ccid-card-emulated.c         | 10 +++++-----=0D
 hw/usb/ccid-card-passthru.c         |  8 ++++----=0D
 hw/usb/dev-serial.c                 |  4 ++--=0D
 hw/usb/dev-smartcard-reader.c       |  8 ++++----=0D
 hw/usb/dev-storage.c                | 12 ++++++------=0D
 hw/usb/redirect.c                   | 22 ++++++++++-----------=0D
 hw/usb/tusb6010.c                   |  6 +++---=0D
 hw/vfio/ap.c                        | 10 +++++-----=0D
 hw/vfio/pci.c                       | 22 ++++++++++-----------=0D
 net/filter-rewriter.c               | 18 ++++++++---------=0D
 target/arm/kvm.c                    |  2 +-=0D
 target/i386/kvm.c                   |  2 +-=0D
 target/mips/kvm.c                   |  2 +-=0D
 target/ppc/kvm.c                    |  4 ++--=0D
 tests/check-qom-proplist.c          | 30 ++++++++++++++---------------=0D
 tests/test-char.c                   |  4 ++--=0D
 tests/test-io-task.c                | 14 +++++++-------=0D
 tests/test-qdev-global-props.c      | 16 +++++++--------=0D
 ui/console.c                        |  8 ++++----=0D
 ui/gtk.c                            |  6 +++---=0D
 ui/spice-app.c                      | 10 +++++-----=0D
 121 files changed, 406 insertions(+), 406 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


