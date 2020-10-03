Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A29C41604
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 23:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3273920674
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 23:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DM7C9yc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3273920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOrO4-00035Q-9E
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 19:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kOrNN-0002f1-BT
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 19:55:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kOrNK-0005mc-Vz
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 19:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601769336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T7BwrqSBDieqKpgX3vJMm50DoCPW8OYxmsCBO25PSbo=;
 b=DM7C9yc/ZIHzrVlgJke0fR9sKy8zpmiP5fkXp72jdUnbqUll03V3EeWWEiNlu9Xb5AqGat
 FskCYYUYhtLYCleZoWsP14sK6OJaQEFvOEWkaEQIxufx7Q8ft1qZ1ttoVfyd5oM/RiFr52
 h4Xfl7Gm/BM5eURSBWhzKhSZvHnKNaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-zJfnFoRVMSKd-_Jq7OVc1g-1; Sat, 03 Oct 2020 19:55:34 -0400
X-MC-Unique: zJfnFoRVMSKd-_Jq7OVc1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A11E28030DB;
 Sat,  3 Oct 2020 23:55:33 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A80E19C66;
 Sat,  3 Oct 2020 23:55:33 +0000 (UTC)
Subject: Re: [PATCH v2] scripts/qmp/qom-set: Allow setting integer value
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Jonatan_P=c3=a5lsson?= <jonatan.p@gmail.com>
References: <20201002205200.276477-1-jonatan.p@gmail.com>
 <2f65b14a-7073-300f-df86-4df55675e1ca@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7c29812a-db05-a91e-25f2-8fde3612f8f5@redhat.com>
Date: Sat, 3 Oct 2020 19:55:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2f65b14a-7073-300f-df86-4df55675e1ca@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/03 19:55:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.252, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/20 1:33 PM, Philippe Mathieu-Daudé wrote:
> Hi Jonatan,
> 
> On 10/2/20 10:52 PM, Jonatan Pålsson wrote:
>> If the value appears to be an integer, parse it as such.
>>
>> This allows the following:
>>
>>      qmp/qom-set -s ~/qmp.sock sensor.temperature 20000
> 
> Maybe instead:
> 
> Fix the following error:
> 
>    $ scripts/qmp/qom-set -s ~/qmp.sock sensor.temperature 20000
>    Traceback (most recent call last):
>      File "scripts/qmp/qom-set", line 66, in <module>
>        print(srv.command('qom-set', path=path, property=prop, value=value))
>      File "scripts/qmp/../../python/qemu/qmp.py", line 274, in command
>        raise QMPResponseError(ret)
>    qemu.qmp.QMPResponseError: Invalid parameter type for 'temperature',
> expected: integer
> 

No, this is just relaying the error that QMP returned. QMP is telling 
you it doesn't want string data for this parameter. His diagnosis of the 
problem is accurate.

>>
>> .. where sensor is a tmp105 device, and temperature is an integer
>> property.
>>
>> Signed-off-by: Jonatan Pålsson <jonatan.p@gmail.com>
>> ---
>>   scripts/qmp/qom-set | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
>> index 240a78187f..49eebe4924 100755
>> --- a/scripts/qmp/qom-set
>> +++ b/scripts/qmp/qom-set
>> @@ -56,7 +56,10 @@ if len(args) > 1:
>>           path, prop = args[0].rsplit('.', 1)
>>       except:
>>           usage_error("invalid format for path/property/value")
>> -    value = args[1]
>> +    try:
>> +        value = int(args[1])
> 
> Maybe 'long' is safer?
> 

This is a Python patch, what's a "long"?

>> +    except ValueError:
>> +        value = args[1]
>>   else:
>>       usage_error("not enough arguments")
>>   
>>
> 


