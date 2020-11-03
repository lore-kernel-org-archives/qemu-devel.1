Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F4AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BF320870
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BF320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvJS-0001TH-OX
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvIC-0008Av-Ae; Tue, 03 Nov 2020 07:20:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvI5-0007y0-BC; Tue, 03 Nov 2020 07:20:02 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQTP44DpGzLr1R;
 Tue,  3 Nov 2020 20:19:36 +0800 (CST)
Received: from [10.174.184.155] (10.174.184.155) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 20:19:33 +0800
Subject: Re: [PATCH v3 0/9] block-backend: Introduce I/O hang
To: <kwolf@redhat.com>
References: <20201022130303.1092-1-cenjiahui@huawei.com>
 <20201026165341.GM52035@stefanha-x1.localdomain>
 <b5aef6d9-bc2c-1cf4-b392-5db37049df33@huawei.com>
 <20201030132153.GB320132@stefanha-x1.localdomain>
From: cenjiahui <cenjiahui@huawei.com>
Message-ID: <3b815863-3a39-073a-e871-44a5df3c9635@huawei.com>
Date: Tue, 3 Nov 2020 20:19:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201030132153.GB320132@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.184.155]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=cenjiahui@huawei.com;
 helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 06:47:30
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, fangying1@huawei.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/10/30 21:21, Stefan Hajnoczi wrote:
> On Thu, Oct 29, 2020 at 05:42:42PM +0800, cenjiahui wrote:
>>
>> On 2020/10/27 0:53, Stefan Hajnoczi wrote:
>>> On Thu, Oct 22, 2020 at 09:02:54PM +0800, Jiahui Cen wrote:
>>>> A VM in the cloud environment may use a virutal disk as the backend storage,
>>>> and there are usually filesystems on the virtual block device. When backend
>>>> storage is temporarily down, any I/O issued to the virtual block device will
>>>> cause an error. For example, an error occurred in ext4 filesystem would make
>>>> the filesystem readonly. However a cloud backend storage can be soon recovered.
>>>> For example, an IP-SAN may be down due to network failure and will be online
>>>> soon after network is recovered. The error in the filesystem may not be
>>>> recovered unless a device reattach or system restart. So an I/O rehandle is
>>>> in need to implement a self-healing mechanism.
>>>>
>>>> This patch series propose a feature called I/O hang. It can rehandle AIOs
>>>> with EIO error without sending error back to guest. From guest's perspective
>>>> of view it is just like an IO is hanging and not returned. Guest can get
>>>> back running smoothly when I/O is recovred with this feature enabled.
>>>
>>> Hi,
>>> This feature seems like an extension of the existing -drive
>>> rerror=/werror= parameters:
>>>
>>>   werror=action,rerror=action
>>>       Specify which action to take on write and read errors. Valid
>>>       actions are: "ignore" (ignore the error and try to continue),
>>>       "stop" (pause QEMU), "report" (report the error to the guest),
>>>       "enospc" (pause QEMU only if the host disk is full; report the
>>>       error to the guest otherwise).  The default setting is
>>>       werror=enospc and rerror=report.
>>>
>>> That mechanism already has a list of requests to retry and live
>>> migration integration. Using the werror=/rerror= mechanism would avoid
>>> code duplication between these features. You could add a
>>> werror/rerror=retry error action for this feature.
>>>
>>> Does that sound good?
>>>
>>> Stefan
>>>
>>
>> Hi Stefan,
>>
>> Thanks for your reply. Extending the rerror=/werror= mechanism is a feasible
>> way for the retry feature.
>>
>> However, AFAIK, the rerror=/werror= mechanism in block-backend layer only
>> provides ACTION, and the real handler of errors need be implemented several
>> times in device layer for different devices. While our I/O Hang mechanism
>> directly handles AIO errors no matter which type of devices it is. Is it a
>> more common way to implement the feature in block-backend layer? Especially we
>> can set retry timeout in a common structure BlockBackend.
>>
>> Besides, is there any reason that QEMU implements the rerror=/werror mechansim
>> in device layer rather than in block-backend layer?
> 
> Yes, it's because failed requests can be live-migrated and retried on
> the destination host. In other words, live migration still works even
> when there are failed requests.
> 
> There may be things that can be refactored so there is less duplication
> in devices, but the basic design goal is that the block layer doesn't
> keep track of failed requests because they are live migrated together
> with the device state.
> 
> Maybe Kevin Wolf has more thoughts to share about rerror=/werror=.
> 
> Stefan
> 

Hi Kevin,

What do you think about extending rerror=/werror= for the retry feature?

And which place is better to set retry timeout, BlockBackend in
block layer or per device structure in device layer?

Jiahui

