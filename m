Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCC9CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 22:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF0721897
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 22:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNBma5pE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF0721897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLxN4-0002Yw-PL
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 18:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nicolas.prochazka@gmail.com>) id 1iLwPj-00058g-6B
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 17:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nicolas.prochazka@gmail.com>) id 1iLwPf-0007nf-VX
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 17:37:31 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:43678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nicolas.prochazka@gmail.com>)
 id 1iLwPf-0007ms-Ib
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 17:37:27 -0400
Received: by mail-ed1-x533.google.com with SMTP id q24so1189344edr.10
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 14:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=8SykEx+8B03/td97h9Em75rZp1TlbTcykQ23snPlyK8=;
 b=VNBma5pEu/kd8dxBhYPKs17BcUdY5vHkyPb2wvYAw7xNGH3tdre3HqKH/3TgCPAlP7
 Ogg8xDVvf25odM62E7sWsyWSc4IpXwGycKRnknh4lnxJdcZbhqNWHXU53iPHoxspkxzH
 GDUDi6woUElLPYHqetswUmvK7fNtrFwvkQ6F+Q6QHnab9aF8DisMYPMi+7YjOZCg640G
 3JAN0UAj5fTcS5ThoOpuFdcSmH3Sknt0b40Axws6oVa9qp1UoZZMVxCUj3P6ZgZJpCJN
 Ly6ZFfL3FlQmTY+Qu8Qp2ULzTZ4QtajQIcRBgzt8QrBclN1+U3YCJBjzXW/RoeNUbCaL
 xaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=8SykEx+8B03/td97h9Em75rZp1TlbTcykQ23snPlyK8=;
 b=QCkhqeGejtKyborFpp7Sjx7wtFb+c2SEMx0Q734ykFIBSusZw6ZIl/BsoujaMU13IO
 g2h+B9xE380YR7EEE+Ts8GusgPUKlM/T60lqnzYPAzJNQ4Id5ZkwHIlwuhOOafUZpgKK
 RQYOiZO3CrV5CjgilAuKuBdZi/Nso1CzHBtr5Usb9iOfXjFUxgMt0A2ZCvZHxrQFxigt
 CpbI4Q/fKTyOkrvkOTqJ1/P4ne2HYgoZ+0UiMAx3k2YzYiXf2fhsQMMFsHqPyOUmvz9o
 fd1cA7rntHgZcFhunc7oMqeyHBgDehGM2beaXjMx1x5m3IIyKlNh/1/3qRAAJIyrjhjf
 Sg3g==
X-Gm-Message-State: APjAAAX1mTKydsZ3PVwsVVoeqfmw1ettJXEAlgvLU+PUavIV5LUOi8Iq
 rMSdhj/gKoVWh8MRe35aoQmGQSjrGTkHGdC5IJHdvKI1
X-Google-Smtp-Source: APXvYqwK0WchrKzbIYasEX90Hb7pr3oBLDCMaKFdP/cGN9CgI2ZB039YDckQVF9rdEeyWOfaaylnvEXojLx/Z0Vjaow=
X-Received: by 2002:a17:906:c4a:: with SMTP id
 t10mr14987951ejf.290.1571521044658; 
 Sat, 19 Oct 2019 14:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <CADdae-gJnt5pU_qYFuhM9NH2q86NRpQO1CrBJ4PMKaT_iNZmFA@mail.gmail.com>
In-Reply-To: <CADdae-gJnt5pU_qYFuhM9NH2q86NRpQO1CrBJ4PMKaT_iNZmFA@mail.gmail.com>
From: nicolas prochazka <prochazka.nicolas@gmail.com>
Date: Sat, 19 Oct 2019 23:37:09 +0200
Message-ID: <CADdae-ippkCmVO1wnxrftb1OCuF10bM7GOzsQZ0EO8tVO9Vk3w@mail.gmail.com>
Subject: Fwd: IGD assignment / Legacy Mode Question
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::533
X-Mailman-Approved-At: Sat, 19 Oct 2019 18:36:47 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,
We are using IGD legacy assignment to start our Vm  on Intel nuc
platform ( generation 7, 8 ) with succes.
However, in some cases, we must set rombar to off and sometime rombar
set to on in order to start the Vm.

We are using Windows 10 :
according to the hardware ( intel nuc 6,7,8 generation, other
plateforme as asus PN60 )
- Rombar must be set to on or off  , ( off can block at seabios level)
- When rombar is set to on, there's no windows boot logon ( vga not
detect ? , if rombar set to off, vga boot is present )

Is there any explanation to these strange behaviour, or just Intel Igd ?


Regards,
Nicolas Prochazka


Libvirt Xml :
Important point :

        <qemu:commandline>
                <qemu:arg value='-netdev
user,id=user.0,restrict=on,hostfwd=tcp:127.0.0.1:5901-:5900,hostfwd=tcp:127.0.0.1:3389-:3389
-device virtio-net-pci,netdev=user.0'/>
                <qemu:arg value='-set'/>
                <qemu:arg value='device.hostdev0.x-igd-gms=1'/>
                <qemu:arg value='-chardev stdio,id=seabios -device
isa-debugcon,iobase=0x402,chardev=seabios' />
</qemu:commandline>



    <hostdev mode='subsystem' type='pci' managed='yes'>
                        <source>
                                <address domain='0x0000' bus='0x00'
slot='0x02' function='0x0'/>
                        </source>
                        <address type='pci' domain='0x0000' bus='0x00'
slot='0x02' function='0x0'/>
<rom bar='off' file='/data/ROOT/templates/romIgd.03441V'/>
                </hostdev>


=> Qemu log / seabios seems to be block


2019-10-07 12:39:58.384+0000: starting up libvirt version: 5.2.0, qemu
version: 4.1.0, kernel: 4.19.75, hostname: -DELL5590
LC_ALL=C \
PATH=/bin:/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
\
HOME=/var/lib/libvirt/qemu/domain-4-W10 \
USER=root \
XDG_DATA_HOME=/var/lib/libvirt/qemu/domain-4-W10/.local/share \
XDG_CACHE_HOME=/var/lib/libvirt/qemu/domain-4-W10/.cache \
XDG_CONFIG_HOME=/var/lib/libvirt/qemu/domain-4-W10/.config \
QEMU_AUDIO_DRV=none \
/usr/bin/qemu-kvm.igd \
-name guest=W10,debug-threads=on \
-S \
-object secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-4-W10/master-key.aes
\
-machine pc-i440fx-2.11,accel=kvm,usb=off,dump-guest-core=off \
-cpu host,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=0x1000,hv_vpindex,hv_runtime,hv_synic,hv_reset
\
-bios /usr/share/seabios/bios.bin \
-m 6413 \
-mem-prealloc \
-mem-path /dev/hugepages/libvirt/qemu/4-W10 \
-realtime mlock=off \
-smp 6,sockets=1,cores=6,threads=1 \
-uuid 0414a538-bab4-3456-87f1-b8271b4b018d \
-display none \
-no-user-config \
-nodefaults \
-chardev socket,id=charmonitor,fd=25,server,nowait \
-mon chardev=charmonitor,id=monitor,mode=control \
-rtc base=localtime \
-no-shutdown \
-global PIIX4_PM.disable_s3=1 \
-global PIIX4_PM.disable_s4=1 \
-boot strict=on \
-device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 \
-device virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x4 \
-drive file=/data/VMS/W10/hda.qcow2,format=qcow2,if=none,id=drive-virtio-disk0,cache=writeback
\
-device virtio-blk-pci,scsi=off,num-queues=4,bus=pci.0,addr=0x5,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1,write-cache=on
\
-drive file=/data/VMS/W10/swap.qcow2,format=qcow2,if=none,id=drive-virtio-disk1,cache=unsafe
\
-device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x6,drive=drive-virtio-disk1,id=virtio-disk1,write-cache=on
\
-netdev tap,fd=27,id=hostnet0,vhost=on,vhostfd=28 \
-device virtio-net-pci,netdev=hostnet0,id=net0,mac=ac:de:50:65:9f:5d,bus=pci.0,addr=0x3
\
-chardev socket,id=charchannel0,fd=29,server,nowait \
-device virtserialport,bus=virtio-serial0.0,nr=1,chardev=charchannel0,id=channel0,name=org.qemu.guest_agent.0
\
-device virtio-input-host-pci,id=input0,evdev=/dev/input/event4,bus=pci.0,addr=0x11
\
-device virtio-input-host-pci,id=input1,evdev=/dev/input/event5,bus=pci.0,addr=0x12
\
-device vfio-pci,host=00:02.0,id=hostdev0,bus=pci.0,addr=0x2,rombar=0,romfile=/data/ROOT/templates/romIgd.03441V
\
-device vfio-pci,host=00:14.0,id=hostdev1,bus=pci.0,addr=0x7 \
-device vfio-pci,host=00:1f.3,id=hostdev2,bus=pci.0,addr=0x8 \
-device vfio-pci,host=02:00.0,id=hostdev3,bus=pci.0,addr=0x9 \
'-netdev user,id=user.0,restrict=on,hostfwd=tcp:127.0.0.1:5901-:5900,hostfwd=tcp:127.0.0.1:3389-:3389
-device virtio-net-pci,netdev=user.0' \
-set device.hostdev0.x-igd-gms=1 \
'-chardev stdio,id=seabios -device isa-debugcon,iobase=0x402,chardev=seabios' \
-msg timestamp=on
2019-10-07 12:39:58.384+0000: Domain id=4 is tainted: high-privileges
2019-10-07 12:39:58.384+0000: Domain id=4 is tainted: custom-argv
2019-10-07 12:39:58.384+0000: Domain id=4 is tainted: host-cpu
qemu-system-x86_64.igd: -realtime mlock=off: warning: '-realtime
mlock=...' is deprecated, please use '-overcommit mem-lock=...'
instead
qemu_madvise: Invalid argument
madvise doesn't support MADV_DONTDUMP, but dump_guest_core=off specified
2019-10-07T12:39:59.942833Z qemu-system-x86_64.igd: vfio: Cannot reset
device 0000:00:1f.3, no available reset mechanism.
2019-10-07T12:39:59.982817Z qemu-system-x86_64.igd: vfio: Cannot reset
device 0000:00:14.0, no available reset mechanism.
2019-10-07T12:40:00.143566Z qemu-system-x86_64.igd: vfio: Cannot reset
device 0000:00:1f.3, no available reset mechanism.
2019-10-07T12:40:00.143718Z qemu-system-x86_64.igd: vfio: Cannot reset
device 0000:00:14.0, no available reset mechanism.
SeaBIOS (version 1.12.0-20191007_112719-localhost.localdomain)
BUILD: gcc: (Gentoo 7.3.0-r3 p1.4) 7.3.0 binutils: (Gentoo 2.24 p1.4) 2.24
No Xen hypervisor found.
RamSize: 0xc0000000 [cmos]
Relocating init from 0x000d88c0 to 0xbffac2a0 (size 81088)
Found QEMU fw_cfg
QEMU fw_cfg DMA interface supported
RamBlock: addr 0x0000000000000000 len 0x00000000c0000000 [e820]
RamBlock: addr 0x0000000100000000 len 0x00000000d0d00000 [e820]
Moving pm_base to 0x600
boot order:
1: /pci@i0cf8/scsi@5/disk@0,0
2: HALT
=== PCI bus & bridge init ===
PCI: pci_bios_init_bus_rec bus = 0x0
=== PCI device probing ===
Found 17 PCI devices (max PCI bus is 00)
=== PCI new allocation pass #1 ===
PCI: check devices
=== PCI new allocation pass #2 ===
PCI: IO: c000 - c16f
PCI: 32: 00000000c0000000 - 00000000fec00000
PCI: map device bdf=00:02.0  bar 4, addr 0000c000, size 00000040 [io]
PCI: map device bdf=00:04.0  bar 0, addr 0000c040, size 00000040 [io]
PCI: map device bdf=00:05.0  bar 0, addr 0000c080, size 00000040 [io]
PCI: map device bdf=00:06.0  bar 0, addr 0000c0c0, size 00000040 [io]
PCI: map device bdf=00:01.2  bar 4, addr 0000c100, size 00000020 [io]
PCI: map device bdf=00:03.0  bar 0, addr 0000c120, size 00000020 [io]
PCI: map device bdf=00:0a.0  bar 0, addr 0000c140, size 00000020 [io]
PCI: map device bdf=00:01.1  bar 4, addr 0000c160, size 00000010 [io]
PCI: map device bdf=00:02.0  bar 0, addr fd000000, size 01000000 [mem]
PCI: map device bdf=00:03.0  bar 6, addr fe000000, size 00040000 [mem]
PCI: map device bdf=00:0a.0  bar 6, addr fe040000, size 00040000 [mem]
PCI: map device bdf=00:07.0  bar 0, addr fe080000, size 00010000 [mem]
PCI: map device bdf=00:08.0  bar 4, addr fe090000, size 00010000 [mem]
PCI: map device bdf=00:08.0  bar 0, addr fe0a0000, size 00004000 [mem]
PCI: map device bdf=00:09.0  bar 0, addr fe0a4000, size 00002000 [mem]
PCI: map device bdf=00:03.0  bar 1, addr fe0a6000, size 00001000 [mem]
PCI: map device bdf=00:04.0  bar 1, addr fe0a7000, size 00001000 [mem]
PCI: map device bdf=00:05.0  bar 1, addr fe0a8000, size 00001000 [mem]
PCI: map device bdf=00:06.0  bar 1, addr fe0a9000, size 00001000 [mem]
PCI: map device bdf=00:0a.0  bar 1, addr fe0aa000, size 00001000 [mem]
PCI: map device bdf=00:11.0  bar 1, addr fe0ab000, size 00001000 [mem]
PCI: map device bdf=00:12.0  bar 1, addr fe0ac000, size 00001000 [mem]
PCI: map device bdf=00:02.0  bar 2, addr e0000000, size 10000000 [prefmem]
PCI: map device bdf=00:03.0  bar 4, addr f0000000, size 00004000 [prefmem]
PCI: map device bdf=00:04.0  bar 4, addr f0004000, size 00004000 [prefmem]
PCI: map device bdf=00:05.0  bar 4, addr f0008000, size 00004000 [prefmem]
PCI: map device bdf=00:06.0  bar 4, addr f000c000, size 00004000 [prefmem]
PCI: map device bdf=00:0a.0  bar 4, addr f0010000, size 00004000 [prefmem]
PCI: map device bdf=00:11.0  bar 4, addr f0014000, size 00004000 [prefmem]
PCI: map device bdf=00:12.0  bar 4, addr f0018000, size 00004000 [prefmem]
PCI: init bdf=00:00.0 id=8086:1237
PCI: init bdf=00:01.0 id=8086:7000
PIIX3/PIIX4 init: elcr=00 0c
PCI: init bdf=00:01.1 id=8086:7010
PCI: init bdf=00:01.2 id=8086:7020
PCI: init bdf=00:01.3 id=8086:7113
Using pmtimer, ioport 0x608
PCI: init bdf=00:02.0 id=8086:5917
Intel IGD OpRegion enabled at 0xbfffe000, size 8KB, dev 00:02.0
Intel IGD BDSM enabled at 0xbd700000, size 40MB, dev 00:02.0
PCI: init bdf=00:03.0 id=1af4:1000
PCI: init bdf=00:04.0 id=1af4:1003
PCI: init bdf=00:05.0 id=1af4:1001
PCI: init bdf=00:06.0 id=1af4:1001
PCI: init bdf=00:07.0 id=8086:9d2f
PCI: init bdf=00:08.0 id=8086:9d71
PCI: init bdf=00:09.0 id=8086:24fd
PCI: init bdf=00:0a.0 id=1af4:1000
PCI: init bdf=00:11.0 id=1af4:1052
PCI: init bdf=00:12.0 id=1af4:1052
PCI: init bdf=00:1f.0 id=8086:9d4e
PCI: Using 00:02.0 for primary VGA
handle_smp: apic_id=0x2
handle_smp: apic_id=0x5
handle_smp: apic_id=0x1
handle_smp: apic_id=0x3
handle_smp: apic_id=0x4
Found 6 cpu(s) max supported 6 cpu(s)
Copying PIR from 0xbffbfc20 to 0x000f5dc0
Copying MPTABLE from 0x00006e64/bffa2ac0 to 0x000f5c80
Copying SMBIOS entry point from 0x00006e64 to 0x000f5aa0
WARNING - Timeout at wait_reg8:81!
WARNING - Timeout at wait_reg8:81!
Scan for VGA option rom
Running option rom at c000:0003



---------------------------------------------- rombar = on
2019-10-07 12:41:47.765+0000: starting up libvirt version: 5.2.0, qemu
version: 4.1.0, kernel: 4.19.75, hostname: -DELL5590
LC_ALL=C \
PATH=/bin:/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
\
HOME=/var/lib/libvirt/qemu/domain-5-W10 \
USER=root \
XDG_DATA_HOME=/var/lib/libvirt/qemu/domain-5-W10/.local/share \
XDG_CACHE_HOME=/var/lib/libvirt/qemu/domain-5-W10/.cache \
XDG_CONFIG_HOME=/var/lib/libvirt/qemu/domain-5-W10/.config \
QEMU_AUDIO_DRV=none \
/usr/bin/qemu-kvm.igd \
-name guest=W10,debug-threads=on \
-S \
-object secret,id=masterKey0,format=raw,file=/var/lib/libvirt/qemu/domain-5-W10/master-key.aes
\
-machine pc-i440fx-2.11,accel=kvm,usb=off,dump-guest-core=off \
-cpu host,hv_time,hv_relaxed,hv_vapic,hv_spinlocks=0x1000,hv_vpindex,hv_runtime,hv_synic,hv_reset
\
-bios /usr/share/seabios/bios.bin \
-m 6413 \
-mem-prealloc \
-mem-path /dev/hugepages/libvirt/qemu/5-W10 \
-realtime mlock=off \
-smp 6,sockets=1,cores=6,threads=1 \
-uuid 0414a538-bab4-3456-87f1-b8271b4b018d \
-display none \
-no-user-config \
-nodefaults \
-chardev socket,id=charmonitor,fd=24,server,nowait \
-mon chardev=charmonitor,id=monitor,mode=control \
-rtc base=localtime \
-no-shutdown \
-global PIIX4_PM.disable_s3=1 \
-global PIIX4_PM.disable_s4=1 \
-boot strict=on \
-device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2 \
-device virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x4 \
-drive file=/data/VMS/W10/hda.qcow2,format=qcow2,if=none,id=drive-virtio-disk0,cache=writeback
\
-device virtio-blk-pci,scsi=off,num-queues=4,bus=pci.0,addr=0x5,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1,write-cache=on
\
-drive file=/data/VMS/W10/swap.qcow2,format=qcow2,if=none,id=drive-virtio-disk1,cache=unsafe
\
-device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x6,drive=drive-virtio-disk1,id=virtio-disk1,write-cache=on
\
-netdev tap,fd=26,id=hostnet0,vhost=on,vhostfd=27 \
-device virtio-net-pci,netdev=hostnet0,id=net0,mac=ac:de:50:65:9f:5d,bus=pci.0,addr=0x3
\
-chardev socket,id=charchannel0,fd=28,server,nowait \
-device virtserialport,bus=virtio-serial0.0,nr=1,chardev=charchannel0,id=channel0,name=org.qemu.guest_agent.0
\
-device virtio-input-host-pci,id=input0,evdev=/dev/input/event4,bus=pci.0,addr=0x11
\
-device virtio-input-host-pci,id=input1,evdev=/dev/input/event5,bus=pci.0,addr=0x12
\
-device vfio-pci,host=00:02.0,id=hostdev0,bus=pci.0,addr=0x2,rombar=1,romfile=/data/ROOT/templates/romIgd.03441V
\
-device vfio-pci,host=00:14.0,id=hostdev1,bus=pci.0,addr=0x7 \
-device vfio-pci,host=00:1f.3,id=hostdev2,bus=pci.0,addr=0x8 \
-device vfio-pci,host=02:00.0,id=hostdev3,bus=pci.0,addr=0x9 \
'-netdev user,id=user.0,restrict=on,hostfwd=tcp:127.0.0.1:5901-:5900,hostfwd=tcp:127.0.0.1:3389-:3389
-device virtio-net-pci,netdev=user.0' \
-set device.hostdev0.x-igd-gms=1 \
'-chardev stdio,id=seabios -device isa-debugcon,iobase=0x402,chardev=seabios' \
-msg timestamp=on
2019-10-07 12:41:47.765+0000: Domain id=5 is tainted: high-privileges
2019-10-07 12:41:47.765+0000: Domain id=5 is tainted: custom-argv
2019-10-07 12:41:47.765+0000: Domain id=5 is tainted: host-cpu
qemu-system-x86_64.igd: -realtime mlock=off: warning: '-realtime
mlock=...' is deprecated, please use '-overcommit mem-lock=...'
instead
qemu_madvise: Invalid argument
madvise doesn't support MADV_DONTDUMP, but dump_guest_core=off specified
2019-10-07T12:41:49.272900Z qemu-system-x86_64.igd: vfio: Cannot reset
device 0000:00:1f.3, no available reset mechanism.
2019-10-07T12:41:49.312881Z qemu-system-x86_64.igd: vfio: Cannot reset
device 0000:00:14.0, no available reset mechanism.
2019-10-07T12:41:49.473547Z qemu-system-x86_64.igd: vfio: Cannot reset
device 0000:00:1f.3, no available reset mechanism.
2019-10-07T12:41:49.473702Z qemu-system-x86_64.igd: vfio: Cannot reset
device 0000:00:14.0, no available reset mechanism.
SeaBIOS (version 1.12.0-20191007_112719-localhost.localdomain)
BUILD: gcc: (Gentoo 7.3.0-r3 p1.4) 7.3.0 binutils: (Gentoo 2.24 p1.4) 2.24
No Xen hypervisor found.
RamSize: 0xc0000000 [cmos]
Relocating init from 0x000d88c0 to 0xbffac2a0 (size 81088)
Found QEMU fw_cfg
QEMU fw_cfg DMA interface supported
RamBlock: addr 0x0000000000000000 len 0x00000000c0000000 [e820]
RamBlock: addr 0x0000000100000000 len 0x00000000d0d00000 [e820]
Moving pm_base to 0x600
boot order:
1: /pci@i0cf8/scsi@5/disk@0,0
2: HALT
=== PCI bus & bridge init ===
PCI: pci_bios_init_bus_rec bus = 0x0
=== PCI device probing ===
Found 17 PCI devices (max PCI bus is 00)
=== PCI new allocation pass #1 ===
PCI: check devices
=== PCI new allocation pass #2 ===
PCI: IO: c000 - c16f
PCI: 32: 00000000c0000000 - 00000000fec00000
PCI: map device bdf=00:02.0  bar 4, addr 0000c000, size 00000040 [io]
PCI: map device bdf=00:04.0  bar 0, addr 0000c040, size 00000040 [io]
PCI: map device bdf=00:05.0  bar 0, addr 0000c080, size 00000040 [io]
PCI: map device bdf=00:06.0  bar 0, addr 0000c0c0, size 00000040 [io]
PCI: map device bdf=00:01.2  bar 4, addr 0000c100, size 00000020 [io]
PCI: map device bdf=00:03.0  bar 0, addr 0000c120, size 00000020 [io]
PCI: map device bdf=00:0a.0  bar 0, addr 0000c140, size 00000020 [io]
PCI: map device bdf=00:01.1  bar 4, addr 0000c160, size 00000010 [io]
PCI: map device bdf=00:02.0  bar 0, addr fd000000, size 01000000 [mem]
PCI: map device bdf=00:03.0  bar 6, addr fe000000, size 00040000 [mem]
PCI: map device bdf=00:0a.0  bar 6, addr fe040000, size 00040000 [mem]
PCI: map device bdf=00:02.0  bar 6, addr fe080000, size 00010000 [mem]
PCI: map device bdf=00:07.0  bar 0, addr fe090000, size 00010000 [mem]
PCI: map device bdf=00:08.0  bar 4, addr fe0a0000, size 00010000 [mem]
PCI: map device bdf=00:08.0  bar 0, addr fe0b0000, size 00004000 [mem]
PCI: map device bdf=00:09.0  bar 0, addr fe0b4000, size 00002000 [mem]
PCI: map device bdf=00:03.0  bar 1, addr fe0b6000, size 00001000 [mem]
PCI: map device bdf=00:04.0  bar 1, addr fe0b7000, size 00001000 [mem]
PCI: map device bdf=00:05.0  bar 1, addr fe0b8000, size 00001000 [mem]
PCI: map device bdf=00:06.0  bar 1, addr fe0b9000, size 00001000 [mem]
PCI: map device bdf=00:0a.0  bar 1, addr fe0ba000, size 00001000 [mem]
PCI: map device bdf=00:11.0  bar 1, addr fe0bb000, size 00001000 [mem]
PCI: map device bdf=00:12.0  bar 1, addr fe0bc000, size 00001000 [mem]
PCI: map device bdf=00:02.0  bar 2, addr e0000000, size 10000000 [prefmem]
PCI: map device bdf=00:03.0  bar 4, addr f0000000, size 00004000 [prefmem]
PCI: map device bdf=00:04.0  bar 4, addr f0004000, size 00004000 [prefmem]
PCI: map device bdf=00:05.0  bar 4, addr f0008000, size 00004000 [prefmem]
PCI: map device bdf=00:06.0  bar 4, addr f000c000, size 00004000 [prefmem]
PCI: map device bdf=00:0a.0  bar 4, addr f0010000, size 00004000 [prefmem]
PCI: map device bdf=00:11.0  bar 4, addr f0014000, size 00004000 [prefmem]
PCI: map device bdf=00:12.0  bar 4, addr f0018000, size 00004000 [prefmem]
PCI: init bdf=00:00.0 id=8086:1237
PCI: init bdf=00:01.0 id=8086:7000
PIIX3/PIIX4 init: elcr=00 0c
PCI: init bdf=00:01.1 id=8086:7010
PCI: init bdf=00:01.2 id=8086:7020
PCI: init bdf=00:01.3 id=8086:7113
Using pmtimer, ioport 0x608
PCI: init bdf=00:02.0 id=8086:5917
Intel IGD OpRegion enabled at 0xbfffe000, size 8KB, dev 00:02.0
Intel IGD BDSM enabled at 0xbd700000, size 40MB, dev 00:02.0
PCI: init bdf=00:03.0 id=1af4:1000
PCI: init bdf=00:04.0 id=1af4:1003
PCI: init bdf=00:05.0 id=1af4:1001
PCI: init bdf=00:06.0 id=1af4:1001
PCI: init bdf=00:07.0 id=8086:9d2f
PCI: init bdf=00:08.0 id=8086:9d71
PCI: init bdf=00:09.0 id=8086:24fd
PCI: init bdf=00:0a.0 id=1af4:1000
PCI: init bdf=00:11.0 id=1af4:1052
PCI: init bdf=00:12.0 id=1af4:1052
PCI: init bdf=00:1f.0 id=8086:9d4e
PCI: Using 00:02.0 for primary VGA
handle_smp: apic_id=0x4
handle_smp: apic_id=0x3
handle_smp: apic_id=0x2
handle_smp: apic_id=0x1
handle_smp: apic_id=0x5
Found 6 cpu(s) max supported 6 cpu(s)
Copying PIR from 0xbffbfc20 to 0x000f5dc0
Copying MPTABLE from 0x00006e64/bffa2b90 to 0x000f5c80
Copying SMBIOS entry point from 0x00006e64 to 0x000f5aa0
WARNING - Timeout at wait_reg8:81!
WARNING - Timeout at wait_reg8:81!
Scan for VGA option rom
Turning on vga text mode console
SeaBIOS (version 1.12.0-20191007_112719-localhost.localdomain)
Machine UUID 0414a538-bab4-3456-87f1-b8271b4b018d
XHCI init on dev 00:07.0: regs @ 0xfe090000, 18 ports, 64 slots, 32
byte contexts
XHCI    protocol USB  2.00, 12 ports (offset 1), def 3011
XHCI    protocol USB  3.00, 6 ports (offset 13), def 3000
XHCI    extcap 0xc0 @ 0xfe098070
XHCI    extcap 0x1 @ 0xfe09846c
XHCI    extcap 0xc6 @ 0xfe0984f4
XHCI    extcap 0xc7 @ 0xfe098500
XHCI    extcap 0xc2 @ 0xfe098600
XHCI    extcap 0xa @ 0xfe098700
XHCI    extcap 0xc3 @ 0xfe098740
XHCI    extcap 0xc4 @ 0xfe098800
XHCI    extcap 0xc5 @ 0xfe098900
WARNING - Unable to allocate resource at configure_xhci:499!
All threads complete.
UHCI init on dev 00:01.2 (io=c100)
ATA controller 1 at 1f0/3f4/0 (irq 14 dev 9)
ATA controller 2 at 170/374/0 (irq 15 dev 9)
found virtio-blk at 00:05.0
pci dev 0:5 virtio cap at 0x84 type 5 [pci cfg access]
pci dev 0:5 virtio cap at 0x70 type 2 bar 4 at 0xf0008000 off +0x3000 [mmio]
pci dev 0:5 virtio cap at 0x60 type 4 bar 4 at 0xf0008000 off +0x2000 [mmio]
pci dev 0:5 virtio cap at 0x50 type 3 bar 4 at 0xf0008000 off +0x1000 [mmio]
pci dev 0:5 virtio cap at 0x40 type 1 bar 4 at 0xf0008000 off +0x0000 [mmio]
pci dev 00:05.0 using modern (1.0) virtio mode
Searching bootorder for: /pci@i0cf8/*@5
found virtio-blk at 00:06.0
pci dev 0:6 virtio cap at 0x84 type 5 [pci cfg access]
pci dev 0:6 virtio cap at 0x70 type 2 bar 4 at 0xf000c000 off +0x3000 [mmio]
pci dev 0:6 virtio cap at 0x60 type 4 bar 4 at 0xf000c000 off +0x2000 [mmio]
pci dev 0:6 virtio cap at 0x50 type 3 bar 4 at 0xf000c000 off +0x1000 [mmio]
pci dev 0:6 virtio cap at 0x40 type 1 bar 4 at 0xf000c000 off +0x0000 [mmio]
pci dev 00:06.0 using modern (1.0) virtio mode
Searching bootorder for: /pci@i0cf8/*@6
PS2 keyboard initialized
Found 0 lpt ports
Found 0 serial ports
All threads complete.
Scan for option roms
Running option rom at c000:0003
pmm call arg1=1
pmm call arg1=0
pmm call arg1=1
pmm call arg1=0
Running option rom at c100:0003
pmm call arg1=1
pmm call arg1=1
Searching bootorder for: /pci@i0cf8/*@3
Searching bootorder for: /pci@i0cf8/*@a
Searching bootorder for: /rom@genroms/kvmvapic.bin
Searching bootorder for: HALT
drive 0x000ebc60: PCHS=16383/16/63 translation=lba LCHS=1024/255/63 s=125829120
drive 0x000ebc00: PCHS=8322/16/63 translation=lba LCHS=522/255/63 s=8388608
Running option rom at c200:0003
Space available for UMB: c4800-eb800, f5640-f5a40
Returned 98304 bytes of ZoneHigh
e820 map has 10 items:
  0: 0000000000000000 - 000000000009fc00 = 1 RAM
  1: 000000000009fc00 - 00000000000a0000 = 2 RESERVED
  2: 00000000000f0000 - 0000000000100000 = 2 RESERVED
  3: 0000000000100000 - 00000000bd700000 = 1 RAM
  4: 00000000bd700000 - 00000000bff00000 = 2 RESERVED
  5: 00000000bff00000 - 00000000bffd8000 = 1 RAM
  6: 00000000bffd8000 - 00000000c0000000 = 2 RESERVED
  7: 00000000feffc000 - 00000000ff000000 = 2 RESERVED
  8: 00000000fffc0000 - 0000000100000000 = 2 RESERVED
  9: 0000000100000000 - 00000001d0d00000 = 1 RAM
enter handle_19:
  NULL
Booting from Hard Disk...
Booting from 0000:7c00



























Complete libvirt domain xml





<domain type='kvm' xmlns:qemu='http://libvirt.org/schemas/domain/qemu/1.0'>

        <qemu:commandline>
                <qemu:arg value='-netdev
user,id=user.0,restrict=on,hostfwd=tcp:127.0.0.1:5901-:5900,hostfwd=tcp:127.0.0.1:3389-:3389
-device virtio-net-pci,netdev=user.0'/>
                <qemu:arg value='-set'/>
                <qemu:arg value='device.hostdev0.x-igd-gms=1'/>
                <qemu:arg value='-chardev stdio,id=seabios -device
isa-debugcon,iobase=0x402,chardev=seabios' />
</qemu:commandline>

        <uuid>0414a538-bab4-3456-87f1-b8271b4b018d</uuid>
        <name>W10</name>
        <memory unit='MB'>6724</memory>
        <currentMemory unit='MB'>6724</currentMemory>

        <memoryBacking>
                <hugepages/>
        </memoryBacking>

        <os>
                <type>hvm</type>
                <loader readonly='yes'
type='rom'>/usr/share/seabios/bios.bin</loader>
        </os>

        <features>
                <acpi/>
                <apic/>
                <hap/>
                <hyperv>
                        <relaxed state='on'/>
                        <vapic state='on'/>
                        <spinlocks state='on' retries='4096'/>
                        <vpindex state='on'/>
                        <runtime state='on'/>
                        <synic state='on'/>
                        <reset state='on'/>
                </hyperv>
        </features>

        <vcpu placement='static'>6</vcpu>
        <cputune>
                <vcpupin vcpu='0' cpuset='2'/>
                <vcpupin vcpu='1' cpuset='3'/>
        </cputune>

        <cpu mode='host-passthrough'>
                <model>kvm64</model>
                <feature policy='optional' name='x2apic' />
                <topology sockets='1' cores='6' threads='1' />
        </cpu>

        <pm>
                <suspend-to-disk enabled='no'/>
                <suspend-to-mem enabled='no'/>
        </pm>

        <clock offset='localtime' timezone='Europe/Paris'>
                <timer name='hpet' present='yes'/>
                <timer name='hypervclock' present='yes'/>
        </clock>

        <devices>
                <emulator>/usr/bin/qemu-kvm.igd</emulator>
                <channel type='unix'>
                        <source mode='bind' />
                        <target type='virtio' name='org.qemu.guest_agent.0'/>
                        <address type='virtio-serial' controller='0'
bus='0' port='1'/>
                </channel>

                <disk type='file' device='disk'>
                        <driver name='qemu' type='qcow2' queues='4'
cache='writeback'/>
                        <boot order='1'/>
                        <source file='/data/VMS/W10/hda.qcow2'/>
                        <target dev='vda' bus='virtio' />
                </disk>

                <disk type='file' device='disk' snapshot='no'>
                        <driver name='qemu' type='qcow2' cache='unsafe'/>
                        <source file='/data/VMS/W10/swap.qcow2' />
                        <target dev='vdb' bus='virtio' />
                </disk>

                <memballoon model='none'/>
                <interface type='bridge'>
                        <source bridge='switch0' />
                        <virtualport type='openvswitch' />
                        <model type='virtio'/>
                        <mac address='AC:DE:50:65:9F:5D'/>
                        <vlan>
                                <tag id='0' />
                        </vlan>
                </interface>

                <hostdev mode='subsystem' type='pci' managed='yes'>
                        <source>
                                <address domain='0x0000' bus='0x00'
slot='0x02' function='0x0'/>
                        </source>
                        <address type='pci' domain='0x0000' bus='0x00'
slot='0x02' function='0x0'/>
                </hostdev>

</devices></domain>

