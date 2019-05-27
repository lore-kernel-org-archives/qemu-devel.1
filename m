Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4674C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89BA620859
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 12:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BA620859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45499 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVF7l-0003yg-Oi
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 08:53:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1hVF5y-00030U-SX
	for qemu-devel@nongnu.org; Mon, 27 May 2019 08:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1hVF5x-00028z-1x
	for qemu-devel@nongnu.org; Mon, 27 May 2019 08:51:18 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:34344 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujunjie23@huawei.com>)
	id 1hVF5w-00023L-HF
	for qemu-devel@nongnu.org; Mon, 27 May 2019 08:51:17 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
	by Forcepoint Email with ESMTP id 4F44986D39BB69E7660A;
	Mon, 27 May 2019 20:51:06 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
	DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Mon, 27 May 2019 20:51:06 +0800
Received: from DGGEMM521-MBX.china.huawei.com ([169.254.4.56]) by
	dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id
	14.03.0439.000; Mon, 27 May 2019 20:51:00 +0800
From: "liujunjie (A)" <liujunjie23@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Thread-Topic: Question about wrong ram-node0 reference
Thread-Index: AdUSqrvZOubDxvGnQFyIol9vimbQhwBc/9gAABqnK/A=
Date: Mon, 27 May 2019 12:51:00 +0000
Message-ID: <B526101FCAB4654DB0892B650DEFC55527EED5C6@dggemm521-mbx.china.huawei.com>
References: <B526101FCAB4654DB0892B650DEFC55527EECB46@dggemm521-mbx.china.huawei.com>
	<20190527095644.36b8fea8@redhat.com>
In-Reply-To: <20190527095644.36b8fea8@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.68.90]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.255
Subject: Re: [Qemu-devel] Question about wrong ram-node0 reference
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Huangweidong \(C\)" <weidong.huang@huawei.com>,
	"ehabkost@redhat.com" <ehabkost@redhat.com>,
	"wangxin \(U\)" <wangxinxin.wang@huawei.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"Zhoujian \(jay\)" <jianjay.zhou@huawei.com>,
	fangying <fangying1@huawei.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"afaerber@suse.de" <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We find only one VM aborted among at least 20 VMs with the same configurati=
on.=20
And this problem does not reproduce yet... (Be aware of reproduce is import=
ance to figure out the problem, we already tried to add more VMs to reprodu=
ce, but no results yet.)
The qemu cmdline is as follows:
/usr/bin/qemu-kvm -name guest=3Dinstance-00025bf8,debug-threads=3Don -S -ob=
ject secret,id=3DmasterKey0,format=3Draw,file=3D/var/run/libvirt/qemu/domai=
n-118-instance-00025bf8/master-key.aes -machine pc-i440fx-2.8,accel=3Dkvm,u=
sb=3Doff,dump-guest-core=3Doff,max-ram-below-4g=3D2G -cpu host,host-cache-i=
nfo=3Don -m 131072 -realtime min_guarantee=3D131072,mlock=3Doff -smp 16,soc=
kets=3D2,cores=3D4,threads=3D2 -object iothread,id=3Diothread1 -object ioth=
read,id=3Diothread2 -object iothread,id=3Diothread3 -object iothread,id=3Di=
othread4 -object iothread,id=3Diothread5 -object iothread,id=3Diothread6 -o=
bject iothread,id=3Diothread7 -object iothread,id=3Diothread8 -object iothr=
ead,id=3Diothread9 -object iothread,id=3Diothread10 -object iothread,id=3Di=
othread11 -object iothread,id=3Diothread12 -object iothread,id=3Diothread13=
 -object iothread,id=3Diothread14 -object iothread,id=3Diothread15 -object =
iothread,id=3Diothread16 -object iothread,id=3Diothread17 -object iothread,=
id=3Diothread18 -object iothread,id=3Diothread19 -object iothread,id=3Dioth=
read20 -object iothread,id=3Diothread21 -object iothread,id=3Diothread22 -o=
bject iothread,id=3Diothread23 -object iothread,id=3Diothread24 -object iot=
hread,id=3Diothread25 -object iothread,id=3Diothread26 -object iothread,id=
=3Diothread27 -object iothread,id=3Diothread28 -object iothread,id=3Diothre=
ad29 -object memory-backend-file,id=3Dram-node0,prealloc=3Dyes,mem-path=3D/=
dev/hugepages/libvirt/qemu/118-instance-00025bf8,share=3Dyes,size=3D6871947=
6736,host-nodes=3D0,policy=3Dbind -numa node,nodeid=3D0,cpus=3D0-7,memdev=
=3Dram-node0 -object memory-backend-file,id=3Dram-node1,prealloc=3Dyes,mem-=
path=3D/dev/hugepages/libvirt/qemu/118-instance-00025bf8,share=3Dyes,size=
=3D68719476736,host-nodes=3D1,policy=3Dbind -numa node,nodeid=3D1,cpus=3D8-=
15,memdev=3Dram-node1 -uuid 6952c043-4e0c-4267-80c1-fac2e302443f -smbios ty=
pe=3D1,manufacturer=3DOpenStack Foundation,product=3DOpenStack Nova,version=
=3D13.2.1-20181119144459,serial=3Dc5cc21e6-1d3b-4587-8c1e-208a1d19a47e,uuid=
=3D6952c043-4e0c-4267-80c1-fac2e302443f,family=3DVirtual Machine -no-user-c=
onfig -nodefaults -chardev socket,id=3Dcharmonitor,path=3D/var/run/libvirt/=
qemu/domain-118-instance-00025bf8/monitor.sock,server,nowait -mon chardev=
=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3D2019-01-21T06:59:37,=
clock=3Dvm,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay -no-hpe=
t -no-shutdown -boot strict=3Don -device pci-bridge,chassis_nr=3D1,id=3Dpci=
.1,bus=3Dpci.0,addr=3D0x3 -device pci-bridge,chassis_nr=3D2,id=3Dpci.2,bus=
=3Dpci.0,addr=3D0x4 -device pci-bridge,chassis_nr=3D3,id=3Dpci.3,bus=3Dpci.=
0,addr=3D0x5 -device pci-bridge,chassis_nr=3D4,id=3Dpci.4,bus=3Dpci.0,addr=
=3D0x6 -device pci-bridge,chassis_nr=3D5,id=3Dpci.5,bus=3Dpci.0,addr=3D0x7 =
-device pci-bridge,chassis_nr=3D6,id=3Dpci.6,bus=3Dpci.0,addr=3D0x8 -device=
 pci-bridge,chassis_nr=3D7,id=3Dpci.7,bus=3Dpci.0,addr=3D0x9 -device pci-br=
idge,chassis_nr=3D8,id=3Dpci.8,bus=3Dpci.0,addr=3D0xa -device piix3-usb-uhc=
i,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2 -device virtio-serial-pci,id=3Dvirtio=
-serial0,bus=3Dpci.0,addr=3D0xb -drive file=3D/dev/mapper/648d06e72e68404a9=
401854e21409f3d-dm,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0,serial=3D=
648d06e7-2e68-404a-9401-854e21409f3d,cache=3Dnone,aio=3Dnative -device virt=
io-blk-pci,scsi=3Doff,bus=3Dpci.2,addr=3D0x1,drive=3Ddrive-virtio-disk0,id=
=3Dvirtio-disk0,bootindex=3D1 -chardev socket,id=3Dcharnet0,path=3D/var/run=
/vhost-user/tap4ba9f4eb-19 -netdev vhost-user,chardev=3Dcharnet0,queues=3D4=
,id=3Dhostnet0 -device virtio-net-pci,mq=3Don,vectors=3D10,netdev=3Dhostnet=
0,id=3Dnet0,mac=3Dfa:16:3e:0f:ed:94,bus=3Dpci.4,addr=3D0x3,bootindex=3D2 -a=
dd-fd set=3D0,fd=3D45 -chardev file,id=3Dcharserial0,path=3D/dev/fdset/0,ap=
pend=3Don -device isa-serial,chardev=3Dcharserial0,id=3Dserial0 -chardev so=
cket,id=3Dcharchannel0,path=3D/var/run/libvirt/qemu/instance-00025bf8.exten=
d,server,nowait -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D1,charde=
v=3Dcharchannel0,id=3Dchannel0,name=3Dorg.qemu.guest_agent.1 -chardev socke=
t,id=3Dcharchannel1,path=3D/var/run/libvirt/qemu/instance-00025bf8.agent,se=
rver,nowait -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D2,chardev=3D=
charchannel1,id=3Dchannel1,name=3Dorg.qemu.guest_agent.0 -chardev socket,id=
=3Dcharchannel2,path=3D/var/run/libvirt/qemu/instance-00025bf8.hostd,server=
,nowait -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D3,chardev=3Dchar=
channel2,id=3Dchannel2,name=3Dorg.qemu.guest_agent.2 -chardev socket,id=3Dc=
harchannel3,path=3D/var/run/libvirt/qemu/instance-00025bf8.upgraded,server,=
nowait -device virtserialport,bus=3Dvirtio-serial0.0,nr=3D4,chardev=3Dcharc=
hannel3,id=3Dchannel3,name=3Dorg.qemu.guest_agent.3 -device usb-tablet,id=
=3Dinput0,bus=3Dusb.0,port=3D1 -vnc 172.28.5.246:3,password -k en-us -devic=
e cirrus-vga,id=3Dvideo0,vgamem_mb=3D16,bus=3Dpci.0,addr=3D0x2 -device vfio=
-pci,host=3D95:00.0,id=3Dhostdev0,bus=3Dpci.5,addr=3D0x1 -device vfio-pci,h=
ost=3D99:00.0,id=3Dhostdev1,bus=3Dpci.5,addr=3D0x2 -device vfio-pci,host=3D=
35:00.0,id=3Dhostdev2,peer-clique-id=3D0,iomem=3D0x98000000-0x98ffffff:0x3e=
800000000-0x3ebffffffff:0x3ec00000000-0x3ec01ffffff,bus=3Dpci.0,addr=3D0xc =
-device vfio-pci,host=3D39:00.0,id=3Dhostdev3,peer-clique-id=3D0,iomem=3D0x=
92000000-0x92ffffff:0x3e000000000-0x3e3ffffffff:0x3e400000000-0x3e401ffffff=
,bus=3Dpci.0,addr=3D0xd -global p2p.downstream_ports=3D28:10.0 28:14.0 -dev=
ice virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0xe -NetInterruptAu=
tobind -chardev file,id=3Dseabios,path=3D/var/log/libvirt/qemu/instance-000=
25bf8.seabios,mux=3Doff,append=3Don -device isa-debugcon,iobase=3D0x402,cha=
rdev=3Dseabios -msg timestamp=3Don

> -----Original Message-----
> From: Igor Mammedov [mailto:imammedo@redhat.com]
> Sent: Monday, May 27, 2019 3:57 PM
> To: liujunjie (A) <liujunjie23@huawei.com>
> Cc: pbonzini@redhat.com; afaerber@suse.de; ehabkost@redhat.com;
> qemu-devel@nongnu.org; Zhoujian (jay) <jianjay.zhou@huawei.com>; fangying
> <fangying1@huawei.com>; wangxin (U) <wangxinxin.wang@huawei.com>;
> Huangweidong (C) <weidong.huang@huawei.com>
> Subject: Re: Question about wrong ram-node0 reference
>=20
> On Sat, 25 May 2019 03:35:20 +0000
> "liujunjie (A)" <liujunjie23@huawei.com> wrote:
>=20
> > Hi, I have met a problem:
> >
> > The QEMU version is 2.8.1, the virtual machine is configured with 1G hu=
ge
> pages, two NUMA nodes and four pass-through NVME SSDs.
> >
> > After we started the VM, in addition to some QMP queries nothing more h=
as
> been done, the QEMU aborted after some months later.
> > After that, the VM is restarted, and the problem does not reproduce yet=
.
> > And The backtrace of the RCU thread is as follows:
> > (gdb) bt
> > #0  0x00007fd2695f0197 in raise () from /usr/lib64/libc.so.6
> > #1  0x00007fd2695f1888 in abort () from /usr/lib64/libc.so.6
> > #2  0x00007fd2695e9206 in __assert_fail_base () from /usr/lib64/libc.so=
.6
> > #3  0x00007fd2695e92b2 in __assert_fail () from /usr/lib64/libc.so.6
> > #4  0x0000000000476a84 in memory_region_finalize (obj=3D<optimized out>=
)
> >     at /home/abuild/rpmbuild/BUILD/qemu-kvm-2.8.1/memory.c:1512
> > #5  0x0000000000763105 in object_deinit (obj=3Dobj@entry=3D0x1dc1fd0,
> >     type=3Dtype@entry=3D0x1d065b0) at qom/object.c:448
> > #6  0x0000000000763153 in object_finalize (data=3D0x1dc1fd0) at
> qom/object.c:462
> > #7  0x00000000007627cc in object_property_del_all
> (obj=3Dobj@entry=3D0x1dc1f70)
> >     at qom/object.c:399
> > #8  0x0000000000763148 in object_finalize (data=3D0x1dc1f70) at
> qom/object.c:461
> > #9  0x0000000000764426 in object_unref (obj=3D<optimized out>) at
> qom/object.c:897
> > #10 0x0000000000473b6b in memory_region_unref (mr=3D<optimized out>)
> >     at /home/abuild/rpmbuild/BUILD/qemu-kvm-2.8.1/memory.c:1560
> > #11 0x0000000000473bc7 in flatview_destroy (view=3D0x7fc188b9cb90)
> >     at /home/abuild/rpmbuild/BUILD/qemu-kvm-2.8.1/memory.c:289
> > #12 0x0000000000843be0 in call_rcu_thread (opaque=3D<optimized out>)
> >     at util/rcu.c:279
> > #13 0x00000000008325c2 in qemu_thread_start
> (args=3Dargs@entry=3D0x1d00810)
> >     at util/qemu_thread_posix.c:496
> > #14 0x00007fd269983dc5 in start_thread () from /usr/lib64/libpthread.so=
.0
> > #15 0x00007fd2696b27bd in clone () from /usr/lib64/libc.so.6
> >
> > In this core, I found that the reference of "/objects/ram-node0"( the t=
ype of
> ram-node0 is struct "HostMemoryBackendFile") equals to 0 , while the
> reference of "/objects/ram-node1" equals to 129, more details can be seen=
 at
> the end of this email.
> >
> > I searched through the community, and found a case that had the same er=
ror
> report:
> https://mail.coreboot.org/pipermail/seabios/2017-September/011799.html
> > However, I did not configure pcie_pci_bridge. Besides, qemu aborted in
> device initialization phase in this case.
> That case doesn't seem relevant.
>=20
> >
> > Also, I try to find out which can reference "/objects/ram-node0" so as =
to look
> for the one that may un reference improperly, most of them lie in the fun=
ction
> of "render_memory_region" or "phys_section_add" when memory topology
> changes.
> > Later, the temporary flatviews are destroyed by RCU thread, so un refer=
ence
> happened and the backtrace is similar to the one shown above.
> > But I am not familiar with the detail of these process, it is hard to k=
eep trace
> of these memory topology changes.
> >
> > My question is:
> > How can ram-node0's reference comes down to 0 when the virtual machine =
is
> still running?
> >
> > Maybe someone who is familiar with memory_region_ref or
> memory-backend-file can help me figure out.
> > Any idea is appreciated.
>=20
> Could you provide steps to reproduce (incl. command line)?
>=20
> [...]
> > Thanks,
> > Junjie Liu
> >


