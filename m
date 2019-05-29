Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAF4C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:14:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A290320665
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A290320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53278 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVxTL-0000de-Sm
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 08:14:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1hVxSC-0008Sm-1A
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1hVxS8-0003Ul-NC
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:13:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2239 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wangjie88@huawei.com>)
	id 1hVxS7-0003Og-MR
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:13:08 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 74A2ECFE9BC54A8AD735;
	Wed, 29 May 2019 20:13:01 +0800 (CST)
Received: from [127.0.0.1] (10.177.25.93) by DGGEMS411-HUB.china.huawei.com
	(10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 29 May 2019
	20:12:57 +0800
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <1556608500-12183-1-git-send-email-wangjie88@huawei.com>
	<20190501164006.GH21155@stefanha-x1.localdomain>
From: Jie Wang <wangjie88@huawei.com>
Message-ID: <08f11758-7176-fd00-1b9b-462fd6db36e1@huawei.com>
Date: Wed, 29 May 2019 20:12:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190501164006.GH21155@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.177.25.93]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.191
Subject: [Qemu-devel] Ping Re: [PATCH] vhost: fix memory leak in
 vhost_user_scsi_realize
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/5/2 0:40, Stefan Hajnoczi wrote:
> On Tue, Apr 30, 2019 at 03:15:00PM +0800, Jie Wang wrote:
>> fix memory leak in vhost_user_scsi_realize
>>
>> Signed-off-by: Jie Wang <wangjie88@huawei.com>
>> ---
>>  hw/scsi/vhost-user-scsi.c | 3 +++
>>  1 file changed, 3 insertions(+)
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


