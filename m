Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0C1C10F11
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 03:09:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBDA20818
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 03:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBDA20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEQ5P-0004qI-JY
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 23:09:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hEQ48-000466-Cy
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 23:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hEPxf-0006bF-S0
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 23:01:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42436
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1hEPxf-0006Ys-M2
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 23:01:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3B314Rf057029
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 23:01:04 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rsumpkh95-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 23:00:59 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Thu, 11 Apr 2019 03:59:47 +0100
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
	by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 11 Apr 2019 03:59:44 +0100
Received: from b03ledav006.gho.boulder.ibm.com
	(b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3B2xh0o28770414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 11 Apr 2019 02:59:43 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02461C6059;
	Thu, 11 Apr 2019 02:59:43 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA459C6055;
	Thu, 11 Apr 2019 02:59:41 +0000 (GMT)
Received: from [9.85.159.235] (unknown [9.85.159.235])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Thu, 11 Apr 2019 02:59:41 +0000 (GMT)
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-2-cohuck@redhat.com>
	<9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
	<20190408190747.12e3618b.cohuck@redhat.com>
	<20190410013434.7cea1971@oc2783563651>
From: Eric Farman <farman@linux.ibm.com>
Date: Wed, 10 Apr 2019 22:59:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190410013434.7cea1971@oc2783563651>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041102-8235-0000-0000-00000E7CE042
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010906; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000284; SDB=6.01187341; UDB=6.00621929;
	IPR=6.00968106; 
	MB=3.00026384; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-11 02:59:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041102-8236-0000-0000-00004519723B
Message-Id: <4a692c11-edb2-93f9-7d8e-96a73a7ecdae@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-11_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904110020
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v4 1/6] vfio-ccw: make it safe to access
 channel programs
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
Cc: linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
	kvm@vger.kernel.org, qemu-s390x@nongnu.org,
	Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411025941.n78OkHrRIccQAtB7gBAZWGhECVoiW9HbzE_JdUfo9rw@z>



On 4/9/19 7:34 PM, Halil Pasic wrote:
> On Mon, 8 Apr 2019 19:07:47 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> On Mon, 8 Apr 2019 13:02:12 -0400
>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>
>>> On 03/01/2019 04:38 AM, Cornelia Huck wrote:
>>>> When we get a solicited interrupt, the start function may have
>>>> been cleared by a csch, but we still have a channel program
>>>> structure allocated. Make it safe to call the cp accessors in
>>>> any case, so we can call them unconditionally.
>>>>
>>>> While at it, also make sure that functions called from other parts
>>>> of the code return gracefully if the channel program structure
>>>> has not been initialized (even though that is a bug in the caller).
>>>>
>>>> Reviewed-by: Eric Farman<farman@linux.ibm.com>
>>>> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
>>>> ---
>>>
>>> Hi Connie,
>>>
>>> My series of fixes for vfio-ccw depends on this patch as I would like to
>>> call cp_free unconditionally :) (I had developed my code on top of your
>>> patches).
>>>
>>> Could we pick this patch up as well when/if you pick up my patch series?
>>> I am in the process of sending out a v2.
>>>
>>> Regarding this patch we could merge it as a stand alone patch, separate
>>> from this series. And also the patch LGTM
>>>
>>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
>>
>> Actually, I wanted to ask how people felt about merging this whole
>> series for the next release :) It would be one thing less on my plate...
>>
> 
> Sorry I was not able to spend any significant amount of time on this
> lately.
> 
> Gave the combined set (this + Farhans fio-ccw fixes for kernel
> stacktraces v2) it a bit of smoke testing after some minor adjustments
> to make it compile:
> 
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -13,6 +13,7 @@
>   #include <linux/vfio.h>
>   #include <linux/mdev.h>
>   #include <linux/nospec.h>
> +#include <linux/slab.h>
>   
>   #include "vfio_ccw_private.h"
> 
> 

Hrm...  Taking today's master, and the two series you mention (slight 
adjustment to apply patch 3 of Connie's series, because part of it was 
split out a few weeks ago), and I don't encounter this.  Tried switching 
between SLUB/SLAB, but still compiles fine.

> I'm just running fio on a pass-through DASD and on some virto-blk disks
> in parallel. My QEMU is today's vfio-ccw-caps from your repo.
> 
> I see stuff like this:
> qemu-git: vfio-ccw: wirte I/O region failed with errno=16[1811/7332/0 iops] [eta 26m:34s]

Without knowing what the I/O was that failed, this is a guessing game. 
But I encountered something similar just now running fio.

qemu:
2019-04-11T02:06:09.524838Z qemu-system-s390x: vfio-ccw: wirte I/O 
region failed with errno=16

guest:
[  422.931458] dasd-eckd 0.0.ca8d: An error occurred in the DASD device 
driver, reason=14 00000000730bbe9a
[  553.741554] dasd-eckd 0.0.ca8e: An error occurred in the DASD device 
driver, reason=14 00000000e59b81da
[  554.761552] dasd-eckd 0.0.ca8d: An error occurred in the DASD device 
driver, reason=14 00000000cdf4fb4e
[  554.921518] dasd-eckd 0.0.ca8b: An error occurred in the DASD device 
driver, reason=14 0000000068775082
[  555.271556] dasd-eckd 0.0.ca8d: ERP 00000000cdf4fb4e has run out of 
retries and failed
[  555.271786] dasd(eckd): I/O status report for device 0.0.ca8d:
                dasd(eckd): in req: 00000000cdf4fb4e CC:00 FC:00 AC:00 
SC:00 DS:00 CS:00 RC:-16
                dasd(eckd): device 0.0.ca8d: Failing CCW:           (null)
                dasd(eckd): SORRY - NO VALID SENSE AVAILABLE
[  555.272214] dasd(eckd): Related CP in req: 00000000cdf4fb4e
                dasd(eckd): CCW 000000006434c30f: 03400000 00000000 DAT:
                dasd(eckd): CCW 000000007a65f7e0: 08000000 70E5B700 DAT:
[  555.272508] dasd(eckd):......


 From the associated I/O, I think this is fixed by a series I am nearly 
ready to send for review.  I'll try again with those fixes on top of the 
two series here, and report back.

> [Thread 0x3ff75890910 (LWP 43803) exited]/7932KB/0KB /s] [1930/7932/0 iops] [eta 26m:33s]
> [Thread 0x3ff6b7b7910 (LWP 43800) exited]/8030KB/0KB /s] [2031/8030/0 iops] [eta 26m:32s]
> dasd-eckd 0.0.1234: An error occurred in the DASD device driver, reason=14 00000000caa27abe
> INFO: task kworker/u6:1:26 blocked for more than 122 seconds.ps] [eta 23m:26s]eta 23m:25s]
>        Not tainted 5.1.0-rc3-00217-g6ab18dc #598
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kworker/u6:1    D    0    26      2 0x00000000
> Workqueue: writeback wb_workfn (flush-94:0)
> Call Trace:
> ([<0000000000ae23f2>] __schedule+0x4fa/0xc98)
>   [<0000000000ae2bda>] schedule+0x4a/0xb0
>   [<00000000001b30ec>] io_schedule+0x2c/0x50
>   [<000000000071cc9c>] blk_mq_get_tag+0x1bc/0x310
>   [<000000000071571c>] blk_mq_get_request+0x1a4/0x4a8
>   [<0000000000719d38>] blk_mq_make_request+0x100/0x728
>   [<000000000070aa0a>] generic_make_request+0x26a/0x478
>   [<000000000070ac76>] submit_bio+0x5e/0x178
>   [<00000000004cfa2c>] ext4_io_submit+0x74/0x88
>   [<00000000004cfd32>] ext4_bio_write_page+0x2d2/0x4c8
>   [<00000000004aa5b4>] mpage_submit_page+0x74/0xa8
>   [<00000000004aa676>] mpage_process_page_bufs+0x8e/0x1b8
>   [<00000000004aa9bc>] mpage_prepare_extent_to_map+0x21c/0x390
>   [<00000000004b063c>] ext4_writepages+0x4bc/0x11a0
>   [<000000000032ef7a>] do_writepages+0x3a/0xf0
>   [<0000000000416226>] __writeback_single_inode+0x86/0x7a0
>   [<0000000000417154>] writeback_sb_inodes+0x2cc/0x550
>   [<0000000000417476>] __writeback_inodes_wb+0x9e/0xe8
>   [<00000000004179e0>] wb_writeback+0x468/0x598
>   [<0000000000418780>] wb_workfn+0x3b8/0x710
>   [<0000000000199322>] process_one_work+0x25a/0x668
>   [<000000000019977a>] worker_thread+0x4a/0x428
>   [<00000000001a1ae8>] kthread+0x150/0x170
>   [<0000000000aeadda>] kernel_thread_starter+0x6/0xc
>   [<0000000000aeadd4>] kernel_thread_starter+0x0/0xc
> 4 locks held by kworker/u6:1/26:
>   #0: 00000000792cf224 ((wq_completion)writeback){+.+.}, at: process_one_work+0x19c/0x668
>   #1: 000000009888c0e5 ((work_completion)(&(&wb->dwork)->work)){+.+.}, at: process_one_work+0x19c/0x668
>   #2: 000000002bfb76f0 (&type->s_umount_key#29){++++}, at: trylock_super+0x2e/0xa8
>   #3: 00000000ff47fe1d (&sbi->s_journal_flag_rwsem){.+.+}, at: do_writepages+0x3a/0xf0
> 
> 
> Since I haven't had the time to keep up lately, I will just trust Eric
> and Farhan on whether this should be merged or not. From a quick look at
> the code, and a quick stroll through my remaining memories, I think, there
> are a couple of things, that I myself would try to solve differently. But
> that is not a valid reason to hold this up.
> 
> I would like to spare the hustle of revisiting my old comments for everyone.
>  From the stability and utility perspective I'm pretty convinced we are
> better off than without the patches in question.

I agree, both series are an improvement.  I'll focus on both tomorrow.

  - Eric

> 
> TLDR:
> If it is good enough for Eric and Farhan, I have no objections against merging.
> 
> Regards,
> Halil
> 


