Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4F0C33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 01:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5270A20728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 01:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5270A20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isGTt-0003BS-CA
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 20:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1isGT9-0002ax-ER
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 20:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1isGT6-0006OH-G5
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 20:30:39 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:37362 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1isGT6-0006Ba-5K
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 20:30:36 -0500
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 0036B2F9EE57B7979F4F;
 Fri, 17 Jan 2020 09:30:30 +0800 (CST)
Received: from DGGEMI529-MBX.china.huawei.com ([169.254.6.126]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0439.000;
 Fri, 17 Jan 2020 09:30:21 +0800
From: fengzhimin <fengzhimin1@huawei.com>
To: "quintela@redhat.com" <quintela@redhat.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>
Subject: RE: [PATCH RFC 01/12] migration: Add multiRDMA capability support
Thread-Topic: [PATCH RFC 01/12] migration: Add multiRDMA capability support
Thread-Index: AQHVzG9yVHxXEfJM4USLZDsbao0TcafuEkeQ
Date: Fri, 17 Jan 2020 01:30:20 +0000
Message-ID: <03C2A65461456D4EBE9E6D4D0D96C583FBCA98@DGGEMI529-MBX.china.huawei.com>
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200109045922.904-2-fengzhimin1@huawei.com>
 <20200115180907.GH3811@work-vm> <87r1zz8rpz.fsf@secure.laptop>
In-Reply-To: <87r1zz8rpz.fsf@secure.laptop>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.198]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.255
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "jemmy858585@gmail.com" <jemmy858585@gmail.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for your review. I will modify its according to your suggestions.

-----Original Message-----
From: Juan Quintela [mailto:quintela@redhat.com]=20
Sent: Thursday, January 16, 2020 9:19 PM
To: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: fengzhimin <fengzhimin1@huawei.com>; armbru@redhat.com; eblake@redhat.c=
om; qemu-devel@nongnu.org; Zhanghailiang <zhang.zhanghailiang@huawei.com>; =
jemmy858585@gmail.com
Subject: Re: [PATCH RFC 01/12] migration: Add multiRDMA capability support

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Zhimin Feng (fengzhimin1@huawei.com) wrote:
>> From: fengzhimin <fengzhimin1@huawei.com>
>>=20
>> Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
>
> Instead of creating x-multirdma as a capability and the corresponding=20
> parameter for the number of channels; it would be better just to use=20
> the multifd parameters when used with an rdma transport; as far as I=20
> know multifd doesn't work with rdma at the moment, and to the user the=20
> idea of multifd over rdma is just the same thing.

I was about to suggest that.  We could setup both capabilities:

multifd + rdma


