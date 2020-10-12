Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AE5C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:13:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F4042076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4042076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRvm1-0000fe-Du
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenjiajun8@huawei.com>)
 id 1kRvkt-00008Z-Ds
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:12:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5222 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenjiajun8@huawei.com>)
 id 1kRvkr-0004GN-7i
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:12:39 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 692DE3448C71E8E6274B;
 Mon, 12 Oct 2020 19:12:18 +0800 (CST)
Received: from [10.174.186.113] (10.174.186.113) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 19:12:11 +0800
Subject: Re: [PATCH] vhost-user: add separate memslot counter for vhost-user
To: Raphael Norwitz <raphael.s.norwitz@gmail.com>
References: <20200928131731.69684-1-chenjiajun8@huawei.com>
 <CAFubqFs1Vac2xQspDBF5M1oxCH0O9jEhjPj5g0CD6RSHrqwEiQ@mail.gmail.com>
From: chenjiajun <chenjiajun8@huawei.com>
Message-ID: <1125cff0-29da-3f3d-5f6f-490f485418fe@huawei.com>
Date: Mon, 12 Oct 2020 19:12:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAFubqFs1Vac2xQspDBF5M1oxCH0O9jEhjPj5g0CD6RSHrqwEiQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.113]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=chenjiajun8@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 07:12:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Cc: zhang.zhanghailiang@huawei.com, "Michael S. Tsirkin" <mst@redhat.com>,
 jasowang@redhat.com, QEMU <qemu-devel@nongnu.org>, xiexiangyou@huawei.com,
 imammedo@redhat.com,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/10/2 10:05, Raphael Norwitz wrote:
> On Mon, Sep 28, 2020 at 9:17 AM Jiajun Chen <chenjiajun8@huawei.com> wrote:
>>
>> Used_memslots is equal to dev->mem->nregions now, it is true for
>> vhost kernel, but not for vhost user, which uses the memory regions
>> that have file descriptor. In fact, not all of the memory regions
>> have file descriptor.
>> It is usefully in some scenarios, e.g. used_memslots is 8, and only
>> 5 memory slots can be used by vhost user, it is failed to hot plug
>> a new memory RAM because vhost_has_free_slot just returned false,
>> but we can hot plug it safely in fact.
>>
>> --
>> ChangeList:
>> v3:
>> -make used_memslots a member of struct vhost_dev instead of a global static value
>>
>> v2:
>> -eliminating useless used_memslots_exceeded variable and used_memslots_is_exceeded() API
>>
>> v1:
>> -vhost-user: add separate memslot counter for vhost-user
>>
>> Signed-off-by: Jiajun Chen <chenjiajun8@huawei.com>
>> Signed-off-by: Jianjay Zhou <jianjay.zhou@huawei.com>
> 
> I'm happy with this from a vhost/vhost-user perspective. vhost-backend
> change looks good too. I'm a little confused by what's going on with
> net/vhost-user.c.
> 
>> ---
>>  hw/virtio/vhost-backend.c         | 12 ++++++++++
>>  hw/virtio/vhost-user.c            | 25 +++++++++++++++++++++
>>  hw/virtio/vhost.c                 | 37 +++++++++++++++++++++++--------
>>  include/hw/virtio/vhost-backend.h |  5 +++++
>>  include/hw/virtio/vhost.h         |  1 +
>>  net/vhost-user.c                  |  7 ++++++
>>  6 files changed, 78 insertions(+), 9 deletions(-)
>>
> 
>> diff --git a/net/vhost-user.c b/net/vhost-user.c
>> index 17532daaf3..7e93955537 100644
>> --- a/net/vhost-user.c
>> +++ b/net/vhost-user.c
>> @@ -20,6 +20,7 @@
>>  #include "qemu/error-report.h"
>>  #include "qemu/option.h"
>>  #include "trace.h"
>> +#include "include/hw/virtio/vhost.h"
>>
>>  typedef struct NetVhostUserState {
>>      NetClientState nc;
>> @@ -347,6 +348,12 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
>>          qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
>>                                   net_vhost_user_event, NULL, nc0->name, NULL,
>>                                   true);
> 
> Can you elaborate on this check here? What does it have to do with
> fixing memslots accounting? Maybe it should be in a separate change?
> 
When the number of virtual machine memslots exceeds the upper limit of the back-end support,
QEMU main thread may enters an endless loop and cannot process other requests.
And number of memslots will not automatically decrease, so add a check here to exit from loop
in this scenario. For the newly started virtual machine, boot fails; for the hot plug network card,
hot plug fails.
>> +
>> +        if (!vhost_has_free_slot()) {
>> +            error_report("used memslots exceeded the backend limit, quit "
>> +                         "loop");
>> +            goto err;
>> +        }
>>      } while (!s->started);
>>
>>      assert(s->vhost_net);
>> --
>> 2.27.0.dirty
>>
> .
> 

