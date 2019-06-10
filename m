Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42156C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:53:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18DB920859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DB920859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47466 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haLfV-0006ZE-AW
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 10:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38986)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lizhengui@huawei.com>) id 1haLel-00060j-KA
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lizhengui@huawei.com>) id 1haLek-0008Uk-MC
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:52:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2175 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lizhengui@huawei.com>)
 id 1haLeg-0008GV-P1; Mon, 10 Jun 2019 10:52:16 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 159D2C83EF5CEDAA36E9;
 Mon, 10 Jun 2019 22:52:03 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.193) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0;
 Mon, 10 Jun 2019 22:51:56 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, <stefanha@redhat.com>,
 <mreitz@redhat.com>, <kwolf@redhat.com>
References: <1560173684-6264-1-git-send-email-lizhengui@huawei.com>
 <1a218c83-7167-68c4-798f-2870f2f98475@redhat.com>
From: l00284672 <lizhengui@huawei.com>
Message-ID: <49e6310d-1c1c-2379-47e6-7239e0058e78@huawei.com>
Date: Mon, 10 Jun 2019 22:51:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <1a218c83-7167-68c4-798f-2870f2f98475@redhat.com>
Content-Type: multipart/mixed; boundary="------------99187FACADB90121DC25F9F6"
Content-Language: en-US
X-Originating-IP: [10.177.251.193]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] file-posix: unlock
 qemu_global_mutex before pread when attach disk
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
Cc: jiangyiwen@huawei.com, wangjie88@huawei.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, eric.fangyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--------------99187FACADB90121DC25F9F6
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

The pread will hang in attaching disk just when backend storage network=20
disconnection .

I think the locking range of qemu_global_mutex is too large when do qmp=20
operation. what

does the qemu_global_mutex=C2=A0 really protect?=C2=A0 what is the risk o=
f=20
unlocking qemu_global_mutex

in qmp?


On 2019/6/10 21:51, Paolo Bonzini wrote:
> On 10/06/19 15:34, Zhengui li wrote:
>> when do qmp sush as drive_add,  qemu main thread locks the
>> qemu_global_mutex  and do pread in raw_probe_alignmen. Pread is a
>> synchronous operation. If backend storage network has a large delay
>> or IO pressure is too large,  the pread operation will not return for
>> a long time, which make vcpu thread can't acquire qemu_global_mutex
>> for a long time and make the vcpu thread unable to be scheduled for a
>> long time.  So virtual machine cpu soft lockup happened.
>>
>> qemu main thread should not hold qemu_global_mutex for a long time
>> when do qmp that involving IO synchronous operation sush pread ,
>> ioctl, etc. So this patch unlock qemu_global_mutex before IO
>> synchronous operation sush pread.
> These preads are for 512-4096 bytes, can they really last much longer
> than the "open" that precedes them?  If pread of 4K can trigger a soft
> lockup, things are really screwed up---and it's hard to be sure that al=
l
> callers of raw_probe_alignment are okay with releasing the global mutex=
.
>
> Paolo
>
> .
>


--------------99187FACADB90121DC25F9F6
Content-Type: text/x-vcard; name="lizhengui.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lizhengui.vcf"

bnVsbA==
--------------99187FACADB90121DC25F9F6--

