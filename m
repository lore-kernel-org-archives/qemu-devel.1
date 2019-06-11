Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C85CC43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 02:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB40420665
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 02:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB40420665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51528 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haWyT-0005NR-SH
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 22:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lizhengui@huawei.com>) id 1haWx4-0004GO-D7
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 22:55:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lizhengui@huawei.com>) id 1haWus-0004Ki-Gv
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 22:53:43 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35946 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lizhengui@huawei.com>)
 id 1haWuq-0004EW-UY; Mon, 10 Jun 2019 22:53:41 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id D462E1EB61AD12626001;
 Tue, 11 Jun 2019 10:53:35 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.193) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0;
 Tue, 11 Jun 2019 10:53:29 +0800
To: Paolo Bonzini <pbonzini@redhat.com>, <stefanha@redhat.com>,
 <mreitz@redhat.com>, <kwolf@redhat.com>
References: <1560173684-6264-1-git-send-email-lizhengui@huawei.com>
 <1a218c83-7167-68c4-798f-2870f2f98475@redhat.com>
 <49e6310d-1c1c-2379-47e6-7239e0058e78@huawei.com>
 <487a3a9d-92b3-bed4-4082-5701cd4bd08d@redhat.com>
From: l00284672 <lizhengui@huawei.com>
Message-ID: <98826c00-3dae-3972-c68a-f86f544c2093@huawei.com>
Date: Tue, 11 Jun 2019 10:53:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <487a3a9d-92b3-bed4-4082-5701cd4bd08d@redhat.com>
Content-Type: multipart/mixed; boundary="------------F5D85B9FB6F33D4340270AEA"
Content-Language: en-US
X-Originating-IP: [10.177.251.193]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
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
Cc: jiangyiwen@huawei.com, eric.fangyi@huawei.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, wangjie88@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--------------F5D85B9FB6F33D4340270AEA
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

-- Would the "open" hang as well in that case?
    The "open" doesn't hang in that case.

Do you have any better solutions to solve this problem in the case?
  =20


On 2019/6/11 0:03, Paolo Bonzini wrote:
> On 10/06/19 16:51, l00284672 wrote:
>> The pread will hang in attaching disk just when backend storage networ=
k
>> disconnection .
> Would the "open" hang as well in that case?
>> I think the locking range of qemu_global_mutex is too large when do qm=
p
>> operation. what
>> does the qemu_global_mutex=C2=A0 really protect?
> Basically everything.
>
>> what is the risk of unlocking qemu_global_mutex in qmp?
> It's not QMP; it's specifically the code that calls raw_probe_alignment=
.
>
> Paolo
>
> .
>


--------------F5D85B9FB6F33D4340270AEA
Content-Type: text/x-vcard; name="lizhengui.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lizhengui.vcf"

bnVsbA==
--------------F5D85B9FB6F33D4340270AEA--

