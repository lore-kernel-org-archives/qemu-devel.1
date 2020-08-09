Return-Path: <SRS0=L55N=BT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FA1C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 04:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC4D4206C0
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 04:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXTjcwp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC4D4206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4cqg-0003GF-3Z
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 00:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k4cpt-0002hN-QG
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 00:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k4cpq-0005cL-8X
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 00:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596946883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FeS48GRNcwCkvMpNdJzjIATnYzq6WesnkSaYyqA3VtY=;
 b=AXTjcwp9g+W5eYBSY6NTHK7b+CeMy33UFYwxqUeG3FtbPPyVPl8vDK6z4/RfAMPUfeRIrv
 7heYd9Bep+Z3U78PSZ3qC5YtRowBK0f9/+OVhxc5tB7YNstL7BelyC6JrHLxthcZDIuCOH
 dn+Iu+X9XYtRmeS8pspDd8cCp9cc7KE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-_H1SuA2BNQKKQOGDvk3y2w-1; Sun, 09 Aug 2020 00:21:20 -0400
X-MC-Unique: _H1SuA2BNQKKQOGDvk3y2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02A18100A614
 for <qemu-devel@nongnu.org>; Sun,  9 Aug 2020 04:21:20 +0000 (UTC)
Received: from localhost (ovpn-113-123.rdu2.redhat.com [10.10.113.123])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8215619B5;
 Sun,  9 Aug 2020 04:21:18 +0000 (UTC)
Date: Sun, 9 Aug 2020 00:21:18 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/4] qom: provide convenient macros for declaring and
 defining types
Message-ID: <20200809042118.GG1700540@habkost.net>
References: <20200723181410.3145233-1-berrange@redhat.com>
 <20200723181410.3145233-3-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200723181410.3145233-3-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 00:21:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are implicit requirements in the macros that will be a problem in some
existing type definitions:

On Thu, Jul 23, 2020 at 07:14:08PM +0100, Daniel P. Berrangé wrote:
[...]
> +/**
> + * OBJECT_DECLARE_TYPE:
> + * @ModuleObjName: the object name with initial capitalization
> + * @module_obj_name: the object name in lowercase with underscore separators
> + * @MODULE_OBJ_NAME: the object name in uppercase with underscore separators
> + *
> + * This macro is typically used in a header file, and will:
> + *
> + *   - create the typedefs for the object and class structs
> + *   - register the type for use with g_autoptr
> + *   - provide three standard type cast functions
> + *
> + * The object struct and class struct need to be declared manually.
> + */
> +#define OBJECT_DECLARE_TYPE(ModuleObjName, module_obj_name, MODULE_OBJ_NAME) \
> +    typedef struct ModuleObjName ModuleObjName; \
> +    typedef struct ModuleObjName##Class ModuleObjName##Class; \

The ModuleObjName / ModuleObjName##Class pattern will be a problem in the following cases:

hw/arm/mps2-tz.c:107:1: class typedef MPS2TZMachineClass doesn't match instance typedef MPS2TZMachineState
hw/arm/mps2.c:83:1: class typedef MPS2MachineClass doesn't match instance typedef MPS2MachineState
hw/arm/musca.c:89:1: class typedef MuscaMachineClass doesn't match instance typedef MuscaMachineState
hw/arm/raspi.c:53:1: class typedef RaspiMachineClass doesn't match instance typedef RaspiMachineState
hw/arm/spitz.c:59:1: class typedef SpitzMachineClass doesn't match instance typedef SpitzMachineState
hw/arm/vexpress.c:182:1: class typedef VexpressMachineClass doesn't match instance typedef VexpressMachineState
hw/avr/arduino.c:36:1: class typedef ArduinoMachineClass doesn't match instance typedef ArduinoMachineState
hw/block/m25p80.c:462:1: class typedef M25P80Class doesn't match instance typedef Flash
hw/i386/kvm/i8254.c:40:1: class typedef KVMPITClass doesn't match instance typedef KVMPITState
hw/input/adb-kbd.c:33:1: class typedef ADBKeyboardClass doesn't match instance typedef KBDState
hw/input/adb-mouse.c:32:1: class typedef ADBMouseClass doesn't match instance typedef MouseState
hw/intc/arm_gic_kvm.c:34:1: class typedef KVMARMGICClass doesn't match instance typedef GICState
hw/intc/arm_gicv3_its_kvm.c:32:1: class typedef KVMARMITSClass doesn't match instance typedef GICv3ITSState
hw/intc/arm_gicv3_kvm.c:44:1: class typedef KVMARMGICv3Class doesn't match instance typedef GICv3State
hw/misc/tmp421.c:74:1: class typedef TMP421Class doesn't match instance typedef TMP421State
hw/rtc/m48t59-isa.c:39:1: class typedef M48txxISADeviceClass doesn't match instance typedef M48txxISAState
hw/rtc/m48t59.c:49:1: class typedef M48txxSysBusDeviceClass doesn't match instance typedef M48txxSysBusState
hw/rx/rx-gdbsim.c:53:1: class typedef RxGdbSimMachineClass doesn't match instance typedef RxGdbSimMachineState
hw/scsi/scsi-disk.c:56:1: class typedef SCSIDiskClass doesn't match instance typedef SCSIDiskState
hw/virtio/virtio-pci.h:29:1: class typedef VirtioPCIBusClass doesn't match instance typedef VirtioPCIBusState
hw/virtio/virtio-pci.h:101:1: class typedef VirtioPCIClass doesn't match instance typedef VirtIOPCIProxy
include/hw/boards.h:24:1: class typedef MachineClass doesn't match instance typedef MachineState
include/hw/i386/pc.h:124:1: class typedef PCMachineClass doesn't match instance typedef PCMachineState
include/hw/qdev-core.h:15:1: class typedef DeviceClass doesn't match instance typedef DeviceState
include/hw/qdev-core.h:206:1: class typedef BusClass doesn't match instance typedef BusState

> +    \
> +    G_DEFINE_AUTOPTR_CLEANUP_FUNC(ModuleObjName##Class, object_unref) \
> +    \
> +    static inline G_GNUC_UNUSED ModuleObjName##Class * \
> +    MODULE_OBJ_NAME##_GET_CLASS(void *obj) \
> +    { return OBJECT_GET_CLASS(ModuleObjName##Class, obj, \
> +                              TYPE_##MODULE_OBJ_NAME); } \

The TYPE_##MODULE_OBJ_NAME pattern will be a problem in the following cases:

accel/tcg/tcg-all.c:47:1: macro name TCG_STATE doesn't match type name TYPE_TCG_ACCEL
chardev/baum.c:106:1: macro name BAUM_CHARDEV doesn't match type name TYPE_CHARDEV_BRAILLE
chardev/char-parallel.c:57:1: macro name PARALLEL_CHARDEV doesn't match type name TYPE_CHARDEV_PARALLEL
chardev/char-parallel.c:184:1: macro name PARALLEL_CHARDEV doesn't match type name TYPE_CHARDEV_PARALLEL
chardev/char-pty.c:45:1: macro name PTY_CHARDEV doesn't match type name TYPE_CHARDEV_PTY
chardev/char-ringbuf.c:42:1: macro name RINGBUF_CHARDEV doesn't match type name TYPE_CHARDEV_RINGBUF
chardev/char-socket.c:88:1: macro name SOCKET_CHARDEV doesn't match type name TYPE_CHARDEV_SOCKET
chardev/char-udp.c:45:1: macro name UDP_CHARDEV doesn't match type name TYPE_CHARDEV_UDP
chardev/char-win-stdio.c:40:1: macro name WIN_STDIO_CHARDEV doesn't match type name TYPE_CHARDEV_WIN_STDIO
chardev/msmouse.c:46:1: macro name MOUSE_CHARDEV doesn't match type name TYPE_CHARDEV_MSMOUSE
chardev/testdev.c:41:1: macro name TESTDEV_CHARDEV doesn't match type name TYPE_CHARDEV_TESTDEV
chardev/wctablet.c:87:1: macro name WCTABLET_CHARDEV doesn't match type name TYPE_CHARDEV_WCTABLET
hw/audio/intel-hda.c:205:1: macro name INTEL_HDA doesn't match type name TYPE_INTEL_HDA_GENERIC
hw/char/etraxfs_ser.c:52:1: macro name ETRAX_SERIAL doesn't match type name TYPE_ETRAX_FS_SERIAL
hw/char/virtio-console.c:24:1: macro name VIRTIO_CONSOLE doesn't match type name TYPE_VIRTIO_CONSOLE_SERIAL_PORT
hw/display/ramfb-standalone.c:8:1: macro name RAMFB doesn't match type name TYPE_RAMFB_DEVICE
hw/i386/kvm/i8254.c:40:1: macro name KVM_PIT doesn't match type name TYPE_KVM_I8254
hw/i386/kvm/i8254.c:42:1: macro name KVM_PIT_CLASS doesn't match type name TYPE_KVM_I8254
hw/i386/kvm/i8254.c:44:1: macro name KVM_PIT_GET_CLASS doesn't match type name TYPE_KVM_I8254
hw/i386/kvm/i8259.c:22:1: macro name KVM_PIC_CLASS doesn't match type name TYPE_KVM_I8259
hw/i386/kvm/i8259.c:24:1: macro name KVM_PIC_GET_CLASS doesn't match type name TYPE_KVM_I8259
hw/intc/i8259.c:40:1: macro name PIC_CLASS doesn't match type name TYPE_I8259
hw/intc/i8259.c:41:1: macro name PIC_GET_CLASS doesn't match type name TYPE_I8259
hw/mips/boston.c:46:1: macro name BOSTON doesn't match type name TYPE_MIPS_BOSTON
hw/misc/edu.c:36:1: macro name EDU doesn't match type name TYPE_PCI_EDU_DEVICE
hw/misc/pvpanic.c:31:1: macro name ISA_PVPANIC_DEVICE doesn't match type name TYPE_PVPANIC
hw/net/can/can_kvaser_pci.c:48:1: macro name KVASER_PCI_DEV doesn't match type name TYPE_CAN_PCI_DEV
hw/net/can/can_mioe3680_pci.c:44:1: macro name MIOe3680_PCI_DEV doesn't match type name TYPE_CAN_PCI_DEV
hw/net/can/can_pcm3680_pci.c:44:1: macro name PCM3680i_PCI_DEV doesn't match type name TYPE_CAN_PCI_DEV
hw/net/e1000.c:150:1: macro name E1000 doesn't match type name TYPE_E1000_BASE
hw/net/e1000.c:153:1: macro name E1000_DEVICE_CLASS doesn't match type name TYPE_E1000_BASE
hw/net/e1000.c:156:1: macro name E1000_DEVICE_GET_CLASS doesn't match type name TYPE_E1000_BASE
hw/net/vmxnet3.c:135:1: macro name VMXNET3_DEVICE_CLASS doesn't match type name TYPE_VMXNET3
hw/net/vmxnet3.c:138:1: macro name VMXNET3_DEVICE_GET_CLASS doesn't match type name TYPE_VMXNET3
hw/pci-bridge/pci_expander_bridge.c:41:1: macro name PXB_DEV doesn't match type name TYPE_PXB_DEVICE
hw/pci-bridge/pci_expander_bridge.c:44:1: macro name PXB_PCIE_DEV doesn't match type name TYPE_PXB_PCIE_DEVICE
hw/pci-host/versatile.c:159:1: macro name PCI_VPB doesn't match type name TYPE_VERSATILE_PCI
hw/pci-host/versatile.c:163:1: macro name PCI_VPB_HOST doesn't match type name TYPE_VERSATILE_PCIHOST
hw/ppc/rs6000_mc.c:31:1: macro name RS6000MC_DEVICE doesn't match type name TYPE_RS6000MC
hw/scsi/esp-pci.c:38:1: macro name PCI_ESP doesn't match type name TYPE_AM53C974_DEVICE
hw/scsi/esp-pci.c:417:1: macro name DC390 doesn't match type name TYPE_DC390_DEVICE
hw/scsi/megasas.c:133:1: macro name MEGASAS doesn't match type name TYPE_MEGASAS_BASE
hw/scsi/megasas.c:136:1: macro name MEGASAS_DEVICE_CLASS doesn't match type name TYPE_MEGASAS_BASE
hw/scsi/megasas.c:139:1: macro name MEGASAS_DEVICE_GET_CLASS doesn't match type name TYPE_MEGASAS_BASE
hw/scsi/mptsas.c:46:1: macro name MPT_SAS doesn't match type name TYPE_MPTSAS1068
hw/scsi/vmw_pvscsi.c:66:1: macro name PVSCSI_DEVICE_CLASS doesn't match type name TYPE_PVSCSI
hw/scsi/vmw_pvscsi.c:69:1: macro name PVSCSI_DEVICE_GET_CLASS doesn't match type name TYPE_PVSCSI
hw/sparc/sun4m.c:777:1: macro name SUN4M_RAM doesn't match type name TYPE_SUN4M_MEMORY
hw/sparc64/sun4u.c:490:1: macro name SUN4U_RAM doesn't match type name TYPE_SUN4U_MEMORY
hw/timer/etraxfs_timer.c:51:1: macro name ETRAX_TIMER doesn't match type name TYPE_ETRAX_FS_TIMER
hw/timer/i8254.c:38:1: macro name PIT_CLASS doesn't match type name TYPE_I8254
hw/timer/i8254.c:40:1: macro name PIT_GET_CLASS doesn't match type name TYPE_I8254
hw/tpm/tpm_crb.c:47:1: macro name CRB doesn't match type name TYPE_TPM_CRB
hw/tpm/tpm_spapr.c:31:1: macro name VIO_SPAPR_VTPM doesn't match type name TYPE_TPM_SPAPR
hw/usb/ccid-card-emulated.c:48:1: macro name EMULATED_CCID_CARD doesn't match type name TYPE_EMULATED_CCID
hw/usb/ccid-card-passthru.c:67:1: macro name PASSTHRU_CCID_CARD doesn't match type name TYPE_CCID_PASSTHRU
hw/usb/dev-serial.c:114:1: macro name USB_SERIAL_DEV doesn't match type name TYPE_USB_SERIAL
hw/usb/dev-smartcard-reader.c:63:1: macro name USB_CCID_DEV doesn't match type name CCID_DEV_NAME
hw/usb/dev-storage.c:71:1: macro name USB_STORAGE_DEV doesn't match type name TYPE_USB_STORAGE
hw/usb/redirect.c:147:1: macro name USB_REDIRECT doesn't match type name TYPE_USB_REDIR
hw/usb/tusb6010.c:33:1: macro name TUSB doesn't match type name TYPE_TUSB6010
hw/vfio/ap.c:38:1: macro name VFIO_AP_DEVICE doesn't match type name VFIO_AP_DEVICE_TYPE
hw/vfio/pci.c:46:1: macro name PCI_VFIO doesn't match type name TYPE_VFIO_PCI
net/filter-rewriter.c:25:1: macro name FILTER_COLO_REWRITER doesn't match type name TYPE_FILTER_REWRITER
tests/check-qom-proplist.c:35:1: macro name DUMMY_OBJECT doesn't match type name TYPE_DUMMY
tests/test-qdev-global-props.c:34:1: macro name STATIC_TYPE doesn't match type name TYPE_STATIC_PROPS
tests/test-qdev-global-props.c:130:1: macro name DYNAMIC_TYPE doesn't match type name TYPE_DYNAMIC_PROPS
ui/console.c:1091:1: macro name VC_CHARDEV doesn't match type name TYPE_CHARDEV_VC
ui/gtk.c:181:1: macro name VC_CHARDEV doesn't match type name TYPE_CHARDEV_VC
ui/spice-app.c:48:1: macro name VC_CHARDEV doesn't match type name TYPE_CHARDEV_VC



> +    \
> +    static inline G_GNUC_UNUSED ModuleObjName##Class * \
> +    MODULE_OBJ_NAME##_CLASS(void *klass) \
> +    { return OBJECT_CLASS_CHECK(ModuleObjName##Class, klass, \
> +                                TYPE_##MODULE_OBJ_NAME); } \
> +    \
> +    static inline G_GNUC_UNUSED ModuleObjName * \
> +    MODULE_OBJ_NAME(void *obj) \
> +    { return OBJECT_CHECK(ModuleObjName, obj, \
> +                          TYPE_##MODULE_OBJ_NAME); }
> +
[...]

-- 
Eduardo


