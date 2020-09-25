Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8F7C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469762083B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcgcCBt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469762083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLrPQ-0000fo-8G
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLrOc-0000FF-FL
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:20:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLrOa-0006Fm-Ju
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:20:34 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601054432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=agSp5clNkAlvv+7OQrr58my2ojfitmXmXyJkiPqDTAQ=;
 b=HcgcCBt0EixryLdvj/ofSWKTHsjjR9mDk/qBEQAr5xEkDctB7Ma+bdIWFRsMXj0UC5yBYJ
 TcEeK7ADcOZm83dQdLoHzSqXciudk/KFTSqv0cHhazCEq6eHhoKZuueVGDJeISrorOVOR6
 Kw+VJdoU8LssnI0MIaGJD/VyNzbwVk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-xkDB8LHNOI2SgyYBo1w5HA-1; Fri, 25 Sep 2020 13:20:28 -0400
X-MC-Unique: xkDB8LHNOI2SgyYBo1w5HA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67B71802B4A;
 Fri, 25 Sep 2020 17:20:26 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 643011002C34;
 Fri, 25 Sep 2020 17:20:19 +0000 (UTC)
Subject: Re: [PATCH v2 22/38] qapi/source.py: add type hint annotations
To: Cleber Rosa <crosa@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-23-jsnow@redhat.com>
 <20200923223619.GV191229@localhost.localdomain>
 <0ace0c8d-0853-d078-d865-1453640b1c06@redhat.com>
 <20200925170524.GD402155@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <08a051c3-308c-4d68-ea9f-5db9f9c06a3e@redhat.com>
Date: Fri, 25 Sep 2020 13:20:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925170524.GD402155@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 1:05 PM, Cleber Rosa wrote:
> On Wed, Sep 23, 2020 at 07:55:50PM -0400, John Snow wrote:
>> On 9/23/20 6:36 PM, Cleber Rosa wrote:
>>> On Tue, Sep 22, 2020 at 05:00:45PM -0400, John Snow wrote:
>>>> Annotations do not change runtime behavior.
>>>> This commit *only* adds annotations.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>    scripts/qapi/mypy.ini  |  5 -----
>>>>    scripts/qapi/source.py | 31 ++++++++++++++++++-------------
>>>>    2 files changed, 18 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
>>>> index 9da1dccef4..43c8bd1973 100644
>>>> --- a/scripts/qapi/mypy.ini
>>>> +++ b/scripts/qapi/mypy.ini
>>>> @@ -39,11 +39,6 @@ disallow_untyped_defs = False
>>>>    disallow_incomplete_defs = False
>>>>    check_untyped_defs = False
>>>> -[mypy-qapi.source]
>>>> -disallow_untyped_defs = False
>>>> -disallow_incomplete_defs = False
>>>> -check_untyped_defs = False
>>>> -
>>>
>>> This is what I meant in my comment in the previous patch.  It looks
>>> like a mix of commit grannurality styles.  Not a blocker though.
>>>
>>
>> Yep. Just how the chips fell. Some files were just very quick to cleanup and
>> I didn't have to refactor them much when I split things out, so the
>> enablements got rolled in.
>>
>> I will, once reviews are in (and there is a commitment to merge), try to
>> squash things where it seems appropriate.
>>
>>>>    [mypy-qapi.types]
>>>>    disallow_untyped_defs = False
>>>>    disallow_incomplete_defs = False
>>>> diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
>>>> index e97b9a8e15..1cc6a5b82d 100644
>>>> --- a/scripts/qapi/source.py
>>>> +++ b/scripts/qapi/source.py
>>>> @@ -11,37 +11,42 @@
>>>>    import copy
>>>>    import sys
>>>> +from typing import List, Optional, TypeVar
>>>>    class QAPISchemaPragma:
>>>> -    def __init__(self):
>>>> +    def __init__(self) -> None:
>>>
>>> I don't follow the reason for typing this...
>>>
>>>>            # Are documentation comments required?
>>>>            self.doc_required = False
>>>>            # Whitelist of commands allowed to return a non-dictionary
>>>> -        self.returns_whitelist = []
>>>> +        self.returns_whitelist: List[str] = []
>>>>            # Whitelist of entities allowed to violate case conventions
>>>> -        self.name_case_whitelist = []
>>>> +        self.name_case_whitelist: List[str] = []
>>>>    class QAPISourceInfo:
>>>> -    def __init__(self, fname, line, parent):
>>>> +    T = TypeVar('T', bound='QAPISourceInfo')
>>>> +
>>>> +    def __init__(self: T, fname: str, line: int, parent: Optional[T]):
>>>
>>> And not this... to tune my review approach, should I assume that this
>>> series intends to add complete type hints or not?
>>>
>>
>> This is a mypy quirk you've discovered that I've simply forgotten about.
>>
>> When __init__ has *no* arguments, you need to annotate its return to explain
>> to mypy that you have fully typed that method. It's a sentinel that says
>> "Please type check this class!"
>>
> 
> Ouch.  Is this a permanent quirk or a known bug that will eventually
> be addressed?

Permanent, it is a feature.

mypy intentionally supports gradual typing as a paradigm: it allows you 
to intermix "typed" and "untyped" functions.

```
def __init__(self):
     pass
```

Happens to pass as both untyped and fully typed. In order to distinguish 
it in this one case, you must add the return annotation as a declaration 
of intent.

However, when using '--strict' mode, you are declaring your intent to 
mypy that everything MUST be strictly typed, so perhaps in this case it 
would be possible to omit the annotation for __init__.

So maybe someday this will change; but given how uncommon it is to write 
no-argument init methods, I am hardly bothered by it. Mypy will remind 
you if you forget.

> 
> - Cleber.
> 


