Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08820C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 18:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A842082A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 18:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A842082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35846 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEI9E-0002OH-4B
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 14:40:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hEI5S-0008OQ-GB
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1hEI5R-0001Vg-LN
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:36:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1hEI5R-0001Ul-A5
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:36:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4399E37E88;
	Wed, 10 Apr 2019 18:36:39 +0000 (UTC)
Received: from [10.10.123.233] (ovpn-123-233.rdu2.redhat.com [10.10.123.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 304D9608EB;
	Wed, 10 Apr 2019 18:36:37 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <f61645d0b3720a039423532d49dd65588d9bccd8.1554919328.git.crobinso@redhat.com>
	<4aee66fd-1cfa-a935-daa6-6f221af42095@redhat.com>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <4ee1fc10-b718-7100-8e38-f6afe5fdbe9a@redhat.com>
Date: Wed, 10 Apr 2019 14:36:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4aee66fd-1cfa-a935-daa6-6f221af42095@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 10 Apr 2019 18:36:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0?] hmp: delvm: use hmp_handle_error
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
Cc: Peter Maydell <peter.maydell@linaro.org>, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410183637.tldZuZ87UjRKmA7OFcIfR8iwHfjlc7mf8GJWOO9dPQY@z>

On 4/10/19 2:27 PM, Eric Blake wrote:
> On 4/10/19 1:03 PM, Cole Robinson wrote:
>> This gives us the consistent 'Error:' prefix added in 66363e9a43f,
>> which helps users like libvirt who still need to scrape hmp error
>> messages to detect failure.
>>
>> Signed-off-by: Cole Robinson <crobinso@redhat.com>
>> ---
>>  hmp.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Not enough to drive -rc4 on its own, but worth adding to our wishlist of
> potential easy patches if we do have a release blocker surface.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
>>
>> diff --git a/hmp.c b/hmp.c
>> index 8eec768088..74a4bfc1f9 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -1481,10 +1481,11 @@ void hmp_delvm(Monitor *mon, const QDict *qdict)
>>      const char *name = qdict_get_str(qdict, "name");
>>  
>>      if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
>> -        error_reportf_err(err,
>> -                          "Error while deleting snapshot on device '%s': ",
>> -                          bdrv_get_device_name(bs));
>> +        error_prepend(&err,
>> +                      "Error while deleting snapshot on device '%s': ",
> 
> Do we want to reword the message (maybe s/Error while //) to avoid the
> word "Error" twice in the same line?
> 

I'm fine with that, and I checked it won't affect libvirt's error
scraping in this area

Thanks,
Cole

