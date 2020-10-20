Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC454C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 01:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E677022244
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 01:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E677022244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUgZD-0000wA-31
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 21:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1kUgY1-0000GZ-Nz; Mon, 19 Oct 2020 21:34:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5188 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1kUgXz-0001Zo-OP; Mon, 19 Oct 2020 21:34:45 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E0D7D5DCD34E4EC4EBEF;
 Tue, 20 Oct 2020 09:34:37 +0800 (CST)
Received: from [10.174.185.201] (10.174.185.201) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 20 Oct 2020 09:34:28 +0800
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
 <20200914132738.GL579094@stefanha-x1.localdomain>
 <7ad220bd-7ee5-1f66-b2e5-7dc57d72eb2e@huawei.com>
 <20200917154415.GB839531@stefanha-x1.localdomain>
 <20200917160054.GA2453251@dev>
 <5a5822ec-f3bc-a247-2b5a-f764b941c820@huawei.com>
 <20200918140628.GA2509473@dev>
 <1ba06b0d-3fcf-3676-f9e0-52875851ff19@huawei.com>
 <20200921111435.GA2524022@dev>
 <20201013100033.GB164611@stefanha-x1.localdomain>
 <f70dc6ce-385b-a4f9-04a0-244018f3ddbb@huawei.com>
 <6fd02e2b-50fa-b667-efc6-47d1765bdd8c@redhat.com>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <4eb92c5e-fa2f-50a5-a0f7-5cabe6e15bb4@huawei.com>
Date: Tue, 20 Oct 2020 09:34:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <6fd02e2b-50fa-b667-efc6-47d1765bdd8c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.185.201]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=yezhenyu2@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 21:34:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, armbru@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/10/19 21:25, Paolo Bonzini wrote:
> On 19/10/20 14:40, Zhenyu Ye wrote:
>> The kernel backtrace for io_submit in GUEST is:
>>
>> 	guest# ./offcputime -K -p `pgrep -nx fio`
>> 	    b'finish_task_switch'
>> 	    b'__schedule'
>> 	    b'schedule'
>> 	    b'io_schedule'
>> 	    b'blk_mq_get_tag'
>> 	    b'blk_mq_get_request'
>> 	    b'blk_mq_make_request'
>> 	    b'generic_make_request'
>> 	    b'submit_bio'
>> 	    b'blkdev_direct_IO'
>> 	    b'generic_file_read_iter'
>> 	    b'aio_read'
>> 	    b'io_submit_one'
>> 	    b'__x64_sys_io_submit'
>> 	    b'do_syscall_64'
>> 	    b'entry_SYSCALL_64_after_hwframe'
>> 	    -                fio (1464)
>> 		40031912
>>
>> And Linux io_uring can avoid the latency problem.
> 
> What filesystem are you using?
> 

On host, the VM image and disk images are based on ext4 filesystem.
In guest, the '/' uses xfs filesystem, and the disks are raw devices.

guest# df -hT
Filesystem              Type      Size  Used Avail Use% Mounted on
devtmpfs                devtmpfs   16G     0   16G   0% /dev
tmpfs                   tmpfs      16G     0   16G   0% /dev/shm
tmpfs                   tmpfs      16G  976K   16G   1% /run
/dev/mapper/fedora-root xfs       8.0G  3.2G  4.9G  40% /
tmpfs                   tmpfs      16G     0   16G   0% /tmp
/dev/sda1               xfs      1014M  181M  834M  18% /boot
tmpfs                   tmpfs     3.2G     0  3.2G   0% /run/user/0

guest# lsblk
NAME            MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda               8:0    0  10G  0 disk
├─sda1            8:1    0   1G  0 part /boot
└─sda2            8:2    0   9G  0 part
  ├─fedora-root 253:0    0   8G  0 lvm  /
  └─fedora-swap 253:1    0   1G  0 lvm  [SWAP]
vda             252:0    0  10G  0 disk
vdb             252:16   0  10G  0 disk
vdc             252:32   0  10G  0 disk
vdd             252:48   0  10G  0 disk

Thanks,
Zhenyu

