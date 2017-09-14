Received: from eggs.gnu.org ([2001:4830:134:3::10]:37930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlfightup@gmail.com>) id 1dsTZf-00050n-8w
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlfightup@gmail.com>) id 1dsTZc-000527-AX
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:48:55 -0400
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:37898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlfightup@gmail.com>) id 1dsTZc-000515-3o
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 08:48:52 -0400
Received: by mail-yw0-x244.google.com with SMTP id t127so1660504ywg.5
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 05:48:50 -0700 (PDT)
MIME-Version: 1.0
From: Paul Schlacter <wlfightup@gmail.com>
Date: Thu, 14 Sep 2017 20:48:49 +0800
Message-ID: <CADak6y79L+eUYg3LmO2MGTf5BKxHZ8rG5zHBJ9UKPhKHNxsFkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] host doesn't support requested feature:
 CPUID.01H:EDX.ds [bit 21] Does this warn affect virtual machine performance
 or use?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

this is my stackoverflow question:
https://stackoverflow.com/questions/46219552/host-doesnt-support-requested-=
feature-cpuid-01hedx-ds-bit-21-does-this-warn


I found a lot of warning from the VM qemu log, Does this warn affect
virtual machine performance or use? , is my libvirt.xml file problem? Or
support hot-plug will have these warnings

This is my libvirt xml configuration:

<domain type=3D'kvm' id=3D'315'>
  <name>instance-000005b2</name>
  <uuid>793fe065-36a6-4840-80cf-840ebed41d3e</uuid>
  <maxMemory slots=3D'32' unit=3D'KiB'>68719476736</maxMemory>
  <memory unit=3D'KiB'>2097152</memory>
  <currentMemory unit=3D'KiB'>2097152</currentMemory>
  <vcpu placement=3D'auto'>8</vcpu>
  <vcpus>
    <vcpu id=3D'0' enabled=3D'yes' hotpluggable=3D'no' order=3D'1'/>
    <vcpu id=3D'1' enabled=3D'yes' hotpluggable=3D'yes' order=3D'2'/>
    <vcpu id=3D'2' enabled=3D'yes' hotpluggable=3D'yes' order=3D'3'/>
    <vcpu id=3D'3' enabled=3D'yes' hotpluggable=3D'yes' order=3D'4'/>
    <vcpu id=3D'4' enabled=3D'yes' hotpluggable=3D'yes' order=3D'5'/>
    <vcpu id=3D'5' enabled=3D'yes' hotpluggable=3D'yes' order=3D'6'/>
    <vcpu id=3D'6' enabled=3D'yes' hotpluggable=3D'yes' order=3D'7'/>
    <vcpu id=3D'7' enabled=3D'yes' hotpluggable=3D'yes' order=3D'8'/>
  </vcpus>
  <cputune>
    <shares>2048</shares>
    <vcpupin vcpu=3D'0' cpuset=3D'0-9,20-29'/>
    <vcpupin vcpu=3D'1' cpuset=3D'0-9,20-29'/>
    <emulatorpin cpuset=3D'0-9,20-29'/>
  </cputune>
  <numatune>
    <memory mode=3D'strict' nodeset=3D'0'/>
    <memnode cellid=3D'0' mode=3D'strict' nodeset=3D'0'/>
  </numatune>
  <resource>
    <partition>/machine</partition>
  </resource>
  <os>
    <type arch=3D'x86_64' machine=3D'pc-i440fx-rhel7.3.0'>hvm</type>
    <boot dev=3D'hd'/>
  </os>
  <features>
    <acpi/>
    <apic/>
  </features>
  <cpu mode=3D'host-model'>
    <model fallback=3D'allow'/>
    <numa>
      <cell id=3D'0' cpus=3D'0-1' memory=3D'2097152' unit=3D'KiB'/>
    </numa>
  </cpu>
  <devices>
    <emulator>/usr/libexec/qemu-kvm</emulator>
    <controller type=3D'virtio-serial' index=3D'0'>
      <alias name=3D'virtio-serial0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04'
function=3D'0x0'/>
    </controller>
    <memballoon model=3D'virtio'>
      <alias name=3D'balloon0'/>
      <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x06'
function=3D'0x0'/>
    </memballoon>
  </devices>
</domain>




The following warn log=EF=BC=9A


2017-09-14T12:16:03.441702Z qemu-kvm: warning: CPU(s) not present in
any NUMA nodes: 2 3 4 5 6 7
2017-09-14T12:16:03.441773Z qemu-kvm: warning: All CPU(s) up to
maxcpus should be described in NUMA config
warning: host doesn't support requested feature: CPUID.01H:EDX.ds [bit 21]
warning: host doesn't support requested feature: CPUID.01H:EDX.acpi [bit 22=
]
warning: host doesn't support requested feature: CPUID.01H:EDX.ht [bit 28]
warning: host doesn't support requested feature: CPUID.01H:EDX.tm [bit 29]
warning: host doesn't support requested feature: CPUID.01H:EDX.pbe [bit 31]
warning: host doesn't support requested feature: CPUID.01H:ECX.dtes64 [bit =
2]
warning: host doesn't support requested feature: CPUID.01H:ECX.monitor [bit=
 3]
warning: host doesn't support requested feature: CPUID.01H:ECX.ds_cpl [bit =
4]
warning: host doesn't support requested feature: CPUID.01H:ECX.vmx [bit 5]
warning: host doesn't support requested feature: CPUID.01H:ECX.smx [bit 6]
warning: host doesn't support requested feature: CPUID.01H:ECX.est [bit 7]
warning: host doesn't support requested feature: CPUID.01H:ECX.tm2 [bit 8]
warning: host doesn't support requested feature: CPUID.01H:ECX.xtpr [bit 14=
]
warning: host doesn't support requested feature: CPUID.01H:ECX.pdcm [bit 15=
]
warning: host doesn't support requested feature: CPUID.01H:ECX.dca [bit 18]
warning: host doesn't support requested feature: CPUID.01H:ECX.osxsave [bit=
 27]
warning: host doesn't support requested feature: CPUID.01H:EDX.ds [bit 21]
warning: host doesn't support requested feature: CPUID.01H:EDX.acpi [bit 22=
]
warning: host doesn't support requested feature: CPUID.01H:EDX.ht [bit 28]
warning: host doesn't support requested feature: CPUID.01H:EDX.tm [bit 29]
warning: host doesn't support requested feature: CPUID.01H:EDX.pbe [bit 31]
warning: host doesn't support requested feature: CPUID.01H:ECX.dtes64 [bit =
2]
warning: host doesn't support requested feature: CPUID.01H:ECX.monitor [bit=
 3]
warning: host doesn't support requested feature: CPUID.01H:ECX.ds_cpl [bit =
4]
