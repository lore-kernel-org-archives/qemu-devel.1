Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1F5C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B8720656
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B8720656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42703 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT2h0-0004b7-1c
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 08:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jT2g2-0002xE-Ob
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jT2fx-0001vM-M8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:15:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:47188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jT2fx-0001p2-5E
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:15:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jT2fu-0004H4-Ig
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 12:15:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8B70F2E8109
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 12:15:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Apr 2020 12:09:37 -0000
From: A van Schie <1875139@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: avschie berrange
X-Launchpad-Bug-Reporter: A van Schie (avschie)
X-Launchpad-Bug-Modifier: A van Schie (avschie)
References: <158788589324.18152.6333525201430073299.malonedeb@wampee.canonical.com>
Message-Id: <158798937750.18021.12217668708037565402.malone@wampee.canonical.com>
Subject: [Bug 1875139] Re: Domain fails to start when 'readonly' device not
 writable
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="486bbbd6cb608f8eb468ed0d08689a349dfabe49";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c69ac51b265e06283e33a6a84cdfcfbde247871b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 08:15:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1875139 <1875139@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The domain.xml:
<domain type=3D'kvm'>
  <name>rotest</name>
  <uuid>b4aa0288-8886-42df-abfd-4c8f729e1330</uuid>
  <memory unit=3D'KiB'>2048000</memory>
  <currentMemory unit=3D'KiB'>2048000</currentMemory>
  <vcpu placement=3D'static'>2</vcpu>
  <os>
    <type arch=3D'x86_64' machine=3D'pc-i440fx-2.7'>hvm</type>
    <kernel>/var/lib/libvirt/pink/kernel</kernel>
    <cmdline>root=3D/dev/sda ro panic=3D300 systemd.show_status=3D1 systemd=
.unit=3Dgraphical.target quiet</cmdline>
    <boot dev=3D'hd'/>
  </os>
  <features>
    <acpi/>
  </features>
  <cpu mode=3D'custom' match=3D'exact' check=3D'none'>
    <model fallback=3D'forbid'>qemu64</model>
  </cpu>
  <clock offset=3D'utc'>
    <timer name=3D'rtc' tickpolicy=3D'catchup'/>
    <timer name=3D'pit' tickpolicy=3D'delay'/>
    <timer name=3D'hpet' present=3D'no'/>
  </clock>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <devices>
    <emulator>/usr/bin/qemu-system-x86_64</emulator>
    <disk type=3D'block' device=3D'disk'>
      <driver name=3D'qemu' type=3D'raw'/>
      <source dev=3D'/dev/nvmvg/rotest'/>
      <target dev=3D'sda' bus=3D'scsi'/>
      <readonly/>
      <shareable/>
      <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' unit=
=3D'0'/>
    </disk>
    <disk type=3D'block' device=3D'disk'>
      <driver name=3D'qemu' type=3D'raw' cache=3D'none'/>
      <source dev=3D'/dev/nvmvg/rotest-var'/>
      <target dev=3D'sdb' bus=3D'scsi'/>
      <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' unit=
=3D'1'/>
    </disk>
    <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>
    <controller type=3D'scsi' index=3D'0' model=3D'virtio-scsi'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' fu=
nction=3D'0x0'/>
    </controller>
    <controller type=3D'usb' index=3D'0' model=3D'piix3-uhci'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x2'/>
    </controller>
    <input type=3D'mouse' bus=3D'ps2'/>
    <input type=3D'keyboard' bus=3D'ps2'/>
    <graphics type=3D'spice' autoport=3D'yes'>
      <listen type=3D'address'/>
      <gl enable=3D'no' rendernode=3D'/dev/dri/by-path/pci-0000:00:02.0-ren=
der'/>
    </graphics>
    <video>
      <model type=3D'virtio' heads=3D'1' primary=3D'yes'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x0'/>
    </video>
    <memballoon model=3D'virtio'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x07' fu=
nction=3D'0x0'/>
    </memballoon>
  </devices>
</domain>

---------------------------------------------------------------------------=
-----

The qemu command:
2020-04-27 11:57:11.720+0000: starting up libvirt version: 6.0.0, qemu vers=
ion: 4.2.0, kernel: 5.4.28-gentoo, hostname: gentoo
LC_ALL=3DC \
PATH=3D/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
HOME=3D/var/lib/libvirt/qemu/domain-10-rotest \
XDG_DATA_HOME=3D/var/lib/libvirt/qemu/domain-10-rotest/.local/share \
XDG_CACHE_HOME=3D/var/lib/libvirt/qemu/domain-10-rotest/.cache \
XDG_CONFIG_HOME=3D/var/lib/libvirt/qemu/domain-10-rotest/.config \
QEMU_AUDIO_DRV=3Dspice \
/usr/bin/qemu-system-x86_64 \
-name guest=3Drotest,debug-threads=3Don \
-S \
-object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/do=
main-10-rotest/master-key.aes \
-machine pc-i440fx-2.7,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff \
-cpu qemu64 \
-m 2000 \
-overcommit mem-lock=3Doff \
-smp 2,sockets=3D2,cores=3D1,threads=3D1 \
-uuid b4aa0288-8886-42df-abfd-4c8f729e1330 \
-no-user-config \
-nodefaults \
-chardev socket,id=3Dcharmonitor,fd=3D32,server,nowait \
-mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
-rtc base=3Dutc,driftfix=3Dslew \
-global kvm-pit.lost_tick_policy=3Ddelay \
-no-hpet \
-no-shutdown \
-boot strict=3Don \
-kernel /var/lib/libvirt/pink/kernel \
-append 'root=3D/dev/sda ro panic=3D300 systemd.show_status=3D1 systemd.uni=
t=3Dgraphical.target quiet' \
-device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 \
-device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.0,addr=3D0x5 \
-blockdev '{"driver":"host_device","filename":"/dev/nvmvg/rotest","node-nam=
e":"libvirt-2-storage","auto-read-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-2-format","read-only":true,"driver":"raw",=
"file":"libvirt-2-storage"}' \
-device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,device_id=3Dd=
rive-scsi0-0-0-0,share-rw=3Don,drive=3Dlibvirt-2-format,id=3Dscsi0-0-0-0,bo=
otindex=3D1 \
-blockdev '{"driver":"host_device","filename":"/dev/nvmvg/rotest-var","node=
-name":"libvirt-1-storage","cache":{"direct":true,"no-flush":false},"auto-r=
ead-only":true,"discard":"unmap"}' \
-blockdev '{"node-name":"libvirt-1-format","read-only":false,"cache":{"dire=
ct":true,"no-flush":false},"driver":"raw","file":"libvirt-1-storage"}' \
-device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D1,device_id=3Dd=
rive-scsi0-0-0-1,drive=3Dlibvirt-1-format,id=3Dscsi0-0-0-1,write-cache=3Don=
 \
-spice port=3D5900,addr=3D192.168.1.9,disable-ticketing,seamless-migration=
=3Don \
-device virtio-vga,id=3Dvideo0,max_outputs=3D1,bus=3Dpci.0,addr=3D0x2 \
-device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x7 \
-sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcec=
ontrol=3Ddeny \
-msg timestamp=3Don
2020-04-27T11:57:11.804028Z qemu-system-x86_64: -blockdev {"driver":"host_d=
evice","filename":"/dev/nvmvg/rotest","node-name":"libvirt-2-storage","auto=
-read-only":true,"discard":"unmap"}: The device is not writable: Permission=
 denied
2020-04-27 11:57:11.805+0000: shutting down, reason=3Dfailed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1875139

Title:
  Domain fails to start when 'readonly' device not writable

Status in QEMU:
  New

Bug description:
  This issue is introduced in QEMU 4.2.0 (4.1.0 is working fine)

  My root disk is a LVM2 volume thin snapshot that is marked as read-only
  But when I try to start the domain (using virt-manager) I get the followi=
ng error:

  Error starting domain: internal error: process exited while connecting
  to monitor: 2020-04-26T06:55:06.342700Z qemu-system-x86_64: -blockdev
  {"driver":"host_device","filename":"/dev/vg/vmroot-20200425","aio":"native
  ","node-name":"libvirt-3-storage","cache":{"direct":true,"no-
  flush":false},"auto-read-only":true,"discard":"unmap"} The device is
  not writable: Permission denied

  Changing the lvm snapshot to writeable allows me to start the domain.
  (Making it changes possible during domain is running)

  I don't think QEMU should fail when it can't open a (block) device when t=
he read-only option is set.
  (why is write access needed?)

  Reproduce steps:
  * Create LVM read-only volume (I don't think any data is needed)
  * Create domain with read-only volume as block device
  * Try to start the domain

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1875139/+subscriptions

