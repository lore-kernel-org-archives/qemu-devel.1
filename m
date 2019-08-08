Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DD6C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 08:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7812187F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 08:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7812187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvdVX-0007KS-0m
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 04:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34319)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <piaojun@huawei.com>) id 1hvdV8-0006uN-W3
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <piaojun@huawei.com>) id 1hvdV7-0008B5-7J
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:10:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2249 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <piaojun@huawei.com>) id 1hvdV6-000880-S9
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 04:10:21 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id DB81E942BA9F4AB7F688;
 Thu,  8 Aug 2019 16:10:11 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 8 Aug 2019
 16:10:08 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>, <virtio-fs@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <20190807180355.GA22758@stefanha-x1.localdomain>
From: piaojun <piaojun@huawei.com>
Message-ID: <5D4BD8D8.5080402@huawei.com>
Date: Thu, 8 Aug 2019 16:10:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20190807180355.GA22758@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: Re: [Qemu-devel] [Virtio-fs] [PATCH 0/4] virtiofsd: multithreading
 preparation part 3
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

From my test, your patch set of multithreading improves iops greatly as
below:

Guest configuration:
8 vCPU
8GB RAM
Linux 5.1 (vivek-aug-06-2019)

Host configuration:
Intel(R) Xeon(R) CPU E5-2670 0 @ 2.60GHz (8 cores x 4 threads)
32GB RAM
Linux 3.10.0
EXT4 + LVM + local HDD

---
Before:
# fio -direct=1 -time_based -iodepth=64 -rw=randread -ioengine=libaio -bs=4k -size=1G -numjob=1 -runtime=30 -group_reporting -name=file -filename=/mnt/virtiofs/file
Jobs: 1 (f=1): [r(1)] [100.0% done] [1177KB/0KB/0KB /s] [294/0/0 iops] [eta 00m:00s]
file: (groupid=0, jobs=1): err= 0: pid=6037: Thu Aug  8 23:18:59 2019
  read : io=35148KB, bw=1169.9KB/s, iops=292, runt= 30045msec

After:
Jobs: 1 (f=1): [r(1)] [100.0% done] [6246KB/0KB/0KB /s] [1561/0/0 iops] [eta 00m:00s]
file: (groupid=0, jobs=1): err= 0: pid=5850: Thu Aug  8 23:21:22 2019
  read : io=191216KB, bw=6370.7KB/s, iops=1592, runt= 30015msec
---

But there is no iops improvment when I change from HDD to ramdisk. I
guess this is because ramdisk has no iodepth.

Thanks,
Jun

On 2019/8/8 2:03, Stefan Hajnoczi wrote:
> On Thu, Aug 01, 2019 at 05:54:05PM +0100, Stefan Hajnoczi wrote:
>> Performance
>> -----------
>> Please try these patches out and share your results.
> 
> Here are the performance numbers:
> 
>   Threadpool | iodepth | iodepth
>      size    |    1    |   64
>   -----------+---------+--------
>   None       |   4451  |  4876
>   1          |   4360  |  4858
>   64         |   4359  | 33,266
> 
> A graph is available here:
> https://vmsplice.net/~stefan/virtiofsd-threadpool-performance.png
> 
> Summary:
> 
>  * iodepth=64 performance is increased by 6.8 times.
>  * iodepth=1 performance degrades by 2%.
>  * DAX is bottlenecked by QEMU's single-threaded
>    VHOST_USER_SLAVE_FS_MAP/UNMAP handler.
> 
> Threadpool size "none" is virtiofsd commit 813a824b707 ("virtiofsd: use
> fuse_lowlevel_is_virtio() in fuse_session_destroy()") without any of the
> multithreading preparation patches.  I benchmarked this to check whether
> the patches introduce a regression for iodepth=1.  They do, but it's
> only around 2%.
> 
> I also ran with DAX but found there was not much difference between
> iodepth=1 and iodepth=64.  This might be because the host mmap(2)
> syscall becomes the bottleneck and a serialization point.  QEMU only
> processes one VHOST_USER_SLAVE_FS_MAP/UNMAP at a time.  If we want to
> accelerate DAX it may be necessary to parallelize mmap, assuming the
> host kernel can do them in parallel on a single file.  This performance
> optimization is future work and not directly related to this patch
> series.
> 
> The following fio job was run with cache=none and no DAX:
> 
>   [global]
>   runtime=60
>   ramp_time=30
>   filename=/var/tmp/fio.dat
>   direct=1
>   rw=randread
>   bs=4k
>   size=4G
>   ioengine=libaio
>   iodepth=1
> 
>   [read]
> 
> Guest configuration:
> 1 vCPU
> 4 GB RAM
> Linux 5.1 (vivek-aug-06-2019)
> 
> Host configuration:
> Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz (2 cores x 2 threads)
> 8 GB RAM
> Linux 5.1.20-300.fc30.x86_64
> XFS + dm-thin + dm-crypt
> Toshiba THNSFJ256GDNU (256 GB SATA SSD)
> 
> Stefan
> 
> 
> 
> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs
> 

