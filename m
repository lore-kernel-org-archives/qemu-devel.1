Received: from eggs.gnu.org ([2001:4830:134:3::10]:35135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fijHe-0007sQ-F6
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:38:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fijHZ-0000U1-Rh
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:38:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47956 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fijHZ-0000SF-K9
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:38:29 -0400
Date: Thu, 26 Jul 2018 19:38:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180726193758-mutt-send-email-mst@kernel.org>
References: <1407239306.11199051.1530240887935.JavaMail.zimbra@redhat.com>
	<20180705194311-mutt-send-email-mst@kernel.org>
	<DB5PR05MB1160D84E747DA480435B6605D5440@DB5PR05MB1160.eurprd05.prod.outlook.com>
	<DB5PR05MB1160BB381473C723C8336EC2D55A0@DB5PR05MB1160.eurprd05.prod.outlook.com>
	<AM5PR0501MB2499CB4F2D01BCDA47C0ACB6C95A0@AM5PR0501MB2499.eurprd05.prod.outlook.com>
	<DB5PR05MB1160093E018FD91787E80A79D5590@DB5PR05MB1160.eurprd05.prod.outlook.com>
	<20180726145214.GD17777@stefanha-x1.localdomain>
	<488bdc8d-e36c-ad3e-f7b3-a45a78a99dda@gmail.com>
	<20180726191315-mutt-send-email-mst@kernel.org>
	<fd3e6d7a-b495-c6c9-6885-1e8f2d767da1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <fd3e6d7a-b495-c6c9-6885-1e8f2d767da1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Question: SRIOV support over Win Hyper-V VM
 running in QEMU process on Linux host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Elijah Shakkour <elijahs@mellanox.com>, Knut Omang <knut.omang@oracle.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Tal Attaly <talat@mellanox.com>

On Thu, Jul 26, 2018 at 07:34:41PM +0300, Marcel Apfelbaum wrote:
>=20
>=20
> On 07/26/2018 07:14 PM, Michael S. Tsirkin wrote:
> > On Thu, Jul 26, 2018 at 06:51:13PM +0300, Marcel Apfelbaum wrote:
> > > Hi
> > >=20
> > > On 07/26/2018 05:52 PM, Stefan Hajnoczi wrote:
> > > > On Thu, Jul 12, 2018 at 07:33:14AM +0000, Elijah Shakkour wrote:
> > > > > Hey,
> > > > >=20
> > > > > Our team is adding a NIC functional  emulation to QEMU.
> > > > > One of the features we are adding to this NIC is SRIOV.
> > > > >=20
> > > > > Here is the error message I get when checking SRIOV support of =
 our emulated NIC on Win2016 server (the hyper-v VM).
> > > > > "
> > > > > SR-IOV cannot be used on this system as the PCI Express hardwar=
e does not support Access Control Services (ACS) at any root port.
> > > QEMU's emulated PCI Express Root Ports do not support ACS yet, howe=
ver I am
> > > not sure ACS is a prerequisite
> > > for SR-IOV.
> > Looks like windows blocks dev assignment in nested VMs without it.
> > Thinking about it, doesn't vfio do the same by default?
> vfio requires vIOMMU even for nested, as far as I know.

Absolutely.

> They do have a
> "no-iommu"
> option, but I don't know how=A0 it can help in this case.
>=20
> Elijah, what about implementing ACS for QEMU's generic PCIe Root Ports?
> Maybe is not too complicated and it seems like a handy feature to have
> anyway.
> Patches would be welcomed :)
>=20
> Thanks,
> Marcel
>=20
> >   I think vfio has
> > a flag to override this though.
> >=20
> > > We would need ARI support for allowing more than 8VFs, but QEMU
> > > doesn't support that either (yet).
> > >=20
> > > Knut Omag has some working patches, he successfully implemented SR-=
IOV with
> > > QEMU, see:
> > >  =A0=A0=A0=A0 https://github.com/knuto/qemu/tree/sriov_patches_v7
> > >=20
> > > The code was not merged since we need at least a device with SR-IOV=
 support
> > > to justify the addition.
> > >=20
> > > > > Contact your system vendor for further information.
> > > > > "
> > > > I'm not sure what the status of emulated SR-IOV is so I have CCed
> > > > Michael Tsirkin and Marcel Apfelbaum, the PCI maintainers in QEMU=
.
> > > Thanks,
> > > Marcel
> > >=20
> > > > > Could you please advise about what could be the issue here?
> > > > >=20
> > > > > BTW: I use same configuration (VM XML file attached) when runni=
ng linux VM (RH7.2) image (instead of Win Hyper-V) over the same host and=
 SRIOV is working for me there.
> > > > >=20
> > > > > Here the XML file I use to define the VM (our emulated NIC is a=
dded at the end of XML):
> > > > > "
> > > > > <domain type=3D'kvm' xmlns:qemu=3D'http://libvirt.org/schemas/d=
omain/qemu/1.0'>
> > > > >     <name>nst105</name>
> > > > >     <uuid>0249a525-2ee2-432b-a1f5-a6db83b089a3</uuid>
> > > > >     <memory unit=3D'KiB'>8388608</memory>
> > > > >     <currentMemory unit=3D'KiB'>8388608</currentMemory>
> > > > >     <vcpu placement=3D'static'>8</vcpu>
> > > > >     <resource>
> > > > >       <partition>/machine</partition>
> > > > >     </resource>
> > > > >     <os>
> > > > >       <type arch=3D'x86_64' machine=3D'pc-q35-2.11'>hvm</type>
> > > > >     </os>
> > > > >     <features>
> > > > >       <acpi/>
> > > > >       <apic/>
> > > > >       <hyperv>
> > > > >         <relaxed state=3D'on'/>
> > > > >         <vapic state=3D'on'/>
> > > > >         <spinlocks state=3D'on' retries=3D'8191'/>
> > > > >       </hyperv>
> > > > >     </features>
> > > > >     <cpu mode=3D'custom' match=3D'exact' check=3D'none'>
> > > > >       <model fallback=3D'forbid'>SandyBridge</model>
> > > > >       <feature policy=3D'require' name=3D'hypervisor'/>
> > > > >       <feature policy=3D'require' name=3D'vmx'/>
> > > > >     </cpu>
> > > > >     <clock offset=3D'localtime'>
> > > > >       <timer name=3D'rtc' tickpolicy=3D'catchup'/>
> > > > >       <timer name=3D'pit' tickpolicy=3D'delay'/>
> > > > >       <timer name=3D'hpet' present=3D'no'/>
> > > > >       <timer name=3D'hypervclock' present=3D'yes'/>
> > > > >     </clock>
> > > > >     <on_poweroff>destroy</on_poweroff>
> > > > >     <on_reboot>restart</on_reboot>
> > > > >     <on_crash>destroy</on_crash>
> > > > >     <pm>
> > > > >       <suspend-to-mem enabled=3D'no'/>
> > > > >       <suspend-to-disk enabled=3D'no'/>
> > > > >     </pm>
> > > > >     <devices>
> > > > >       <emulator>/opt/qemu/bin/qemu-system-x86_64</emulator>
> > > > >       <disk type=3D'file' device=3D'disk'>
> > > > >         <driver name=3D'qemu' type=3D'qcow2'/>
> > > > >         <source file=3D'/images/nst105.qcow2'/>
> > > > >         <target dev=3D'sda' bus=3D'sata'/>
> > > > >         <boot order=3D'2'/>
> > > > >         <address type=3D'drive' controller=3D'0' bus=3D'0' targ=
et=3D'0' unit=3D'0'/>
> > > > >       </disk>
> > > > >       <controller type=3D'usb' index=3D'0' model=3D'ich9-ehci1'=
>
> > > > >         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' sl=
ot=3D'0x1d' function=3D'0x7'/>
> > > > >       </controller>
> > > > >       <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci1'=
>
> > > > >         <master startport=3D'0'/>
> > > > >         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' sl=
ot=3D'0x1d' function=3D'0x0' multifunction=3D'on'/>
> > > > >       </controller>
> > > > >       <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci2'=
>
> > > > >         <master startport=3D'2'/>
> > > > >         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' sl=
ot=3D'0x1d' function=3D'0x1'/>
> > > > >       </controller>
> > > > >       <controller type=3D'usb' index=3D'0' model=3D'ich9-uhci3'=
>
> > > > >         <master startport=3D'4'/>
> > > > >         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' sl=
ot=3D'0x1d' function=3D'0x2'/>
> > > > >       </controller>
> > > > >       <controller type=3D'sata' index=3D'0'>
> > > > >         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' sl=
ot=3D'0x1f' function=3D'0x2'/>
> > > > >       </controller>
> > > > >       <controller type=3D'pci' index=3D'0' model=3D'pcie-root'/=
>
> > > > >       <controller type=3D'pci' index=3D'1' model=3D'pcie-root-p=
ort'>
> > > > >         <model name=3D'pcie-root-port'/>
> > > > >         <target chassis=3D'1' port=3D'0x10'/>
> > > > >         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' sl=
ot=3D'0x02' function=3D'0x0' multifunction=3D'on'/>
> > > > >       </controller>
> > > > >       <controller type=3D'pci' index=3D'2' model=3D'pcie-root-p=
ort'>
> > > > >         <model name=3D'pcie-root-port'/>
> > > > >         <target chassis=3D'2' port=3D'0x11'/>
> > > > >         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' sl=
ot=3D'0x02' function=3D'0x1'/>
> > > > >       </controller>
> > > > >       <controller type=3D'pci' index=3D'3' model=3D'pcie-root-p=
ort'>
> > > > >         <model name=3D'pcie-root-port'/>
> > > > >         <target chassis=3D'3' port=3D'0x12'/>
> > > > >         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' sl=
ot=3D'0x02' function=3D'0x2'/>
> > > > >       </controller>
> > > > >       <controller type=3D'pci' index=3D'4' model=3D'dmi-to-pci-=
bridge'>
> > > > >         <model name=3D'i82801b11-bridge'/>
> > > > >         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' sl=
ot=3D'0x1e' function=3D'0x0'/>
> > > > >       </controller>
> > > > >       <controller type=3D'pci' index=3D'5' model=3D'pci-bridge'=
>
> > > > >         <model name=3D'pci-bridge'/>
> > > > >         <target chassisNr=3D'5'/>
> > > > >         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x04' sl=
ot=3D'0x00' function=3D'0x0'/>
> > > > >       </controller>
> > > > >       <interface type=3D'bridge'>
> > > > >         <mac address=3D'00:50:56:1b:dd:6f'/>
> > > > >         <source bridge=3D'br0'/>
> > > > >         <model type=3D'virtio'/>
> > > > >         <boot order=3D'1'/>
> > > > >         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x01' sl=
ot=3D'0x00' function=3D'0x0'/>
> > > > >       </interface>
> > > > >       <serial type=3D'pty'>
> > > > >         <target port=3D'0'/>
> > > > >       </serial>
> > > > >       <console type=3D'pty'>
> > > > >         <target type=3D'serial' port=3D'0'/>
> > > > >       </console>
> > > > >       <input type=3D'tablet' bus=3D'usb'>
> > > > >         <address type=3D'usb' bus=3D'0' port=3D'1'/>
> > > > >       </input>
> > > > >       <input type=3D'mouse' bus=3D'ps2'/>
> > > > >       <input type=3D'keyboard' bus=3D'ps2'/>
> > > > >       <graphics type=3D'vnc' port=3D'-1' autoport=3D'yes' liste=
n=3D'127.0.0.1' keymap=3D'en-us'>
> > > > >         <listen type=3D'address' address=3D'127.0.0.1'/>
> > > > >       </graphics>
> > > > >       <video>
> > > > >         <model type=3D'vga' vram=3D'16384' heads=3D'1' primary=3D=
'yes'/>
> > > > >         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x00' sl=
ot=3D'0x01' function=3D'0x0'/>
> > > > >       </video>
> > > > >       <memballoon model=3D'virtio'>
> > > > >         <address type=3D'pci' domain=3D'0x0000' bus=3D'0x02' sl=
ot=3D'0x00' function=3D'0x0'/>
> > > > >       </memballoon>
> > > > >     </devices>
> > > > >     <seclabel type=3D'none' model=3D'none'/>
> > > > >     <seclabel type=3D'dynamic' model=3D'dac' relabel=3D'yes'/>
> > > > >     <qemu:commandline>
> > > > >       <qemu:arg value=3D'-device'/>
> > > > >       <qemu:arg value=3D'pcie-root-port,pref64-reserve=3D500M,s=
lot=3D0,id=3Dpcie_port.1'/>
> > > > >       <qemu:arg value=3D'-netdev'/>
> > > > >       <qemu:arg value=3D'tap,id=3Dtap5,ifname=3Dtap5,script=3Dn=
o,downscript=3Dno'/>
> > > > >       <qemu:arg value=3D'-device'/>
> > > > >       <qemu:arg value=3D'my_emu_nic,netdev=3Dtap5,bus=3Dpcie_po=
rt.1'/>
> > > > >     </qemu:commandline>
> > > > > </domain>
> > > > > "
> > > > > ______________________
> > > > > General info:
> > > > > Host OS: RH7.0 (Kernel: 4.14.13)
> > > > > QEMU version: 2.11
> > > > > libvirt version: 3.2.0
> > > > > Running the following on the host shows that both nested and IO=
MMU are
> > > > > enabled:
> > > > > ~]#: cat /sys/module/kvm_intel/parameters/nested
> > > > > Y
> > > > > ~]# dmesg | grep -e DMAR -e IOMMU
> > > > > [    0.000000] DMAR: IOMMU enabled
> > > > >=20
> > > > > Thanks,
> > > > > Elijah
> > > > >=20
