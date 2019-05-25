Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3205C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 03:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E132075C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 03:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E132075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35553 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUNUS-00054J-K8
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 23:37:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1hUNTE-00044V-LK
	for qemu-devel@nongnu.org; Fri, 24 May 2019 23:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujunjie23@huawei.com>) id 1hUNT9-00080u-70
	for qemu-devel@nongnu.org; Fri, 24 May 2019 23:35:44 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2420 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujunjie23@huawei.com>)
	id 1hUNT8-0007sk-B6
	for qemu-devel@nongnu.org; Fri, 24 May 2019 23:35:39 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.56])
	by Forcepoint Email with ESMTP id EF95496ACCEF5DF31E96;
	Sat, 25 May 2019 11:35:27 +0800 (CST)
Received: from DGGEMM521-MBX.china.huawei.com ([169.254.4.56]) by
	DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id
	14.03.0439.000; Sat, 25 May 2019 11:35:21 +0800
From: "liujunjie (A)" <liujunjie23@huawei.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "afaerber@suse.de"
	<afaerber@suse.de>, "ehabkost@redhat.com" <ehabkost@redhat.com>,
	"imammedo@redhat.com" <imammedo@redhat.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
Thread-Topic: Question about wrong ram-node0 reference
Thread-Index: AdUSqrvZOubDxvGnQFyIol9vimbQhw==
Date: Sat, 25 May 2019 03:35:20 +0000
Message-ID: <B526101FCAB4654DB0892B650DEFC55527EECB46@dggemm521-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.68.90]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.187
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] Question about wrong ram-node0 reference
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
Cc: fangying <fangying1@huawei.com>,
	"wangxin \(U\)" <wangxinxin.wang@huawei.com>,
	"Huangweidong \(C\)" <weidong.huang@huawei.com>,
	"Zhoujian \(jay\)" <jianjay.zhou@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, I have met a problem:

The QEMU version is 2.8.1, the virtual machine is configured with 1G huge p=
ages, two NUMA nodes and four pass-through NVME SSDs.

After we started the VM, in addition to some QMP queries nothing more has b=
een done, the QEMU aborted after some months later.
After that, the VM is restarted, and the problem does not reproduce yet.
And The backtrace of the RCU thread is as follows:
(gdb) bt
#0  0x00007fd2695f0197 in raise () from /usr/lib64/libc.so.6
#1  0x00007fd2695f1888 in abort () from /usr/lib64/libc.so.6
#2  0x00007fd2695e9206 in __assert_fail_base () from /usr/lib64/libc.so.6
#3  0x00007fd2695e92b2 in __assert_fail () from /usr/lib64/libc.so.6
#4  0x0000000000476a84 in memory_region_finalize (obj=3D<optimized out>)
    at /home/abuild/rpmbuild/BUILD/qemu-kvm-2.8.1/memory.c:1512
#5  0x0000000000763105 in object_deinit (obj=3Dobj@entry=3D0x1dc1fd0,
    type=3Dtype@entry=3D0x1d065b0) at qom/object.c:448
#6  0x0000000000763153 in object_finalize (data=3D0x1dc1fd0) at qom/object.=
c:462
#7  0x00000000007627cc in object_property_del_all (obj=3Dobj@entry=3D0x1dc1=
f70)
    at qom/object.c:399
#8  0x0000000000763148 in object_finalize (data=3D0x1dc1f70) at qom/object.=
c:461
#9  0x0000000000764426 in object_unref (obj=3D<optimized out>) at qom/objec=
t.c:897
#10 0x0000000000473b6b in memory_region_unref (mr=3D<optimized out>)
    at /home/abuild/rpmbuild/BUILD/qemu-kvm-2.8.1/memory.c:1560
#11 0x0000000000473bc7 in flatview_destroy (view=3D0x7fc188b9cb90)
    at /home/abuild/rpmbuild/BUILD/qemu-kvm-2.8.1/memory.c:289
#12 0x0000000000843be0 in call_rcu_thread (opaque=3D<optimized out>)
    at util/rcu.c:279
#13 0x00000000008325c2 in qemu_thread_start (args=3Dargs@entry=3D0x1d00810)
    at util/qemu_thread_posix.c:496
#14 0x00007fd269983dc5 in start_thread () from /usr/lib64/libpthread.so.0
#15 0x00007fd2696b27bd in clone () from /usr/lib64/libc.so.6

In this core, I found that the reference of "/objects/ram-node0"( the type =
of ram-node0 is struct "HostMemoryBackendFile") equals to 0 , while the ref=
erence of "/objects/ram-node1" equals to 129, more details can be seen at t=
he end of this email.

I searched through the community, and found a case that had the same error =
report: https://mail.coreboot.org/pipermail/seabios/2017-September/011799.h=
tml
However, I did not configure pcie_pci_bridge. Besides, qemu aborted in devi=
ce initialization phase in this case.

Also, I try to find out which can reference "/objects/ram-node0" so as to l=
ook for the one that may un reference improperly, most of them lie in the f=
unction of "render_memory_region" or "phys_section_add" when memory topolog=
y changes.
Later, the temporary flatviews are destroyed by RCU thread, so un reference=
 happened and the backtrace is similar to the one shown above.
But I am not familiar with the detail of these process, it is hard to keep =
trace of these memory topology changes.

My question is:
How can ram-node0's reference comes down to 0 when the virtual machine is s=
till running?

Maybe someone who is familiar with memory_region_ref or memory-backend-file=
 can help me figure out.
Any idea is appreciated.

---
(gdb) p *((HostMemoryBackendFile *) 0x1dc1f70)
$24 =3D {parent_obj =3D {parent =3D {class =3D 0x1d70880, free =3D 0x7fd26a=
812580 <g_free>, properties =3D 0x1db7920, ref =3D 0, parent =3D 0x1da9710}=
, size =3D 68719476736, merge =3D true, dump =3D false, prealloc =3D true, =
force_prealloc =3D false, is_mapped =3D true, host_nodes =3D {1, 0, 0}, pol=
icy =3D HOST_MEM_POLICY_BIND, mr =3D {parent_obj =3D {class =3D 0x1d6d790, =
free =3D 0x0, properties =3D 0x1db79e0, ref =3D 0, parent =3D 0x0}, romd_mo=
de =3D true, ram =3D true, subpage =3D false, readonly =3D false, rom_devic=
e =3D false, flush_coalesced_mmio =3D false, global_locking =3D true, dirty=
_log_mask =3D 0 '\000', ram_block =3D 0x1dc2960, owner =3D 0x1dc1f70, iommu=
_ops =3D 0x0, ops =3D 0xcb0fe0 <unassigned_mem_ops>, opaque =3D 0x0, contai=
ner =3D 0x200d4c0, size =3D 0x00000000000000000000001000000000, addr =3D 0,=
 destructor =3D 0x470800 <memory_region_destructor_ram>, align =3D 10737418=
24, terminates =3D true, ram_device =3D false, enabled =3D true, warning_pr=
inted =3D false, vga_logging_count =3D 0 '\000', alias =3D 0x0, alias_offse=
t =3D 0, priority =3D 0, subregions =3D {tqh_first =3D 0x0, tqh_last =3D 0x=
1dc2078}, subregions_link =3D {tqe_next =3D 0x0, tqe_prev =3D 0x1dc2c68}, c=
oalesced =3D {tqh_first =3D 0x0, tqh_last =3D 0x1dc2098}, name =3D 0x1dc27a=
0 "/objects/ram-node0", ioeventfd_nb =3D 0, ioeventfds =3D 0x0, iommu_notif=
y =3D {lh_first =3D 0x0}, iommu_notify_flags =3D IOMMU_NOTIFIER_NONE}}, sha=
re =3D true, mem_path =3D 0x1dc2350 "/dev/hugepages/libvirt/qemu/118-instan=
ce-00025bf8"}

(gdb) p *((HostMemoryBackendFile *) 0x1dc2b50)
$205 =3D {parent_obj =3D {parent =3D {class =3D 0x1d70880, free =3D 0x7fd26=
a812580 <g_free>, properties =3D 0x1db7a40, ref =3D 129, parent =3D 0x1da97=
10}, size =3D 68719476736, merge =3D true, dump =3D false, prealloc =3D tru=
e, force_prealloc =3D false, is_mapped =3D true, host_nodes =3D {2, 0, 0}, =
policy =3D HOST_MEM_POLICY_BIND, mr =3D {parent_obj =3D {class =3D 0x1d6d79=
0, free =3D 0x0, properties =3D 0x1db7aa0, ref =3D 1, parent =3D 0x1dc2b50}=
, romd_mode =3D true, ram =3D true, subpage =3D false, readonly =3D false, =
rom_device =3D false, flush_coalesced_mmio =3D false, global_locking =3D tr=
ue, dirty_log_mask =3D 0 '\000', ram_block =3D 0x1dc3470, owner =3D 0x1dc2b=
50, iommu_ops =3D 0x0, ops =3D 0xcb0fe0 <unassigned_mem_ops>, opaque =3D 0x=
0, container =3D 0x200d4c0, size =3D 0x00000000000000000000001000000000, ad=
dr =3D 68719476736, destructor =3D 0x470800 <memory_region_destructor_ram>,=
 align =3D 1073741824, terminates =3D true, ram_device =3D false, enabled =
=3D true, warning_printed =3D false, vga_logging_count =3D 0 '\000', alias =
=3D 0x0, alias_offset =3D 0, priority =3D 0, subregions =3D {tqh_first =3D =
0x0, tqh_last =3D 0x1dc2c58}, subregions_link =3D {tqe_next =3D 0x1dc1fd0, =
tqe_prev =3D 0x200d568}, coalesced =3D {tqh_first =3D 0x0, tqh_last =3D 0x1=
dc2c78}, name =3D 0x1dc32b0 "/objects/ram-node1", ioeventfd_nb =3D 0, ioeve=
ntfds =3D 0x0, iommu_notify =3D {lh_first =3D 0x0}, iommu_notify_flags =3D =
IOMMU_NOTIFIER_NONE}}, share =3D true, mem_path =3D 0x1da8c40 "/dev/hugepag=
es/libvirt/qemu/118-instance-00025bf8"}

Thanks,
Junjie Liu

