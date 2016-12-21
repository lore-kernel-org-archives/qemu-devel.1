Received: from eggs.gnu.org ([2001:4830:134:3::10]:36982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <holger@fam-schranz.de>) id 1cJfRm-0000J3-4j
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:52:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <holger@fam-schranz.de>) id 1cJfRX-00059l-Jy
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:52:38 -0500
Received: from smtp3.goneo.de ([85.220.129.37]:47962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <holger@fam-schranz.de>)
	id 1cJfRW-00059E-SI
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 06:52:23 -0500
References: <c532ac07-fd54-eedb-b3f0-548aeacf0a04@fam-schranz.de>
	<3dce9a63-6472-54c2-3455-52521a0a3651@redhat.com>
	<89d9fe09-3bdc-3c84-3ddf-f9462adb2068@fam-schranz.de>
	<20161220234738.GB2994@lemon>
	<3512163a-f8c7-f4b7-7bd1-89675c74a1ac@fam-schranz.de>
From: Holger Schranz <holger@fam-schranz.de>
Message-ID: <274b8510-26a0-ce0d-4690-f9680ab59fba@fam-schranz.de>
Date: Wed, 21 Dec 2016 12:51:51 +0100
MIME-Version: 1.0
In-Reply-To: <3512163a-f8c7-f4b7-7bd1-89675c74a1ac@fam-schranz.de>
Content-Type: multipart/mixed; boundary="------------D6A36D918608DB4351EDF485"
Subject: Re: [Qemu-devel] Strange/wrong behavior with iSCSI Tape devices in
 QEMU 2.8.0-rc4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: mueller-ralf@t-online.de, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org

This is a multi-part message in MIME format.
--------------D6A36D918608DB4351EDF485
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Fam, John,

meanwhile i have installed the 2.8.0 from the official wiki.qemu.org
(tarball says rc4 ??).

About dmesg, I have attached the dmesg from both version. In a short
view ... in 2.6.2 you see the target stx/sgx and the controller for
it. In the 2.8.0. nothing to see ... not controller nor devices.

"git bisect" isn't fit to me :(. I never use it.

The request for testing with iscsiadm host side to pass it to QEMU
I haven't done related to the fact a can't see the controller for the
iscsi devices in the VM guest. Should I do this in any cases?

Best regards

Holger

Am 21.12.2016 um 05:44 schrieb Holger Schranz:
> Hi Fam,
>
> meanwhile I have sent the requested QEMU CLI direct to John. Your reque=
st
> I will try after the reinstall with the released version.So please wait
> for a while.
>
> Best regards
>
> Holger
>
> Am 21.12.2016 um 00:47 schrieb Fam Zheng:
>> On Tue, 12/20 17:53, Holger Schranz wrote:
>>> Hi John,
>>>
>>> sorry or late. I will reproduce it and send you the QEMU command line
>>> instruction.
>>>
>>> About the guest system: LINUX SuSE SLES11 SP4.
>>>
>>> About 2.7.0 Release: it doesn't run without the patches for the issue=
:
>>> [Qemu-devel] [PATCH] iscsi: Fix divide-by-zero regression on raw SG=20
>>> devices
>>>
>>> (I can't find the issue number).
>> Are there any related message showing up in guest dmesg?
>>
>> Is it possible to do a git bisect?
>>
>> Also, does it work if you login with host side iscsi client=20
>> (iscsiadm) and pass
>> the /dev/sgX to QEMU?
>>
>> Fam
>>
>>> Best regards
>>>
>>> Holger
>>>
>>> Am 19.12.2016 um 18:30 schrieb John Snow:
>>>> On 12/19/2016 04:05 AM, Holger Schranz wrote:
>>>>> # Strange/wrong behavior in QEMU 2.8.0-rc4
>>>>>
>>>>> After update from QEMU 2.6.2 to 2.8.0-rc4 the tape devices
>>>>> and the corresponding medium changer are no longer available
>>>>> in the VM quest system.
>>>>>
>>>>> The tape devices and the media changer are declared in the
>>>>> xml-file for libvirt. Both, tape drives and medium changer
>>>>> are avalilable via iSCSI.
>>>>>
>>>>> In a first rough investigation the login in iSCSI runs well
>>>>> but in QEMU, it seems the devices doesn't reported to the VM-Quest.
>>>>>
>>>>> ------------------
>>>>>
>>>>> Best regards
>>>>>
>>>>> Holger
>>>>>
>>>> Hi, thanks for the report; do you have a QEMU command line that we c=
an
>>>> use to help reproduce the problem? It's easiest if we can cut libvir=
t
>>>> out of the loop.
>>>>
>>>> What is the architecture and version of the guest?
>>>>
>>>> Lastly, it looks like this worked in our 2.7 release if I'm reading=20
>>>> you
>>>> correctly, so this is a change for the 2.8 release as far as you can
>>>> tell, right?
>>>>
>>>> --js
>>>>
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>
>>>>> XML-Declration:
>>>>>
>>>>> .
>>>>> .
>>>>> .
>>>>>
>>>>> <!-- SCSI 2 -->
>>>>>       <controller type=3D'scsi' model=3D'virtio-scsi' index=3D'1'>
>>>>>         <alias name=3D'scsi1'/>
>>>>>       </controller>
>>>>>
>>>>> <!-- 2 x LTO5 -->
>>>>>       <hostdev mode=3D'subsystem' type=3D'scsi' managed=3D'no' rawi=
o=3D'yes'>
>>>>>         <source protocol=3D'iscsi'
>>>>> name=3D'iqn.2008-09.net.fsc:server.LT260_61003/4'>
>>>>>         <host name=3D'etcsvms2.abg.fsc.net' port=3D'3260'/>
>>>>>         </source>
>>>>>         <address type=3D'drive' controller=3D'1' bus=3D'0' target=3D=
'2'=20
>>>>> unit=3D'1'/>
>>>>>       </hostdev>
>>>>>
>>>>>       <hostdev mode=3D'subsystem' type=3D'scsi' managed=3D'no' rawi=
o=3D'yes'>
>>>>>         <source protocol=3D'iscsi'
>>>>> name=3D'iqn.2008-09.net.fsc:server.LT260_61003/5'>
>>>>>         <host name=3D'etcsvms2.abg.fsc.net' port=3D'3260'/>
>>>>>         </source>
>>>>>         <address type=3D'drive' controller=3D'1' bus=3D'0' target=3D=
'2'=20
>>>>> unit=3D'2'/>
>>>>>       </hostdev>
>>>>>
>>>>> <!-- Virtual media changer Fujitsu LT260 -->
>>>>>       <hostdev mode=3D'subsystem' type=3D'scsi' managed=3D'no' rawi=
o=3D'yes'>
>>>>>         <source protocol=3D'iscsi'
>>>>> name=3D'iqn.2008-09.net.fsc:server.LT260_61003/6'>
>>>>>         <host name=3D'etcsvms2.abg.fsc.net' port=3D'3260'/>
>>>>>         </source>
>>>>>         <address type=3D'drive' controller=3D'1' bus=3D'0' target=3D=
'2'=20
>>>>> unit=3D'3'/>
>>>>>       </hostdev>
>>>>>
>>>>> <!-- 2 x LTO6 (via PLP(LAN-attached library)) -->
>>>>>       <hostdev mode=3D'subsystem' type=3D'scsi' managed=3D'no' rawi=
o=3D'yes'>
>>>>>         <source protocol=3D'iscsi'
>>>>> name=3D'iqn.2008-09.net.fsc:server.LT60_61005/3'>
>>>>>         <host name=3D'etcsvms2.abg.fsc.net' port=3D'3260'/>
>>>>>         </source>
>>>>>         <address type=3D'drive' controller=3D'1' bus=3D'0' target=3D=
'2'=20
>>>>> unit=3D'4'/>
>>>>>       </hostdev>
>>>>>
>>>>>       <hostdev mode=3D'subsystem' type=3D'scsi' managed=3D'no' rawi=
o=3D'yes'>
>>>>>         <source protocol=3D'iscsi'
>>>>> name=3D'iqn.2008-09.net.fsc:server.LT60_61005/4'>
>>>>>         <host name=3D'etcsvms2.abg.fsc.net' port=3D'3260'/>
>>>>>         </source>
>>>>>         <address type=3D'drive' controller=3D'1' bus=3D'0' target=3D=
'2'=20
>>>>> unit=3D'5'/>
>>>>>       </hostdev>
>>>>> .
>>>>> .
>>>>> .
>>>>>
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=20
>>>>>
>>>>>
>>>>>
>>>>> correct behavior/Result inside the VM-Quest together with QEMU/KVM=20
>>>>> 2.6.2
>>>>> / 2.7.0
>>>>> --=20
>>>>> (VCSTCS82:A)IUP1:~ # lsscsi -g
>>>>> [0:2:0:0]    disk    FTS      PRAID EP420i     4.25 /dev/sda /dev/s=
g0
>>>>> [3:0:0:0]    cd/dvd  QEMU     QEMU DVD-ROM     2.5+ /dev/sr0 /dev/s=
g1
>>>>> [8:0:2:1]    tape    HP       Ultrium 5-SCSI   0001 /dev/st3 /dev/s=
g6
>>>>> [8:0:2:2]    tape    HP       Ultrium 5-SCSI   0001 /dev/st2 /dev/s=
g5
>>>>> [8:0:2:3]    mediumx FUJITSU  ETERNUS LT260    6.20  - /dev/sg4
>>>>> [8:0:2:4]    tape    HP       Ultrium 6-SCSI   23AB /dev/st1 /dev/s=
g3
>>>>> [8:0:2:5]    tape    HP       Ultrium 6-SCSI   23AB /dev/st0 /dev/s=
g2
>>>>> [11:0:0:0]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdb /dev/s=
g7
>>>>> [11:0:0:2]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdh=20
>>>>> /dev/sg13
>>>>> [11:0:0:3]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdg=20
>>>>> /dev/sg12
>>>>> [11:0:0:4]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdf=20
>>>>> /dev/sg11
>>>>> [11:0:0:5]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sde=20
>>>>> /dev/sg10
>>>>> [11:0:0:6]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdd /dev/s=
g9
>>>>> [11:0:0:7]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdc /dev/s=
g8
>>>>> [11:0:0:15]  disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdi=20
>>>>> /dev/sg14
>>>>> (VCSTCS82:A)IUP1:~ #
>>>>>
>>>>>
>>>>>
>>>>> Wrong behavior/Result inside the VM-Quest together with QEMU/KVM=20
>>>>> 2.8.0-RC4
>>>>> --=20
>>>>> (VCSTCS82:A)IUP1:~ # lsscsi -g
>>>>> [0:2:0:0]    disk    FTS      PRAID EP420i     4.25 /dev/sda /dev/s=
g0
>>>>> [3:0:0:0]    cd/dvd  QEMU     QEMU DVD-ROM     2.5+ /dev/sr0 /dev/s=
g1
>>>>> [11:0:1:0]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdj=20
>>>>> /dev/sg10
>>>>> [11:0:1:2]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdp=20
>>>>> /dev/sg16
>>>>> [11:0:1:3]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdo=20
>>>>> /dev/sg15
>>>>> [11:0:1:4]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdn=20
>>>>> /dev/sg14
>>>>> [11:0:1:5]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdm=20
>>>>> /dev/sg13
>>>>> [11:0:1:6]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdl=20
>>>>> /dev/sg12
>>>>> [11:0:1:7]   disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdk=20
>>>>> /dev/sg11
>>>>> [11:0:1:15]  disk    FUJITSU  ETERNUS_DXL      0000 /dev/sdq=20
>>>>> /dev/sg17
>>>>> (VCSTCS82:A)IUP1:~ #
>>>>>
>>>
>>> ---
>>> Diese E-Mail wurde von Avast Antivirus-Software auf Viren gepr=FCft.
>>> https://www.avast.com/antivirus
>>>
>>>
>
>
> ---
> Diese E-Mail wurde von Avast Antivirus-Software auf Viren gepr=FCft.
> https://www.avast.com/antivirus
>
>



---
Diese E-Mail wurde von Avast Antivirus-Software auf Viren gepr=FCft.
https://www.avast.com/antivirus

--------------D6A36D918608DB4351EDF485
Content-Type: text/plain; charset=UTF-8;
 name="dmesg-2.6.2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg-2.6.2.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.0.101-80-default (geeko@buildhost) (gcc version 4.3.4 [gcc-4_3-branch revision 152973] (SUSE Linux) ) #1 SMP Fri Jul 15 14:30:41 UTC 2016 (eb2ba81)
[    0.000000] Command line: root=/dev/disk/by-id/scsi-0FTS_PRAID_EP420i_SDA-part7 instmode=cd resume=/dev/disk/by-id/scsi-0FTS_PRAID_EP420i_SDA-part5 splash=silent nmi_watchdog=0 audit=1 vga=0x318 crashkernel=128M@64M tsc=reliable elevator=noop
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007ffdf000 (usable)
[    0.000000]  BIOS-e820: 000000007ffdf000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000b0000000 - 00000000c0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000feffc000 - 00000000ff000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000380000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.8 present.
[    0.000000] DMI: FUJITSU PRIMERGY RX300 S8/D2939-B1, BIOS V4.6.5.4 R1.14.0 for D2939-B1x 10/13/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x380000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00C0000000 mask FFC0000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT not supported by CPU.
[    0.000000] last_pfn = 0x7ffdf max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [ffff8800000f6af0] f6af0
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff88000009a000] 9a000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-000000007ffdf000
[    0.000000]  0000000000 - 007fe00000 page 2M
[    0.000000]  007fe00000 - 007ffdf000 page 4k
[    0.000000] kernel direct mapping tables up to 0x7ffdefff @ [mem 0x1fffc000-0x1fffffff]
[    0.000000] init_memory_mapping: 0000000100000000-0000000380000000
[    0.000000]  0100000000 - 0380000000 page 2M
[    0.000000] kernel direct mapping tables up to 0x37fffffff @ [mem 0x7ffd4000-0x7ffdefff]
[    0.000000] nmi ring buffer: 262144
[    0.000000] RAMDISK: 37a3d000 - 37ff0000
[    0.000000] Reserving 128MB of memory at 64MB for crashkernel (System RAM: 14336MB)
[    0.000000] ACPI: RSDP 00000000000f6aa0 00014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 000000007ffe1f09 00034 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACP 000000007ffe1da1 00074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 000000007ffdfc00 021A1 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACS 000000007ffdfbc0 00040
[    0.000000] ACPI: APIC 000000007ffe1e15 00080 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.000000] ACPI: HPET 000000007ffe1e95 00038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.000000] ACPI: MCFG 000000007ffe1ecd 0003C (v01 BOCHS  BXPCMCFG 00000001 BXPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000380000000
[    0.000000] Initmem setup node 0 0000000000000000-0000000380000000
[    0.000000]   NODE_DATA [000000037ff99000 - 000000037ffbffff]
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 0:1bef801, boot clock
[    0.000000]  [ffffea0000000000-ffffea000c3fffff] PMD -> [ffff880373600000-ffff88037ddfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00380000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0007ffdf
[    0.000000]     0: 0x00100000 -> 0x00380000
[    0.000000] On node 0 totalpages: 3145582
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3922 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 505879 pages, LIFO batch:31
[    0.000000]   Normal zone: 35840 pages used for memmap
[    0.000000]   Normal zone: 2585600 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
[    0.000000] PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 000000007ffdf000 - 0000000080000000
[    0.000000] PM: Registered nosave memory: 0000000080000000 - 00000000b0000000
[    0.000000] PM: Registered nosave memory: 00000000b0000000 - 00000000c0000000
[    0.000000] PM: Registered nosave memory: 00000000c0000000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000feffc000
[    0.000000] PM: Registered nosave memory: 00000000feffc000 - 00000000ff000000
[    0.000000] PM: Registered nosave memory: 00000000ff000000 - 00000000fffc0000
[    0.000000] PM: Registered nosave memory: 00000000fffc0000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at c0000000 (gap: c0000000:3ed1c000)
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] setup_percpu: NR_CPUS:4096 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] PERCPU: Embedded 25 pages/cpu @ffff88037fc00000 s71680 r8192 d22528 u1048576
[    0.000000] pcpu-alloc: s71680 r8192 d22528 u1048576 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 
[    0.000000] kvm-clock: cpu 0, msr 3:7fc10801, primary cpu clock
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 3095401
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=/dev/disk/by-id/scsi-0FTS_PRAID_EP420i_SDA-part7 instmode=cd resume=/dev/disk/by-id/scsi-0FTS_PRAID_EP420i_SDA-part5 splash=silent nmi_watchdog=0 audit=1 vga=0x318 crashkernel=128M@64M tsc=reliable elevator=noop
[    0.000000] bootsplash: silent mode.
[    0.000000] audit: enabled (after initialization)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Memory: 12190096k/14680064k available (4566k kernel code, 2097736k absent, 392232k reserved, 7581k data, 1360k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:262400 nr_irqs:512 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 100663296 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Detected 2593.990 MHz processor.
[    0.008000] Calibrating delay loop (skipped) preset value.. 5187.98 BogoMIPS (lpj=10375960)
[    0.008000] pid_max: default: 32768 minimum: 301
[    0.008000] kdb version 4.4 by Keith Owens, Scott Lurndal. Copyright SGI, All Rights Reserved
[    0.008000] Security Framework initialized
[    0.008000] AppArmor: AppArmor initialized
[    0.008000] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.008465] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.009761] Mount-cache hash table entries: 256
[    0.009837] Initializing cgroup subsys cpuacct
[    0.009839] Initializing cgroup subsys memory
[    0.009847] Initializing cgroup subsys devices
[    0.009849] Initializing cgroup subsys freezer
[    0.009850] Initializing cgroup subsys net_cls
[    0.009852] Initializing cgroup subsys blkio
[    0.009855] Initializing cgroup subsys perf_event
[    0.009914] mce: CPU supports 10 MCE banks
[    0.011421] ACPI: Core revision 20110413
[    0.012406] Enabling x2apic
[    0.012412] Enabled x2apic
[    0.012576] Switched APIC routing to physical x2apic.
[    0.013319] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.013321] CPU0: Intel QEMU Virtual CPU version 2.5+ stepping 03
[    0.016000] Performance Events: Broken PMU hardware detected, using software events only.
[    0.016000] Failed to access perfctr msr (MSR c1 is 0)
[    0.016000] Booting Node   0, Processors  #1 Ok.
[    0.024008] kvm-clock: cpu 1, msr 3:7fd10801, secondary cpu clock
[    0.024016] Brought up 2 CPUs
[    0.024019] Total of 2 processors activated (10375.96 BogoMIPS).
[    0.024014] KVM setup async PF for cpu 1
[    0.024298] devtmpfs: initialized
[    0.029725] print_constraints: dummy: 
[    0.029725] Time: 11:10:12  Date: 12/21/16
[    0.029725] NET: Registered protocol family 16
[    0.029725] ACPI: bus type pci registered
[    0.029725] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xb0000000-0xbfffffff] (base 0xb0000000)
[    0.029725] PCI: MMCONFIG at [mem 0xb0000000-0xbfffffff] reserved in E820
[    0.029870] PCI: Using configuration type 1 for base access
[    0.032099] bio: create slab <bio-0> at 0
[    0.032508] ACPI: EC: Look up EC in DSDT
[    0.034762] ACPI: Interpreter enabled
[    0.034766] ACPI: (supports S0 S3 S4 S5)
[    0.034779] ACPI: Using IOAPIC for interrupt routing
[    0.037021] ACPI: No dock devices found.
[    0.037025] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.037082] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.037112] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    0.037114] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    0.037116] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.037118] pci_root PNP0A08:00: host bridge window [mem 0xc0000000-0xfebfffff]
[    0.037148] pci 0000:00:00.0: [8086:29c0] type 0 class 0x000600
[    0.037354] pci 0000:00:01.0: [8086:3420] type 1 class 0x000604
[    0.044292] pci 0000:00:02.0: [8086:3420] type 1 class 0x000604
[    0.053551] pci 0000:00:03.0: [8086:3420] type 1 class 0x000604
[    0.062069] pci 0000:00:04.0: [8086:100f] type 0 class 0x000200
[    0.064026] pci 0000:00:04.0: reg 10: [mem 0xfe980000-0xfe99ffff]
[    0.068029] pci 0000:00:04.0: reg 14: [io  0xb100-0xb13f]
[    0.094132] pci 0000:00:04.0: reg 30: [mem 0xfe800000-0xfe83ffff pref]
[    0.096084] pci 0000:00:05.0: [8086:3420] type 1 class 0x000604
[    0.106446] pci 0000:00:06.0: [1000:0079] type 0 class 0x000104
[    0.108026] pci 0000:00:06.0: reg 10: [io  0xb000-0xb0ff]
[    0.116050] pci 0000:00:06.0: reg 14: [mem 0xfea30000-0xfea33fff 64bit]
[    0.123417] pci 0000:00:06.0: reg 1c: [mem 0xfe840000-0xfe87ffff 64bit]
[    0.140312] pci 0000:00:0b.0: [1af4:1050] type 0 class 0x000300
[    0.144030] pci 0000:00:0b.0: reg 10: [mem 0xfa800000-0xfaffffff pref]
[    0.157862] pci 0000:00:0b.0: reg 18: [mem 0xfb000000-0xfb7fffff 64bit pref]
[    0.164034] pci 0000:00:0b.0: reg 20: [mem 0xfea34000-0xfea34fff]
[    0.176037] pci 0000:00:0b.0: reg 30: [mem 0xfea20000-0xfea2ffff pref]
[    0.180358] pci 0000:00:10.0: [8086:100f] type 0 class 0x000200
[    0.185686] pci 0000:00:10.0: reg 10: [mem 0xfe9a0000-0xfe9bffff]
[    0.188031] pci 0000:00:10.0: reg 14: [io  0xb140-0xb17f]
[    0.212037] pci 0000:00:10.0: reg 30: [mem 0xfe880000-0xfe8bffff pref]
[    0.214177] pci 0000:00:11.0: [8086:100f] type 0 class 0x000200
[    0.216034] pci 0000:00:11.0: reg 10: [mem 0xfe9c0000-0xfe9dffff]
[    0.221781] pci 0000:00:11.0: reg 14: [io  0xb180-0xb1bf]
[    0.246338] pci 0000:00:11.0: reg 30: [mem 0xfe8c0000-0xfe8fffff pref]
[    0.252580] pci 0000:00:12.0: [8086:100f] type 0 class 0x000200
[    0.256048] pci 0000:00:12.0: reg 10: [mem 0xfe9e0000-0xfe9fffff]
[    0.265462] pci 0000:00:12.0: reg 14: [io  0xb1c0-0xb1ff]
[    0.289423] pci 0000:00:12.0: reg 30: [mem 0xfe900000-0xfe93ffff pref]
[    0.292084] pci 0000:00:13.0: [8086:100f] type 0 class 0x000200
[    0.294136] pci 0000:00:13.0: reg 10: [mem 0xfea00000-0xfea1ffff]
[    0.297957] pci 0000:00:13.0: reg 14: [io  0xb200-0xb23f]
[    0.322076] pci 0000:00:13.0: reg 30: [mem 0xfe940000-0xfe97ffff pref]
[    0.324137] pci 0000:00:1e.0: [8086:244e] type 1 class 0x000604
[    0.332157] pci 0000:00:1f.0: [8086:2918] type 0 class 0x000601
[    0.332442] pci 0000:00:1f.2: [8086:2922] type 0 class 0x000106
[    0.354133] pci 0000:00:1f.2: reg 20: [io  0xb280-0xb29f]
[    0.358005] pci 0000:00:1f.2: reg 24: [mem 0xfea35000-0xfea35fff]
[    0.365807] pci 0000:00:1f.3: [8086:2930] type 0 class 0x000c05
[    0.376043] pci 0000:00:1f.3: reg 20: [io  0x0700-0x073f]
[    0.384176] pci 0000:01:00.0: [1af4:1004] type 0 class 0x000100
[    0.386060] pci 0000:01:00.0: reg 10: [io  0xa000-0xa03f]
[    0.391544] pci 0000:01:00.0: reg 14: [mem 0xfe600000-0xfe600fff]
[    0.416186] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.416213] pci 0000:00:01.0:   bridge window [io  0xa000-0xafff]
[    0.416223] pci 0000:00:01.0:   bridge window [mem 0xfe600000-0xfe7fffff]
[    0.416241] pci 0000:00:01.0:   bridge window [mem 0xfca00000-0xfcbfffff 64bit pref]
[    0.419044] pci 0000:02:00.0: [1000:0012] type 0 class 0x000100
[    0.420052] pci 0000:02:00.0: reg 10: [io  0x9000-0x90ff]
[    0.430007] pci 0000:02:00.0: reg 14: [mem 0xfe402000-0xfe4023ff]
[    0.436053] pci 0000:02:00.0: reg 18: [mem 0xfe400000-0xfe401fff]
[    0.468093] pci 0000:00:02.0: PCI bridge to [bus 02-02]
[    0.468107] pci 0000:00:02.0:   bridge window [io  0x9000-0x9fff]
[    0.468116] pci 0000:00:02.0:   bridge window [mem 0xfe400000-0xfe5fffff]
[    0.468133] pci 0000:00:02.0:   bridge window [mem 0xfc800000-0xfc9fffff 64bit pref]
[    0.472178] pci 0000:03:00.0: [1af4:1003] type 0 class 0x000780
[    0.474328] pci 0000:03:00.0: reg 10: [io  0x8000-0x801f]
[    0.477960] pci 0000:03:00.0: reg 14: [mem 0xfe200000-0xfe200fff]
[    0.504169] pci 0000:00:03.0: PCI bridge to [bus 03-03]
[    0.504183] pci 0000:00:03.0:   bridge window [io  0x8000-0x8fff]
[    0.504192] pci 0000:00:03.0:   bridge window [mem 0xfe200000-0xfe3fffff]
[    0.504209] pci 0000:00:03.0:   bridge window [mem 0xfc600000-0xfc7fffff 64bit pref]
[    0.506344] pci 0000:04:00.0: [1af4:1002] type 0 class 0x0000ff
[    0.508033] pci 0000:04:00.0: reg 10: [io  0x7000-0x701f]
[    0.523862] pci 0000:00:05.0: PCI bridge to [bus 04-04]
[    0.523878] pci 0000:00:05.0:   bridge window [io  0x7000-0x7fff]
[    0.523889] pci 0000:00:05.0:   bridge window [mem 0xfe000000-0xfe1fffff]
[    0.523908] pci 0000:00:05.0:   bridge window [mem 0xfc400000-0xfc5fffff 64bit pref]
[    0.528182] pci 0000:05:00.0: [1b36:0001] type 1 class 0x000604
[    0.530682] pci 0000:05:00.0: reg 10: [mem 0xfde00000-0xfde000ff 64bit]
[    0.537733] pci 0000:05:01.0: [1b36:0001] type 1 class 0x000604
[    0.540075] pci 0000:05:01.0: reg 10: [mem 0xfde01000-0xfde010ff 64bit]
[    0.548319] pci 0000:05:02.0: [1b36:0001] type 1 class 0x000604
[    0.551890] pci 0000:05:02.0: reg 10: [mem 0xfde02000-0xfde020ff 64bit]
[    0.556321] pci 0000:05:03.0: [1b36:0001] type 1 class 0x000604
[    0.560075] pci 0000:05:03.0: reg 10: [mem 0xfde03000-0xfde030ff 64bit]
[    0.568281] pci 0000:05:04.0: [1b36:0001] type 1 class 0x000604
[    0.570183] pci 0000:05:04.0: reg 10: [mem 0xfde04000-0xfde040ff 64bit]
[    0.577590] pci 0000:05:05.0: [1b36:0001] type 1 class 0x000604
[    0.579812] pci 0000:05:05.0: reg 10: [mem 0xfde05000-0xfde050ff 64bit]
[    0.584355] pci 0000:00:1e.0: PCI bridge to [bus 05-0b] (subtractive decode)
[    0.584368] pci 0000:00:1e.0:   bridge window [io  0x1000-0x6fff]
[    0.584377] pci 0000:00:1e.0:   bridge window [mem 0xfd200000-0xfdffffff]
[    0.584394] pci 0000:00:1e.0:   bridge window [mem 0xfb800000-0xfc3fffff 64bit pref]
[    0.584396] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.584397] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.584399] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.584400] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xfebfffff] (subtractive decode)
[    0.585720] pci 0000:05:00.0: PCI bridge to [bus 06-06]
[    0.585731] pci 0000:05:00.0:   bridge window [io  0x6000-0x6fff]
[    0.585740] pci 0000:05:00.0:   bridge window [mem 0xfdc00000-0xfddfffff]
[    0.585764] pci 0000:05:00.0:   bridge window [mem 0xfc200000-0xfc3fffff 64bit pref]
[    0.590832] pci 0000:05:01.0: PCI bridge to [bus 07-07]
[    0.590844] pci 0000:05:01.0:   bridge window [io  0x5000-0x5fff]
[    0.590853] pci 0000:05:01.0:   bridge window [mem 0xfda00000-0xfdbfffff]
[    0.590870] pci 0000:05:01.0:   bridge window [mem 0xfc000000-0xfc1fffff 64bit pref]
[    0.593201] pci 0000:08:01.0: [8086:100f] type 0 class 0x000200
[    0.595130] pci 0000:08:01.0: reg 10: [mem 0xfd840000-0xfd85ffff]
[    0.598008] pci 0000:08:01.0: reg 14: [io  0x4000-0x403f]
[    0.624064] pci 0000:08:01.0: reg 30: [mem 0xfd800000-0xfd83ffff pref]
[    0.626125] pci 0000:05:02.0: PCI bridge to [bus 08-08]
[    0.626138] pci 0000:05:02.0:   bridge window [io  0x4000-0x4fff]
[    0.626164] pci 0000:05:02.0:   bridge window [mem 0xfd800000-0xfd9fffff]
[    0.626183] pci 0000:05:02.0:   bridge window [mem 0xfbe00000-0xfbffffff 64bit pref]
[    0.628330] pci 0000:05:03.0: PCI bridge to [bus 09-09]
[    0.628342] pci 0000:05:03.0:   bridge window [io  0x3000-0x3fff]
[    0.628352] pci 0000:05:03.0:   bridge window [mem 0xfd600000-0xfd7fffff]
[    0.628370] pci 0000:05:03.0:   bridge window [mem 0xfbc00000-0xfbdfffff 64bit pref]
[    0.632310] pci 0000:0a:01.0: [8086:100f] type 0 class 0x000200
[    0.634256] pci 0000:0a:01.0: reg 10: [mem 0xfd440000-0xfd45ffff]
[    0.637899] pci 0000:0a:01.0: reg 14: [io  0x2000-0x203f]
[    0.664070] pci 0000:0a:01.0: reg 30: [mem 0xfd400000-0xfd43ffff pref]
[    0.669690] pci 0000:05:04.0: PCI bridge to [bus 0a-0a]
[    0.669706] pci 0000:05:04.0:   bridge window [io  0x2000-0x2fff]
[    0.669718] pci 0000:05:04.0:   bridge window [mem 0xfd400000-0xfd5fffff]
[    0.669738] pci 0000:05:04.0:   bridge window [mem 0xfba00000-0xfbbfffff 64bit pref]
[    0.672248] pci 0000:0b:01.0: [8086:100f] type 0 class 0x000200
[    0.674690] pci 0000:0b:01.0: reg 10: [mem 0xfd240000-0xfd25ffff]
[    0.680063] pci 0000:0b:01.0: reg 14: [io  0x1000-0x103f]
[    0.708054] pci 0000:0b:01.0: reg 30: [mem 0xfd200000-0xfd23ffff pref]
[    0.710569] pci 0000:05:05.0: PCI bridge to [bus 0b-0b]
[    0.710583] pci 0000:05:05.0:   bridge window [io  0x1000-0x1fff]
[    0.710593] pci 0000:05:05.0:   bridge window [mem 0xfd200000-0xfd3fffff]
[    0.710612] pci 0000:05:05.0:   bridge window [mem 0xfb800000-0xfb9fffff 64bit pref]
[    0.742533] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.744178]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.744265]  pci0000:00: ACPI _OSC control (0x1d) granted
[    0.747392] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.747510] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.747595] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.747695] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.747783] ACPI: PCI Interrupt Link [LNKE] (IRQs 5 *10 11)
[    0.747874] ACPI: PCI Interrupt Link [LNKF] (IRQs 5 *10 11)
[    0.747954] ACPI: PCI Interrupt Link [LNKG] (IRQs 5 10 *11)
[    0.748065] ACPI: PCI Interrupt Link [LNKH] (IRQs 5 10 *11)
[    0.748125] ACPI: PCI Interrupt Link [GSIA] (IRQs *16)
[    0.748144] ACPI: PCI Interrupt Link [GSIB] (IRQs *17)
[    0.748155] ACPI: PCI Interrupt Link [GSIC] (IRQs *18)
[    0.748184] ACPI: PCI Interrupt Link [GSID] (IRQs *19)
[    0.748202] ACPI: PCI Interrupt Link [GSIE] (IRQs *20)
[    0.748212] ACPI: PCI Interrupt Link [GSIF] (IRQs *21)
[    0.748226] ACPI: PCI Interrupt Link [GSIG] (IRQs *22)
[    0.748236] ACPI: PCI Interrupt Link [GSIH] (IRQs *23)
[    0.748344] vgaarb: device added: PCI:0000:00:0b.0,decodes=io+mem,owns=io+mem,locks=none
[    0.748353] vgaarb: loaded
[    0.748486] PCI: Using ACPI for IRQ routing
[    0.788738] PCI: pci_cache_line_size set to 64 bytes
[    0.788997] reserve RAM buffer: 000000000009fc00 - 000000000009ffff 
[    0.788999] reserve RAM buffer: 000000007ffdf000 - 000000007fffffff 
[    0.789064] NetLabel: Initializing
[    0.789066] NetLabel:  domain hash size = 128
[    0.789067] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.789074] NetLabel:  unlabeled traffic allowed by default
[    0.789091] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.789101] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.789105] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.792064] Switching to clocksource kvm-clock
[    0.792861] AppArmor: AppArmor Filesystem Enabled
[    0.792877] pnp: PnP ACPI init
[    0.792886] ACPI: bus type pnp registered
[    0.792904] pnp 00:00: [bus 00-ff]
[    0.792905] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.792907] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.792908] pnp 00:00: [io  0x0d00-0xffff window]
[    0.792909] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.792910] pnp 00:00: [mem 0xc0000000-0xfebfffff window]
[    0.792939] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.792946] pnp 00:01: [io  0x0070-0x0071]
[    0.792967] pnp 00:01: [irq 8]
[    0.792968] pnp 00:01: [io  0x0072-0x0077]
[    0.792983] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.792999] pnp 00:02: [io  0x0060]
[    0.793000] pnp 00:02: [io  0x0064]
[    0.793010] pnp 00:02: [irq 1]
[    0.793025] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.793044] pnp 00:03: [irq 12]
[    0.793057] pnp 00:03: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.793107] pnp 00:04: [io  0x03f8-0x03ff]
[    0.793129] pnp 00:04: [irq 4]
[    0.793144] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.793175] pnp 00:05: [io  0x0620-0x062f]
[    0.793188] pnp 00:05: Plug and Play ACPI device, IDs PNP0a06 (active)
[    0.793195] pnp 00:06: [io  0x0cd8-0x0cf7]
[    0.793207] pnp 00:06: Plug and Play ACPI device, IDs PNP0a06 (active)
[    0.793258] pnp 00:07: [mem 0xfed00000-0xfed003ff]
[    0.793274] pnp 00:07: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.793405] pnp: PnP ACPI: found 8 devices
[    0.793407] ACPI: ACPI bus type pnp unregistered
[    0.798596] PCI: max bus depth: 2 pci_try_num: 3
[    0.830503] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.830516] pci 0000:00:01.0:   bridge window [io  0xa000-0xafff]
[    0.834909] pci 0000:00:01.0:   bridge window [mem 0xfe600000-0xfe7fffff]
[    0.838155] pci 0000:00:01.0:   bridge window [mem 0xfca00000-0xfcbfffff 64bit pref]
[    0.844453] pci 0000:00:02.0: PCI bridge to [bus 02-02]
[    0.844466] pci 0000:00:02.0:   bridge window [io  0x9000-0x9fff]
[    0.847820] pci 0000:00:02.0:   bridge window [mem 0xfe400000-0xfe5fffff]
[    0.850032] pci 0000:00:02.0:   bridge window [mem 0xfc800000-0xfc9fffff 64bit pref]
[    0.855521] pci 0000:00:03.0: PCI bridge to [bus 03-03]
[    0.855535] pci 0000:00:03.0:   bridge window [io  0x8000-0x8fff]
[    0.858729] pci 0000:00:03.0:   bridge window [mem 0xfe200000-0xfe3fffff]
[    0.861119] pci 0000:00:03.0:   bridge window [mem 0xfc600000-0xfc7fffff 64bit pref]
[    0.866598] pci 0000:00:05.0: PCI bridge to [bus 04-04]
[    0.868770] pci 0000:00:05.0:   bridge window [io  0x7000-0x7fff]
[    0.872222] pci 0000:00:05.0:   bridge window [mem 0xfe000000-0xfe1fffff]
[    0.874420] pci 0000:00:05.0:   bridge window [mem 0xfc400000-0xfc5fffff 64bit pref]
[    0.878957] pci 0000:05:00.0: PCI bridge to [bus 06-06]
[    0.880159] pci 0000:05:00.0:   bridge window [io  0x6000-0x6fff]
[    0.883457] pci 0000:05:00.0:   bridge window [mem 0xfdc00000-0xfddfffff]
[    0.885602] pci 0000:05:00.0:   bridge window [mem 0xfc200000-0xfc3fffff 64bit pref]
[    0.889921] pci 0000:05:01.0: PCI bridge to [bus 07-07]
[    0.889932] pci 0000:05:01.0:   bridge window [io  0x5000-0x5fff]
[    0.894641] pci 0000:05:01.0:   bridge window [mem 0xfda00000-0xfdbfffff]
[    0.896820] pci 0000:05:01.0:   bridge window [mem 0xfc000000-0xfc1fffff 64bit pref]
[    0.901200] pci 0000:05:02.0: PCI bridge to [bus 08-08]
[    0.902238] pci 0000:05:02.0:   bridge window [io  0x4000-0x4fff]
[    0.905483] pci 0000:05:02.0:   bridge window [mem 0xfd800000-0xfd9fffff]
[    0.907563] pci 0000:05:02.0:   bridge window [mem 0xfbe00000-0xfbffffff 64bit pref]
[    0.911984] pci 0000:05:03.0: PCI bridge to [bus 09-09]
[    0.912094] pci 0000:05:03.0:   bridge window [io  0x3000-0x3fff]
[    0.915520] pci 0000:05:03.0:   bridge window [mem 0xfd600000-0xfd7fffff]
[    0.918135] pci 0000:05:03.0:   bridge window [mem 0xfbc00000-0xfbdfffff 64bit pref]
[    0.924476] pci 0000:05:04.0: PCI bridge to [bus 0a-0a]
[    0.925505] pci 0000:05:04.0:   bridge window [io  0x2000-0x2fff]
[    0.929230] pci 0000:05:04.0:   bridge window [mem 0xfd400000-0xfd5fffff]
[    0.931443] pci 0000:05:04.0:   bridge window [mem 0xfba00000-0xfbbfffff 64bit pref]
[    0.935712] pci 0000:05:05.0: PCI bridge to [bus 0b-0b]
[    0.935725] pci 0000:05:05.0:   bridge window [io  0x1000-0x1fff]
[    0.939153] pci 0000:05:05.0:   bridge window [mem 0xfd200000-0xfd3fffff]
[    0.943067] pci 0000:05:05.0:   bridge window [mem 0xfb800000-0xfb9fffff 64bit pref]
[    0.947390] pci 0000:00:1e.0: PCI bridge to [bus 05-0b]
[    0.947403] pci 0000:00:1e.0:   bridge window [io  0x1000-0x6fff]
[    0.950524] pci 0000:00:1e.0:   bridge window [mem 0xfd200000-0xfdffffff]
[    0.952767] pci 0000:00:1e.0:   bridge window [mem 0xfb800000-0xfc3fffff 64bit pref]
[    0.962573] pci 0000:00:01.0: setting latency timer to 64
[    0.965259] pci 0000:00:02.0: setting latency timer to 64
[    0.968218] pci 0000:00:03.0: setting latency timer to 64
[    0.972594] pci 0000:00:05.0: setting latency timer to 64
[    0.976335] pci 0000:00:1e.0: setting latency timer to 64
[    0.976375] ACPI: PCI Interrupt Link [GSIE] enabled at IRQ 20
[    0.976402] pci 0000:05:00.0: PCI INT A -> Link[GSIE] -> GSI 20 (level, high) -> IRQ 20
[    0.979964] pci 0000:05:00.0: setting latency timer to 64
[    0.979991] ACPI: PCI Interrupt Link [GSIF] enabled at IRQ 21
[    0.980024] pci 0000:05:01.0: PCI INT A -> Link[GSIF] -> GSI 21 (level, high) -> IRQ 21
[    0.985441] pci 0000:05:01.0: setting latency timer to 64
[    0.985685] ACPI: PCI Interrupt Link [GSIG] enabled at IRQ 22
[    0.985704] pci 0000:05:02.0: PCI INT A -> Link[GSIG] -> GSI 22 (level, high) -> IRQ 22
[    0.989866] pci 0000:05:02.0: setting latency timer to 64
[    0.989891] ACPI: PCI Interrupt Link [GSIH] enabled at IRQ 23
[    0.989909] pci 0000:05:03.0: PCI INT A -> Link[GSIH] -> GSI 23 (level, high) -> IRQ 23
[    0.994178] pci 0000:05:03.0: setting latency timer to 64
[    0.994193] pci 0000:05:04.0: PCI INT A -> Link[GSIE] -> GSI 20 (level, high) -> IRQ 20
[    0.999002] pci 0000:05:04.0: setting latency timer to 64
[    1.000885] pci 0000:05:05.0: PCI INT A -> Link[GSIF] -> GSI 21 (level, high) -> IRQ 21
[    1.007087] pci 0000:05:05.0: setting latency timer to 64
[    1.007098] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    1.007101] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    1.007103] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    1.007105] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff]
[    1.007107] pci_bus 0000:01: resource 0 [io  0xa000-0xafff]
[    1.007109] pci_bus 0000:01: resource 1 [mem 0xfe600000-0xfe7fffff]
[    1.007111] pci_bus 0000:01: resource 2 [mem 0xfca00000-0xfcbfffff 64bit pref]
[    1.007114] pci_bus 0000:02: resource 0 [io  0x9000-0x9fff]
[    1.007116] pci_bus 0000:02: resource 1 [mem 0xfe400000-0xfe5fffff]
[    1.007118] pci_bus 0000:02: resource 2 [mem 0xfc800000-0xfc9fffff 64bit pref]
[    1.007120] pci_bus 0000:03: resource 0 [io  0x8000-0x8fff]
[    1.007122] pci_bus 0000:03: resource 1 [mem 0xfe200000-0xfe3fffff]
[    1.007124] pci_bus 0000:03: resource 2 [mem 0xfc600000-0xfc7fffff 64bit pref]
[    1.007127] pci_bus 0000:04: resource 0 [io  0x7000-0x7fff]
[    1.007129] pci_bus 0000:04: resource 1 [mem 0xfe000000-0xfe1fffff]
[    1.007131] pci_bus 0000:04: resource 2 [mem 0xfc400000-0xfc5fffff 64bit pref]
[    1.007133] pci_bus 0000:05: resource 0 [io  0x1000-0x6fff]
[    1.007135] pci_bus 0000:05: resource 1 [mem 0xfd200000-0xfdffffff]
[    1.007137] pci_bus 0000:05: resource 2 [mem 0xfb800000-0xfc3fffff 64bit pref]
[    1.007139] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7]
[    1.007141] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff]
[    1.007143] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff]
[    1.007145] pci_bus 0000:05: resource 7 [mem 0xc0000000-0xfebfffff]
[    1.007147] pci_bus 0000:06: resource 0 [io  0x6000-0x6fff]
[    1.007149] pci_bus 0000:06: resource 1 [mem 0xfdc00000-0xfddfffff]
[    1.007151] pci_bus 0000:06: resource 2 [mem 0xfc200000-0xfc3fffff 64bit pref]
[    1.007154] pci_bus 0000:07: resource 0 [io  0x5000-0x5fff]
[    1.007155] pci_bus 0000:07: resource 1 [mem 0xfda00000-0xfdbfffff]
[    1.007157] pci_bus 0000:07: resource 2 [mem 0xfc000000-0xfc1fffff 64bit pref]
[    1.007160] pci_bus 0000:08: resource 0 [io  0x4000-0x4fff]
[    1.007162] pci_bus 0000:08: resource 1 [mem 0xfd800000-0xfd9fffff]
[    1.007164] pci_bus 0000:08: resource 2 [mem 0xfbe00000-0xfbffffff 64bit pref]
[    1.007166] pci_bus 0000:09: resource 0 [io  0x3000-0x3fff]
[    1.007168] pci_bus 0000:09: resource 1 [mem 0xfd600000-0xfd7fffff]
[    1.007170] pci_bus 0000:09: resource 2 [mem 0xfbc00000-0xfbdfffff 64bit pref]
[    1.007172] pci_bus 0000:0a: resource 0 [io  0x2000-0x2fff]
[    1.007174] pci_bus 0000:0a: resource 1 [mem 0xfd400000-0xfd5fffff]
[    1.007176] pci_bus 0000:0a: resource 2 [mem 0xfba00000-0xfbbfffff 64bit pref]
[    1.007178] pci_bus 0000:0b: resource 0 [io  0x1000-0x1fff]
[    1.007180] pci_bus 0000:0b: resource 1 [mem 0xfd200000-0xfd3fffff]
[    1.007182] pci_bus 0000:0b: resource 2 [mem 0xfb800000-0xfb9fffff 64bit pref]
[    1.007463] NET: Registered protocol family 2
[    1.007971] IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    1.009183] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    1.010512] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.010597] TCP: Hash tables configured (established 524288 bind 65536)
[    1.010601] TCP reno registered
[    1.010621] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    1.010838] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    1.010963] NET: Registered protocol family 1
[    1.012125] pci 0000:00:0b.0: Boot video device
[    1.012297] PCI: CLS 0 bytes, default 64
[    1.012333] Unpacking initramfs...
[    1.097704] Freeing initrd memory: 5836k freed
[    1.098224] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.098228] Placing 64MB software IO TLB between ffff88007bfd4000 - ffff88007ffd4000
[    1.098230] software IO TLB at phys 0x7bfd4000 - 0x7ffd4000
[    1.098507] futex hash table entries: 512 (order: 4, 65536 bytes)
[    1.098515] Initialise module verification
[    1.098580] audit: initializing netlink socket (enabled)
[    1.098588] type=2000 audit(1482315013.092:1): initialized
[    1.114263] bounce pool size: 64 pages
[    1.114270] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.115177] VFS: Disk quotas dquot_6.5.2
[    1.115206] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.115456] msgmni has been set to 5955
[    1.115590] alg: No test for stdrng (krng)
[    1.115597] Asymmetric key parser 'x509' registered
[    1.115619] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    1.115636] io scheduler noop registered (default)
[    1.115638] io scheduler deadline registered
[    1.115658] io scheduler cfq registered
[    1.115815] pcieport 0000:00:01.0: setting latency timer to 64
[    1.115980] pcieport 0000:00:01.0: irq 40 for MSI/MSI-X
[    1.119118] pcieport 0000:00:02.0: setting latency timer to 64
[    1.119282] pcieport 0000:00:02.0: irq 41 for MSI/MSI-X
[    1.122249] pcieport 0000:00:03.0: setting latency timer to 64
[    1.122405] pcieport 0000:00:03.0: irq 42 for MSI/MSI-X
[    1.125292] pcieport 0000:00:05.0: setting latency timer to 64
[    1.125460] pcieport 0000:00:05.0: irq 43 for MSI/MSI-X
[    1.130351] aer 0000:00:01.0:pcie02: service driver aer loaded
[    1.130438] aer 0000:00:02.0:pcie02: service driver aer loaded
[    1.130522] aer 0000:00:03.0:pcie02: service driver aer loaded
[    1.130605] aer 0000:00:05.0:pcie02: service driver aer loaded
[    1.130633] pcieport 0000:00:01.0: Signaling PME through PCIe PME interrupt
[    1.130636] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    1.130647] pcie_pme 0000:00:01.0:pcie01: service driver pcie_pme loaded
[    1.130670] pcieport 0000:00:02.0: Signaling PME through PCIe PME interrupt
[    1.130672] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    1.130683] pcie_pme 0000:00:02.0:pcie01: service driver pcie_pme loaded
[    1.130704] pcieport 0000:00:03.0: Signaling PME through PCIe PME interrupt
[    1.130706] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
[    1.130717] pcie_pme 0000:00:03.0:pcie01: service driver pcie_pme loaded
[    1.130739] pcieport 0000:00:05.0: Signaling PME through PCIe PME interrupt
[    1.130741] pci 0000:04:00.0: Signaling PME through PCIe PME interrupt
[    1.130752] pcie_pme 0000:00:05.0:pcie01: service driver pcie_pme loaded
[    1.130800] vesafb: mode is 1024x768x24, linelength=3072, pages=2
[    1.130802] vesafb: scrolling: redraw
[    1.130804] vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
[    1.130843] vesafb: framebuffer at 0xfa800000, mapped to 0xffffc90012680000, using 4608k, total 8192k
[    1.130928] bootsplash 3.2.0-2010/03/31: looking for picture...
[    1.130929] bootsplash: silentjpeg size 59221 bytes
[    1.136811] bootsplash: ...found (1024x768, 31358 bytes, v3).
[    1.136860] bootsplash: silentjpeg size 62784 bytes
[    1.151964] Console: switching to colour frame buffer device 124x44
[    1.162357] fb0: VESA VGA frame buffer device
[    1.162391] GHES: HEST is not enabled!
[    1.162434] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    1.162606] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.392267] 00:04: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.428233] Non-volatile memory driver v1.3
[    1.428236] Linux agpgart interface v0.103
[    1.428281] Fixed MDIO Bus: probed
[    1.428310] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    1.428763] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.428769] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.428803] mousedev: PS/2 mouse device common for all mice
[    1.428949] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.429239] cpuidle: using governor ladder
[    1.429241] cpuidle: using governor menu
[    1.429270] EFI Variables Facility v0.08 2004-May-17
[    1.429403] TCP cubic registered
[    1.429433] Registering the dns_resolver key type
[    1.429502] Loading module verification certificates
[    1.429540] MODSIGN: Loaded cert 'SUSE Linux Enterprise Secure Boot Signkey: 3fb077b6cebc6ff2522e1c148c57c777c788e3e7'
[    1.429572] MODSIGN: Loaded cert 'SUSE Linux Enterprise Secure Boot Signkey: 3fb077b6cebc6ff2522e1c148c57c777c788e3e7'
[    1.429596] PM: Checking hibernation image partition /dev/disk/by-id/scsi-0FTS_PRAID_EP420i_SDA-part5
[    1.429598] PM: Hibernation image not present or could not be loaded.
[    1.429606] registered taskstats version 1
[    1.430607]   Magic number: 12:397:176
[    1.430656] acpi device:0c: hash matches
[    1.431880] Freeing unused kernel memory: 1360k freed
[    1.432039] Write protecting the kernel read-only data: 10240k
[    1.434365] Freeing unused kernel memory: 1560k freed
[    1.435933] Freeing unused kernel memory: 900k freed
[    1.463108] SCSI subsystem initialized
[    1.463624] megasas: 06.806.08.00-rc1 Thu. Sep. 4 17:00:00 PDT 2014
[    1.463660] megasas: 0x1000:0x0079:0x1000:0x9261: bus 0:slot 6:func 0
[    1.463717] megaraid_sas 0000:00:06.0: PCI INT A -> Link[GSIG] -> GSI 22 (level, high) -> IRQ 22
[    1.463754] megaraid_sas 0000:00:06.0: setting latency timer to 64
[    1.464054] megasas: FW now in Ready state
[    1.464204] megaraid_sas 0000:00:06.0: irq 44 for MSI/MSI-X
[    1.464239] megaraid_sas 0000:00:06.0: [scsi0]: FW supports<0> MSIX vector,Online CPUs: <2>,Current MSIX <1>
[    1.464735] megasas_init_mfi: fw_support_ieee=67108864
[    1.464738] megasas: INIT adapter done
[    1.464826] megaraid_sas 0000:00:06.0: Controller type: MR,Memory size is: 512MB
[    1.464885] scsi0 : LSI SAS based MegaRAID driver
[    1.466549] scsi 0:2:0:0: Direct-Access     FTS      PRAID EP420i     4.25 PQ: 0 ANSI: 5
[    1.475523] libata version 3.00 loaded.
[    1.475942] ahci 0000:00:1f.2: version 3.0
[    1.475984] ACPI: PCI Interrupt Link [GSIA] enabled at IRQ 16
[    1.476034] ahci 0000:00:1f.2: PCI INT A -> Link[GSIA] -> GSI 16 (level, high) -> IRQ 16
[    1.476154] ahci 0000:00:1f.2: irq 45 for MSI/MSI-X
[    1.476385] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
[    1.476414] ahci 0000:00:1f.2: flags: ncq only 
[    1.476463] ahci 0000:00:1f.2: setting latency timer to 64
[    1.476990] scsi1 : ahci
[    1.477072] scsi2 : ahci
[    1.477135] scsi3 : ahci
[    1.477196] scsi4 : ahci
[    1.477256] scsi5 : ahci
[    1.477312] scsi6 : ahci
[    1.477367] ata2: SATA max UDMA/133 abar m4096@0xfea35000 port 0xfea35100 irq 45
[    1.477398] ata3: SATA max UDMA/133 abar m4096@0xfea35000 port 0xfea35180 irq 45
[    1.477429] ata4: SATA max UDMA/133 abar m4096@0xfea35000 port 0xfea35200 irq 45
[    1.477458] ata5: SATA max UDMA/133 abar m4096@0xfea35000 port 0xfea35280 irq 45
[    1.477488] ata6: SATA max UDMA/133 abar m4096@0xfea35000 port 0xfea35300 irq 45
[    1.477517] ata7: SATA max UDMA/133 abar m4096@0xfea35000 port 0xfea35380 irq 45
[    1.796097] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.796260] ata6: SATA link down (SStatus 0 SControl 300)
[    1.796363] ata5: SATA link down (SStatus 0 SControl 300)
[    1.796461] ata2: SATA link down (SStatus 0 SControl 300)
[    1.796567] ata7: SATA link down (SStatus 0 SControl 300)
[    1.796616] ata4.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    1.796645] ata4.00: applying bridge limits
[    1.796814] ata3: SATA link down (SStatus 0 SControl 300)
[    1.796933] ata4.00: configured for UDMA/100
[    1.797100] scsi 3:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    1.801016] sym53c8xx 0000:02:00.0: PCI INT A -> Link[GSIG] -> GSI 22 (level, high) -> IRQ 22
[    1.801996] sym0: <895a> rev 0x0 at pci 0000:02:00.0 irq 22
[    1.804128] sym0: No NVRAM, ID 7, Fast-40, LVD, parity checking
[    1.808004] sym0: SCSI BUS has been reset.
[    1.812118] scsi7 : sym-2.2.3
[    2.068643] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input1
[    2.112101] Refined TSC clocksource calibration: 2594.052 MHz.
[    4.817405] virtio-pci 0000:01:00.0: PCI INT A -> Link[GSIF] -> GSI 21 (level, high) -> IRQ 21
[    4.817478] virtio-pci 0000:01:00.0: setting latency timer to 64
[    4.817661] virtio-pci 0000:03:00.0: PCI INT A -> Link[GSIH] -> GSI 23 (level, high) -> IRQ 23
[    4.821655] virtio-pci 0000:03:00.0: setting latency timer to 64
[    4.821759] virtio-pci 0000:04:00.0: PCI INT A -> Link[GSIF] -> GSI 21 (level, high) -> IRQ 21
[    4.825775] virtio-pci 0000:04:00.0: setting latency timer to 64
[    4.829969] alua: device handler registered
[    4.833339] rdac: device handler registered
[    4.836626] emc: device handler registered
[    4.839934] hp_sw: device handler registered
[    4.842360] udev: starting version 147
[    4.873682] ACPI: acpi_idle registered with cpuidle
[    4.880289] sd 0:2:0:0: [sda] 629145600 512-byte logical blocks: (322 GB/300 GiB)
[    4.880418] sd 0:2:0:0: [sda] Write Protect is off
[    4.880447] sd 0:2:0:0: [sda] Mode Sense: 63 00 00 08
[    4.880481] sd 0:2:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.910195]  sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
[    4.910559] sd 0:2:0:0: [sda] Attached SCSI disk
[    6.920272] kjournald starting.  Commit interval 15 seconds
[    6.920385] EXT3-fs (sda7): using internal journal
[    6.920418] EXT3-fs (sda7): mounted filesystem with ordered data mode
[   15.584838] udev: starting version 147
[   16.806942] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[   16.807001] ACPI: Power Button [PWRF]
[   17.086736] input: PC Speaker as /devices/platform/pcspkr/input/input3
[   17.177774] iTCO_vendor_support: vendor-support=0
[   17.215722] rtc_cmos 00:01: RTC can wake from S4
[   17.215878] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[   17.216069] rtc0: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
[   17.217618] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   17.219668] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   17.220924] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.06
[   17.221083] iTCO_wdt: Found a ICH9 TCO device (Version=2, TCOBASE=0x0660)
[   17.221159] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   17.445163] virtio-pci 0000:03:00.0: irq 46 for MSI/MSI-X
[   17.445175] virtio-pci 0000:03:00.0: irq 47 for MSI/MSI-X
[   17.505757] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[   17.505789] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   17.505848] e1000 0000:00:04.0: PCI INT A -> Link[GSIE] -> GSI 20 (level, high) -> IRQ 20
[   17.509079] e1000 0000:00:04.0: setting latency timer to 64
[   17.523187] virtio-pci 0000:01:00.0: irq 48 for MSI/MSI-X
[   17.523199] virtio-pci 0000:01:00.0: irq 49 for MSI/MSI-X
[   17.523209] virtio-pci 0000:01:00.0: irq 50 for MSI/MSI-X
[   17.523219] virtio-pci 0000:01:00.0: irq 51 for MSI/MSI-X
[   17.523626] scsi8 : Virtio SCSI HBA
[   17.524618] scsi 8:0:2:5: Sequential-Access HP       Ultrium 6-SCSI   23AB PQ: 0 ANSI: 5
[   17.524913] scsi 8:0:2:4: Sequential-Access HP       Ultrium 6-SCSI   23AB PQ: 0 ANSI: 5
[   17.525190] scsi 8:0:2:3: Sequential-Access HP       Ultrium 5-SCSI   0001 PQ: 0 ANSI: 5
[   17.525448] scsi 8:0:2:2: Sequential-Access HP       Ultrium 5-SCSI   0001 PQ: 0 ANSI: 5
[   17.525707] scsi 8:0:2:1: Sequential-Access HP       Ultrium 5-SCSI   0001 PQ: 0 ANSI: 5
[   17.694117] sr0: scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[   17.694150] cdrom: Uniform CD-ROM driver Revision: 3.20
[   17.694246] sr 3:0:0:0: Attached scsi CD-ROM sr0
[   17.696178] sd 0:2:0:0: Attached scsi generic sg0 type 0
[   17.696223] sr 3:0:0:0: Attached scsi generic sg1 type 5
[   17.696264] scsi 8:0:2:5: Attached scsi generic sg2 type 1
[   17.696303] scsi 8:0:2:4: Attached scsi generic sg3 type 1
[   17.696341] scsi 8:0:2:3: Attached scsi generic sg4 type 1
[   17.696386] scsi 8:0:2:2: Attached scsi generic sg5 type 1
[   17.696424] scsi 8:0:2:1: Attached scsi generic sg6 type 1
[   17.825189] e1000 0000:00:04.0: eth0: (PCI:33MHz:32-bit) 00:82:67:84:01:01
[   17.825251] e1000 0000:00:04.0: eth0: Intel(R) PRO/1000 Network Connection
[   17.825339] e1000 0000:00:10.0: PCI INT A -> Link[GSIE] -> GSI 20 (level, high) -> IRQ 20
[   17.829441] e1000 0000:00:10.0: setting latency timer to 64
[   18.013995] osst :I: Tape driver with OnStream support version 0.99.4
[   18.013996] osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
[   18.143843] e1000 0000:00:10.0: eth1: (PCI:33MHz:32-bit) 00:82:67:84:01:02
[   18.143872] e1000 0000:00:10.0: eth1: Intel(R) PRO/1000 Network Connection
[   18.143938] e1000 0000:00:11.0: PCI INT A -> Link[GSIF] -> GSI 21 (level, high) -> IRQ 21
[   18.147050] e1000 0000:00:11.0: setting latency timer to 64
[   18.462674] e1000 0000:00:11.0: eth2: (PCI:33MHz:32-bit) 00:fc:61:69:00:01
[   18.462707] e1000 0000:00:11.0: eth2: Intel(R) PRO/1000 Network Connection
[   18.462771] e1000 0000:00:12.0: PCI INT A -> Link[GSIG] -> GSI 22 (level, high) -> IRQ 22
[   18.465913] e1000 0000:00:12.0: setting latency timer to 64
[   18.511555] Disabling lock debugging due to kernel taint
[   18.511825] st: Version 20110511, fixed bufsize 32768, s/g segs 256
[   18.511966] st 8:0:2:5: Attached scsi tape st0
[   18.512014] st 8:0:2:5: st0: try direct i/o: yes (alignment 4 B)
[   18.512121] st 8:0:2:4: Attached scsi tape st1
[   18.512146] st 8:0:2:4: st1: try direct i/o: yes (alignment 4 B)
[   18.512248] st 8:0:2:3: Attached scsi tape st2
[   18.512273] st 8:0:2:3: st2: try direct i/o: yes (alignment 4 B)
[   18.512375] st 8:0:2:2: Attached scsi tape st3
[   18.512400] st 8:0:2:2: st3: try direct i/o: yes (alignment 4 B)
[   18.512504] st 8:0:2:1: Attached scsi tape st4
[   18.512529] st 8:0:2:1: st4: try direct i/o: yes (alignment 4 B)
[   18.776302] e1000 0000:00:12.0: eth3: (PCI:33MHz:32-bit) 00:fc:61:69:00:02
[   18.776337] e1000 0000:00:12.0: eth3: Intel(R) PRO/1000 Network Connection
[   18.776405] e1000 0000:00:13.0: PCI INT A -> Link[GSIH] -> GSI 23 (level, high) -> IRQ 23
[   18.780058] e1000 0000:00:13.0: setting latency timer to 64
[   19.095319] e1000 0000:00:13.0: eth4: (PCI:33MHz:32-bit) 00:fc:61:69:00:05
[   19.095366] e1000 0000:00:13.0: eth4: Intel(R) PRO/1000 Network Connection
[   19.095453] e1000 0000:08:01.0: PCI INT A -> Link[GSIH] -> GSI 23 (level, high) -> IRQ 23
[   19.095463] i801_smbus 0000:00:1f.3: PCI INT A -> Link[GSIA] -> GSI 16 (level, high) -> IRQ 16
[   19.099313] e1000 0000:08:01.0: setting latency timer to 64
[   19.411991] e1000 0000:08:01.0: eth5: (PCI:33MHz:32-bit) 00:86:67:84:01:06
[   19.412049] e1000 0000:08:01.0: eth5: Intel(R) PRO/1000 Network Connection
[   19.412109] e1000 0000:0a:01.0: PCI INT A -> Link[GSIF] -> GSI 21 (level, high) -> IRQ 21
[   19.415932] e1000 0000:0a:01.0: setting latency timer to 64
[   19.728016] e1000 0000:0a:01.0: eth6: (PCI:33MHz:32-bit) 00:82:67:84:01:04
[   19.728054] e1000 0000:0a:01.0: eth6: Intel(R) PRO/1000 Network Connection
[   19.728111] e1000 0000:0b:01.0: PCI INT A -> Link[GSIG] -> GSI 22 (level, high) -> IRQ 22
[   19.732396] e1000 0000:0b:01.0: setting latency timer to 64
[   20.043914] e1000 0000:0b:01.0: eth7: (PCI:33MHz:32-bit) 00:82:67:84:01:05
[   20.043945] e1000 0000:0b:01.0: eth7: Intel(R) PRO/1000 Network Connection
[   20.133906] Adding 12585980k swap on /dev/sda5.  Priority:-1 extents:1 across:12585980k 
[   20.483489] type=1111 audit(1482315032.480:2): user pid=1029 uid=0 auid=4294967295 ses=4294967295 msg='changing system time: exe="/sbin/hwclock" (hostname=?, addr=?, terminal=console res=success)'
[   20.512821] device-mapper: uevent: version 1.0.3
[   20.512909] device-mapper: ioctl: 4.25.0-ioctl (2012-07-25) initialised: dm-devel@redhat.com
[   20.573217] pps_core: LinuxPPS API ver. 1 registered
[   20.573250] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   20.573671] PTP clock support registered
[   22.173232] loop: module loaded
[   22.567651] kjournald starting.  Commit interval 15 seconds
[   22.567799] EXT3-fs (sda6): using internal journal
[   22.567831] EXT3-fs (sda6): mounted filesystem with ordered data mode
[   25.707938] fuse init (API version 7.16)
[   28.470827] ipmi message handler version 39.2
[   28.478390] ipmi device interface
[   28.480175] IPMI System Interface driver.
[   28.480196] ipmi_si: probing via SMBIOS
[   28.480198] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[   28.480200] ipmi_si: Adding SMBIOS-specified kcs state machine
[   28.480203] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
[   28.480216] ipmi_si: Interface detection failed
[   50.826472] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   51.208985] ip_tables: (C) 2000-2006 Netfilter Core Team
[   51.214329] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[   51.239140] type=1325 audit(1482315063.236:3): table=filter family=2 entries=0
[   51.239344] type=1300 audit(1482315063.236:3): arch=c000003e syscall=175 success=yes exit=0 a0=7fc2e7110000 a1=1ea7 a2=61e440 a3=7fffd86f1450 items=0 ppid=1838 pid=1839 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="modprobe" exe="/sbin/modprobe" key=(null)
[   51.266801] type=1325 audit(1482315063.260:4): table=raw family=2 entries=0
[   51.267095] type=1300 audit(1482315063.260:4): arch=c000003e syscall=175 success=yes exit=0 a0=7efc422a1000 a1=1a1f a2=61e440 a3=7fff6ce4cdb0 items=0 ppid=1844 pid=1845 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="modprobe" exe="/sbin/modprobe" key=(null)
[   51.293522] type=1325 audit(1482315063.288:5): table=filter family=2 entries=4
[   51.293532] type=1300 audit(1482315063.288:5): arch=c000003e syscall=54 success=yes exit=0 a0=5 a1=0 a2=40 a3=60fa90 items=0 ppid=1810 pid=1837 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="iptables-batch" exe="/usr/sbin/iptables-batch" key=(null)
[   51.294670] type=1325 audit(1482315063.288:6): table=raw family=2 entries=3
[   51.294680] type=1300 audit(1482315063.288:6): arch=c000003e syscall=54 success=yes exit=0 a0=7 a1=0 a2=40 a3=60b320 items=0 ppid=1810 pid=1837 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="iptables-batch" exe="/usr/sbin/iptables-batch" key=(null)
[   75.445434] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   75.648765] device eth2 entered promiscuous mode
[   75.648771] type=1700 audit(1482315087.640:7): dev=eth2 prom=256 old_prom=0 auid=4294967295 uid=0 gid=0 ses=4294967295
[   75.650085] e1000: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   75.651762] type=1300 audit(1482315087.640:7): arch=c000003e syscall=46 success=yes exit=32 a0=3 a1=7ffe0dee6da0 a2=0 a3=7ffe0dee6b10 items=0 ppid=3782 pid=3960 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="ip" exe="/sbin/ip" key=(null)
[   75.821745] device eth3 entered promiscuous mode
[   75.821750] type=1700 audit(1482315087.812:8): dev=eth3 prom=256 old_prom=0 auid=4294967295 uid=0 gid=0 ses=4294967295
[   75.823481] type=1300 audit(1482315087.812:8): arch=c000003e syscall=46 success=yes exit=32 a0=3 a1=7ffdcda3c8a0 a2=0 a3=7ffdcda3c610 items=0 ppid=4013 pid=4191 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="ip" exe="/sbin/ip" key=(null)
[   75.825441] e1000: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   75.983641] device eth4 entered promiscuous mode
[   75.983647] type=1700 audit(1482315087.976:9): dev=eth4 prom=256 old_prom=0 auid=4294967295 uid=0 gid=0 ses=4294967295
[   75.985424] e1000: eth4 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   75.986851] type=1300 audit(1482315087.976:9): arch=c000003e syscall=46 success=yes exit=32 a0=3 a1=7ffcea7f6a70 a2=0 a3=7ffcea7f67e0 items=0 ppid=4244 pid=4422 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="ip" exe="/sbin/ip" key=(null)
[   77.328187] 802.1Q VLAN Support v1.8
[   77.328200] 8021q: adding VLAN 0 to HW filter on device eth0
[   77.328276] 8021q: adding VLAN 0 to HW filter on device eth2
[   77.328349] 8021q: adding VLAN 0 to HW filter on device eth3
[   77.328384] 8021q: adding VLAN 0 to HW filter on device eth4
[   77.330204] NET: Registered protocol family 17
[   77.532547] scsi9 : FCoE Driver
[   77.532688] fcoe: No FDMI support.
[   77.532818] host9: libfc: Link up on port (000000)
[   77.534158] scsi10 : FCoE Driver
[   77.534296] fcoe: No FDMI support.
[   77.534375] host10: libfc: Link up on port (000000)
[   77.535633] scsi11 : FCoE Driver
[   77.535772] fcoe: No FDMI support.
[   77.535852] host11: libfc: Link up on port (000000)
[   78.052601] host11: Assigned Port ID 000002
[   78.080543] host10: Assigned Port ID 000001
[   78.112603] host9: Assigned Port ID 000005
[   81.132045] scsi 10:0:0:0: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   81.132156] sd 10:0:0:0: Attached scsi generic sg7 type 0
[   81.133259] sd 10:0:0:0: [sdb] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   81.133403] scsi 10:0:0:7: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   81.133478] sd 10:0:0:7: Attached scsi generic sg8 type 0
[   81.134151] sd 10:0:0:7: [sdc] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   81.134279] scsi 10:0:0:6: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   81.134396] sd 10:0:0:6: Attached scsi generic sg9 type 0
[   81.134871] sd 10:0:0:0: [sdb] Write Protect is off
[   81.134875] sd 10:0:0:0: [sdb] Mode Sense: 69 00 00 08
[   81.135425] sd 10:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   81.135562] sd 10:0:0:7: [sdc] Write Protect is off
[   81.135566] sd 10:0:0:7: [sdc] Mode Sense: 69 00 00 08
[   81.135586] sd 10:0:0:6: [sdd] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   81.136114] scsi 10:0:0:5: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   81.136125] sd 10:0:0:7: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   81.136228] sd 10:0:0:5: Attached scsi generic sg10 type 0
[   81.136966] sd 10:0:0:6: [sdd] Write Protect is off
[   81.136970] sd 10:0:0:6: [sdd] Mode Sense: 69 00 00 08
[   81.137139] scsi 10:0:0:4: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   81.137237] sd 10:0:0:4: Attached scsi generic sg11 type 0
[   81.137409] sd 10:0:0:5: [sde] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   81.137723] sd 10:0:0:6: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   81.139115] scsi 10:0:0:3: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   81.139214] sd 10:0:0:3: Attached scsi generic sg12 type 0
[   81.139961] sd 10:0:0:5: [sde] Write Protect is off
[   81.139966] sd 10:0:0:5: [sde] Mode Sense: 69 00 00 08
[   81.140040] scsi 10:0:0:2: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   81.140140] sd 10:0:0:2: Attached scsi generic sg13 type 0
[   81.141186] sd 10:0:0:5: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   81.141377] scsi 10:0:0:15: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   81.141476] sd 10:0:0:15: Attached scsi generic sg14 type 0
[   81.142989] sd 10:0:0:4: [sdf] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   81.143224]  sdb: sdb1
[   81.144462]  sdc: sdc1
[   81.145161] sd 10:0:0:4: [sdf] Write Protect is off
[   81.145165] sd 10:0:0:4: [sdf] Mode Sense: 69 00 00 08
[   81.145604]  sdd: sdd1
[   81.146596] sd 10:0:0:4: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   81.146747] sd 10:0:0:3: [sdg] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   81.146775] sd 10:0:0:0: [sdb] Attached SCSI disk
[   81.147745] sd 10:0:0:7: [sdc] Attached SCSI disk
[   81.148132] sd 10:0:0:2: [sdh] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   81.148451] sd 10:0:0:3: [sdg] Write Protect is off
[   81.148455] sd 10:0:0:3: [sdg] Mode Sense: 69 00 00 08
[   81.148671] sd 10:0:0:15: [sdi] 268435456 512-byte logical blocks: (137 GB/128 GiB)
[   81.149135] sd 10:0:0:3: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   81.149535] sd 10:0:0:2: [sdh] Write Protect is off
[   81.149539] sd 10:0:0:2: [sdh] Mode Sense: 69 00 00 08
[   81.149557] sd 10:0:0:6: [sdd] Attached SCSI disk
[   81.149823] sd 10:0:0:15: [sdi] Write Protect is off
[   81.149827] sd 10:0:0:15: [sdi] Mode Sense: 69 00 00 08
[   81.150220]  sde: sde1
[   81.150397] sd 10:0:0:2: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   81.150543] sd 10:0:0:15: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   81.152696] sd 10:0:0:5: [sde] Attached SCSI disk
[   81.153696]  sdi: sdi1 sdi2
[   81.155018]  sdf: sdf1
[   81.156046]  sdg: sdg1
[   81.156625] sd 10:0:0:15: [sdi] Attached SCSI disk
[   81.157323]  sdh: sdh1
[   81.157476] sd 10:0:0:4: [sdf] Attached SCSI disk
[   81.159273] sd 10:0:0:3: [sdg] Attached SCSI disk
[   81.160147] sd 10:0:0:2: [sdh] Attached SCSI disk
[   93.185554] scsi 11:0:1:0: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   93.185690] sd 11:0:1:0: Attached scsi generic sg15 type 0
[   93.186866] scsi 11:0:1:7: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   93.186958] sd 11:0:1:7: Attached scsi generic sg16 type 0
[   93.187029] sd 11:0:1:0: [sdj] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   93.187513] scsi 11:0:1:6: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   93.187594] sd 11:0:1:6: Attached scsi generic sg17 type 0
[   93.187797] sd 11:0:1:7: [sdk] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   93.188254] scsi 11:0:1:5: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   93.188335] sd 11:0:1:5: Attached scsi generic sg18 type 0
[   93.188559] sd 11:0:1:0: [sdj] Write Protect is off
[   93.188563] sd 11:0:1:0: [sdj] Mode Sense: 69 00 00 08
[   93.188575] sd 11:0:1:6: [sdl] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   93.189030] scsi 11:0:1:4: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   93.189158] sd 11:0:1:4: Attached scsi generic sg19 type 0
[   93.189559] sd 11:0:1:7: [sdk] Write Protect is off
[   93.189563] sd 11:0:1:7: [sdk] Mode Sense: 69 00 00 08
[   93.189778] sd 11:0:1:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   93.190242] sd 11:0:1:7: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   93.190581] sd 11:0:1:5: [sdm] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   93.190593] scsi 11:0:1:3: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   93.190679] sd 11:0:1:3: Attached scsi generic sg20 type 0
[   93.191534] sd 11:0:1:6: [sdl] Write Protect is off
[   93.191538] sd 11:0:1:6: [sdl] Mode Sense: 69 00 00 08
[   93.191564] sd 11:0:1:4: [sdn] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   93.191663] scsi 11:0:1:2: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   93.191742] sd 11:0:1:2: Attached scsi generic sg21 type 0
[   93.192079] sd 11:0:1:5: [sdm] Write Protect is off
[   93.192083] sd 11:0:1:5: [sdm] Mode Sense: 69 00 00 08
[   93.192402] sd 11:0:1:6: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   93.192672] scsi 11:0:1:15: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   93.192754] sd 11:0:1:15: Attached scsi generic sg22 type 0
[   93.192939] sd 11:0:1:5: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   93.193086] sd 11:0:1:4: [sdn] Write Protect is off
[   93.193090] sd 11:0:1:4: [sdn] Mode Sense: 69 00 00 08
[   93.193768] sd 11:0:1:4: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   93.194166] sd 11:0:1:3: [sdo] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   93.196035] sd 11:0:1:3: [sdo] Write Protect is off
[   93.196040] sd 11:0:1:3: [sdo] Mode Sense: 69 00 00 08
[   93.196677] sd 11:0:1:2: [sdp] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   93.196951] sd 11:0:1:3: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   93.198547]  sdk: sdk1
[   93.198680] sd 11:0:1:2: [sdp] Write Protect is off
[   93.198684] sd 11:0:1:2: [sdp] Mode Sense: 69 00 00 08
[   93.200247] sd 11:0:1:2: [sdp] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   93.201373]  sdj: sdj1
[   93.202162] sd 11:0:1:15: [sdq] 268435456 512-byte logical blocks: (137 GB/128 GiB)
[   93.202811] sd 11:0:1:7: [sdk] Attached SCSI disk
[   93.203804]  sdm: sdm1
[   93.204079]  sdl: sdl1
[   93.204260] sd 11:0:1:15: [sdq] Write Protect is off
[   93.204264] sd 11:0:1:15: [sdq] Mode Sense: 69 00 00 08
[   93.205413] sd 11:0:1:15: [sdq] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   93.206188]  sdn: sdn1
[   93.206733] sd 11:0:1:0: [sdj] Attached SCSI disk
[   93.207435]  sdo: sdo1
[   93.208232] sd 11:0:1:6: [sdl] Attached SCSI disk
[   93.208393] sd 11:0:1:5: [sdm] Attached SCSI disk
[   93.209666]  sdq: sdq1 sdq2
[   93.209915]  sdp: sdp1
[   93.210554] sd 11:0:1:3: [sdo] Attached SCSI disk
[   93.211224] sd 11:0:1:4: [sdn] Attached SCSI disk
[   93.213350] sd 11:0:1:15: [sdq] Attached SCSI disk
[   93.213450] sd 11:0:1:2: [sdp] Attached SCSI disk
[   95.981911] type=1305 audit(1482315107.980:10): audit_pid=5513 old=0 auid=4294967295 ses=4294967295 res=1
[  108.021320] RPC: Registered named UNIX socket transport module.
[  108.021321] RPC: Registered udp transport module.
[  108.021322] RPC: Registered tcp transport module.
[  108.021323] RPC: Registered tcp NFSv4.1 backchannel transport module.
[  108.056519] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  108.736177] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[  108.736429] NFSD: starting 90-second grace period
[  110.346242] Fusion MPT base driver 4.28.00.01suse
[  110.346244] Copyright (c) 1999-2010 LSI Corporation
[  110.347304] Fusion MPT misc device (ioctl) driver 4.28.00.01suse
[  110.347334] mptctl: Registered with Fusion MPT base driver
[  110.347336] mptctl: /dev/mptctl @ (major,minor=10,220)
[  128.184307] st0: Block limits 4 - 1048576 bytes.
[  128.184891] st1: Block limits 4 - 1048576 bytes.
[  128.186614] st2: Block limits 4 - 1048576 bytes.
[  128.187098] st3: Block limits 4 - 1048576 bytes.
[  128.187589] st4: Block limits 4 - 1048576 bytes.
[  134.812165] st: Unloaded.
[  136.915083] st: Version 20110511, fixed bufsize 32768, s/g segs 256
[  136.915206] st 8:0:2:5: Attached scsi tape st0
[  136.915207] st 8:0:2:5: st0: try direct i/o: yes (alignment 4 B)
[  136.915297] st 8:0:2:4: Attached scsi tape st1
[  136.915298] st 8:0:2:4: st1: try direct i/o: yes (alignment 4 B)
[  136.915388] st 8:0:2:3: Attached scsi tape st2
[  136.915389] st 8:0:2:3: st2: try direct i/o: yes (alignment 4 B)
[  136.915480] st 8:0:2:2: Attached scsi tape st3
[  136.915481] st 8:0:2:2: st3: try direct i/o: yes (alignment 4 B)
[  136.915570] st 8:0:2:1: Attached scsi tape st4
[  136.915571] st 8:0:2:1: st4: try direct i/o: yes (alignment 4 B)
[  136.938347] licDriver: module loaded (major: 245)
[  139.272516] device-mapper: multipath: version 1.6.0 loaded
[  139.663173] device-mapper: multipath service-time: version 0.2.0 loaded
[  164.197569] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[  203.855452] Emulex LightPulse Fibre Channel SCSI driver 10.6.193.12.6fts
[  203.855454] Copyright(c) 2004-2015 Emulex.  All rights reserved.
[  203.878824] trc_m: kernel trace driver, version 0.0.1, numeric time zone 01 (1)
[  205.678380] fct4: ---vvv------------------ fct4_init ------------------vvv---
[  205.678652] fct4: Fibre Channel SLI4 series SCSI target-mode low level driver 0.0.3
[  205.678654] fct4: Copyright(c) 2004-2015 Emulex.  All rights reserved.
[  205.678655] fct4: Copyright(c) 2013-2015 Fujitsu Technology Solutions.
[  205.678656] fct4: operation mode selected: fcp_initiator [ fcp_target ] ficon
[  255.690797] st0: Block limits 4 - 1048576 bytes.
[  255.691163] st1: Block limits 4 - 1048576 bytes.
[  255.691492] st2: Block limits 4 - 1048576 bytes.
[  255.691816] st3: Block limits 4 - 1048576 bytes.
[  255.692148] st4: Block limits 4 - 1048576 bytes.
[  348.819335] bonding: Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
[  348.820183] bonding: SLAN00 is being created...
[  348.820854] bonding: SLAN00: Setting MII monitoring interval to 100.
[  348.822274] bonding: SLAN00: Setting up delay to 30000.
[  348.822642] bonding: SLAN00: setting mode to active-backup (1).
[  348.829327] bonding: SLAN00: Adding slave eth5.
[  348.832784] 8021q: adding VLAN 0 to HW filter on device eth5
[  348.832847] bonding: SLAN00: enslaving eth5 as a backup interface with a down link.
[  348.833590] e1000: eth5 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  348.881372] bonding: SLAN00: link status up for interface eth5, enabling it in 0 ms.
[  348.882105] 8021q: adding VLAN 0 to HW filter on device SLAN00
[  348.885120] bonding: SLAN00: link status definitely up for interface eth5, 1000 Mbps full duplex.
[  348.885122] bonding: SLAN00: making interface eth5 the new active one.
[  348.885628] bonding: SLAN00: first active interface up!
[  349.625395] 8021q: adding VLAN 0 to HW filter on device eth1
[  351.628467] e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  352.415719] 8021q: adding VLAN 0 to HW filter on device eth6
[  354.420657] e1000: eth6 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  355.175484] 8021q: adding VLAN 0 to HW filter on device eth7
[  357.180512] e1000: eth7 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  385.572635] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36632 PROTO=2 
[  514.220441] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36633 PROTO=2 
[  523.456757] e1000: eth7 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  555.564071] stg4: Fibre Channel SLI4 series SCSI target-mode emulation interface driver 0.0.1
[  602.838775] bootsplash: status on console 0 changed to on
[  642.866544] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36634 PROTO=2 

--------------D6A36D918608DB4351EDF485
Content-Type: text/plain; charset=UTF-8;
 name="dmesg-2.8.0.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg-2.8.0.txt"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.0.101-80-default (geeko@buildhost) (gcc version 4.3.4 [gcc-4_3-branch revision 152973] (SUSE Linux) ) #1 SMP Fri Jul 15 14:30:41 UTC 2016 (eb2ba81)
[    0.000000] Command line: root=/dev/disk/by-id/scsi-0FTS_PRAID_EP420i_SDA-part7 linux_x86_64 nmi_watchdog=0 resume=/dev/disk/by-id/scsi-0FTS_PRAID_EP420i_SDA-part5 splash=silent audit=1 vga=0x318 crashkernel=128M@64M tsc=reliable elevator=noop
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007ffdf000 (usable)
[    0.000000]  BIOS-e820: 000000007ffdf000 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000b0000000 - 00000000c0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
[    0.000000]  BIOS-e820: 00000000feffc000 - 00000000ff000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000380000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.8 present.
[    0.000000] DMI: FUJITSU PRIMERGY RX300 S8/D2939-B1, BIOS V4.6.5.4 R1.14.0 for D2939-B1x 10/13/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x380000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00C0000000 mask FFC0000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT not supported by CPU.
[    0.000000] last_pfn = 0x7ffdf max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [ffff8800000f6ad0] f6ad0
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff88000009a000] 9a000 size 20480
[    0.000000] init_memory_mapping: 0000000000000000-000000007ffdf000
[    0.000000]  0000000000 - 007fe00000 page 2M
[    0.000000]  007fe00000 - 007ffdf000 page 4k
[    0.000000] kernel direct mapping tables up to 0x7ffdefff @ [mem 0x1fffc000-0x1fffffff]
[    0.000000] init_memory_mapping: 0000000100000000-0000000380000000
[    0.000000]  0100000000 - 0380000000 page 2M
[    0.000000] kernel direct mapping tables up to 0x37fffffff @ [mem 0x7ffd4000-0x7ffdefff]
[    0.000000] nmi ring buffer: 262144
[    0.000000] RAMDISK: 37a51000 - 37ff0000
[    0.000000] Reserving 128MB of memory at 64MB for crashkernel (System RAM: 14336MB)
[    0.000000] ACPI: RSDP 00000000000f6a80 00014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 000000007ffe20b7 00034 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACP 000000007ffe1f4f 00074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 000000007ffdfc00 0234F (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACS 000000007ffdfbc0 00040
[    0.000000] ACPI: APIC 000000007ffe1fc3 00080 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.000000] ACPI: HPET 000000007ffe2043 00038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.000000] ACPI: MCFG 000000007ffe207b 0003C (v01 BOCHS  BXPCMCFG 00000001 BXPC 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000380000000
[    0.000000] Initmem setup node 0 0000000000000000-0000000380000000
[    0.000000]   NODE_DATA [000000037ff99000 - 000000037ffbffff]
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 0:1bef801, boot clock
[    0.000000]  [ffffea0000000000-ffffea000c3fffff] PMD -> [ffff880373600000-ffff88037ddfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00380000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0007ffdf
[    0.000000]     0: 0x00100000 -> 0x00380000
[    0.000000] On node 0 totalpages: 3145582
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3922 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 505879 pages, LIFO batch:31
[    0.000000]   Normal zone: 35840 pages used for memmap
[    0.000000]   Normal zone: 2585600 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 40
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000f0000
[    0.000000] PM: Registered nosave memory: 00000000000f0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 000000007ffdf000 - 0000000080000000
[    0.000000] PM: Registered nosave memory: 0000000080000000 - 00000000b0000000
[    0.000000] PM: Registered nosave memory: 00000000b0000000 - 00000000c0000000
[    0.000000] PM: Registered nosave memory: 00000000c0000000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed20000
[    0.000000] PM: Registered nosave memory: 00000000fed20000 - 00000000feffc000
[    0.000000] PM: Registered nosave memory: 00000000feffc000 - 00000000ff000000
[    0.000000] PM: Registered nosave memory: 00000000ff000000 - 00000000fffc0000
[    0.000000] PM: Registered nosave memory: 00000000fffc0000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at c0000000 (gap: c0000000:3ed1c000)
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] setup_percpu: NR_CPUS:4096 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
[    0.000000] PERCPU: Embedded 25 pages/cpu @ffff88037fc00000 s71680 r8192 d22528 u1048576
[    0.000000] pcpu-alloc: s71680 r8192 d22528 u1048576 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 
[    0.000000] kvm-clock: cpu 0, msr 3:7fc10801, primary cpu clock
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 3095401
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=/dev/disk/by-id/scsi-0FTS_PRAID_EP420i_SDA-part7 linux_x86_64 nmi_watchdog=0 resume=/dev/disk/by-id/scsi-0FTS_PRAID_EP420i_SDA-part5 splash=silent audit=1 vga=0x318 crashkernel=128M@64M tsc=reliable elevator=noop
[    0.000000] bootsplash: silent mode.
[    0.000000] audit: enabled (after initialization)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Memory: 12190176k/14680064k available (4566k kernel code, 2097736k absent, 392152k reserved, 7581k data, 1360k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:262400 nr_irqs:512 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 100663296 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Detected 2594.014 MHz processor.
[    0.008000] Calibrating delay loop (skipped) preset value.. 5188.02 BogoMIPS (lpj=10376056)
[    0.008000] pid_max: default: 32768 minimum: 301
[    0.008000] kdb version 4.4 by Keith Owens, Scott Lurndal. Copyright SGI, All Rights Reserved
[    0.008000] Security Framework initialized
[    0.008000] AppArmor: AppArmor initialized
[    0.008000] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.008210] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.009498] Mount-cache hash table entries: 256
[    0.009584] Initializing cgroup subsys cpuacct
[    0.009587] Initializing cgroup subsys memory
[    0.009594] Initializing cgroup subsys devices
[    0.009596] Initializing cgroup subsys freezer
[    0.009597] Initializing cgroup subsys net_cls
[    0.009599] Initializing cgroup subsys blkio
[    0.009602] Initializing cgroup subsys perf_event
[    0.009659] CPU: Physical Processor ID: 0
[    0.009669] mce: CPU supports 10 MCE banks
[    0.011306] ACPI: Core revision 20110413
[    0.012226] Enabling x2apic
[    0.012233] Enabled x2apic
[    0.012441] Switched APIC routing to physical x2apic.
[    0.013212] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.013214] CPU0: Intel QEMU Virtual CPU version 2.5+ stepping 03
[    0.016000] Performance Events: Broken PMU hardware detected, using software events only.
[    0.016000] Failed to access perfctr msr (MSR c1 is 0)
[    0.016000] Booting Node   0, Processors  #1 Ok.
[    0.024005] kvm-clock: cpu 1, msr 3:7fd10801, secondary cpu clock
[    0.024017] Brought up 2 CPUs
[    0.024015] KVM setup async PF for cpu 1
[    0.024023] Total of 2 processors activated (10376.05 BogoMIPS).
[    0.024342] devtmpfs: initialized
[    0.030473] print_constraints: dummy: 
[    0.030473] Time:  6:44:40  Date: 12/21/16
[    0.030473] NET: Registered protocol family 16
[    0.030473] ACPI: bus type pci registered
[    0.030473] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xb0000000-0xbfffffff] (base 0xb0000000)
[    0.030473] PCI: MMCONFIG at [mem 0xb0000000-0xbfffffff] reserved in E820
[    0.033065] PCI: Using configuration type 1 for base access
[    0.033712] bio: create slab <bio-0> at 0
[    0.033712] ACPI: EC: Look up EC in DSDT
[    0.040191] ACPI: Interpreter enabled
[    0.040196] ACPI: (supports S0 S3 S4 S5)
[    0.040214] ACPI: Using IOAPIC for interrupt routing
[    0.042725] ACPI: No dock devices found.
[    0.042730] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.042800] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.042837] pci_root PNP0A08:00: host bridge window [io  0x0000-0x0cf7]
[    0.042840] pci_root PNP0A08:00: host bridge window [io  0x0d00-0xffff]
[    0.042843] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    0.042846] pci_root PNP0A08:00: host bridge window [mem 0xc0000000-0xfebfffff]
[    0.042883] pci 0000:00:00.0: [8086:29c0] type 0 class 0x000600
[    0.043215] pci 0000:00:01.0: [8086:3420] type 1 class 0x000604
[    0.052442] pci 0000:00:02.0: [8086:3420] type 1 class 0x000604
[    0.062689] pci 0000:00:03.0: [8086:3420] type 1 class 0x000604
[    0.069744] pci 0000:00:04.0: [8086:100f] type 0 class 0x000200
[    0.073449] pci 0000:00:04.0: reg 10: [mem 0xfe980000-0xfe99ffff]
[    0.080033] pci 0000:00:04.0: reg 14: [io  0xb100-0xb13f]
[    0.113881] pci 0000:00:04.0: reg 30: [mem 0xfe800000-0xfe83ffff pref]
[    0.116119] pci 0000:00:05.0: [8086:3420] type 1 class 0x000604
[    0.122206] pci 0000:00:06.0: [1000:0079] type 0 class 0x000104
[    0.125627] pci 0000:00:06.0: reg 10: [io  0xb000-0xb0ff]
[    0.132047] pci 0000:00:06.0: reg 14: [mem 0xfea30000-0xfea33fff 64bit]
[    0.140037] pci 0000:00:06.0: reg 1c: [mem 0xfe840000-0xfe87ffff 64bit]
[    0.154913] pci 0000:00:0b.0: [1af4:1050] type 0 class 0x000300
[    0.156036] pci 0000:00:0b.0: reg 10: [mem 0xfb000000-0xfb7fffff pref]
[    0.170655] pci 0000:00:0b.0: reg 18: [mem 0xfcc00000-0xfcc03fff 64bit pref]
[    0.177541] pci 0000:00:0b.0: reg 20: [mem 0xfea34000-0xfea34fff]
[    0.189638] pci 0000:00:0b.0: reg 30: [mem 0xfea20000-0xfea2ffff pref]
[    0.192480] pci 0000:00:10.0: [8086:100f] type 0 class 0x000200
[    0.194252] pci 0000:00:10.0: reg 10: [mem 0xfe9a0000-0xfe9bffff]
[    0.197741] pci 0000:00:10.0: reg 14: [io  0xb140-0xb17f]
[    0.217809] pci 0000:00:10.0: reg 30: [mem 0xfe880000-0xfe8bffff pref]
[    0.220113] pci 0000:00:11.0: [8086:100f] type 0 class 0x000200
[    0.221926] pci 0000:00:11.0: reg 10: [mem 0xfe9c0000-0xfe9dffff]
[    0.228381] pci 0000:00:11.0: reg 14: [io  0xb180-0xb1bf]
[    0.248039] pci 0000:00:11.0: reg 30: [mem 0xfe8c0000-0xfe8fffff pref]
[    0.250017] pci 0000:00:12.0: [8086:100f] type 0 class 0x000200
[    0.253737] pci 0000:00:12.0: reg 10: [mem 0xfe9e0000-0xfe9fffff]
[    0.257938] pci 0000:00:12.0: reg 14: [io  0xb1c0-0xb1ff]
[    0.280028] pci 0000:00:12.0: reg 30: [mem 0xfe900000-0xfe93ffff pref]
[    0.281967] pci 0000:00:13.0: [8086:100f] type 0 class 0x000200
[    0.284038] pci 0000:00:13.0: reg 10: [mem 0xfea00000-0xfea1ffff]
[    0.288037] pci 0000:00:13.0: reg 14: [io  0xb200-0xb23f]
[    0.310039] pci 0000:00:13.0: reg 30: [mem 0xfe940000-0xfe97ffff pref]
[    0.312162] pci 0000:00:1e.0: [8086:244e] type 1 class 0x000604
[    0.320191] pci 0000:00:1f.0: [8086:2918] type 0 class 0x000601
[    0.320522] pci 0000:00:1f.2: [8086:2922] type 0 class 0x000106
[    0.337890] pci 0000:00:1f.2: reg 20: [io  0xb280-0xb29f]
[    0.344030] pci 0000:00:1f.2: reg 24: [mem 0xfea35000-0xfea35fff]
[    0.350095] pci 0000:00:1f.3: [8086:2930] type 0 class 0x000c05
[    0.360046] pci 0000:00:1f.3: reg 20: [io  0x0700-0x073f]
[    0.366216] pci 0000:01:00.0: [1af4:1048] type 0 class 0x000100
[    0.372048] pci 0000:01:00.0: reg 14: [mem 0xfe600000-0xfe600fff]
[    0.385830] pci 0000:01:00.0: reg 20: [mem 0xfca00000-0xfca03fff 64bit pref]
[    0.392259] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.392279] pci 0000:00:01.0:   bridge window [io  0xa000-0xafff]
[    0.392290] pci 0000:00:01.0:   bridge window [mem 0xfe600000-0xfe7fffff]
[    0.392320] pci 0000:00:01.0:   bridge window [mem 0xfca00000-0xfcbfffff 64bit pref]
[    0.396043] pci 0000:02:00.0: [1000:0012] type 0 class 0x000100
[    0.398657] pci 0000:02:00.0: reg 10: [io  0x9000-0x90ff]
[    0.404047] pci 0000:02:00.0: reg 14: [mem 0xfe402000-0xfe4023ff]
[    0.412043] pci 0000:02:00.0: reg 18: [mem 0xfe400000-0xfe401fff]
[    0.438732] pci 0000:00:02.0: PCI bridge to [bus 02-02]
[    0.438749] pci 0000:00:02.0:   bridge window [io  0x9000-0x9fff]
[    0.438758] pci 0000:00:02.0:   bridge window [mem 0xfe400000-0xfe5fffff]
[    0.438776] pci 0000:00:02.0:   bridge window [mem 0xfc800000-0xfc9fffff 64bit pref]
[    0.441289] pci 0000:03:00.0: [1af4:1043] type 0 class 0x000780
[    0.445667] pci 0000:03:00.0: reg 14: [mem 0xfe200000-0xfe200fff]
[    0.459414] pci 0000:03:00.0: reg 20: [mem 0xfc600000-0xfc603fff 64bit pref]
[    0.468658] pci 0000:00:03.0: PCI bridge to [bus 03-03]
[    0.468685] pci 0000:00:03.0:   bridge window [io  0x8000-0x8fff]
[    0.468696] pci 0000:00:03.0:   bridge window [mem 0xfe200000-0xfe3fffff]
[    0.468729] pci 0000:00:03.0:   bridge window [mem 0xfc600000-0xfc7fffff 64bit pref]
[    0.471320] pci 0000:04:00.0: [1af4:1045] type 0 class 0x0000ff
[    0.482206] pci 0000:04:00.0: reg 20: [mem 0xfc400000-0xfc403fff 64bit pref]
[    0.485681] pci 0000:00:05.0: PCI bridge to [bus 04-04]
[    0.485696] pci 0000:00:05.0:   bridge window [io  0x7000-0x7fff]
[    0.485707] pci 0000:00:05.0:   bridge window [mem 0xfe000000-0xfe1fffff]
[    0.485728] pci 0000:00:05.0:   bridge window [mem 0xfc400000-0xfc5fffff 64bit pref]
[    0.489441] pci 0000:05:00.0: [1b36:0001] type 1 class 0x000604
[    0.492075] pci 0000:05:00.0: reg 10: [mem 0xfde00000-0xfde000ff 64bit]
[    0.498544] pci 0000:05:01.0: [1b36:0001] type 1 class 0x000604
[    0.501523] pci 0000:05:01.0: reg 10: [mem 0xfde01000-0xfde010ff 64bit]
[    0.508394] pci 0000:05:02.0: [1b36:0001] type 1 class 0x000604
[    0.510626] pci 0000:05:02.0: reg 10: [mem 0xfde02000-0xfde020ff 64bit]
[    0.518467] pci 0000:05:03.0: [1b36:0001] type 1 class 0x000604
[    0.520077] pci 0000:05:03.0: reg 10: [mem 0xfde03000-0xfde030ff 64bit]
[    0.528389] pci 0000:05:04.0: [1b36:0001] type 1 class 0x000604
[    0.532077] pci 0000:05:04.0: reg 10: [mem 0xfde04000-0xfde040ff 64bit]
[    0.540239] pci 0000:05:05.0: [1b36:0001] type 1 class 0x000604
[    0.542322] pci 0000:05:05.0: reg 10: [mem 0xfde05000-0xfde050ff 64bit]
[    0.548448] pci 0000:00:1e.0: PCI bridge to [bus 05-0b] (subtractive decode)
[    0.548464] pci 0000:00:1e.0:   bridge window [io  0x1000-0x6fff]
[    0.548475] pci 0000:00:1e.0:   bridge window [mem 0xfd200000-0xfdffffff]
[    0.548496] pci 0000:00:1e.0:   bridge window [mem 0xfb800000-0xfc3fffff 64bit pref]
[    0.548499] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (subtractive decode)
[    0.548500] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff] (subtractive decode)
[    0.548502] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.548504] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xfebfffff] (subtractive decode)
[    0.551370] pci 0000:05:00.0: PCI bridge to [bus 06-06]
[    0.551384] pci 0000:05:00.0:   bridge window [io  0x6000-0x6fff]
[    0.551409] pci 0000:05:00.0:   bridge window [mem 0xfdc00000-0xfddfffff]
[    0.551430] pci 0000:05:00.0:   bridge window [mem 0xfc200000-0xfc3fffff 64bit pref]
[    0.553517] pci 0000:05:01.0: PCI bridge to [bus 07-07]
[    0.553531] pci 0000:05:01.0:   bridge window [io  0x5000-0x5fff]
[    0.553543] pci 0000:05:01.0:   bridge window [mem 0xfda00000-0xfdbfffff]
[    0.553565] pci 0000:05:01.0:   bridge window [mem 0xfc000000-0xfc1fffff 64bit pref]
[    0.556243] pci 0000:08:01.0: [8086:100f] type 0 class 0x000200
[    0.558311] pci 0000:08:01.0: reg 10: [mem 0xfd840000-0xfd85ffff]
[    0.564276] pci 0000:08:01.0: reg 14: [io  0x4000-0x403f]
[    0.589873] pci 0000:08:01.0: reg 30: [mem 0xfd800000-0xfd83ffff pref]
[    0.592452] pci 0000:05:02.0: PCI bridge to [bus 08-08]
[    0.592493] pci 0000:05:02.0:   bridge window [io  0x4000-0x4fff]
[    0.592521] pci 0000:05:02.0:   bridge window [mem 0xfd800000-0xfd9fffff]
[    0.592555] pci 0000:05:02.0:   bridge window [mem 0xfbe00000-0xfbffffff 64bit pref]
[    0.596607] pci 0000:05:03.0: PCI bridge to [bus 09-09]
[    0.596619] pci 0000:05:03.0:   bridge window [io  0x3000-0x3fff]
[    0.596641] pci 0000:05:03.0:   bridge window [mem 0xfd600000-0xfd7fffff]
[    0.596668] pci 0000:05:03.0:   bridge window [mem 0xfbc00000-0xfbdfffff 64bit pref]
[    0.601936] pci 0000:0a:01.0: [8086:100f] type 0 class 0x000200
[    0.604088] pci 0000:0a:01.0: reg 10: [mem 0xfd440000-0xfd45ffff]
[    0.612066] pci 0000:0a:01.0: reg 14: [io  0x2000-0x203f]
[    0.633912] pci 0000:0a:01.0: reg 30: [mem 0xfd400000-0xfd43ffff pref]
[    0.636213] pci 0000:05:04.0: PCI bridge to [bus 0a-0a]
[    0.636226] pci 0000:05:04.0:   bridge window [io  0x2000-0x2fff]
[    0.636236] pci 0000:05:04.0:   bridge window [mem 0xfd400000-0xfd5fffff]
[    0.636254] pci 0000:05:04.0:   bridge window [mem 0xfba00000-0xfbbfffff 64bit pref]
[    0.638454] pci 0000:0b:01.0: [8086:100f] type 0 class 0x000200
[    0.641528] pci 0000:0b:01.0: reg 10: [mem 0xfd240000-0xfd25ffff]
[    0.645854] pci 0000:0b:01.0: reg 14: [io  0x1000-0x103f]
[    0.667521] pci 0000:0b:01.0: reg 30: [mem 0xfd200000-0xfd23ffff pref]
[    0.668264] pci 0000:05:05.0: PCI bridge to [bus 0b-0b]
[    0.668280] pci 0000:05:05.0:   bridge window [io  0x1000-0x1fff]
[    0.668292] pci 0000:05:05.0:   bridge window [mem 0xfd200000-0xfd3fffff]
[    0.668314] pci 0000:05:05.0:   bridge window [mem 0xfb800000-0xfb9fffff 64bit pref]
[    0.699445] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.700487]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.700564]  pci0000:00: ACPI _OSC control (0x1d) granted
[    0.704353] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.704432] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.704491] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.704547] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.704602] ACPI: PCI Interrupt Link [LNKE] (IRQs 5 *10 11)
[    0.704657] ACPI: PCI Interrupt Link [LNKF] (IRQs 5 *10 11)
[    0.704712] ACPI: PCI Interrupt Link [LNKG] (IRQs 5 10 *11)
[    0.704773] ACPI: PCI Interrupt Link [LNKH] (IRQs 5 10 *11)
[    0.704804] ACPI: PCI Interrupt Link [GSIA] (IRQs *16)
[    0.704814] ACPI: PCI Interrupt Link [GSIB] (IRQs *17)
[    0.704824] ACPI: PCI Interrupt Link [GSIC] (IRQs *18)
[    0.704833] ACPI: PCI Interrupt Link [GSID] (IRQs *19)
[    0.704854] ACPI: PCI Interrupt Link [GSIE] (IRQs *20)
[    0.704863] ACPI: PCI Interrupt Link [GSIF] (IRQs *21)
[    0.704873] ACPI: PCI Interrupt Link [GSIG] (IRQs *22)
[    0.704883] ACPI: PCI Interrupt Link [GSIH] (IRQs *23)
[    0.704953] vgaarb: device added: PCI:0000:00:0b.0,decodes=io+mem,owns=io+mem,locks=none
[    0.704961] vgaarb: loaded
[    0.705044] PCI: Using ACPI for IRQ routing
[    0.740685] PCI: pci_cache_line_size set to 64 bytes
[    0.740955] reserve RAM buffer: 000000000009fc00 - 000000000009ffff 
[    0.740957] reserve RAM buffer: 000000007ffdf000 - 000000007fffffff 
[    0.741021] NetLabel: Initializing
[    0.741023] NetLabel:  domain hash size = 128
[    0.741024] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.741032] NetLabel:  unlabeled traffic allowed by default
[    0.741048] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.741059] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.741062] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.748062] Switching to clocksource kvm-clock
[    0.748856] AppArmor: AppArmor Filesystem Enabled
[    0.748872] pnp: PnP ACPI init
[    0.748881] ACPI: bus type pnp registered
[    0.748897] pnp 00:00: [bus 00-ff]
[    0.748899] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.748900] pnp 00:00: [io  0x0000-0x0cf7 window]
[    0.748901] pnp 00:00: [io  0x0d00-0xffff window]
[    0.748902] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.748904] pnp 00:00: [mem 0xc0000000-0xfebfffff window]
[    0.748932] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.748940] pnp 00:01: [io  0x0070-0x0071]
[    0.748961] pnp 00:01: [irq 8]
[    0.748963] pnp 00:01: [io  0x0072-0x0077]
[    0.748977] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.748993] pnp 00:02: [io  0x0060]
[    0.748994] pnp 00:02: [io  0x0064]
[    0.749005] pnp 00:02: [irq 1]
[    0.749020] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.749039] pnp 00:03: [irq 12]
[    0.749051] pnp 00:03: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.749103] pnp 00:04: [io  0x03f8-0x03ff]
[    0.749124] pnp 00:04: [irq 4]
[    0.749139] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.749163] pnp 00:05: [io  0x0cd8-0x0ce3]
[    0.749175] pnp 00:05: Plug and Play ACPI device, IDs PNP0a06 (active)
[    0.749200] pnp 00:06: [io  0x0620-0x062f]
[    0.749214] pnp 00:06: Plug and Play ACPI device, IDs PNP0a06 (active)
[    0.749271] pnp 00:07: [mem 0xfed00000-0xfed003ff]
[    0.749288] pnp 00:07: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.749434] pnp: PnP ACPI: found 8 devices
[    0.749436] ACPI: ACPI bus type pnp unregistered
[    0.754677] PCI: max bus depth: 2 pci_try_num: 3
[    0.784319] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    0.784331] pci 0000:00:01.0:   bridge window [io  0xa000-0xafff]
[    0.787172] pci 0000:00:01.0:   bridge window [mem 0xfe600000-0xfe7fffff]
[    0.789881] pci 0000:00:01.0:   bridge window [mem 0xfca00000-0xfcbfffff 64bit pref]
[    0.794876] pci 0000:00:02.0: PCI bridge to [bus 02-02]
[    0.794888] pci 0000:00:02.0:   bridge window [io  0x9000-0x9fff]
[    0.797674] pci 0000:00:02.0:   bridge window [mem 0xfe400000-0xfe5fffff]
[    0.799722] pci 0000:00:02.0:   bridge window [mem 0xfc800000-0xfc9fffff 64bit pref]
[    0.805616] pci 0000:00:03.0: PCI bridge to [bus 03-03]
[    0.805632] pci 0000:00:03.0:   bridge window [io  0x8000-0x8fff]
[    0.808795] pci 0000:00:03.0:   bridge window [mem 0xfe200000-0xfe3fffff]
[    0.810937] pci 0000:00:03.0:   bridge window [mem 0xfc600000-0xfc7fffff 64bit pref]
[    0.815292] pci 0000:00:05.0: PCI bridge to [bus 04-04]
[    0.815315] pci 0000:00:05.0:   bridge window [io  0x7000-0x7fff]
[    0.819725] pci 0000:00:05.0:   bridge window [mem 0xfe000000-0xfe1fffff]
[    0.821595] pci 0000:00:05.0:   bridge window [mem 0xfc400000-0xfc5fffff 64bit pref]
[    0.825467] pci 0000:05:00.0: PCI bridge to [bus 06-06]
[    0.825480] pci 0000:05:00.0:   bridge window [io  0x6000-0x6fff]
[    0.829061] pci 0000:05:00.0:   bridge window [mem 0xfdc00000-0xfddfffff]
[    0.832554] pci 0000:05:00.0:   bridge window [mem 0xfc200000-0xfc3fffff 64bit pref]
[    0.836455] pci 0000:05:01.0: PCI bridge to [bus 07-07]
[    0.836468] pci 0000:05:01.0:   bridge window [io  0x5000-0x5fff]
[    0.839439] pci 0000:05:01.0:   bridge window [mem 0xfda00000-0xfdbfffff]
[    0.841390] pci 0000:05:01.0:   bridge window [mem 0xfc000000-0xfc1fffff 64bit pref]
[    0.846546] pci 0000:05:02.0: PCI bridge to [bus 08-08]
[    0.846559] pci 0000:05:02.0:   bridge window [io  0x4000-0x4fff]
[    0.849218] pci 0000:05:02.0:   bridge window [mem 0xfd800000-0xfd9fffff]
[    0.851026] pci 0000:05:02.0:   bridge window [mem 0xfbe00000-0xfbffffff 64bit pref]
[    0.855970] pci 0000:05:03.0: PCI bridge to [bus 09-09]
[    0.855983] pci 0000:05:03.0:   bridge window [io  0x3000-0x3fff]
[    0.858800] pci 0000:05:03.0:   bridge window [mem 0xfd600000-0xfd7fffff]
[    0.860601] pci 0000:05:03.0:   bridge window [mem 0xfbc00000-0xfbdfffff 64bit pref]
[    0.864690] pci 0000:05:04.0: PCI bridge to [bus 0a-0a]
[    0.864716] pci 0000:05:04.0:   bridge window [io  0x2000-0x2fff]
[    0.869253] pci 0000:05:04.0:   bridge window [mem 0xfd400000-0xfd5fffff]
[    0.871121] pci 0000:05:04.0:   bridge window [mem 0xfba00000-0xfbbfffff 64bit pref]
[    0.874685] pci 0000:05:05.0: PCI bridge to [bus 0b-0b]
[    0.874697] pci 0000:05:05.0:   bridge window [io  0x1000-0x1fff]
[    0.877806] pci 0000:05:05.0:   bridge window [mem 0xfd200000-0xfd3fffff]
[    0.881138] pci 0000:05:05.0:   bridge window [mem 0xfb800000-0xfb9fffff 64bit pref]
[    0.884715] pci 0000:00:1e.0: PCI bridge to [bus 05-0b]
[    0.884728] pci 0000:00:1e.0:   bridge window [io  0x1000-0x6fff]
[    0.887539] pci 0000:00:1e.0:   bridge window [mem 0xfd200000-0xfdffffff]
[    0.889363] pci 0000:00:1e.0:   bridge window [mem 0xfb800000-0xfc3fffff 64bit pref]
[    0.894287] ACPI: PCI Interrupt Link [GSIF] enabled at IRQ 21
[    0.894313] pci 0000:00:01.0: PCI INT A -> Link[GSIF] -> GSI 21 (level, high) -> IRQ 21
[    0.896267] pci 0000:00:01.0: setting latency timer to 64
[    0.896292] ACPI: PCI Interrupt Link [GSIG] enabled at IRQ 22
[    0.896310] pci 0000:00:02.0: PCI INT A -> Link[GSIG] -> GSI 22 (level, high) -> IRQ 22
[    0.898534] pci 0000:00:02.0: setting latency timer to 64
[    0.898557] ACPI: PCI Interrupt Link [GSIH] enabled at IRQ 23
[    0.898572] pci 0000:00:03.0: PCI INT A -> Link[GSIH] -> GSI 23 (level, high) -> IRQ 23
[    0.902299] pci 0000:00:03.0: setting latency timer to 64
[    0.902316] pci 0000:00:05.0: PCI INT A -> Link[GSIF] -> GSI 21 (level, high) -> IRQ 21
[    0.904968] pci 0000:00:05.0: setting latency timer to 64
[    0.907883] pci 0000:00:1e.0: setting latency timer to 64
[    0.907912] ACPI: PCI Interrupt Link [GSIE] enabled at IRQ 20
[    0.907931] pci 0000:05:00.0: PCI INT A -> Link[GSIE] -> GSI 20 (level, high) -> IRQ 20
[    0.911001] pci 0000:05:00.0: setting latency timer to 64
[    0.911016] pci 0000:05:01.0: PCI INT A -> Link[GSIF] -> GSI 21 (level, high) -> IRQ 21
[    0.914849] pci 0000:05:01.0: setting latency timer to 64
[    0.916543] pci 0000:05:02.0: PCI INT A -> Link[GSIG] -> GSI 22 (level, high) -> IRQ 22
[    0.920011] pci 0000:05:02.0: setting latency timer to 64
[    0.920025] pci 0000:05:03.0: PCI INT A -> Link[GSIH] -> GSI 23 (level, high) -> IRQ 23
[    0.924148] pci 0000:05:03.0: setting latency timer to 64
[    0.924162] pci 0000:05:04.0: PCI INT A -> Link[GSIE] -> GSI 20 (level, high) -> IRQ 20
[    0.928087] pci 0000:05:04.0: setting latency timer to 64
[    0.929779] pci 0000:05:05.0: PCI INT A -> Link[GSIF] -> GSI 21 (level, high) -> IRQ 21
[    0.933839] pci 0000:05:05.0: setting latency timer to 64
[    0.933847] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[    0.933848] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
[    0.933849] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
[    0.933850] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff]
[    0.933852] pci_bus 0000:01: resource 0 [io  0xa000-0xafff]
[    0.933853] pci_bus 0000:01: resource 1 [mem 0xfe600000-0xfe7fffff]
[    0.933854] pci_bus 0000:01: resource 2 [mem 0xfca00000-0xfcbfffff 64bit pref]
[    0.933855] pci_bus 0000:02: resource 0 [io  0x9000-0x9fff]
[    0.933857] pci_bus 0000:02: resource 1 [mem 0xfe400000-0xfe5fffff]
[    0.933858] pci_bus 0000:02: resource 2 [mem 0xfc800000-0xfc9fffff 64bit pref]
[    0.933859] pci_bus 0000:03: resource 0 [io  0x8000-0x8fff]
[    0.933860] pci_bus 0000:03: resource 1 [mem 0xfe200000-0xfe3fffff]
[    0.933861] pci_bus 0000:03: resource 2 [mem 0xfc600000-0xfc7fffff 64bit pref]
[    0.933863] pci_bus 0000:04: resource 0 [io  0x7000-0x7fff]
[    0.933864] pci_bus 0000:04: resource 1 [mem 0xfe000000-0xfe1fffff]
[    0.933865] pci_bus 0000:04: resource 2 [mem 0xfc400000-0xfc5fffff 64bit pref]
[    0.933867] pci_bus 0000:05: resource 0 [io  0x1000-0x6fff]
[    0.933868] pci_bus 0000:05: resource 1 [mem 0xfd200000-0xfdffffff]
[    0.933869] pci_bus 0000:05: resource 2 [mem 0xfb800000-0xfc3fffff 64bit pref]
[    0.933870] pci_bus 0000:05: resource 4 [io  0x0000-0x0cf7]
[    0.933871] pci_bus 0000:05: resource 5 [io  0x0d00-0xffff]
[    0.933872] pci_bus 0000:05: resource 6 [mem 0x000a0000-0x000bffff]
[    0.933873] pci_bus 0000:05: resource 7 [mem 0xc0000000-0xfebfffff]
[    0.933874] pci_bus 0000:06: resource 0 [io  0x6000-0x6fff]
[    0.933875] pci_bus 0000:06: resource 1 [mem 0xfdc00000-0xfddfffff]
[    0.933877] pci_bus 0000:06: resource 2 [mem 0xfc200000-0xfc3fffff 64bit pref]
[    0.933878] pci_bus 0000:07: resource 0 [io  0x5000-0x5fff]
[    0.933879] pci_bus 0000:07: resource 1 [mem 0xfda00000-0xfdbfffff]
[    0.933880] pci_bus 0000:07: resource 2 [mem 0xfc000000-0xfc1fffff 64bit pref]
[    0.933881] pci_bus 0000:08: resource 0 [io  0x4000-0x4fff]
[    0.933882] pci_bus 0000:08: resource 1 [mem 0xfd800000-0xfd9fffff]
[    0.933883] pci_bus 0000:08: resource 2 [mem 0xfbe00000-0xfbffffff 64bit pref]
[    0.933885] pci_bus 0000:09: resource 0 [io  0x3000-0x3fff]
[    0.933886] pci_bus 0000:09: resource 1 [mem 0xfd600000-0xfd7fffff]
[    0.933887] pci_bus 0000:09: resource 2 [mem 0xfbc00000-0xfbdfffff 64bit pref]
[    0.933888] pci_bus 0000:0a: resource 0 [io  0x2000-0x2fff]
[    0.933889] pci_bus 0000:0a: resource 1 [mem 0xfd400000-0xfd5fffff]
[    0.933890] pci_bus 0000:0a: resource 2 [mem 0xfba00000-0xfbbfffff 64bit pref]
[    0.933891] pci_bus 0000:0b: resource 0 [io  0x1000-0x1fff]
[    0.933892] pci_bus 0000:0b: resource 1 [mem 0xfd200000-0xfd3fffff]
[    0.933893] pci_bus 0000:0b: resource 2 [mem 0xfb800000-0xfb9fffff 64bit pref]
[    0.934137] NET: Registered protocol family 2
[    0.934476] IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.935335] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.936309] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.936366] TCP: Hash tables configured (established 524288 bind 65536)
[    0.936368] TCP reno registered
[    0.936379] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    0.936578] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    0.936663] NET: Registered protocol family 1
[    0.936722] pci 0000:00:0b.0: Boot video device
[    0.936835] PCI: CLS 0 bytes, default 64
[    0.936860] Unpacking initramfs...
[    1.008998] Freeing initrd memory: 5756k freed
[    1.009506] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.009511] Placing 64MB software IO TLB between ffff88007bfd4000 - ffff88007ffd4000
[    1.009514] software IO TLB at phys 0x7bfd4000 - 0x7ffd4000
[    1.010012] futex hash table entries: 512 (order: 4, 65536 bytes)
[    1.010021] Initialise module verification
[    1.010110] audit: initializing netlink socket (enabled)
[    1.010120] type=2000 audit(1482299081.004:1): initialized
[    1.027465] bounce pool size: 64 pages
[    1.027472] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.028795] VFS: Disk quotas dquot_6.5.2
[    1.028828] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.029085] msgmni has been set to 5955
[    1.029234] alg: No test for stdrng (krng)
[    1.029242] Asymmetric key parser 'x509' registered
[    1.029266] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    1.029286] io scheduler noop registered (default)
[    1.029289] io scheduler deadline registered
[    1.029313] io scheduler cfq registered
[    1.029511] pcieport 0000:00:01.0: setting latency timer to 64
[    1.029746] pcieport 0000:00:01.0: irq 40 for MSI/MSI-X
[    1.033431] pcieport 0000:00:02.0: setting latency timer to 64
[    1.033607] pcieport 0000:00:02.0: irq 41 for MSI/MSI-X
[    1.036247] pcieport 0000:00:03.0: setting latency timer to 64
[    1.036403] pcieport 0000:00:03.0: irq 42 for MSI/MSI-X
[    1.038964] pcieport 0000:00:05.0: setting latency timer to 64
[    1.039133] pcieport 0000:00:05.0: irq 43 for MSI/MSI-X
[    1.043027] aer 0000:00:01.0:pcie02: service driver aer loaded
[    1.043110] aer 0000:00:02.0:pcie02: service driver aer loaded
[    1.043192] aer 0000:00:03.0:pcie02: service driver aer loaded
[    1.043273] aer 0000:00:05.0:pcie02: service driver aer loaded
[    1.043300] pcieport 0000:00:01.0: Signaling PME through PCIe PME interrupt
[    1.043304] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    1.043314] pcie_pme 0000:00:01.0:pcie01: service driver pcie_pme loaded
[    1.043335] pcieport 0000:00:02.0: Signaling PME through PCIe PME interrupt
[    1.043337] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    1.043348] pcie_pme 0000:00:02.0:pcie01: service driver pcie_pme loaded
[    1.043368] pcieport 0000:00:03.0: Signaling PME through PCIe PME interrupt
[    1.043370] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
[    1.043381] pcie_pme 0000:00:03.0:pcie01: service driver pcie_pme loaded
[    1.043401] pcieport 0000:00:05.0: Signaling PME through PCIe PME interrupt
[    1.043403] pci 0000:04:00.0: Signaling PME through PCIe PME interrupt
[    1.043413] pcie_pme 0000:00:05.0:pcie01: service driver pcie_pme loaded
[    1.043455] vesafb: mode is 1024x768x24, linelength=3072, pages=2
[    1.043457] vesafb: scrolling: redraw
[    1.043459] vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
[    1.043494] vesafb: framebuffer at 0xfb000000, mapped to 0xffffc90012680000, using 4608k, total 8192k
[    1.043581] bootsplash 3.2.0-2010/03/31: looking for picture...
[    1.043582] bootsplash: silentjpeg size 59221 bytes
[    1.049326] bootsplash: ...found (1024x768, 31358 bytes, v3).
[    1.060316] Console: switching to colour frame buffer device 124x44
[    1.070587] fb0: VESA VGA frame buffer device
[    1.070612] GHES: HEST is not enabled!
[    1.070645] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    1.070813] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.168279] 00:04: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.180215] Non-volatile memory driver v1.3
[    1.180219] Linux agpgart interface v0.103
[    1.180278] Fixed MDIO Bus: probed
[    1.180306] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    1.180798] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.180804] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.180839] mousedev: PS/2 mouse device common for all mice
[    1.181015] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.181281] cpuidle: using governor ladder
[    1.181283] cpuidle: using governor menu
[    1.181286] EFI Variables Facility v0.08 2004-May-17
[    1.181445] TCP cubic registered
[    1.181493] Registering the dns_resolver key type
[    1.181569] Loading module verification certificates
[    1.181608] MODSIGN: Loaded cert 'SUSE Linux Enterprise Secure Boot Signkey: 3fb077b6cebc6ff2522e1c148c57c777c788e3e7'
[    1.181653] MODSIGN: Loaded cert 'SUSE Linux Enterprise Secure Boot Signkey: 3fb077b6cebc6ff2522e1c148c57c777c788e3e7'
[    1.181678] PM: Checking hibernation image partition /dev/disk/by-id/scsi-0FTS_PRAID_EP420i_SDA-part5
[    1.181679] PM: Hibernation image not present or could not be loaded.
[    1.181685] registered taskstats version 1
[    1.182960]   Magic number: 12:932:721
[    1.184178] Freeing unused kernel memory: 1360k freed
[    1.184324] Write protecting the kernel read-only data: 10240k
[    1.186647] Freeing unused kernel memory: 1560k freed
[    1.188104] Freeing unused kernel memory: 900k freed
[    1.215730] SCSI subsystem initialized
[    1.216262] megasas: 06.806.08.00-rc1 Thu. Sep. 4 17:00:00 PDT 2014
[    1.216299] megasas: 0x1000:0x0079:0x1000:0x9261: bus 0:slot 6:func 0
[    1.216353] megaraid_sas 0000:00:06.0: PCI INT A -> Link[GSIG] -> GSI 22 (level, high) -> IRQ 22
[    1.216405] megaraid_sas 0000:00:06.0: setting latency timer to 64
[    1.216537] megasas: FW now in Ready state
[    1.216685] megaraid_sas 0000:00:06.0: irq 44 for MSI/MSI-X
[    1.216722] megaraid_sas 0000:00:06.0: [scsi0]: FW supports<0> MSIX vector,Online CPUs: <2>,Current MSIX <1>
[    1.217229] megasas_init_mfi: fw_support_ieee=67108864
[    1.217231] megasas: INIT adapter done
[    1.217296] megaraid_sas 0000:00:06.0: Controller type: MR,Memory size is: 512MB
[    1.217356] scsi0 : LSI SAS based MegaRAID driver
[    1.219078] scsi 0:2:0:0: Direct-Access     FTS      PRAID EP420i     4.25 PQ: 0 ANSI: 5
[    1.227812] libata version 3.00 loaded.
[    1.228224] ahci 0000:00:1f.2: version 3.0
[    1.228262] ACPI: PCI Interrupt Link [GSIA] enabled at IRQ 16
[    1.228305] ahci 0000:00:1f.2: PCI INT A -> Link[GSIA] -> GSI 16 (level, high) -> IRQ 16
[    1.228418] ahci 0000:00:1f.2: irq 45 for MSI/MSI-X
[    1.228644] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x3f impl SATA mode
[    1.228671] ahci 0000:00:1f.2: flags: ncq only 
[    1.228705] ahci 0000:00:1f.2: setting latency timer to 64
[    1.229202] scsi1 : ahci
[    1.229274] scsi2 : ahci
[    1.229332] scsi3 : ahci
[    1.229388] scsi4 : ahci
[    1.229443] scsi5 : ahci
[    1.229498] scsi6 : ahci
[    1.229555] ata2: SATA max UDMA/133 abar m4096@0xfea35000 port 0xfea35100 irq 45
[    1.229584] ata3: SATA max UDMA/133 abar m4096@0xfea35000 port 0xfea35180 irq 45
[    1.229612] ata4: SATA max UDMA/133 abar m4096@0xfea35000 port 0xfea35200 irq 45
[    1.229639] ata5: SATA max UDMA/133 abar m4096@0xfea35000 port 0xfea35280 irq 45
[    1.229666] ata6: SATA max UDMA/133 abar m4096@0xfea35000 port 0xfea35300 irq 45
[    1.229693] ata7: SATA max UDMA/133 abar m4096@0xfea35000 port 0xfea35380 irq 45
[    1.548118] ata5: SATA link down (SStatus 0 SControl 300)
[    1.548228] ata6: SATA link down (SStatus 0 SControl 300)
[    1.548325] ata7: SATA link down (SStatus 0 SControl 300)
[    1.548423] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    1.548516] ata4.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    1.548542] ata4.00: applying bridge limits
[    1.548630] ata4.00: configured for UDMA/100
[    1.548738] ata2: SATA link down (SStatus 0 SControl 300)
[    1.548831] ata3: SATA link down (SStatus 0 SControl 300)
[    1.548952] scsi 3:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    1.552265] sym53c8xx 0000:02:00.0: PCI INT A -> Link[GSIG] -> GSI 22 (level, high) -> IRQ 22
[    1.553199] sym0: <895a> rev 0x0 at pci 0000:02:00.0 irq 22
[    1.555289] sym0: No NVRAM, ID 7, Fast-40, LVD, parity checking
[    1.557244] sym0: SCSI BUS has been reset.
[    1.563253] scsi7 : sym-2.2.3
[    1.820736] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input1
[    2.024140] Refined TSC clocksource calibration: 2594.035 MHz.
[    4.568761] emc: device handler registered
[    4.572107] hp_sw: device handler registered
[    4.575053] alua: device handler registered
[    4.577947] rdac: device handler registered
[    4.580012] udev: starting version 147
[    4.621894] sd 0:2:0:0: [sda] 629145600 512-byte logical blocks: (322 GB/300 GiB)
[    4.622012] sd 0:2:0:0: [sda] Write Protect is off
[    4.622037] sd 0:2:0:0: [sda] Mode Sense: 63 00 00 08
[    4.622068] sd 0:2:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.177415]  sda: sda1 sda2 < sda5 sda6 sda7 sda8 sda9 >
[    6.177954] sd 0:2:0:0: [sda] Attached SCSI disk
[    6.178544] ACPI: acpi_idle registered with cpuidle
[    8.071851] kjournald starting.  Commit interval 15 seconds
[    8.072032] EXT3-fs (sda7): using internal journal
[    8.072073] EXT3-fs (sda7): mounted filesystem with ordered data mode
[   15.057055] udev: starting version 147
[   15.863470] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[   15.863526] ACPI: Power Button [PWRF]
[   15.870506] iTCO_vendor_support: vendor-support=0
[   15.892591] input: PC Speaker as /devices/platform/pcspkr/input/input3
[   16.165060] i801_smbus 0000:00:1f.3: PCI INT A -> Link[GSIA] -> GSI 16 (level, high) -> IRQ 16
[   16.201401] rtc_cmos 00:01: RTC can wake from S4
[   16.201625] rtc_cmos 00:01: rtc core: registered rtc_cmos as rtc0
[   16.201770] rtc0: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
[   16.241804] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   16.243779] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   16.248718] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.06
[   16.248857] iTCO_wdt: Found a ICH9 TCO device (Version=2, TCOBASE=0x0660)
[   16.248950] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   16.468604] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[   16.468636] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   16.468701] e1000 0000:00:04.0: PCI INT A -> Link[GSIE] -> GSI 20 (level, high) -> IRQ 20
[   16.471476] e1000 0000:00:04.0: setting latency timer to 64
[   16.600104] sd 0:2:0:0: Attached scsi generic sg0 type 0
[   16.600169] scsi 3:0:0:0: Attached scsi generic sg1 type 5
[   16.608541] sr0: scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[   16.608597] cdrom: Uniform CD-ROM driver Revision: 3.20
[   16.608711] sr 3:0:0:0: Attached scsi CD-ROM sr0
[   16.787041] e1000 0000:00:04.0: eth0: (PCI:33MHz:32-bit) 00:82:67:84:02:01
[   16.787072] e1000 0000:00:04.0: eth0: Intel(R) PRO/1000 Network Connection
[   16.787122] e1000 0000:00:10.0: PCI INT A -> Link[GSIE] -> GSI 20 (level, high) -> IRQ 20
[   16.789816] e1000 0000:00:10.0: setting latency timer to 64
[   17.106385] e1000 0000:00:10.0: eth1: (PCI:33MHz:32-bit) 00:82:67:84:02:02
[   17.106445] e1000 0000:00:10.0: eth1: Intel(R) PRO/1000 Network Connection
[   17.106520] e1000 0000:00:11.0: PCI INT A -> Link[GSIF] -> GSI 21 (level, high) -> IRQ 21
[   17.110519] e1000 0000:00:11.0: setting latency timer to 64
[   17.427333] e1000 0000:00:11.0: eth2: (PCI:33MHz:32-bit) 00:fc:61:69:00:03
[   17.427366] e1000 0000:00:11.0: eth2: Intel(R) PRO/1000 Network Connection
[   17.427417] e1000 0000:00:12.0: PCI INT A -> Link[GSIG] -> GSI 22 (level, high) -> IRQ 22
[   17.430085] e1000 0000:00:12.0: setting latency timer to 64
[   17.744008] e1000 0000:00:12.0: eth3: (PCI:33MHz:32-bit) 00:fc:61:69:00:04
[   17.744042] e1000 0000:00:12.0: eth3: Intel(R) PRO/1000 Network Connection
[   17.744093] e1000 0000:00:13.0: PCI INT A -> Link[GSIH] -> GSI 23 (level, high) -> IRQ 23
[   17.747050] e1000 0000:00:13.0: setting latency timer to 64
[   18.060185] e1000 0000:00:13.0: eth4: (PCI:33MHz:32-bit) 00:fc:61:69:00:06
[   18.060219] e1000 0000:00:13.0: eth4: Intel(R) PRO/1000 Network Connection
[   18.060291] e1000 0000:08:01.0: PCI INT A -> Link[GSIH] -> GSI 23 (level, high) -> IRQ 23
[   18.063400] e1000 0000:08:01.0: setting latency timer to 64
[   18.381713] e1000 0000:08:01.0: eth5: (PCI:33MHz:32-bit) 00:86:67:84:02:06
[   18.381769] e1000 0000:08:01.0: eth5: Intel(R) PRO/1000 Network Connection
[   18.381865] e1000 0000:0a:01.0: PCI INT A -> Link[GSIF] -> GSI 21 (level, high) -> IRQ 21
[   18.386815] e1000 0000:0a:01.0: setting latency timer to 64
[   18.708057] e1000 0000:0a:01.0: eth6: (PCI:33MHz:32-bit) 00:82:67:84:02:04
[   18.708103] e1000 0000:0a:01.0: eth6: Intel(R) PRO/1000 Network Connection
[   18.708161] e1000 0000:0b:01.0: PCI INT A -> Link[GSIG] -> GSI 22 (level, high) -> IRQ 22
[   18.711324] e1000 0000:0b:01.0: setting latency timer to 64
[   19.032168] e1000 0000:0b:01.0: eth7: (PCI:33MHz:32-bit) 00:82:67:84:02:05
[   19.032216] e1000 0000:0b:01.0: eth7: Intel(R) PRO/1000 Network Connection
[   19.133896] Adding 12585980k swap on /dev/sda5.  Priority:-1 extents:1 across:12585980k 
[   19.854883] type=1111 audit(1482299099.852:2): user pid=973 uid=0 auid=4294967295 ses=4294967295 msg='changing system time: exe="/sbin/hwclock" (hostname=?, addr=?, terminal=console res=success)'
[   19.897235] device-mapper: uevent: version 1.0.3
[   19.897320] device-mapper: ioctl: 4.25.0-ioctl (2012-07-25) initialised: dm-devel@redhat.com
[   19.957908] pps_core: LinuxPPS API ver. 1 registered
[   19.957950] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[   20.026615] PTP clock support registered
[   22.537127] loop: module loaded
[   23.594293] kjournald starting.  Commit interval 15 seconds
[   23.594444] EXT3-fs (sda6): using internal journal
[   23.594522] EXT3-fs (sda6): mounted filesystem with ordered data mode
[   26.384954] fuse init (API version 7.16)
[   30.092813] ipmi message handler version 39.2
[   30.129583] ipmi device interface
[   30.131273] IPMI System Interface driver.
[   30.131360] ipmi_si: probing via SMBIOS
[   30.131362] ipmi_si: SMBIOS: io 0xca2 regsize 1 spacing 1 irq 0
[   30.131364] ipmi_si: Adding SMBIOS-specified kcs state machine
[   30.131366] ipmi_si: Trying SMBIOS-specified kcs state machine at i/o address 0xca2, slave address 0x20, irq 0
[   30.131378] ipmi_si: Interface detection failed
[   63.909062] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   64.083821] ip_tables: (C) 2000-2006 Netfilter Core Team
[   64.109199] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[   64.135567] type=1325 audit(1482299144.132:3): table=filter family=2 entries=0
[   64.135612] type=1300 audit(1482299144.132:3): arch=c000003e syscall=175 success=yes exit=0 a0=7f46a948e000 a1=1ea7 a2=6276a0 a3=7ffcb132a1c0 items=0 ppid=1784 pid=1785 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="modprobe" exe="/sbin/modprobe" key=(null)
[   64.144395] type=1325 audit(1482299144.140:4): table=raw family=2 entries=0
[   64.144434] type=1300 audit(1482299144.140:4): arch=c000003e syscall=175 success=yes exit=0 a0=7f00f3a0f000 a1=1a1f a2=6276a0 a3=7fffb525d110 items=0 ppid=1790 pid=1791 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="modprobe" exe="/sbin/modprobe" key=(null)
[   64.166964] type=1325 audit(1482299144.164:5): table=filter family=2 entries=4
[   64.166975] type=1300 audit(1482299144.164:5): arch=c000003e syscall=54 success=yes exit=0 a0=5 a1=0 a2=40 a3=60fa90 items=0 ppid=1756 pid=1783 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="iptables-batch" exe="/usr/sbin/iptables-batch" key=(null)
[   64.183076] type=1325 audit(1482299144.164:6): table=raw family=2 entries=3
[   64.183097] type=1300 audit(1482299144.164:6): arch=c000003e syscall=54 success=yes exit=0 a0=7 a1=0 a2=40 a3=60b320 items=0 ppid=1756 pid=1783 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="iptables-batch" exe="/usr/sbin/iptables-batch" key=(null)
[   85.237187] Disabling lock debugging due to kernel taint
[   88.628459] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   88.841291] device eth2 entered promiscuous mode
[   88.841307] type=1700 audit(1482299168.832:7): dev=eth2 prom=256 old_prom=0 auid=4294967295 uid=0 gid=0 ses=4294967295
[   88.843093] type=1300 audit(1482299168.832:7): arch=c000003e syscall=46 success=yes exit=32 a0=3 a1=7ffdf9457a60 a2=0 a3=7ffdf94577d0 items=0 ppid=3727 pid=3905 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="ip" exe="/sbin/ip" key=(null)
[   88.844440] e1000: eth2 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   89.015266] device eth3 entered promiscuous mode
[   89.015273] type=1700 audit(1482299169.008:8): dev=eth3 prom=256 old_prom=0 auid=4294967295 uid=0 gid=0 ses=4294967295
[   89.016822] e1000: eth3 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   89.018731] type=1300 audit(1482299169.008:8): arch=c000003e syscall=46 success=yes exit=32 a0=3 a1=7fff65a3e840 a2=0 a3=7fff65a3e5b0 items=0 ppid=3958 pid=4136 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="ip" exe="/sbin/ip" key=(null)
[   89.202808] device eth4 entered promiscuous mode
[   89.202814] type=1700 audit(1482299169.196:9): dev=eth4 prom=256 old_prom=0 auid=4294967295 uid=0 gid=0 ses=4294967295
[   89.204429] e1000: eth4 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   89.206188] type=1300 audit(1482299169.196:9): arch=c000003e syscall=46 success=yes exit=32 a0=3 a1=7fff62328c10 a2=0 a3=7fff62328980 items=0 ppid=4189 pid=4367 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="ip" exe="/sbin/ip" key=(null)
[   91.960225] 802.1Q VLAN Support v1.8
[   91.960243] 8021q: adding VLAN 0 to HW filter on device eth0
[   91.960322] 8021q: adding VLAN 0 to HW filter on device eth2
[   91.960393] 8021q: adding VLAN 0 to HW filter on device eth3
[   91.960460] 8021q: adding VLAN 0 to HW filter on device eth4
[   91.962160] NET: Registered protocol family 17
[   92.130044] scsi8 : FCoE Driver
[   92.130226] fcoe: No FDMI support.
[   92.130375] host8: libfc: Link up on port (000000)
[   92.132238] scsi9 : FCoE Driver
[   92.132445] fcoe: No FDMI support.
[   92.132564] host9: libfc: Link up on port (000000)
[   92.134603] scsi10 : FCoE Driver
[   92.134880] fcoe: No FDMI support.
[   92.134987] host10: libfc: Link up on port (000000)
[   92.632771] host8: Assigned Port ID 000006
[   92.660737] host9: Assigned Port ID 000004
[   92.716637] host10: Assigned Port ID 000003
[   95.888479] scsi 10:0:0:0: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   95.888589] sd 10:0:0:0: Attached scsi generic sg2 type 0
[   95.889364] scsi 10:0:0:7: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   95.889445] sd 10:0:0:7: Attached scsi generic sg3 type 0
[   95.889660] sd 10:0:0:0: [sdb] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   95.890199] scsi 10:0:0:6: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   95.890316] sd 10:0:0:6: Attached scsi generic sg4 type 0
[   95.890493] sd 10:0:0:7: [sdc] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   95.890851] sd 10:0:0:0: [sdb] Write Protect is off
[   95.890854] sd 10:0:0:0: [sdb] Mode Sense: 69 00 00 08
[   95.890986] scsi 10:0:0:5: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   95.891059] sd 10:0:0:5: Attached scsi generic sg5 type 0
[   95.891728] sd 10:0:0:6: [sdd] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   95.891774] sd 10:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   95.892210] sd 10:0:0:7: [sdc] Write Protect is off
[   95.892214] sd 10:0:0:7: [sdc] Mode Sense: 69 00 00 08
[   95.892239] scsi 10:0:0:4: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   95.892349] sd 10:0:0:4: Attached scsi generic sg6 type 0
[   95.892461] sd 10:0:0:5: [sde] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   95.893003] sd 10:0:0:7: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   95.893128] scsi 10:0:0:3: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   95.893252] sd 10:0:0:4: [sdf] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   95.893266] sd 10:0:0:3: Attached scsi generic sg7 type 0
[   95.893418] sd 10:0:0:6: [sdd] Write Protect is off
[   95.893422] sd 10:0:0:6: [sdd] Mode Sense: 69 00 00 08
[   95.893832] scsi 10:0:0:2: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   95.893970] sd 10:0:0:5: [sde] Write Protect is off
[   95.893974] sd 10:0:0:5: [sde] Mode Sense: 69 00 00 08
[   95.894059] sd 10:0:0:6: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   95.894163] sd 10:0:0:2: Attached scsi generic sg8 type 0
[   95.894325] sd 10:0:0:4: [sdf] Write Protect is off
[   95.894329] sd 10:0:0:4: [sdf] Mode Sense: 69 00 00 08
[   95.894633] sd 10:0:0:5: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   95.894763] scsi 10:0:0:15: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[   95.894845] sd 10:0:0:15: Attached scsi generic sg9 type 0
[   95.895127] sd 10:0:0:4: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   95.897501] sd 10:0:0:3: [sdg] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   95.898100] sd 10:0:0:2: [sdh] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[   95.899529] sd 10:0:0:3: [sdg] Write Protect is off
[   95.899533] sd 10:0:0:3: [sdg] Mode Sense: 69 00 00 08
[   95.899838]  sdb: sdb1
[   95.901241] sd 10:0:0:3: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   95.901518] sd 10:0:0:2: [sdh] Write Protect is off
[   95.901522] sd 10:0:0:2: [sdh] Mode Sense: 69 00 00 08
[   95.902206]  sdc: sdc1
[   95.902851] sd 10:0:0:2: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   95.903904]  sdd: sdd1
[   95.905098]  sdf: sdf1
[   95.905114]  sde: sde1
[   95.906022] sd 10:0:0:0: [sdb] Attached SCSI disk
[   95.907726] sd 10:0:0:7: [sdc] Attached SCSI disk
[   95.907733] sd 10:0:0:15: [sdi] 268435456 512-byte logical blocks: (137 GB/128 GiB)
[   95.908755] sd 10:0:0:4: [sdf] Attached SCSI disk
[   95.909330] sd 10:0:0:5: [sde] Attached SCSI disk
[   95.909335] sd 10:0:0:6: [sdd] Attached SCSI disk
[   95.909445] sd 10:0:0:15: [sdi] Write Protect is off
[   95.909449] sd 10:0:0:15: [sdi] Mode Sense: 69 00 00 08
[   95.910663]  sdg: sdg1
[   95.911406] sd 10:0:0:15: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   95.913191] sd 10:0:0:3: [sdg] Attached SCSI disk
[   95.914314]  sdh: sdh1
[   95.915364]  sdi: sdi1 sdi2
[   95.917605] sd 10:0:0:2: [sdh] Attached SCSI disk
[   95.920165] sd 10:0:0:15: [sdi] Attached SCSI disk
[  107.936948] scsi 9:0:1:0: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[  107.937099] sd 9:0:1:0: Attached scsi generic sg10 type 0
[  107.938031] scsi 9:0:1:7: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[  107.938121] sd 9:0:1:7: Attached scsi generic sg11 type 0
[  107.938275] sd 9:0:1:0: [sdj] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[  107.938704] scsi 9:0:1:6: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[  107.938717] sd 9:0:1:7: [sdk] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[  107.938811] sd 9:0:1:6: Attached scsi generic sg12 type 0
[  107.939390] sd 9:0:1:0: [sdj] Write Protect is off
[  107.939396] sd 9:0:1:0: [sdj] Mode Sense: 69 00 00 08
[  107.939526] scsi 9:0:1:5: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[  107.939629] sd 9:0:1:5: Attached scsi generic sg13 type 0
[  107.939847] sd 9:0:1:7: [sdk] Write Protect is off
[  107.939851] sd 9:0:1:7: [sdk] Mode Sense: 69 00 00 08
[  107.939887] sd 9:0:1:6: [sdl] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[  107.940152] sd 9:0:1:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  107.940434] scsi 9:0:1:4: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[  107.940529] sd 9:0:1:4: Attached scsi generic sg14 type 0
[  107.940549] sd 9:0:1:7: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  107.940939] sd 9:0:1:5: [sdm] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[  107.941690] sd 9:0:1:4: [sdn] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[  107.941737] sd 9:0:1:6: [sdl] Write Protect is off
[  107.941741] sd 9:0:1:6: [sdl] Mode Sense: 69 00 00 08
[  107.941861] scsi 9:0:1:3: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[  107.941970] sd 9:0:1:3: Attached scsi generic sg15 type 0
[  107.942543] sd 9:0:1:5: [sdm] Write Protect is off
[  107.942548] sd 9:0:1:5: [sdm] Mode Sense: 69 00 00 08
[  107.942584] sd 9:0:1:6: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  107.942872] scsi 9:0:1:2: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[  107.942994] sd 9:0:1:2: Attached scsi generic sg16 type 0
[  107.943080] sd 9:0:1:3: [sdo] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[  107.943419] sd 9:0:1:4: [sdn] Write Protect is off
[  107.943423] sd 9:0:1:4: [sdn] Mode Sense: 69 00 00 08
[  107.943454] sd 9:0:1:5: [sdm] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  107.944243] sd 9:0:1:4: [sdn] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  107.944415] scsi 9:0:1:15: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
[  107.944502] sd 9:0:1:15: Attached scsi generic sg17 type 0
[  107.944555] sd 9:0:1:3: [sdo] Write Protect is off
[  107.944559] sd 9:0:1:3: [sdo] Mode Sense: 69 00 00 08
[  107.945305] sd 9:0:1:3: [sdo] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  107.946017] sd 9:0:1:2: [sdp] 1048576000 512-byte logical blocks: (536 GB/500 GiB)
[  107.948170] sd 9:0:1:2: [sdp] Write Protect is off
[  107.948174] sd 9:0:1:2: [sdp] Mode Sense: 69 00 00 08
[  107.948960] sd 9:0:1:2: [sdp] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  107.950163] sd 9:0:1:15: [sdq] 268435456 512-byte logical blocks: (137 GB/128 GiB)
[  107.950351]  sdj: sdj1
[  107.951403]  sdk: sdk1
[  107.952134] sd 9:0:1:15: [sdq] Write Protect is off
[  107.952239] sd 9:0:1:15: [sdq] Mode Sense: 69 00 00 08
[  107.953446] sd 9:0:1:15: [sdq] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  107.954143]  sdm: sdm1
[  107.955154]  sdn: sdn1
[  107.955822]  sdl: sdl1
[  107.956704] sd 9:0:1:7: [sdk] Attached SCSI disk
[  107.957232]  sdo: sdo1
[  107.957810] sd 9:0:1:0: [sdj] Attached SCSI disk
[  107.959769] sd 9:0:1:5: [sdm] Attached SCSI disk
[  107.960235] sd 9:0:1:4: [sdn] Attached SCSI disk
[  107.960367] sd 9:0:1:6: [sdl] Attached SCSI disk
[  107.960821] sd 9:0:1:3: [sdo] Attached SCSI disk
[  107.961275]  sdp: sdp1
[  107.962658]  sdq: sdq1 sdq2
[  107.965055] sd 9:0:1:2: [sdp] Attached SCSI disk
[  107.965462] sd 9:0:1:15: [sdq] Attached SCSI disk
[  110.732002] type=1305 audit(1482299190.728:10): audit_pid=5459 old=0 auid=4294967295 ses=4294967295 res=1
[  119.896053] RPC: Registered named UNIX socket transport module.
[  119.896055] RPC: Registered udp transport module.
[  119.896056] RPC: Registered tcp transport module.
[  119.896057] RPC: Registered tcp NFSv4.1 backchannel transport module.
[  119.936822] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  120.786124] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[  120.786319] NFSD: starting 90-second grace period
[  122.670069] Fusion MPT base driver 4.28.00.01suse
[  122.670071] Copyright (c) 1999-2010 LSI Corporation
[  122.670894] Fusion MPT misc device (ioctl) driver 4.28.00.01suse
[  122.670923] mptctl: Registered with Fusion MPT base driver
[  122.670924] mptctl: /dev/mptctl @ (major,minor=10,220)
[  149.562895] FS-Cache: Loaded
[  149.568351] FS-Cache: Netfs 'nfs' registered for caching
[  150.786555] licDriver: module loaded (major: 246)
[  154.005569] device-mapper: multipath: version 1.6.0 loaded
[  154.077449] device-mapper: multipath service-time: version 0.2.0 loaded
[  186.451782] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[  203.464834] Emulex LightPulse Fibre Channel SCSI driver 10.6.193.12.6fts
[  203.464836] Copyright(c) 2004-2015 Emulex.  All rights reserved.
[  203.487950] trc_m: kernel trace driver, version 0.0.1, numeric time zone 01 (1)
[  204.415921] fct4: ---vvv------------------ fct4_init ------------------vvv---
[  204.416099] fct4: Fibre Channel SLI4 series SCSI target-mode low level driver 0.0.3
[  204.416101] fct4: Copyright(c) 2004-2015 Emulex.  All rights reserved.
[  204.416103] fct4: Copyright(c) 2013-2015 Fujitsu Technology Solutions.
[  204.416104] fct4: operation mode selected: fcp_initiator [ fcp_target ] ficon
[  304.958437] bonding: Ethernet Channel Bonding Driver: v3.7.1 (April 27, 2011)
[  304.959359] bonding: SLAN00 is being created...
[  304.960193] bonding: SLAN00: Setting MII monitoring interval to 100.
[  304.960565] bonding: SLAN00: Setting up delay to 30000.
[  304.960932] bonding: SLAN00: setting mode to active-backup (1).
[  304.967536] bonding: SLAN00: Adding slave eth5.
[  304.970978] 8021q: adding VLAN 0 to HW filter on device eth5
[  304.971044] bonding: SLAN00: enslaving eth5 as a backup interface with a down link.
[  304.973673] e1000: eth5 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  305.021450] bonding: SLAN00: link status up for interface eth5, enabling it in 0 ms.
[  305.022203] 8021q: adding VLAN 0 to HW filter on device SLAN00
[  305.028061] bonding: SLAN00: link status definitely up for interface eth5, 1000 Mbps full duplex.
[  305.028064] bonding: SLAN00: making interface eth5 the new active one.
[  305.028599] bonding: SLAN00: first active interface up!
[  305.781783] 8021q: adding VLAN 0 to HW filter on device eth1
[  307.785452] e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  308.578641] 8021q: adding VLAN 0 to HW filter on device eth6
[  310.580552] e1000: eth6 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  311.371680] 8021q: adding VLAN 0 to HW filter on device eth7
[  313.377061] e1000: eth7 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  341.388121] e1000: eth7 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[  362.446525] stg4: Fibre Channel SLI4 series SCSI target-mode emulation interface driver 0.0.1
[  365.219348] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36508 PROTO=2 
[  380.233852] bootsplash: status on console 0 changed to on
[  493.865879] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36509 PROTO=2 
[  622.512732] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36510 PROTO=2 
[  751.159284] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36511 PROTO=2 
[  879.908301] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36512 PROTO=2 
[ 1008.452629] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36513 PROTO=2 
[ 1137.211392] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36514 PROTO=2 
[ 1265.746245] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36515 PROTO=2 
[ 1394.392855] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36516 PROTO=2 
[ 1523.039698] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36517 PROTO=2 
[ 1651.686362] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36518 PROTO=2 
[ 1780.333137] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36519 PROTO=2 
[ 1908.980154] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36520 PROTO=2 
[ 2037.626674] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36521 PROTO=2 
[ 2166.273406] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36522 PROTO=2 
[ 2294.964138] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36523 PROTO=2 
[ 2423.567323] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36524 PROTO=2 
[ 2552.303841] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36525 PROTO=2 
[ 2680.860868] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36526 PROTO=2 
[ 2809.507369] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36527 PROTO=2 
[ 2938.154314] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36528 PROTO=2 
[ 3066.801270] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36529 PROTO=2 
[ 3195.448035] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36530 PROTO=2 
[ 3324.094812] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36531 PROTO=2 
[ 3452.741551] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36532 PROTO=2 
[ 3581.388298] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36533 PROTO=2 
[ 3710.076648] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36534 PROTO=2 
[ 3838.682046] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36535 PROTO=2 
[ 3967.328830] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36536 PROTO=2 
[ 4095.975762] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36537 PROTO=2 
[ 4224.622479] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36538 PROTO=2 
[ 4353.269140] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36539 PROTO=2 
[ 4481.916172] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36540 PROTO=2 
[ 4610.562758] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36541 PROTO=2 
[ 4739.209599] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36542 PROTO=2 
[ 4867.856389] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36543 PROTO=2 
[ 4996.503241] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36544 PROTO=2 
[ 5125.149921] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36545 PROTO=2 
[ 5253.796905] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36546 PROTO=2 
[ 5382.552956] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36547 PROTO=2 
[ 5511.090612] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36548 PROTO=2 
[ 5639.736972] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36549 PROTO=2 
[ 5768.383854] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36550 PROTO=2 
[ 5897.030603] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36551 PROTO=2 
[ 6025.677430] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36552 PROTO=2 
[ 6154.324130] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36553 PROTO=2 
[ 6282.970960] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36554 PROTO=2 
[ 6411.726350] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36555 PROTO=2 
[ 6540.264482] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36556 PROTO=2 
[ 6668.911452] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36557 PROTO=2 
[ 6706.656015]  rport-9:0-2: blocked FC remote port time out: removing rport
[ 6706.656019]  rport-8:0-3: blocked FC remote port time out: removing rport
[ 6706.656021]  rport-10:0-4: blocked FC remote port time out: removing rport
[ 6706.912013]  rport-10:0-1: blocked FC remote port time out: removing rport
[ 6706.912017]  rport-9:0-3: blocked FC remote port time out: removing rport
[ 6706.912018]  rport-8:0-4: blocked FC remote port time out: removing rport
[ 6706.912019]  rport-10:0-2: blocked FC remote port time out: removing rport
[ 6706.912021]  rport-9:0-1: blocked FC remote port time out: removing rport
[ 6706.912022]  rport-8:0-0: blocked FC remote port time out: removing rport
[ 6797.558083] SFW2-INext-DROP-DEFLT IN=eth1 OUT= MAC=01:00:5e:00:00:01:00:12:cf:19:bb:e0:08:00 SRC=172.17.38.102 DST=224.0.0.1 LEN=28 TOS=0x00 PREC=0x00 TTL=1 ID=36558 PROTO=2 

--------------D6A36D918608DB4351EDF485--
