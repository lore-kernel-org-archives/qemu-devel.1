Received: from eggs.gnu.org ([2001:4830:134:3::10]:54278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOnyL-00088W-T5
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOnyH-0006yG-Qv
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:36:17 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:40340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOnyH-0006xk-L3
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:36:13 -0400
Received: by mail-qk0-x244.google.com with SMTP id r66-v6so20478590qkr.7
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 10:36:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180601171521.1770-1-pbonzini@redhat.com>
	<20180601171521.1770-4-pbonzini@redhat.com>
	<d0ee9736-399a-ce20-5f69-1cf36f29090a@amsat.org>
	<0d714788-b03f-0028-ed14-7fb344d4ff43@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3225b86a-f208-4142-1c45-8252e551290e@amsat.org>
Date: Fri, 1 Jun 2018 14:36:09 -0300
MIME-Version: 1.0
In-Reply-To: <0d714788-b03f-0028-ed14-7fb344d4ff43@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 56/56] hw: make virtio devices configurable
 via default-configs/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 06/01/2018 02:31 PM, Paolo Bonzini wrote:
> On 01/06/2018 19:26, Philippe Mathieu-Daudé wrote:
>> On 06/01/2018 02:15 PM, Paolo Bonzini wrote:
>>> This is only half of the work, because the proxy devices (virtio-*-pci,
>>> virtio-*-ccw, etc.) are still included unconditionally.  It is still a
>>> move in the right direction.
>>>
>>> Based-on: <20180522194943.24871-1-pbonzini@redhat.com>
>>
>> Is this tag useful?
> 
> Yeah, usually it would go in the cover letter.  It remained here because
> this patch was not part of a series.

Sorry I meant "is this useful [in the git history, since this is a pull
request]".

> 
> Paolo
> 
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  default-configs/arm-softmmu.mak     |  1 +
>>>  default-configs/hppa-softmmu.mak    |  2 --
>>>  default-configs/pci.mak             |  4 +---
>>>  default-configs/riscv32-softmmu.mak |  4 ++--
>>>  default-configs/riscv64-softmmu.mak |  4 ++--
>>>  default-configs/s390x-softmmu.mak   |  5 +----
>>>  default-configs/virtio.mak          | 14 ++++++++++++++
>>>  hw/9pfs/Makefile.objs               |  6 ++++--
>>>  hw/block/Makefile.objs              |  6 ++----
>>>  hw/char/Makefile.objs               |  2 +-
>>>  hw/display/Makefile.objs            |  4 ++--
>>>  hw/input/Makefile.objs              |  6 +++---
>>>  hw/net/Makefile.objs                |  2 +-
>>>  hw/scsi/Makefile.objs               |  2 +-
>>>  hw/virtio/Makefile.objs             | 16 +++++++++-------
>>>  15 files changed, 44 insertions(+), 34 deletions(-)
>>>  create mode 100644 default-configs/virtio.mak
>>>
>>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>>> index dd29e741c2..8ba2558b36 100644
>>> --- a/default-configs/arm-softmmu.mak
>>> +++ b/default-configs/arm-softmmu.mak
>>> @@ -41,6 +41,7 @@ CONFIG_USB=y
>>>  CONFIG_USB_MUSB=y
>>>  CONFIG_USB_EHCI_SYSBUS=y
>>>  CONFIG_PLATFORM_BUS=y
>>> +CONFIG_VIRTIO_MMIO=y
>>>  
>>>  CONFIG_ARM11MPCORE=y
>>>  CONFIG_A9MPCORE=y
>>> diff --git a/default-configs/hppa-softmmu.mak b/default-configs/hppa-softmmu.mak
>>> index 013e5f046f..4badc0521e 100644
>>> --- a/default-configs/hppa-softmmu.mak
>>> +++ b/default-configs/hppa-softmmu.mak
>>> @@ -4,8 +4,6 @@ CONFIG_SERIAL=y
>>>  CONFIG_SERIAL_ISA=y
>>>  CONFIG_ISA_BUS=y
>>>  CONFIG_I8259=y
>>> -CONFIG_VIRTIO_PCI=$(CONFIG_PCI)
>>> -CONFIG_VIRTIO=y
>>>  CONFIG_E1000_PCI=y
>>>  CONFIG_IDE_ISA=y
>>>  CONFIG_IDE_CMD646=y
>>> diff --git a/default-configs/pci.mak b/default-configs/pci.mak
>>> index 163dd814c7..de53d20ac6 100644
>>> --- a/default-configs/pci.mak
>>> +++ b/default-configs/pci.mak
>>> @@ -2,7 +2,7 @@ CONFIG_PCI=y
>>>  # For now, CONFIG_IDE_CORE requires ISA, so we enable it here
>>>  CONFIG_ISA_BUS=y
>>>  CONFIG_VIRTIO_PCI=y
>>> -CONFIG_VIRTIO=y
>>> +include virtio.mak
>>>  CONFIG_USB_UHCI=y
>>>  CONFIG_USB_OHCI=y
>>>  CONFIG_USB_EHCI=y
>>> @@ -46,5 +46,3 @@ CONFIG_VGA=y
>>>  CONFIG_VGA_PCI=y
>>>  CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
>>>  CONFIG_ROCKER=y
>>> -CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
>>> -CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
>>> diff --git a/default-configs/riscv32-softmmu.mak b/default-configs/riscv32-softmmu.mak
>>> index 9159a4a8af..20e670d99c 100644
>>> --- a/default-configs/riscv32-softmmu.mak
>>> +++ b/default-configs/riscv32-softmmu.mak
>>> @@ -1,5 +1,5 @@
>>>  # Default configuration for riscv-softmmu
>>>  
>>>  CONFIG_SERIAL=y
>>> -CONFIG_VIRTIO=y
>>> -CONFIG_SCSI=y
>>> +CONFIG_VIRTIO_MMIO=y
>>> +include virtio.mak
>>> diff --git a/default-configs/riscv64-softmmu.mak b/default-configs/riscv64-softmmu.mak
>>> index 9159a4a8af..20e670d99c 100644
>>> --- a/default-configs/riscv64-softmmu.mak
>>> +++ b/default-configs/riscv64-softmmu.mak
>>> @@ -1,5 +1,5 @@
>>>  # Default configuration for riscv-softmmu
>>>  
>>>  CONFIG_SERIAL=y
>>> -CONFIG_VIRTIO=y
>>> -CONFIG_SCSI=y
>>> +CONFIG_VIRTIO_MMIO=y
>>> +include virtio.mak
>>> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
>>> index 729033b25a..d6b67d50f0 100644
>>> --- a/default-configs/s390x-softmmu.mak
>>> +++ b/default-configs/s390x-softmmu.mak
>>> @@ -1,9 +1,6 @@
>>>  CONFIG_PCI=y
>>>  CONFIG_VIRTIO_PCI=$(CONFIG_PCI)
>>> -CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
>>> -CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
>>> -CONFIG_SCSI=y
>>> -CONFIG_VIRTIO=y
>>> +include virtio.mak
>>>  CONFIG_SCLPCONSOLE=y
>>>  CONFIG_TERMINAL3270=y
>>>  CONFIG_S390_FLIC=y
>>> diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
>>> new file mode 100644
>>> index 0000000000..1304849018
>>> --- /dev/null
>>> +++ b/default-configs/virtio.mak
>>> @@ -0,0 +1,14 @@
>>> +CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
>>> +CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
>>> +CONFIG_VIRTIO=y
>>> +CONFIG_VIRTIO_9P=y
>>> +CONFIG_VIRTIO_BALLOON=y
>>> +CONFIG_VIRTIO_BLK=y
>>> +CONFIG_VIRTIO_CRYPTO=y
>>> +CONFIG_VIRTIO_GPU=y
>>> +CONFIG_VIRTIO_INPUT=y
>>> +CONFIG_VIRTIO_NET=y
>>> +CONFIG_VIRTIO_RNG=y
>>> +CONFIG_SCSI=y
>>> +CONFIG_VIRTIO_SCSI=y
>>> +CONFIG_VIRTIO_SERIAL=y
>>> diff --git a/hw/9pfs/Makefile.objs b/hw/9pfs/Makefile.objs
>>> index fd90b62900..e3fa673665 100644
>>> --- a/hw/9pfs/Makefile.objs
>>> +++ b/hw/9pfs/Makefile.objs
>>> @@ -1,3 +1,4 @@
>>> +ifeq ($(call lor,$(CONFIG_VIRTIO_9P),$(CONFIG_XEN)),y)
>>>  common-obj-y  = 9p.o 9p-util.o
>>>  common-obj-y += 9p-local.o 9p-xattr.o
>>>  common-obj-y += 9p-xattr-user.o 9p-posix-acl.o
>>> @@ -5,6 +6,7 @@ common-obj-y += coth.o cofs.o codir.o cofile.o
>>>  common-obj-y += coxattr.o 9p-synth.o
>>>  common-obj-$(CONFIG_OPEN_BY_HANDLE) +=  9p-handle.o
>>>  common-obj-y += 9p-proxy.o
>>> -common-obj-$(CONFIG_XEN) += xen-9p-backend.o
>>> +endif
>>>  
>>> -obj-$(CONFIG_VIRTIO) += virtio-9p-device.o
>>> +common-obj-$(CONFIG_XEN) += xen-9p-backend.o
>>> +obj-$(CONFIG_VIRTIO_9P) += virtio-9p-device.o
>>> diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
>>> index 4c19a583c8..53ce5751ae 100644
>>> --- a/hw/block/Makefile.objs
>>> +++ b/hw/block/Makefile.objs
>>> @@ -11,8 +11,6 @@ common-obj-$(CONFIG_NVME_PCI) += nvme.o
>>>  
>>>  obj-$(CONFIG_SH4) += tc58128.o
>>>  
>>> -obj-$(CONFIG_VIRTIO) += virtio-blk.o
>>> -obj-$(CONFIG_VIRTIO) += dataplane/
>>> -ifeq ($(CONFIG_VIRTIO),y)
>>> +obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
>>> +obj-$(CONFIG_VIRTIO_BLK) += dataplane/
>>>  obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
>>> -endif
>>> diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
>>> index 1b979100b7..b570531291 100644
>>> --- a/hw/char/Makefile.objs
>>> +++ b/hw/char/Makefile.objs
>>> @@ -6,7 +6,7 @@ common-obj-$(CONFIG_PL011) += pl011.o
>>>  common-obj-$(CONFIG_SERIAL) += serial.o
>>>  common-obj-$(CONFIG_SERIAL_ISA) += serial-isa.o
>>>  common-obj-$(CONFIG_SERIAL_PCI) += serial-pci.o
>>> -common-obj-$(CONFIG_VIRTIO) += virtio-console.o
>>> +common-obj-$(CONFIG_VIRTIO_SERIAL) += virtio-console.o
>>>  common-obj-$(CONFIG_XILINX) += xilinx_uartlite.o
>>>  common-obj-$(CONFIG_XEN) += xen_console.o
>>>  common-obj-$(CONFIG_CADENCE) += cadence_uart.o
>>> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
>>> index d907b381ae..b5d97ab26d 100644
>>> --- a/hw/display/Makefile.objs
>>> +++ b/hw/display/Makefile.objs
>>> @@ -36,8 +36,8 @@ obj-$(CONFIG_VGA) += vga.o
>>>  
>>>  common-obj-$(CONFIG_QXL) += qxl.o qxl-logger.o qxl-render.o
>>>  
>>> -obj-$(CONFIG_VIRTIO) += virtio-gpu.o virtio-gpu-3d.o
>>> -obj-$(CONFIG_VIRTIO_PCI) += virtio-gpu-pci.o
>>> +obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu.o virtio-gpu-3d.o
>>> +obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) += virtio-gpu-pci.o
>>>  obj-$(CONFIG_VIRTIO_VGA) += virtio-vga.o
>>>  virtio-gpu.o-cflags := $(VIRGL_CFLAGS)
>>>  virtio-gpu.o-libs += $(VIRGL_LIBS)
>>> diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
>>> index 77e53e6883..c8b00f71ec 100644
>>> --- a/hw/input/Makefile.objs
>>> +++ b/hw/input/Makefile.objs
>>> @@ -7,10 +7,10 @@ common-obj-y += ps2.o
>>>  common-obj-$(CONFIG_STELLARIS_INPUT) += stellaris_input.o
>>>  common-obj-$(CONFIG_TSC2005) += tsc2005.o
>>>  
>>> -common-obj-$(CONFIG_VIRTIO) += virtio-input.o
>>> -common-obj-$(CONFIG_VIRTIO) += virtio-input-hid.o
>>> +common-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input.o
>>> +common-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-hid.o
>>>  ifeq ($(CONFIG_LINUX),y)
>>> -common-obj-$(CONFIG_VIRTIO) += virtio-input-host.o
>>> +common-obj-$(CONFIG_VIRTIO_INPUT) += virtio-input-host.o
>>>  endif
>>>  
>>>  obj-$(CONFIG_MILKYMIST) += milkymist-softusb.o
>>> diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
>>> index ab22968641..fa461d4463 100644
>>> --- a/hw/net/Makefile.objs
>>> +++ b/hw/net/Makefile.objs
>>> @@ -36,7 +36,7 @@ obj-$(CONFIG_MILKYMIST) += milkymist-minimac2.o
>>>  obj-$(CONFIG_PSERIES) += spapr_llan.o
>>>  obj-$(CONFIG_XILINX_ETHLITE) += xilinx_ethlite.o
>>>  
>>> -obj-$(CONFIG_VIRTIO) += virtio-net.o
>>> +obj-$(CONFIG_VIRTIO_NET) += virtio-net.o
>>>  obj-y += vhost_net.o
>>>  
>>>  obj-$(CONFIG_ETSEC) += fsl_etsec/etsec.o fsl_etsec/registers.o \
>>> diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
>>> index b188f7242b..718b4c2a68 100644
>>> --- a/hw/scsi/Makefile.objs
>>> +++ b/hw/scsi/Makefile.objs
>>> @@ -8,7 +8,7 @@ common-obj-$(CONFIG_ESP) += esp.o
>>>  common-obj-$(CONFIG_ESP_PCI) += esp-pci.o
>>>  obj-$(CONFIG_PSERIES) += spapr_vscsi.o
>>>  
>>> -ifeq ($(CONFIG_VIRTIO),y)
>>> +ifeq ($(CONFIG_VIRTIO_SCSI),y)
>>>  obj-y += virtio-scsi.o virtio-scsi-dataplane.o
>>>  obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-common.o vhost-scsi.o
>>>  obj-$(CONFIG_VHOST_USER_SCSI) += vhost-scsi-common.o vhost-user-scsi.o
>>> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
>>> index 765d363c1f..1b2799cfd8 100644
>>> --- a/hw/virtio/Makefile.objs
>>> +++ b/hw/virtio/Makefile.objs
>>> @@ -1,15 +1,17 @@
>>>  ifeq ($(CONFIG_VIRTIO),y)
>>> -common-obj-y += virtio-rng.o
>>> -common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
>>>  common-obj-y += virtio-bus.o
>>> -common-obj-y += virtio-mmio.o
>>> +obj-y += virtio.o
>>> +
>>> +common-obj-$(CONFIG_VIRTIO_RNG) += virtio-rng.o
>>> +common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
>>> +common-obj-$(CONFIG_VIRTIO_MMIO) += virtio-mmio.o
>>> +obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon.o
>>> +obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
>>> +obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
>>>  
>>> -obj-y += virtio.o virtio-balloon.o 
>>>  obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
>>>  obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
>>> -obj-y += virtio-crypto.o
>>> -obj-$(CONFIG_VIRTIO_PCI) += virtio-crypto-pci.o
>>>  endif
>>>  
>>> -common-obj-$(call lnot,$(CONFIG_LINUX)) += vhost-stub.o
>>> +common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
>>>  common-obj-$(CONFIG_ALL) += vhost-stub.o
>>>
> 
> 
