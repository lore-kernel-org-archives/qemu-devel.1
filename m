Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA63C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A437220659
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 15:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A437220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj3VI-00048h-Vy
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 11:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37130)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wangjie88@huawei.com>) id 1hj3U1-0003YU-TR
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wangjie88@huawei.com>) id 1hj3U0-0002kl-1V
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 11:17:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2225 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wangjie88@huawei.com>)
 id 1hj3Tv-0002ZV-RD; Thu, 04 Jul 2019 11:17:08 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id CA7C6E3838FA8E8EA5E1;
 Thu,  4 Jul 2019 23:16:43 +0800 (CST)
Received: from [10.133.211.192] (10.133.211.192) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 4 Jul 2019
 23:16:35 +0800
From: "wangjie (P)" <wangjie88@huawei.com>
To: <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>
Message-ID: <2b55a1d9-7c4f-c895-95fa-a32a7f63ad07@huawei.com>
Date: Thu, 4 Jul 2019 23:16:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [10.133.211.192]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: [Qemu-devel] =?utf-8?q?question=EF=BC=9Aabout_introduce_a_new_fea?=
 =?utf-8?b?dHVyZSBuYW1lZCDigJxJL08gaGFuZ+KAnQ==?=
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
Cc: kwolf@redhat.com, "Fangyi \(C\)" <eric.fangyi@huawei.com>,
 armbru@redhat.com, mreitz@redhat.com, wangjie88@huawei.com, Paolo
 Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, everybody=EF=BC=9A

I developed a feature named "I/O hang"=EF=BC=8Cmy intention is to solve t=
he=20
problem like that=EF=BC=9A
If the backend storage media of VM disk is far-end storage like IPSAN or=20
FCSAN, storage net link will always disconnection and
make I/O requests return EIO to Guest, and the status of filesystem in=20
Guest will be read-only, even the link recovered
after a while, the status of filesystem in Guest will not recover.

So I developed a feature named "I/O hang" to solve this problem, the=20
solution like that=EF=BC=9A
when some I/O requests return EIO in backend, "I/O hang" will catch the=20
requests in qemu block layer and
insert the requests to a rehandle queue but not return EIO to Guest, the=20
I/O requests in Guest will hang but it does not lead
Guest filesystem to be read-only, then "I/O hang" will loop to rehandle=20
the requests for a period time(ex. 5 second) until the requests
not return EIO(when backend storage link recovered).

In addition to the function as above, "I/O hang" also can sent event to=20
libvirt after backend storage status changed.

configure methods:
1. "I/O hang" ability can be configured for each disk as a disk attribute=
.
2. "I/O hang" timeout value also can be configured for each disk, when=20
storage link not recover in timeout value,
 =C2=A0=C2=A0 "I/O hang" will disable rehandle I/O requests and return EI=
O to Guest.


Are you interested in the feature?=C2=A0 I intend to push this feature to=
=20
qemu org, what's your opinion?


