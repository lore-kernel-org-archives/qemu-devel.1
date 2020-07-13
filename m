Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA616C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E02206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7jNEC+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E02206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juz22-0008DX-HY
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juz0u-000751-UJ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:01:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57356
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1juz0t-00053R-7K
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594648858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ywg1t7muIkuuzmFVRW6dR4AFabdXlrdPME1fnRbw83Q=;
 b=a7jNEC+h4VwkaviYAwrlvj0mDxDzIUc2+ggpWgnlrNcUJplDZLbI09Jv9U/A96DRKOX3lh
 Hg/sdTle44Plnd3V36aok5jZve7jVjqqOcDMMhd+98Kw5KeGZ4ArwtH0+hQpHvlaHsyEjQ
 xG3mAFMIBKbA9GS+yPvwEWSFlDJRwqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-ciFiR28wPcuT0TtC0OKoRw-1; Mon, 13 Jul 2020 10:00:54 -0400
X-MC-Unique: ciFiR28wPcuT0TtC0OKoRw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E09DA80183C;
 Mon, 13 Jul 2020 14:00:52 +0000 (UTC)
Received: from [10.3.112.134] (ovpn-112-134.phx2.redhat.com [10.3.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA3ED19D7F;
 Mon, 13 Jul 2020 14:00:49 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] iotests.py: filter_testfiles(): filter SOCK_DIR too
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200701105331.121670-1-vsementsov@virtuozzo.com>
 <20200701105331.121670-5-vsementsov@virtuozzo.com>
 <63b3acac-9501-d80b-79e1-97115cbad32b@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7b661aa0-d6b6-f69a-7dd0-73efedb7514e@redhat.com>
Date: Mon, 13 Jul 2020 09:00:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <63b3acac-9501-d80b-79e1-97115cbad32b@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 8:07 AM, Eric Blake wrote:
> On 7/1/20 5:53 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/iotests.py | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

Queuing 1, 2, and 4 through my NBD tree as trivial iotest improvements, 
while we await better review on 3.

> 
>> diff --git a/tests/qemu-iotests/iotests.py 
>> b/tests/qemu-iotests/iotests.py
>> index ac9d199a1e..31d4b105ca 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -345,8 +345,9 @@ def filter_qmp(qmsg, filter_fn):
>>       return qmsg
>>   def filter_testfiles(msg):
>> -    prefix = os.path.join(test_dir, "%s-" % (os.getpid()))
>> -    return msg.replace(prefix, 'TEST_DIR/PID-')
>> +    pref1 = os.path.join(test_dir, "%s-" % (os.getpid()))
>> +    pref2 = os.path.join(sock_dir, "%s-" % (os.getpid()))
>> +    return msg.replace(pref1, 'TEST_DIR/PID-').replace(pref2, 
>> 'SOCK_DIR/PID-')
>>   def filter_qmp_testfiles(qmsg):
>>       def _filter(_key, value):
>>
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


