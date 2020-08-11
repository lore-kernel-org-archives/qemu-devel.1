Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E814C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:55:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 678952076B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 13:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 678952076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5UkZ-0004F7-Jj
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 09:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1k5UjV-00038z-3U; Tue, 11 Aug 2020 09:54:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4175 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1k5UjS-00075U-O1; Tue, 11 Aug 2020 09:54:28 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 53FB214C811F2C669E32;
 Tue, 11 Aug 2020 21:54:20 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.173) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0;
 Tue, 11 Aug 2020 21:54:09 +0800
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
To: Kevin Wolf <kwolf@redhat.com>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
 <20200810153811.GF14538@linux.fritz.box>
Message-ID: <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
Date: Tue, 11 Aug 2020 21:54:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200810153811.GF14538@linux.fritz.box>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.173]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=yezhenyu2@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 09:54:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, qemu-block@nongnu.org, armbru@redhat.com,
 xiexiangyou@huawei.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Kevin,

On 2020/8/10 23:38, Kevin Wolf wrote:
> Am 10.08.2020 um 16:52 hat Zhenyu Ye geschrieben:
>> Before doing qmp actions, we need to lock the qemu_global_mutex,
>> so the qmp actions should not take too long time.
>>
>> Unfortunately, some qmp actions need to acquire aio context and
>> this may take a long time.  The vm will soft lockup if this time
>> is too long.
> 
> Do you have a specific situation in mind where getting the lock of an
> AioContext can take a long time? I know that the main thread can
> block for considerable time, but QMP commands run in the main thread, so
> this patch doesn't change anything for this case. It would be effective
> if an iothread blocks, but shouldn't everything running in an iothread
> be asynchronous and therefore keep the AioContext lock only for a short
> time?
> 

Theoretically, everything running in an iothread is asynchronous. However,
some 'asynchronous' actions are not non-blocking entirely, such as
io_submit().  This will block while the iodepth is too big and I/O pressure
is too high.  If we do some qmp actions, such as 'info block', at this time,
may cause vm soft lockup.  This series can make these qmp actions safer.

I constructed the scene as follow:
1. create a vm with 4 disks, using iothread.
2. add press to the CPU on the host.  In my scene, the CPU usage exceeds 95%.
3. add press to the 4 disks in the vm at the same time.  I used the fio and
some parameters are:

	 fio -rw=randrw -bs=1M -size=1G -iodepth=512 -ioengine=libaio -numjobs=4

4. do block query actions, for example, by virsh:

	virsh qemu-monitor-command [vm name] --hmp info block

Then the vm will soft lockup, the calltrace is:

[  192.311393] watchdog: BUG: soft lockup - CPU#1 stuck for 42s! [kworker/1:1:33]
[  192.314241] Kernel panic - not syncing: softlockup: hung tasks
[  192.316370] CPU: 1 PID: 33 Comm: kworker/1:1 Kdump: loaded Tainted: G           OEL    4.19.36+ #16
[  192.318765] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[  192.325638] Workqueue: events drm_fb_helper_dirty_work
[  192.roorr327238] Call trace:
[  192.331528]  dump_backtrace+0x0/0x198
[  192.332695]  show_stack+0x24/0x30
[  192.334219]  dump_stack+0xa4/0xcc
[  192.335578]  panic+0x12c/0x314
[  192.336565]  watchdog_timoot_fn+0x3e4/0x3e8
[  192.339984]  __hrtimer_run_queues+0x114/0x358
[  192.341576]  hrtimer_interrupt+0x104/0x2d8
[  192.343247]  arch_timer_handler_virt+0x38/0x58
[  192.345074]  handle_percpu_devid_irq+0x90/0x248
[  192.347238]  generic_handle_irq+0x34/0x50
[  192.349536]  __handle_domain_irq+0x68/0xc0
[  192.351193]  gic_handle_irq+0x6c/0x150
[  192.352639]  el1_irq+0xb8/0x140
[  192.353855]  vp_notify+0x28/0x38 [virtio_pci]
[  192.355646]  virtqueue_kick+0x3c/0x78 [virtio_ring]
[  192.357539]  virtio_gpu_queue_ctrl_buffer_locked+0x180/0x248 [virtio_gpu]
[  192.359869]  virtio_gpu_queue_ctrl_buffer+0x50/0x78 [virtio_gpu]
[  192.361456]  virtio_gpu_cmd_resource_flush+0x8c/0xb0 [virtio_gpu]
[  192.363422]  virtio_gpu_surface_dirty+0x60/0x110 [virtio_gpu]
[  192.365215]  virtio_gpu_framebuffer_surface_dirty+0x34/0x48 [virtio_gpu]
[  192.367452]  drm_fb_helper_dirty_work+0x178/0x1c0
[  192.368912]  process_one_work+0x1b4/0x3f8
[  192.370192]  worker_thread+0x54/0x470
[  192.371370]  kthread+0x134/0x138
[  192.379241]  ret_from_fork+0x10/0x18
[  192.382688] kernel fault(0x5) notification starting on CPU 1
[  192.385059] kernel fault(0x5) notification finished on CPU 1
[  192.387311] SMP: stopping secondary CPUs
[  192.391024] Kernel Offset: disabled
[  192.392111] CPU features: 0x0,a1806008
[  192.393306] Memory Limit: none
[  192.396701] Starting crashdump kernel...
[  192.397821] Bye!

This problem can be avoided after this series applied.

Thanks,
Zhenyu


