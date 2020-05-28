Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE10C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C52206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 13:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFZgpZ1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C52206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeIjp-0000uO-JA
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 09:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeIjF-000096-C4
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:37:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32978
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeIjD-0005V3-Ro
 for qemu-devel@nongnu.org; Thu, 28 May 2020 09:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590673065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IkaZOOBjKKshBBjSRRMWXw/48nYmDJhhZzdR2EL7beY=;
 b=MFZgpZ1UhSmrdO8ucAvTrordBINVg31tvPc9jmxl9pFs40awLBthaIxrWkycDmwbQEGEnm
 8olSeSNMwVQPIHd8NgIpHyo7Gbq/rezYZwQLyh5eZR8dKFtTvXEolHgNn9ALs6jZ8NhNnl
 1JtXpyIPa4rPVIBYSG+NmtqZVGHq/x4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-hodvGw2HPMC8lfATVHRbKw-1; Thu, 28 May 2020 09:37:37 -0400
X-MC-Unique: hodvGw2HPMC8lfATVHRbKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06C8D1054F98;
 Thu, 28 May 2020 13:37:36 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2C8360F88;
 Thu, 28 May 2020 13:37:34 +0000 (UTC)
Subject: Re: [PATCH v2] fpu/softfloat: Silent 'bitwise negation of a boolean
 expression' warning
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200528084833.9531-1-philmd@redhat.com>
 <288fd554-67e2-bfd9-4b51-ac03e565161f@redhat.com>
 <fb5c69f1-af4c-2f6e-b47a-3b964675318a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1809e3cf-5750-e21e-88bf-d27f9d1fb3c3@redhat.com>
Date: Thu, 28 May 2020 08:37:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fb5c69f1-af4c-2f6e-b47a-3b964675318a@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 4:00 AM, Philippe Mathieu-Daudé wrote:
> On 5/28/20 10:57 AM, Thomas Huth wrote:
>> On 28/05/2020 10.48, Philippe Mathieu-Daudé wrote:
>>> When building with clang version 10.0.0-4ubuntu1, we get:

In the subject, I'd suggest s/Silent/Silence/

>>>
>>>      CC      lm32-softmmu/fpu/softfloat.o
>>>    fpu/softfloat.c:3365:13: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>>>        absZ &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
>>>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>>    fpu/softfloat.c:3423:18: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
>>>            absZ0 &= ~ ( ( (uint64_t) ( absZ1<<1 ) == 0 ) & roundNearestEven );
>>>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>

Also, do you need to list all errors, or will just one or two 
representative errors be sufficient?

>>>
>>> Fix by rewriting the fishy bitwise AND of two bools as an int.
>>>
>>> Suggested-by: Eric Blake <eblake@redhat.com>
>>> Buglink: https://bugs.launchpad.net/bugs/1881004
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---

>>> +++ b/fpu/softfloat.c
>>> @@ -3362,7 +3362,9 @@ static int32_t roundAndPackInt32(bool zSign, uint64_t absZ,
>>>       }
>>>       roundBits = absZ & 0x7F;
>>>       absZ = ( absZ + roundIncrement )>>7;
>>> -    absZ &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
>>> +    if (((roundBits ^ 0x40) == 0) && roundNearestEven) {
>>> +        absZ &= ~1;
>>> +    }
>>
>> You could get rid of some more parentheses now:
>>
>>     if ((roundBits ^ 0x40) == 0 && roundNearestEven)
>>
>> ... also in the other hunks.
> 
> I first wrote
> 
>      if (!(roundBits ^ 0x40) && roundNearestEven)
> 
> But then thought this would diverge from Eric suggestion, so I kept what
> he wrote (which is a bit closer to the style of rest of this file).

I don't mind the patch as-is for minimizing churn and matching existing 
style, but I also would not be opposed if you wanted to elide 
unnecessary ().

> 
>>
>> Anyway:
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
> 
> Thanks!
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


