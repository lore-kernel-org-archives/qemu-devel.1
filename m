Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703A3C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 07:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4460F2070D
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 07:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4460F2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41527 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVAWL-0005Nl-Im
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 03:58:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hVAVa-00056w-V0
	for qemu-devel@nongnu.org; Mon, 27 May 2019 03:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hVAVZ-0004Ta-D9
	for qemu-devel@nongnu.org; Mon, 27 May 2019 03:57:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4765)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hVAVZ-0004KJ-6Y
	for qemu-devel@nongnu.org; Mon, 27 May 2019 03:57:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AF58307D864;
	Mon, 27 May 2019 07:57:16 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D0D4A5D704;
	Mon, 27 May 2019 07:57:14 +0000 (UTC)
Date: Mon, 27 May 2019 09:57:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "liujunjie (A)" <liujunjie23@huawei.com>
Message-ID: <20190527095644.36b8fea8@redhat.com>
In-Reply-To: <B526101FCAB4654DB0892B650DEFC55527EECB46@dggemm521-mbx.china.huawei.com>
References: <B526101FCAB4654DB0892B650DEFC55527EECB46@dggemm521-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 27 May 2019 07:57:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

On Sat, 25 May 2019 03:35:20 +0000
"liujunjie (A)" <liujunjie23@huawei.com> wrote:

> Hi, I have met a problem:
> 
> The QEMU version is 2.8.1, the virtual machine is configured with 1G huge pages, two NUMA nodes and four pass-through NVME SSDs.
> 
> After we started the VM, in addition to some QMP queries nothing more has been done, the QEMU aborted after some months later.
> After that, the VM is restarted, and the problem does not reproduce yet.
> And The backtrace of the RCU thread is as follows:
> (gdb) bt
> #0  0x00007fd2695f0197 in raise () from /usr/lib64/libc.so.6
> #1  0x00007fd2695f1888 in abort () from /usr/lib64/libc.so.6
> #2  0x00007fd2695e9206 in __assert_fail_base () from /usr/lib64/libc.so.6
> #3  0x00007fd2695e92b2 in __assert_fail () from /usr/lib64/libc.so.6
> #4  0x0000000000476a84 in memory_region_finalize (obj=<optimized out>)
>     at /home/abuild/rpmbuild/BUILD/qemu-kvm-2.8.1/memory.c:1512
> #5  0x0000000000763105 in object_deinit (obj=obj@entry=0x1dc1fd0,
>     type=type@entry=0x1d065b0) at qom/object.c:448
> #6  0x0000000000763153 in object_finalize (data=0x1dc1fd0) at qom/object.c:462
> #7  0x00000000007627cc in object_property_del_all (obj=obj@entry=0x1dc1f70)
>     at qom/object.c:399
> #8  0x0000000000763148 in object_finalize (data=0x1dc1f70) at qom/object.c:461
> #9  0x0000000000764426 in object_unref (obj=<optimized out>) at qom/object.c:897
> #10 0x0000000000473b6b in memory_region_unref (mr=<optimized out>)
>     at /home/abuild/rpmbuild/BUILD/qemu-kvm-2.8.1/memory.c:1560
> #11 0x0000000000473bc7 in flatview_destroy (view=0x7fc188b9cb90)
>     at /home/abuild/rpmbuild/BUILD/qemu-kvm-2.8.1/memory.c:289
> #12 0x0000000000843be0 in call_rcu_thread (opaque=<optimized out>)
>     at util/rcu.c:279
> #13 0x00000000008325c2 in qemu_thread_start (args=args@entry=0x1d00810)
>     at util/qemu_thread_posix.c:496
> #14 0x00007fd269983dc5 in start_thread () from /usr/lib64/libpthread.so.0
> #15 0x00007fd2696b27bd in clone () from /usr/lib64/libc.so.6
> 
> In this core, I found that the reference of "/objects/ram-node0"( the type of ram-node0 is struct "HostMemoryBackendFile") equals to 0 , while the reference of "/objects/ram-node1" equals to 129, more details can be seen at the end of this email.
> 
> I searched through the community, and found a case that had the same error report: https://mail.coreboot.org/pipermail/seabios/2017-September/011799.html
> However, I did not configure pcie_pci_bridge. Besides, qemu aborted in device initialization phase in this case.
That case doesn't seem relevant.

> 
> Also, I try to find out which can reference "/objects/ram-node0" so as to look for the one that may un reference improperly, most of them lie in the function of "render_memory_region" or "phys_section_add" when memory topology changes.
> Later, the temporary flatviews are destroyed by RCU thread, so un reference happened and the backtrace is similar to the one shown above.
> But I am not familiar with the detail of these process, it is hard to keep trace of these memory topology changes.
> 
> My question is:
> How can ram-node0's reference comes down to 0 when the virtual machine is still running?
> 
> Maybe someone who is familiar with memory_region_ref or memory-backend-file can help me figure out.
> Any idea is appreciated.

Could you provide steps to reproduce (incl. command line)? 

[...]
> Thanks,
> Junjie Liu
> 


