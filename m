Received: from eggs.gnu.org ([2001:4830:134:3::10]:43794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fijhv-0002hD-5a
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fijhr-0008Bq-TM
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:05:43 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fijhr-0008B2-5L
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 13:05:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id c13-v6so2430331wrt.1
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 10:05:39 -0700 (PDT)
References: <DB5PR05MB11605C65D7D734C9354F0421D54F0@DB5PR05MB1160.eurprd05.prod.outlook.com>
	<1407239306.11199051.1530240887935.JavaMail.zimbra@redhat.com>
	<20180705194311-mutt-send-email-mst@kernel.org>
	<DB5PR05MB1160D84E747DA480435B6605D5440@DB5PR05MB1160.eurprd05.prod.outlook.com>
	<DB5PR05MB1160BB381473C723C8336EC2D55A0@DB5PR05MB1160.eurprd05.prod.outlook.com>
	<AM5PR0501MB2499CB4F2D01BCDA47C0ACB6C95A0@AM5PR0501MB2499.eurprd05.prod.outlook.com>
	<DB5PR05MB1160093E018FD91787E80A79D5590@DB5PR05MB1160.eurprd05.prod.outlook.com>
	<20180726145214.GD17777@stefanha-x1.localdomain>
	<488bdc8d-e36c-ad3e-f7b3-a45a78a99dda@gmail.com>
	<1532623112.2458.172.camel@oracle.com>
	<20180726193949-mutt-send-email-mst@kernel.org>
	<1532623371.2458.174.camel@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <9e3bedbf-e6a7-61ae-babd-79a9ec13da24@gmail.com>
Date: Thu, 26 Jul 2018 20:05:35 +0300
MIME-Version: 1.0
In-Reply-To: <1532623371.2458.174.camel@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
To: Knut Omang <knut.omang@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Elijah Shakkour <elijahs@mellanox.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Tal Attaly <talat@mellanox.com>



On 07/26/2018 07:42 PM, Knut Omang wrote:
> On Thu, 2018-07-26 at 19:41 +0300, Michael S. Tsirkin wrote:
>> On Thu, Jul 26, 2018 at 06:38:32PM +0200, Knut Omang wrote:
>>> On Thu, 2018-07-26 at 18:51 +0300, Marcel Apfelbaum wrote:
>>>> Hi
>>>>
>>>> On 07/26/2018 05:52 PM, Stefan Hajnoczi wrote:
>>>>> On Thu, Jul 12, 2018 at 07:33:14AM +0000, Elijah Shakkour wrote:
>>>>>> Hey,
>>>>>>
>>>>>> Our team is adding a NIC functional  emulation to QEMU.
>>>>>> One of the features we are adding to this NIC is SRIOV.
>>>>>>
>>>>>> Here is the error message I get when checking SRIOV support of  our
>>>>>> emulated NIC on Win2016 server (the hyper-v VM).
>>>>>> "
>>>>>> SR-IOV cannot be used on this system as the PCI Express hardware does
>>>>>> not
>>>>>> support Access Control Services (ACS) at any root port.
>>>> QEMU's emulated PCI Express Root Ports do not support ACS yet, however I
>>>> am not sure ACS is a prerequisite
>>>> for SR-IOV. We would need ARI support for allowing more than 8VFs, but
>>>> QEMU doesn't support that either (yet).
>>>>
>>>> Knut Omag has some working patches, he successfully implemented SR-IOV
>>>> with QEMU, see:
>>>>        https://github.com/knuto/qemu/tree/sriov_patches_v7
>>>>
>>>> The code was not merged since we need at least a device with SR-IOV
>>>> support to justify the addition.
>>> FYI, I recently rebased these to latest master but just didn't get to push
>>> them
>>> out. I did just now - they are available here:
>>>
>>>     https://github.com/knuto/qemu/tree/sriov_patches_v8
>>>
>>> As far as I know ARI support with my patch set works just fine - I have
>>> tested
>>> it with lots of VFs.
>>>
>>> One of the patches in the series (pci: Make use of the devfn property when
>>> registering new devices) is necessary to make ARI work as it should with
>>> SR/IOV.
>>>
>>> For the hardware model I developed the SR/IOV patches for, I also added
>>> enough
>>> ACS support in the root port (PCIe capability helper patch + usage in
>>> ioh3420) to make VFIO "happy". I haven't submitted them because they
>>> are "questionable" since they likely do not reflect the actual features of
>>> the
>>> ioh3420.
>> In that the actual ioh3420 doesn't support ACS?
> yes.. I don't have one so I don't know but that was my assumption..

Hi Knut,

We have now a generic PCIe Root Port we can add whatever we want to it.
See please hw/pci-bridge/gen_pcie_root_port.c.

So your patches add both ARI and ACS support, nice!
Maybe it worth merging at least these features.

Thanks,
Marcel

>
> Knut
>
>>> I can make those available if interesting.
>>>
>>> Thanks,
>>> Knut
>>>
>>>>>> Contact your system vendor for further information.
>>>>>> "
>>>>> I'm not sure what the status of emulated SR-IOV is so I have CCed
>>>>> Michael Tsirkin and Marcel Apfelbaum, the PCI maintainers in QEMU.
>>>> Thanks,
>>>> Marcel
>>>>
>>>>>> Could you please advise about what could be the issue here?
>>>>>>
>>>>>> BTW: I use same configuration (VM XML file attached) when running
>>>>>> linux VM
>>>>>> (RH7.2) image (instead of Win Hyper-V) over the same host and SRIOV is
>>>>>> working for me there.
>>>>>>
>>>>>> Here the XML file I use to define the VM (our emulated NIC is added at
>>>>>> the
>>>>>> end of XML):
>>>>>> "
>>>>>> <domain type='kvm' xmlns:qemu='http://libvirt.org/schemas/domain/qemu/
>>>>>> 1.0'
>>>>>>> ;
>>>>>>     <name>nst105</name>
>>>>>>     <uuid>0249a525-2ee2-432b-a1f5-a6db83b089a3</uuid>
>>>>>>     <memory unit='KiB'>8388608</memory>
>>>>>>     <currentMemory unit='KiB'>8388608</currentMemory>
>>>>>>     <vcpu placement='static'>8</vcpu>
>>>>>>     <resource>
>>>>>>       <partition>/machine</partition>
>>>>>>     </resource>
>>>>>>     <os>
>>>>>>       <type arch='x86_64' machine='pc-q35-2.11'>hvm</type>
>>>>>>     </os>
>>>>>>     <features>
>>>>>>       <acpi/>
>>>>>>       <apic/>
>>>>>>       <hyperv>
>>>>>>         <relaxed state='on'/>
>>>>>>         <vapic state='on'/>
>>>>>>         <spinlocks state='on' retries='8191'/>
>>>>>>       </hyperv>
>>>>>>     </features>
>>>>>>     <cpu mode='custom' match='exact' check='none'>
>>>>>>       <model fallback='forbid'>SandyBridge</model>
>>>>>>       <feature policy='require' name='hypervisor'/>
>>>>>>       <feature policy='require' name='vmx'/>
>>>>>>     </cpu>
>>>>>>     <clock offset='localtime'>
>>>>>>       <timer name='rtc' tickpolicy='catchup'/>
>>>>>>       <timer name='pit' tickpolicy='delay'/>
>>>>>>       <timer name='hpet' present='no'/>
>>>>>>       <timer name='hypervclock' present='yes'/>
>>>>>>     </clock>
>>>>>>     <on_poweroff>destroy</on_poweroff>
>>>>>>     <on_reboot>restart</on_reboot>
>>>>>>     <on_crash>destroy</on_crash>
>>>>>>     <pm>
>>>>>>       <suspend-to-mem enabled='no'/>
>>>>>>       <suspend-to-disk enabled='no'/>
>>>>>>     </pm>
>>>>>>     <devices>
>>>>>>       <emulator>/opt/qemu/bin/qemu-system-x86_64</emulator>
>>>>>>       <disk type='file' device='disk'>
>>>>>>         <driver name='qemu' type='qcow2'/>
>>>>>>         <source file='/images/nst105.qcow2'/>
>>>>>>         <target dev='sda' bus='sata'/>
>>>>>>         <boot order='2'/>
>>>>>>         <address type='drive' controller='0' bus='0' target='0'
>>>>>> unit='0'/>
>>>>>>       </disk>
>>>>>>       <controller type='usb' index='0' model='ich9-ehci1'>
>>>>>>         <address type='pci' domain='0x0000' bus='0x00' slot='0x1d'
>>>>>> function='0x7'/>
>>>>>>       </controller>
>>>>>>       <controller type='usb' index='0' model='ich9-uhci1'>
>>>>>>         <master startport='0'/>
>>>>>>         <address type='pci' domain='0x0000' bus='0x00' slot='0x1d'
>>>>>> function='0x0' multifunction='on'/>
>>>>>>       </controller>
>>>>>>       <controller type='usb' index='0' model='ich9-uhci2'>
>>>>>>         <master startport='2'/>
>>>>>>         <address type='pci' domain='0x0000' bus='0x00' slot='0x1d'
>>>>>> function='0x1'/>
>>>>>>       </controller>
>>>>>>       <controller type='usb' index='0' model='ich9-uhci3'>
>>>>>>         <master startport='4'/>
>>>>>>         <address type='pci' domain='0x0000' bus='0x00' slot='0x1d'
>>>>>> function='0x2'/>
>>>>>>       </controller>
>>>>>>       <controller type='sata' index='0'>
>>>>>>         <address type='pci' domain='0x0000' bus='0x00' slot='0x1f'
>>>>>> function='0x2'/>
>>>>>>       </controller>
>>>>>>       <controller type='pci' index='0' model='pcie-root'/>
>>>>>>       <controller type='pci' index='1' model='pcie-root-port'>
>>>>>>         <model name='pcie-root-port'/>
>>>>>>         <target chassis='1' port='0x10'/>
>>>>>>         <address type='pci' domain='0x0000' bus='0x00' slot='0x02'
>>>>>> function='0x0' multifunction='on'/>
>>>>>>       </controller>
>>>>>>       <controller type='pci' index='2' model='pcie-root-port'>
>>>>>>         <model name='pcie-root-port'/>
>>>>>>         <target chassis='2' port='0x11'/>
>>>>>>         <address type='pci' domain='0x0000' bus='0x00' slot='0x02'
>>>>>> function='0x1'/>
>>>>>>       </controller>
>>>>>>       <controller type='pci' index='3' model='pcie-root-port'>
>>>>>>         <model name='pcie-root-port'/>
>>>>>>         <target chassis='3' port='0x12'/>
>>>>>>         <address type='pci' domain='0x0000' bus='0x00' slot='0x02'
>>>>>> function='0x2'/>
>>>>>>       </controller>
>>>>>>       <controller type='pci' index='4' model='dmi-to-pci-bridge'>
>>>>>>         <model name='i82801b11-bridge'/>
>>>>>>         <address type='pci' domain='0x0000' bus='0x00' slot='0x1e'
>>>>>> function='0x0'/>
>>>>>>       </controller>
>>>>>>       <controller type='pci' index='5' model='pci-bridge'>
>>>>>>         <model name='pci-bridge'/>
>>>>>>         <target chassisNr='5'/>
>>>>>>         <address type='pci' domain='0x0000' bus='0x04' slot='0x00'
>>>>>> function='0x0'/>
>>>>>>       </controller>
>>>>>>       <interface type='bridge'>
>>>>>>         <mac address='00:50:56:1b:dd:6f'/>
>>>>>>         <source bridge='br0'/>
>>>>>>         <model type='virtio'/>
>>>>>>         <boot order='1'/>
>>>>>>         <address type='pci' domain='0x0000' bus='0x01' slot='0x00'
>>>>>> function='0x0'/>
>>>>>>       </interface>
>>>>>>       <serial type='pty'>
>>>>>>         <target port='0'/>
>>>>>>       </serial>
>>>>>>       <console type='pty'>
>>>>>>         <target type='serial' port='0'/>
>>>>>>       </console>
>>>>>>       <input type='tablet' bus='usb'>
>>>>>>         <address type='usb' bus='0' port='1'/>
>>>>>>       </input>
>>>>>>       <input type='mouse' bus='ps2'/>
>>>>>>       <input type='keyboard' bus='ps2'/>
>>>>>>       <graphics type='vnc' port='-1' autoport='yes' listen='127.0.0.1'
>>>>>> keymap='en-us'>
>>>>>>         <listen type='address' address='127.0.0.1'/>
>>>>>>       </graphics>
>>>>>>       <video>
>>>>>>         <model type='vga' vram='16384' heads='1' primary='yes'/>
>>>>>>         <address type='pci' domain='0x0000' bus='0x00' slot='0x01'
>>>>>> function='0x0'/>
>>>>>>       </video>
>>>>>>       <memballoon model='virtio'>
>>>>>>         <address type='pci' domain='0x0000' bus='0x02' slot='0x00'
>>>>>> function='0x0'/>
>>>>>>       </memballoon>
>>>>>>     </devices>
>>>>>>     <seclabel type='none' model='none'/>
>>>>>>     <seclabel type='dynamic' model='dac' relabel='yes'/>
>>>>>>     <qemu:commandline>
>>>>>>       <qemu:arg value='-device'/>
>>>>>>       <qemu:arg value='pcie-root-port,pref64-
>>>>>> reserve=500M,slot=0,id=pcie_port.1'/>
>>>>>>       <qemu:arg value='-netdev'/>
>>>>>>       <qemu:arg
>>>>>> value='tap,id=tap5,ifname=tap5,script=no,downscript=no'/>
>>>>>>       <qemu:arg value='-device'/>
>>>>>>       <qemu:arg value='my_emu_nic,netdev=tap5,bus=pcie_port.1'/>
>>>>>>     </qemu:commandline>
>>>>>> </domain>
>>>>>> "
>>>>>> ______________________
>>>>>> General info:
>>>>>> Host OS: RH7.0 (Kernel: 4.14.13)
>>>>>> QEMU version: 2.11
>>>>>> libvirt version: 3.2.0
>>>>>> Running the following on the host shows that both nested and IOMMU are
>>>>>> enabled:
>>>>>> ~]#: cat /sys/module/kvm_intel/parameters/nested
>>>>>> Y
>>>>>> ~]# dmesg | grep -e DMAR -e IOMMU
>>>>>> [    0.000000] DMAR: IOMMU enabled
>>>>>>
>>>>>> Thanks,
>>>>>> Elijah
>>>>>>
>>>>
