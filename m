Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553DBC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D9F724670
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D9F724670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHhB-0006Oo-JZ
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1idGkS-0008S4-P9
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1idGkR-0001j8-Dd
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:46:32 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38260 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1idGkQ-0001Sa-VL
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:46:31 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id D49756632D726C40D541;
 Fri,  6 Dec 2019 17:00:48 +0800 (CST)
Received: from [127.0.0.1] (10.120.177.99) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Dec 2019
 17:00:42 +0800
Subject: Re: [PATCH v2 1/3] virtio: add ability to delete vq through a pointer
To: Amit Shah <amit@kernel.org>, <mst@redhat.com>
References: <1575444716-17632-1-git-send-email-pannengyuan@huawei.com>
 <1eaf11e84a6c1cbfbacebe2ae4361925142c1ab6.camel@kernel.org>
 <32796046-ef9b-6157-3bd0-23eef4d4950b@huawei.com>
 <9e0aba878c29bdda0a8badee3919bc0a46ca0604.camel@kernel.org>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <c449951c-600b-b167-d9be-1027dc15b4e6@huawei.com>
Date: Fri, 6 Dec 2019 17:00:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <9e0aba878c29bdda0a8badee3919bc0a46ca0604.camel@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.120.177.99]
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
Cc: liyiting@huawei.com, kuhn.chenqun@huawei.com, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/12/6 16:56, Amit Shah wrote:
> On Fri, 2019-12-06 at 10:17 +0800, Pan Nengyuan wrote:
>> On 2019/12/6 0:45, Amit Shah wrote:
>>> On Wed, 2019-12-04 at 15:31 +0800, pannengyuan@huawei.com wrote:
>>>> From: Pan Nengyuan <pannengyuan@huawei.com>
>>>
>>> Shouldn't this be From: mst?
>>>
>>> I didn't find a ref to the original patch to confirm if you had to
>>> adapt it in any way, though.
>>>
>>
>> Here is the original
>> patch:=E3=80=80
>> https://lists.nongnu.org/archive/html/qemu-devel/2019-12/msg00402.html
>>
>> I just change one line(set used_elems to NULL). In next version, I
>> will
>> change function name from virtio_delete_queue to virtio_queue_cleanup
>> (It's too similar between "virtio_del_queue" and
>> "virtio_delete_queue"):
>>
> https://lists.nongnu.org/archive/html/qemu-devel/2019-12/msg00877.html
>> .
>>
>> According to these, should I change it in next version?
>=20
> Sure, please change it.  Please ensure 'From:' is Michael, but in the
> sign-off area, you can mention how you changed the original patch, e.g.
> see the "[PMM: ...]" in
>=20
>=20
>=20
> https://lore.kernel.org/qemu-devel/20191126141239.8219-5-peter.maydell@=
linaro.org/
>=20
> Also, please CC me on the entire series.
>=20
> Thanks,
>=20
>=20
OK, I will change it.

Thanks.

>=20
> .
>=20


