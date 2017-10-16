Received: from eggs.gnu.org ([2001:4830:134:3::10]:34395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.jancys@gmail.com>) id 1e42So-00054a-8J
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 06:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.jancys@gmail.com>) id 1e42Sj-0000uF-GC
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 06:17:38 -0400
Received: from mail-lf0-x234.google.com ([2a00:1450:4010:c07::234]:48865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.jancys@gmail.com>) id 1e42Sj-0000t4-2s
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 06:17:33 -0400
Received: by mail-lf0-x234.google.com with SMTP id a69so16373225lfe.5
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 03:17:31 -0700 (PDT)
Received: from gediminasj ([2001:1ab8:1:4:158:32f4:578a:ac31])
	by smtp.gmail.com with ESMTPSA id
	t81sm1399423lff.84.2017.10.16.03.17.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 16 Oct 2017 03:17:29 -0700 (PDT)
From: =?iso-8859-2?Q?Gediminas_Jan=E8ys?= <g.jancys@gmail.com>
Date: Mon, 16 Oct 2017 13:17:28 +0300
Message-ID: <002d01d34667$f8c9b1e0$ea5d15a0$@gmail.com>
MIME-Version: 1.0
Content-Language: lt
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Windows Server 2008 R2 network freezes after some time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello guys, 

I have a problem and desperate with it, can't find a solution for it. I got
Windows Server 2008 R2 guest OS on CentOS Linux release 7.3.1611 (Core) with
libvirt and CloudStack. Problem is that after some time, about 2- 3 days
(should be based on amount of traffic) VM's network got stuck. No traffic in
or out. After restart network works fine until gets stuck again.  I'm
current using VirtIO drivers on guest version 61.74.104.14100. Also I have
tried to use older drivers but same situation. From host and guest logs I
can't see any entries about drivers or something related to this problem,
only casual stuff. Can you help me or guide to find the problems source?
After my investigation I would say that drivers are failing at some point.

 

Libvirts info:

Using library: libvirt 2.0.0

Using API: QEMU 2.0.0

Running hypervisor: QEMU 2.6.0

 

KVM XML:

<domain type='kvm' id='206'>

  <name>i-25-85-VM</name>

  <uuid>2758a8ec-3e86-4132-9110-1051f0708367</uuid>

  <description>Windows PV</description>

  <maxMemory slots='32' unit='KiB'>197191680</maxMemory>

  <memory unit='KiB'>16777216</memory>

  <currentMemory unit='KiB'>16777216</currentMemory>

  <vcpu placement='auto' current='2'>40</vcpu>

  <cputune>

    <shares>146</shares>

  </cputune>

  <numatune>

    <memory mode='strict' placement='auto'/>

  </numatune>

  <resource>

    <partition>/machine</partition>

  </resource>

  <sysinfo type='smbios'>

    <system>

      <entry name='manufacturer'>Apache Software Foundation</entry>

      <entry name='product'>CloudStack KVM Hypervisor</entry>

      <entry name='uuid'>2758a8ec-3e86-4132-9110-1051f0708367</entry>

    </system>

  </sysinfo>

  <os>

    <type arch='x86_64' machine='pc-i440fx-rhel7.3.0'>hvm</type>

    <boot dev='cdrom'/>

    <boot dev='hd'/>

    <smbios mode='sysinfo'/>

  </os>

  <features>

    <acpi/>

    <apic/>

    <pae/>

  </features>

  <cpu mode='host-passthrough'>

    <numa>

      <cell id='0' cpus='0-39' memory='16777216' unit='KiB'/>

    </numa>

  </cpu>

  <clock offset='localtime'>

    <timer name='rtc' tickpolicy='catchup'/>

  </clock>

  <on_poweroff>destroy</on_poweroff>

  <on_reboot>restart</on_reboot>

  <on_crash>destroy</on_crash>

  <devices>

    <emulator>/usr/libexec/qemu-kvm</emulator>

    <disk type='network' device='disk'>

      <driver name='qemu' type='raw' cache='writeback' discard='unmap'/>

      <auth username='kvm'>

        <secret type='ceph' uuid='8321dbbc-8bab-301b-a89f-d558256ddd8b'/>

      </auth>

      <source protocol='rbd'
name='kvm-pool/ec8e6467-7370-4cdc-bbda-01844e5f9c2c'>

        <host name=xxxxxx.xxxx.xx port='6789'/>

      </source>

      <backingStore/>

      <target dev='sda' bus='scsi'/>

      <serial>ec8e646773704cdcbbda</serial>

      <alias name='scsi0-0-0-0'/>

      <address type='drive' controller='0' bus='0' target='0' unit='0'/>

    </disk>

    <disk type='file' device='cdrom'>

      <driver name='qemu' type='raw' cache='none'/>

      <backingStore/>

      <target dev='hdc' bus='ide'/>

      <readonly/>

      <alias name='ide0-1-0'/>

      <address type='drive' controller='0' bus='1' target='0' unit='0'/>

    </disk>

    <controller type='scsi' index='0' model='virtio-scsi'>

      <driver queues='2'/>

      <alias name='scsi0'/>

      <address type='pci' domain='0x0000' bus='0x00' slot='0x04'
function='0x0'/>

    </controller>

    <controller type='usb' index='0'>

      <alias name='usb'/>

      <address type='pci' domain='0x0000' bus='0x00' slot='0x01'
function='0x2'/>

    </controller>

    <controller type='pci' index='0' model='pci-root'>

      <alias name='pci.0'/>

    </controller>

    <controller type='ide' index='0'>

      <alias name='ide'/>

      <address type='pci' domain='0x0000' bus='0x00' slot='0x01'
function='0x1'/>

    </controller>

    <interface type='bridge'>

      <mac address='06:b2:ec:00:01:97'/>

      <source bridge='brbond0-500'/>

      <target dev='vnet14'/>

      <model type='virtio'/>

      <alias name='net0'/>

      <address type='pci' domain='0x0000' bus='0x00' slot='0x03'
function='0x0'/>

    </interface>

    <serial type='pty'>

      <source path='/dev/pts/13'/>

      <target port='0'/>

      <alias name='serial0'/>

    </serial>

    <console type='pty' tty='/dev/pts/13'>

      <source path='/dev/pts/13'/>

      <target type='serial' port='0'/>

      <alias name='serial0'/>

    </console>

    <input type='tablet' bus='usb'>

      <alias name='input0'/>

      <address type='usb' bus='0' port='1'/>

    </input>

    <input type='mouse' bus='ps2'>

      <alias name='input1'/>

    </input>

    <input type='keyboard' bus='ps2'>

      <alias name='input2'/>

    </input>

    <graphics type='vnc' port='5914' autoport='yes' listen='10.24.99.29'>

      <listen type='address' address='10.24.99.29'/>

    </graphics>

    <video>

      <model type='cirrus' vram='16384' heads='1' primary='yes'/>

      <alias name='video0'/>

      <address type='pci' domain='0x0000' bus='0x00' slot='0x02'
function='0x0'/>

    </video>

    <memballoon model='none'/>

  </devices>

  <seclabel type='none' model='none'/>

  <seclabel type='dynamic' model='dac' relabel='yes'>

    <label>+0:+0</label>

    <imagelabel>+0:+0</imagelabel>

  </seclabel>

</domain>

 

King regards

Gediminas J.

 
