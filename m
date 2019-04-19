Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6810C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 10:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D114217FA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 10:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D114217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54368 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHQfO-0006Iy-LP
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 06:22:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hHQdP-0004u1-Ua
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 06:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hHQdN-0003va-R8
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 06:20:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:44622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hHQdN-0003tL-Ha
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 06:20:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hHQdL-0005Ew-I4
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 10:20:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7287E2E80CB
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 10:20:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Apr 2019 10:14:08 -0000
From: =?utf-8?q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@canonical.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=libvirt; status=New; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: koalinux lersek
X-Launchpad-Bug-Reporter: =?utf-8?q?Jos=C3=A9_Pekkarinen_=28koalinux=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Jos=C3=A9_Pekkarinen_=28koalinux=29?=
References: <155156252741.17588.3363806743942119527.malonedeb@gac.canonical.com>
Message-Id:
 <155566884856.13521.11853993565719476166.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e4ed90519793c8f2bdf2783218e5f8b743510f3c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1818367] Re: Initialization of device
 cfi.pflash01 failed: Block node is read-only
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1818367 <1818367@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190419101408.s7G0GYyiM91pBFVPGt0eltqG4EfSX0azIkmEvW7N5VY@z>

oh well, it turns out to be actually related, it turns out
virt-aa-helper is skipping the code file of ovmf:

2019-04-19 10:06:43.576+0000: 9272: error : AppArmorGenSecurityLabel:469 : =
internal error: cannot load AppArmor profile 'libvirt-34c41008-ab91-483b-95=
9c-81a7a12ae9be'
2019-04-19 10:09:25.751+0000: 9270: error : virCommandWait:2636 : internal =
error: Child process (LIBVIRT_LOG_OUTPUTS=3D3:stderr /usr/libexec/virt-aa-h=
elper -c -u libvirt-34c41008-ab91-483b-959c-81a7a12ae9be) unexpected exit s=
tatus 1: 2019-04-19 10:09:25.750+0000: 13797: info : libvirt version: 5.2.0
2019-04-19 10:09:25.750+0000: 13797: info : hostname: mole
2019-04-19 10:09:25.750+0000: 13797: error : virStorageFileBackendFileRead:=
129 : Failed to open file '/dev/mole-vg0/os-1-vda': Permission denied
2019-04-19 10:09:25.750+0000: 13797: error : virStorageFileBackendFileRead:=
129 : Failed to open file '/dev/mole-vg0/os-1-vdb': Permission denied
virt-aa-helper: error: /usr/share/edk2-ovmf/OVMF_CODE.fd
virt-aa-helper: error: skipped restricted file
virt-aa-helper: error: invalid VM definition

The domain now looks like:

<domain type=3D'kvm'>                                                      =
                                                                           =
                                                                           =
                                        [40/100]
  <name>os-1</name>
  <uuid>34c41008-ab91-483b-959c-81a7a12ae9be</uuid>    =

  <memory unit=3D'KiB'>8388608</memory>
  <currentMemory unit=3D'KiB'>8388608</currentMemory>                      =
        =

  <memoryBacking>
    <hugepages/>             =

  </memoryBacking>                      =

  <vcpu placement=3D'static' cpuset=3D'10-11,34-35'>4</vcpu>
  <os>                       =

    <type arch=3D'x86_64' machine=3D'pc-i440fx-2.12'>hvm</type>            =
          =

    <loader readonly=3D'yes' type=3D'pflash'>/usr/share/edk2-ovmf/OVMF_CODE=
.fd</loader>
    <nvram>/var/lib/libvirt/qemu/nvram/os-1_VARS.fd</nvram>
    <boot dev=3D'network'/>               =

    <boot dev=3D'hd'/>           =

  </os>                      =

  <features>                                                               =
      =

    <acpi/>     =

    <apic/>            =

  </features>                            =

  <cpu mode=3D'host-passthrough' check=3D'partial'/>
  <clock offset=3D'utc'>
    <timer name=3D'rtc' tickpolicy=3D'catchup'/>
    <timer name=3D'pit' tickpolicy=3D'delay'/>
    <timer name=3D'hpet' present=3D'no'/> =

  </clock>    =

  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>      =

  <on_crash>destroy</on_crash>                    =

  <pm>                        =

    <suspend-to-mem enabled=3D'no'/>
    <suspend-to-disk enabled=3D'no'/>
  </pm>                                                          =

  <devices>                                                                =
      =

    <emulator>/usr/bin/qemu-system-x86_64</emulator>
    <disk type=3D'block' device=3D'disk'>
      <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native'/>    =
              =

      <source dev=3D'/dev/mole-vg0/os-1-vda'/>
      <target dev=3D'vda' bus=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06' fu=
nction=3D'0x0'/>
    </disk>
    <disk type=3D'block' device=3D'disk'>
      <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native'/>
      <source dev=3D'/dev/mole-vg0/os-1-vdb'/>
      <target dev=3D'vdb' bus=3D'virtio'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x07' fu=
nction=3D'0x0'/>
    </disk>
    <controller type=3D'usb' index=3D'0' model=3D'ich9-ehci1'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' fu=
nction=3D'0x7'/>
    </controller>
    <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci1'>
      <master startport=3D'0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' fu=
nction=3D'0x0' multifunction=3D'on'/>
    </controller>
    <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci2'>
      <master startport=3D'2'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' fu=
nction=3D'0x1'/>
    </controller>
    <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci3'>
      <master startport=3D'4'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' fu=
nction=3D'0x2'/>
    </controller>
    <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>
    <controller type=3D'ide' index=3D'0'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' fu=
nction=3D'0x1'/>
    </controller>
    <interface type=3D'bridge'>
      <mac address=3D'52:54:00:78:cb:97'/>
      <source bridge=3D'virbr0'/>
      <model type=3D'rtl8139'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04' fu=
nction=3D'0x0'/>
    </interface>
    <interface type=3D'bridge'>
      <mac address=3D'52:54:00:1c:4f:22'/>
      <source bridge=3D'virbr1'/>
      <model type=3D'rtl8139'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' fu=
nction=3D'0x0'/>
    </interface>
    <serial type=3D'pty'>
      <target type=3D'isa-serial' port=3D'0'>
        <model name=3D'isa-serial'/>
      </target>
    </serial>
    <console type=3D'pty'>
      <target type=3D'serial' port=3D'0'/>
    </console>
    <input type=3D'mouse' bus=3D'ps2'/>
    <input type=3D'keyboard' bus=3D'ps2'/>
    <graphics type=3D'vnc' port=3D'-1' autoport=3D'yes'>
      <listen type=3D'address'/>
    </graphics>
    <video>
      <model type=3D'cirrus' vram=3D'16384' heads=3D'1' primary=3D'yes'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' fu=
nction=3D'0x0'/>
    </video>
    <memballoon model=3D'virtio'>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x09' fu=
nction=3D'0x0'/>
    </memballoon>
  </devices>
</domain>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1818367

Title:
  Initialization of device cfi.pflash01 failed: Block node is read-only

Status in libvirt:
  New
Status in QEMU:
  Invalid

Bug description:
  Hi,

  I have several vms defined in libvirt using ovmf for uefi, since a later
  update of my server I'm unable to start any of the domains defined. This =
is
  an example of the output given:

  # virsh start os-1
  error: Failed to start domain os-1
  error: internal error: qemu unexpectedly closed the monitor: 2019-03-02T2=
1:23:51.726446Z qemu-system-x86_64: Initialization of device cfi.pflash01 f=
ailed: Block node is read-only

  an example of domain is like this:

  <domain type=3D'kvm'>                                                    =
                                                                           =
                                                                           =
                                                  =

    <name>os-1</name>                                                      =
                                                                           =
                                                                           =
                                                =

    <uuid>34c41008-ab91-483b-959c-81a7a12ae9be</uuid>                      =
                                                                           =
                                                                           =
                                                =

    <memory unit=3D'KiB'>8388608</memory>                                  =
                                                                           =
                                                                           =
                                                  =

    <currentMemory unit=3D'KiB'>8388608</currentMemory>                    =
                                                                           =
                                                                           =
                                                  =

    <memoryBacking>                                                        =
                                                                           =
                                                                           =
                                                =

      <hugepages/>                                                         =
                                                                           =
                                                                           =
                                                =

    </memoryBacking>                                                       =
                                                                           =
                                                                           =
                                                =

    <vcpu placement=3D'static' cpuset=3D'10-11,34-35'>4</vcpu>             =
                                                                           =
                                                                           =
                                                    =

    <os>                                                                   =
                                                                           =
                                                                           =
                                                =

      <type arch=3D'x86_64' machine=3D'pc-i440fx-2.12'>hvm</type>          =
                                                                           =
                                                                           =
                                                    =

      <loader type=3D'pflash'>/var/lib/libvirt/qemu/nvram/os-1-ovmf.fd</loa=
der>                                                                       =
                                                                           =
                                                  =

      <boot dev=3D'network'/>                                              =
                                                                           =
                                                                           =
                                                  =

      <boot dev=3D'hd'/>                                                   =
                                                                           =
                                                                           =
                                                  =

    </os>                                                                  =
                                                                           =
                                                                           =
                                                =

    <features>                                                             =
                                                                           =
                                                                           =
                                                =

      <acpi/>                                                              =
                                                                           =
                                                                           =
                                                =

      <apic/>                                                              =
                                                                           =
                                                                           =
                                                =

    </features>                                                            =
                                                                           =
                                                                           =
                                                =

    <cpu mode=3D'host-passthrough' check=3D'partial'/>                     =
                                                                           =
                                                                           =
                                                    =

    <clock offset=3D'utc'>                                                 =
                                                                           =
                                                                           =
                                                  =

      <timer name=3D'rtc' tickpolicy=3D'catchup'/>                         =
                                                                           =
                                                                           =
                                                    =

      <timer name=3D'pit' tickpolicy=3D'delay'/>                           =
                                                                           =
                                                                           =
                                                    =

      <timer name=3D'hpet' present=3D'no'/>                                =
                                                                           =
                                                                           =
                                                    =

    </clock>                                                               =
                                                                           =
                                                                           =
                                                =

    <on_poweroff>destroy</on_poweroff>                                     =
                                                                           =
                                                                           =
                                                =

    <on_reboot>restart</on_reboot>                                         =
                                                                           =
                                                                           =
                                                =

    <on_crash>destroy</on_crash>                                           =
                                                                           =
                                                                           =
                                                =

    <pm>                                                                   =
                                                                           =
                                                                           =
                                                =

      <suspend-to-mem enabled=3D'no'/>                                     =
                                                                           =
                                                                           =
                                                  =

      <suspend-to-disk enabled=3D'no'/>                                    =
                                                                           =
                                                                           =
                                                  =

    </pm>                                                                  =
                                                                           =
                                                                           =
                                                =

    <devices>                                                              =
                                                                           =
                                                                           =
                                                =

      <emulator>/usr/bin/qemu-system-x86_64</emulator>                     =
                                                                           =
                                                                           =
                                                =

      <disk type=3D'block' device=3D'disk'>                                =
                                                                           =
                                                                           =
                                                    =

        <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native'/>  =
                                                                           =
                                                                           =
                                                        =

        <source dev=3D'/dev/vg0/os-1-vda'/>                                =
                                                                           =
                                                                           =
                                             =

        <target dev=3D'vda' bus=3D'virtio'/>                               =
                                                                           =
                                                                           =
                                                    =

        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06' =
function=3D'0x0'/>                                                         =
                                                                           =
                                                          =

      </disk>                                                              =
                                                                           =
                                                                           =
                                                =

      <disk type=3D'block' device=3D'disk'>
        <driver name=3D'qemu' type=3D'raw' cache=3D'none' io=3D'native'/>
        <source dev=3D'/dev/vg0/os-1-vdb'/>
        <target dev=3D'vdb' bus=3D'virtio'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x07' =
function=3D'0x0'/>
      </disk>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-ehci1'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x7'/>
      </controller>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci1'>
        <master startport=3D'0'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x0' multifunction=3D'on'/>
      </controller>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci2'>
        <master startport=3D'2'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x1'/>
      </controller>
      <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci3'>
        <master startport=3D'4'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x05' =
function=3D'0x2'/>
      </controller>
      <controller type=3D'pci' index=3D'0' model=3D'pci-root'/>
      <controller type=3D'ide' index=3D'0'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01' =
function=3D'0x1'/>
      </controller>
      <interface type=3D'bridge'>
        <mac address=3D'52:54:00:78:cb:97'/>
        <source bridge=3D'virbr0'/>
        <model type=3D'rtl8139'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04' =
function=3D'0x0'/>
      </interface>
      <interface type=3D'bridge'>
        <mac address=3D'52:54:00:1c:4f:22'/>
        <source bridge=3D'virbr1'/>
        <model type=3D'rtl8139'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03' =
function=3D'0x0'/>
      </interface>
      <serial type=3D'pty'>
        <target type=3D'isa-serial' port=3D'0'>
          <model name=3D'isa-serial'/>
        </target>
      </serial>
      <console type=3D'pty'>
        <target type=3D'serial' port=3D'0'/>
      </console>
      <input type=3D'mouse' bus=3D'ps2'/>
      <input type=3D'keyboard' bus=3D'ps2'/>
      <graphics type=3D'vnc' port=3D'-1' autoport=3D'yes'>
        <listen type=3D'address'/>
      </graphics>
      <video>
        <model type=3D'cirrus' vram=3D'16384' heads=3D'1' primary=3D'yes'/>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02' =
function=3D'0x0'/>
      </video>
      <memballoon model=3D'virtio'>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x09' =
function=3D'0x0'/>
      </memballoon>
    </devices>
  </domain>

  where /var/lib/libvirt/qemu/nvram/os-1-ovmf.fd is a copy of
  /usr/share/edk2-ovmf/OVMF_VARS.fd. An the extract from my
  /etc/libvirt/qemu.conf to define ovmf:

  ...
  # Location of master nvram file                                          =
                                                                           =
                                                                           =
                                                =

  #                                                                        =
                                                                           =
                                                                           =
                                                =

  # When a domain is configured to use UEFI instead of standard            =
                                                                           =
                                                                           =
                                                =

  # BIOS it may use a separate storage for UEFI variables. If              =
                                                                           =
                                                                           =
                                                =

  # that's the case libvirt creates the variable store per domain          =
                                                                           =
                                                                           =
                                                =

  # using this master file as image. Each UEFI firmware can,               =
                                                                           =
                                                                           =
                                                =

  # however, have different variables store. Therefore the nvram is        =
                                                                           =
                                                                           =
                                                =

  # a list of strings when a single item is in form of:                    =
                                                                           =
                                                                           =
                                                =

  #   ${PATH_TO_UEFI_FW}:${PATH_TO_UEFI_VARS}.                             =
                                                                           =
                                                                           =
                                                =

  # Later, when libvirt creates per domain variable store, this list is    =
                                                                           =
                                                                           =
                                                =

  # searched for the master image. The UEFI firmware can be called         =
                                                                           =
                                                                           =
                                                =

  # differently for different guest architectures. For instance, it's OVMF =
                                                                           =
                                                                           =
                                                =

  # for x86_64 and i686, but it's AAVMF for aarch64. The libvirt default   =
                                                                           =
                                                                           =
                                                =

  # follows this scheme.                                                   =
                                                                           =
                                                                           =
                                                =

  nvram =3D [                                                              =
                                                                           =
                                                                           =
                                                  =

     "/usr/share/edk2-ovmf/OVMF_CODE.fd:/usr/share/edk2-ovmf/OVMF_VARS.fd",=
                                                                           =
                                                                           =
                                                =

  ]
  ...

  This setup used to work one month ago, now it's setup with:

  QEMU emulator version 3.1.0
  libvirt-5.0.0
  linux-4.19.20

  Any help appreciated.

  Best regards.

  Jos=C3=A9

To manage notifications about this bug go to:
https://bugs.launchpad.net/libvirt/+bug/1818367/+subscriptions

