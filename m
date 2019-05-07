Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033D4C04A6B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 00:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5459206BF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 00:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5459206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35683 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNnf7-0000Bi-Nv
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 20:08:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hNneJ-0008JF-J8
	for qemu-devel@nongnu.org; Mon, 06 May 2019 20:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hNneI-0002tl-J4
	for qemu-devel@nongnu.org; Mon, 06 May 2019 20:07:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hNneE-0002r0-3M
	for qemu-devel@nongnu.org; Mon, 06 May 2019 20:07:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BAC13092676;
	Tue,  7 May 2019 00:07:51 +0000 (UTC)
Received: from [10.72.12.47] (ovpn-12-47.pek2.redhat.com [10.72.12.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AF20661F21;
	Tue,  7 May 2019 00:07:49 +0000 (UTC)
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org
References: <20190420191425.7d1dab82@luklap> <20190506123020.23d168a3@luklap>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a9516138-3ae6-3625-835c-bb592b0ce955@redhat.com>
Date: Tue, 7 May 2019 08:07:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506123020.23d168a3@luklap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Tue, 07 May 2019 00:07:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] net/colo-compare.c: Fix a crash in COLO
 Primary.
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/5/6 =E4=B8=8B=E5=8D=886:32, Lukas Straub wrote:
> On Sat, 20 Apr 2019 19:14:25 +0200
> Lukas Straub <lukasstraub2@web.de> wrote:
>
>> From: Lukas Straub <lukasstraub2@web.de>
>> Because event_unhandled_count may be accessed concurrently, it needs
>> to be protected by taking the lock. However the assert is outside the
>> lock, probably causing it to read garbage and aborting Qemu
>> erroneously.
>>
>> The Bug only happens when running Qemu in COLO mode.
>>
>> This Patch fixes the following bug:
>> https://bugs.launchpad.net/qemu/+bug/1824622
>>
>> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
>> ---
>>   net/colo-compare.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index bf10526f05..fcb491121b 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -813,9 +813,8 @@ static void colo_compare_handle_event(void
>> *opaque) break;
>>       }
>>
>> -    assert(event_unhandled_count > 0);
>> -
>>       qemu_mutex_lock(&event_mtx);
>> +    assert(event_unhandled_count > 0);
>>       event_unhandled_count--;
>>       qemu_cond_broadcast(&event_complete_cond);
>>       qemu_mutex_unlock(&event_mtx);
> Ping.
>
> Regards,
> Lukas Straub


Applied.

Thanks

>

