Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FCEC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11FB206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11FB206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIp9o-0000Rz-TU
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1kIp1y-000838-R6; Thu, 17 Sep 2020 04:12:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4709 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1kIp1w-00086P-6r; Thu, 17 Sep 2020 04:12:38 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 8FCC1CE623D9618DECB0;
 Thu, 17 Sep 2020 16:12:26 +0800 (CST)
Received: from [10.174.187.142] (10.174.187.142) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 16:12:18 +0800
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
 <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
 <20200914144251.GO1252186@redhat.com>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <cfbbe585-c252-bc4c-23d7-7e7cfc6224cf@huawei.com>
Date: Thu, 17 Sep 2020 16:12:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200914144251.GO1252186@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.187.142]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=yezhenyu2@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 03:50:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.062,
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
Cc: Kevin Wolf <kwolf@redhat.com>, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, armbru@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Daniel,

On 2020/9/14 22:42, Daniel P. Berrangé wrote:
> On Tue, Aug 11, 2020 at 09:54:08PM +0800, Zhenyu Ye wrote:
>> Hi Kevin,
>>
>> On 2020/8/10 23:38, Kevin Wolf wrote:
>>> Am 10.08.2020 um 16:52 hat Zhenyu Ye geschrieben:
>>>> Before doing qmp actions, we need to lock the qemu_global_mutex,
>>>> so the qmp actions should not take too long time.
>>>>
>>>> Unfortunately, some qmp actions need to acquire aio context and
>>>> this may take a long time.  The vm will soft lockup if this time
>>>> is too long.
>>>
>>> Do you have a specific situation in mind where getting the lock of an
>>> AioContext can take a long time? I know that the main thread can
>>> block for considerable time, but QMP commands run in the main thread, so
>>> this patch doesn't change anything for this case. It would be effective
>>> if an iothread blocks, but shouldn't everything running in an iothread
>>> be asynchronous and therefore keep the AioContext lock only for a short
>>> time?
>>>
>>
>> Theoretically, everything running in an iothread is asynchronous. However,
>> some 'asynchronous' actions are not non-blocking entirely, such as
>> io_submit().  This will block while the iodepth is too big and I/O pressure
>> is too high.  If we do some qmp actions, such as 'info block', at this time,
>> may cause vm soft lockup.  This series can make these qmp actions safer.
>>
>> I constructed the scene as follow:
>> 1. create a vm with 4 disks, using iothread.
>> 2. add press to the CPU on the host.  In my scene, the CPU usage exceeds 95%.
>> 3. add press to the 4 disks in the vm at the same time.  I used the fio and
>> some parameters are:
>>
>> 	 fio -rw=randrw -bs=1M -size=1G -iodepth=512 -ioengine=libaio -numjobs=4
>>
>> 4. do block query actions, for example, by virsh:
>>
>> 	virsh qemu-monitor-command [vm name] --hmp info block
>>
>> Then the vm will soft lockup, the calltrace is:
> 
> [snip]
> 
>> This problem can be avoided after this series applied.
> 
> At what cost though ?   With this timeout, QEMU is going to start
> reporting bogus failures for various QMP commands when running
> under high load, even if those commands would actually run
> successfully.  This will turn into an error report from libvirt
> which will in turn probably cause an error in the mgmt application
> using libvirt, and in turn could break the user's automation.
> 

I think it's worth reporting an error to avoid the VM softlockup.
The VM may even crash if kernel.softlockup_panic is configured!

We can increase the timeout value (close to the VM cpu soft lock time)
to avoid unnecessary errors.

Thanks,
Zhenyu

