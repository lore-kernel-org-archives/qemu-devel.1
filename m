Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016ADC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 09:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCFF020B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 09:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCFF020B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huZUD-0004nb-1J
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 05:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33607)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <piaojun@huawei.com>) id 1huZTq-0004Np-Mm
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 05:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <piaojun@huawei.com>) id 1huZTp-0004ZH-Sf
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 05:40:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57850 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <piaojun@huawei.com>) id 1huZTp-0004V6-IF
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 05:40:37 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B35E32BAE3A9D6C7208A;
 Mon,  5 Aug 2019 17:40:28 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 5 Aug 2019
 17:40:27 +0800
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20190801165409.20121-1-stefanha@redhat.com>
 <5D4799E5.6020006@huawei.com>
 <20190805080156.GA22337@stefanha-x1.localdomain>
From: piaojun <piaojun@huawei.com>
Message-ID: <5D47F98A.5060807@huawei.com>
Date: Mon, 5 Aug 2019 17:40:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20190805080156.GA22337@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 2019/8/5 16:01, Stefan Hajnoczi wrote:
> On Mon, Aug 05, 2019 at 10:52:21AM +0800, piaojun wrote:
>> # fio -direct=1 -time_based -iodepth=1 -rw=randwrite -ioengine=libaio -bs=1M -size=1G -numjob=1 -runtime=30 -group_reporting -name=file -filename=/mnt/9pshare/file
> 
> This benchmark configuration (--iodepth=1 --numjobs=1) cannot benefit
> from virtiofsd multithreading.  Have you measured a regression when this
> patch series is applied?
> 
> If your benchmark is unrelated to this patch series, let's discuss it in
> a separate email thread.  fuse_buf_copy() can be optimized to use
> pwritev().
> 
> Thanks,
> Stefan

Yes, I have not applied your patch series and test. As you said, I will
discuss *pwritev* in another email.

Thanks,
Jun

> 

