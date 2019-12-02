Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535BBC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2857B20705
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2857B20705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibiEo-0001UW-AW
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 04:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <longpeng2@huawei.com>) id 1ibiDs-0000kN-So
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:42:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <longpeng2@huawei.com>) id 1ibiDr-0002Ek-OI
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:42:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34414 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <longpeng2@huawei.com>)
 id 1ibiDr-0002DL-Db
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:42:27 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C0DFB2BF3217283C8798;
 Mon,  2 Dec 2019 17:42:22 +0800 (CST)
Received: from [127.0.0.1] (10.177.246.209) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0;
 Mon, 2 Dec 2019 17:42:15 +0800
Subject: Re: vfio_pin_map_dma cause synchronize_sched wait too long
To: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
References: <2e53a9f0-3225-d416-98ff-55bd337330bc@huawei.com>
 <34c53520-4144-fe71-528a-8df53e7f4dd1@redhat.com>
From: "Longpeng (Mike)" <longpeng2@huawei.com>
Message-ID: <561fb205-16be-ae87-9cfe-61e6a3b04dc5@huawei.com>
Date: Mon, 2 Dec 2019 17:42:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <34c53520-4144-fe71-528a-8df53e7f4dd1@redhat.com>
Content-Type: text/plain; charset="gbk"
X-Originating-IP: [10.177.246.209]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
 Gonglei <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>,
 "Longpeng\(Mike\)" <longpeng.mike@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D4=DA 2019/12/2 17:31, Paolo Bonzini =D0=B4=B5=C0:
> On 02/12/19 10:10, Longpeng (Mike) wrote:
>>
>> Suppose there're two VMs: VM1 is bind to node-0 and calling vfio_pin_m=
ap_dma(),
>> VM2 is a migrate incoming VM which bind to node-1. We found the vm_sta=
rt( QEMU
>> function) of VM2 will take too long occasionally, the reason is as fol=
low.
>=20
> Which part of vfio_pin_map_dma is running?  There is already a

I need more analysis to find which part.

> cond_resched in vfio_iommu_map.  Perhaps you could add one to
> vfio_pin_pages_remote and/or use vfio_pgsize_bitmap to cap the number o=
f
> pages that it returns.

Um ... There's only one running task (qemu-kvm of the VM1) on that CPU, s=
o maybe
the cond_resched() is ineffective ?

> > Paolo
>=20
>=20
>=20


--=20
Regards,
Longpeng(Mike)


