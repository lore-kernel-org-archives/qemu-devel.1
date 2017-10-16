Received: from eggs.gnu.org ([2001:4830:134:3::10]:37733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e49m8-0002eO-5D
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e49m4-0007NV-QJ
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:06:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e49m4-0007N3-H2
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 14:06:00 -0400
Date: Mon, 16 Oct 2017 19:05:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171016180555.GE2876@work-vm>
References: <002d01d34667$f8c9b1e0$ea5d15a0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <002d01d34667$f8c9b1e0$ea5d15a0$@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Windows Server 2008 R2 network freezes after some
 time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gediminas =?utf-8?Q?Jan=C4=8Dys?= <g.jancys@gmail.com>
Cc: qemu-devel@nongnu.org

* Gediminas Jan=C4=8Dys (g.jancys@gmail.com) wrote:
> Hello guys,=20
>=20
> I have a problem and desperate with it, can't find a solution for it. I=
 got
> Windows Server 2008 R2 guest OS on CentOS Linux release 7.3.1611 (Core)=
 with
> libvirt and CloudStack. Problem is that after some time, about 2- 3 day=
s
> (should be based on amount of traffic) VM's network got stuck. No traff=
ic in
> or out. After restart network works fine until gets stuck again.  I'm
> current using VirtIO drivers on guest version 61.74.104.14100. Also I h=
ave
> tried to use older drivers but same situation. From host and guest logs=
 I
> can't see any entries about drivers or something related to this proble=
m,
> only casual stuff. Can you help me or guide to find the problems source=
?
> After my investigation I would say that drivers are failing at some poi=
nt.

If you switch the NIC from virtio to another type (e1000 for example)
does the problem go away?

Dave
> =20
>=20
> Libvirts info:
>=20
> Using library: libvirt 2.0.0
>=20
> Using API: QEMU 2.0.0
>=20
> Running hypervisor: QEMU 2.6.0
>=20
> =20
>=20
> KVM XML:
>=20
> <domain type=3D'kvm' id=3D'206'>
>=20
>   <name>i-25-85-VM</name>
>=20
>   <uuid>2758a8ec-3e86-4132-9110-1051f0708367</uuid>
>=20
>   <description>Windows PV</description>
>=20
>   <maxMemory slots=3D'32' unit=3D'KiB'>197191680</maxMemory>
>=20
>   <memory unit=3D'KiB'>16777216</memory>
>=20
>   <currentMemory unit=3D'KiB'>16777216</currentMemory>
>=20
>   <vcpu placement=3D'auto' current=3D'2'>40</vcpu>
>=20
>   <cputune>
>=20
>     <shares>146</shares>
>=20
>   </cputune>
>=20
>   <numatune>
>=20
>     <memory mode=3D'strict' placement=3D'auto'/>
>=20
>   </numatune>
>=20
>   <resource>
>=20
>     <partition>/machine</partition>
>=20
>   </resource>
>=20
>   <sysinfo type=3D'smbios'>
>=20
>     <system>
>=20
>       <entry name=3D'manufacturer'>Apache Software Foundation</entry>
>=20
>       <entry name=3D'product'>CloudStack KVM Hypervisor</entry>
>=20
>       <entry name=3D'uuid'>2758a8ec-3e86-4132-9110-1051f0708367</entry>
>=20
>     </system>
>=20
>   </sysinfo>
>=20
>   <os>
>=20
>     <type arch=3D'x86_64' machine=3D'pc-i440fx-rhel7.3.0'>hvm</type>
>=20
>     <boot dev=3D'cdrom'/>
>=20
>     <boot dev=3D'hd'/>
>=20
>     <smbios mode=3D'sysinfo'/>
>=20
>   </os>
>=20
>   <features>
>=20
>     <acpi/>
>=20
>     <apic/>
>=20
>     <pae/>
>=20
>   </features>
>=20
>   <cpu mode=3D'host-passthrough'>
>=20
>     <numa>
>=20
>       <cell id=3D'0' cpus=3D'0-39' memory=3D'16777216' unit=3D'KiB'/>
>=20
>     </numa>
>=20
>   </cpu>
>=20
>   <clock offset=3D'localtime'>
>=20
>     <timer name=3D'rtc' tickpolicy=3D'catchup'/>
>=20
>   </clock>
>=20
>   <on_poweroff>destroy</on_poweroff>
>=20
>   <on_reboot>restart</on_reboot>
>=20
>   <on_crash>destroy</on_crash>
>=20
>   <devices>
>=20
>     <emulator>/usr/libexec/qemu-kvm</emulator>
>=20
>     <disk type=3D'network' device=3D'disk'>
>=20
>       <driver name=3D'qemu' type=3D'raw' cache=3D'writeback' discard=3D=
'unmap'/>
>=20
>       <auth username=3D'kvm'>
>=20
>         <secret type=3D'ceph' uuid=3D'8321dbbc-8bab-301b-a89f-d558256dd=
d8b'/>
>=20
>       </auth>
>=20
>       <source protocol=3D'rbd'
> name=3D'kvm-pool/ec8e6467-7370-4cdc-bbda-01844e5f9c2c'>
>=20
>         <host name=3Dxxxxxx.xxxx.xx port=3D'6789'/>
>=20
>       </source>
>=20
>       <backingStore/>
>=20
>       <target dev=3D'sda' bus=3D'scsi'/>
>=20
>       <serial>ec8e646773704cdcbbda</serial>
>=20
>       <alias name=3D'scsi0-0-0-0'/>
>=20
>       <address type=3D'drive' controller=3D'0' bus=3D'0' target=3D'0' u=
nit=3D'0'/>
>=20
>     </disk>
>=20
>     <disk type=3D'file' device=3D'cdrom'>
>=20
>       <driver name=3D'qemu' type=3D'raw' cache=3D'none'/>
>=20
>       <backingStore/>
>=20
>       <target dev=3D'hdc' bus=3D'ide'/>
>=20
>       <readonly/>
>=20
>       <alias name=3D'ide0-1-0'/>
>=20
>       <address type=3D'drive' controller=3D'0' bus=3D'1' target=3D'0' u=
nit=3D'0'/>
>=20
>     </disk>
>=20
>     <controller type=3D'scsi' index=3D'0' model=3D'virtio-scsi'>
>=20
>       <driver queues=3D'2'/>
>=20
>       <alias name=3D'scsi0'/>
>=20
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x04=
'
> function=3D'0x0'/>
>=20
>     </controller>
>=20
>     <controller type=3D'usb' index=3D'0'>
>=20
>       <alias name=3D'usb'/>
>=20
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01=
'
> function=3D'0x2'/>
>=20
>     </controller>
>=20
>     <controller type=3D'pci' index=3D'0' model=3D'pci-root'>
>=20
>       <alias name=3D'pci.0'/>
>=20
>     </controller>
>=20
>     <controller type=3D'ide' index=3D'0'>
>=20
>       <alias name=3D'ide'/>
>=20
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x01=
'
> function=3D'0x1'/>
>=20
>     </controller>
>=20
>     <interface type=3D'bridge'>
>=20
>       <mac address=3D'06:b2:ec:00:01:97'/>
>=20
>       <source bridge=3D'brbond0-500'/>
>=20
>       <target dev=3D'vnet14'/>
>=20
>       <model type=3D'virtio'/>
>=20
>       <alias name=3D'net0'/>
>=20
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x03=
'
> function=3D'0x0'/>
>=20
>     </interface>
>=20
>     <serial type=3D'pty'>
>=20
>       <source path=3D'/dev/pts/13'/>
>=20
>       <target port=3D'0'/>
>=20
>       <alias name=3D'serial0'/>
>=20
>     </serial>
>=20
>     <console type=3D'pty' tty=3D'/dev/pts/13'>
>=20
>       <source path=3D'/dev/pts/13'/>
>=20
>       <target type=3D'serial' port=3D'0'/>
>=20
>       <alias name=3D'serial0'/>
>=20
>     </console>
>=20
>     <input type=3D'tablet' bus=3D'usb'>
>=20
>       <alias name=3D'input0'/>
>=20
>       <address type=3D'usb' bus=3D'0' port=3D'1'/>
>=20
>     </input>
>=20
>     <input type=3D'mouse' bus=3D'ps2'>
>=20
>       <alias name=3D'input1'/>
>=20
>     </input>
>=20
>     <input type=3D'keyboard' bus=3D'ps2'>
>=20
>       <alias name=3D'input2'/>
>=20
>     </input>
>=20
>     <graphics type=3D'vnc' port=3D'5914' autoport=3D'yes' listen=3D'10.=
24.99.29'>
>=20
>       <listen type=3D'address' address=3D'10.24.99.29'/>
>=20
>     </graphics>
>=20
>     <video>
>=20
>       <model type=3D'cirrus' vram=3D'16384' heads=3D'1' primary=3D'yes'=
/>
>=20
>       <alias name=3D'video0'/>
>=20
>       <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' slot=3D'0x02=
'
> function=3D'0x0'/>
>=20
>     </video>
>=20
>     <memballoon model=3D'none'/>
>=20
>   </devices>
>=20
>   <seclabel type=3D'none' model=3D'none'/>
>=20
>   <seclabel type=3D'dynamic' model=3D'dac' relabel=3D'yes'>
>=20
>     <label>+0:+0</label>
>=20
>     <imagelabel>+0:+0</imagelabel>
>=20
>   </seclabel>
>=20
> </domain>
>=20
> =20
>=20
> King regards
>=20
> Gediminas J.
>=20
> =20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
