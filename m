Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C982CC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 23:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7C120706
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 23:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+568DI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7C120706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLEcz-0007z0-4W
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 19:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLEc9-0007Z1-DS
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 19:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLEc7-0004eA-5d
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 19:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600905354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVZdTvDF+XSofFq11Zpple9ljLuM9NZzVqVuOmOjaII=;
 b=S+568DI6wIas/MCClb26fXGwG+V+OAZDU2WwIA1GXnU5exqKkRsInWTfQ02K11C07Qw++a
 vxnQeKj5SJugHgg22I3+5g8T+4urFC53TpDOltptPDflLnFKw9oPRW2LyL0Re5Kt7xaM36
 1wE6OY2h4+rIjDGUkOfWaL08fL76Bvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-dxFm5AH3PwKV6ZIDq8zUZg-1; Wed, 23 Sep 2020 19:55:52 -0400
X-MC-Unique: dxFm5AH3PwKV6ZIDq8zUZg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D0651084C80;
 Wed, 23 Sep 2020 23:55:51 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9C61B60BEC;
 Wed, 23 Sep 2020 23:55:50 +0000 (UTC)
Subject: Re: [PATCH v2 22/38] qapi/source.py: add type hint annotations
To: Cleber Rosa <crosa@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-23-jsnow@redhat.com>
 <20200923223619.GV191229@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <0ace0c8d-0853-d078-d865-1453640b1c06@redhat.com>
Date: Wed, 23 Sep 2020 19:55:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923223619.GV191229@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 9/23/20 6:36 PM, Cleber Rosa wrote:
> On Tue, Sep 22, 2020 at 05:00:45PM -0400, John Snow wrote:
>> Annotations do not change runtime behavior.
>> This commit *only* adds annotations.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/mypy.ini  |  5 -----
>>   scripts/qapi/source.py | 31 ++++++++++++++++++-------------
>>   2 files changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
>> index 9da1dccef4..43c8bd1973 100644
>> --- a/scripts/qapi/mypy.ini
>> +++ b/scripts/qapi/mypy.ini
>> @@ -39,11 +39,6 @@ disallow_untyped_defs = False
>>   disallow_incomplete_defs = False
>>   check_untyped_defs = False
>>   
>> -[mypy-qapi.source]
>> -disallow_untyped_defs = False
>> -disallow_incomplete_defs = False
>> -check_untyped_defs = False
>> -
> 
> This is what I meant in my comment in the previous patch.  It looks
> like a mix of commit grannurality styles.  Not a blocker though.
> 

Yep. Just how the chips fell. Some files were just very quick to cleanup 
and I didn't have to refactor them much when I split things out, so the 
enablements got rolled in.

I will, once reviews are in (and there is a commitment to merge), try to 
squash things where it seems appropriate.

>>   [mypy-qapi.types]
>>   disallow_untyped_defs = False
>>   disallow_incomplete_defs = False
>> diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
>> index e97b9a8e15..1cc6a5b82d 100644
>> --- a/scripts/qapi/source.py
>> +++ b/scripts/qapi/source.py
>> @@ -11,37 +11,42 @@
>>   
>>   import copy
>>   import sys
>> +from typing import List, Optional, TypeVar
>>   
>>   
>>   class QAPISchemaPragma:
>> -    def __init__(self):
>> +    def __init__(self) -> None:
> 
> I don't follow the reason for typing this...
> 
>>           # Are documentation comments required?
>>           self.doc_required = False
>>           # Whitelist of commands allowed to return a non-dictionary
>> -        self.returns_whitelist = []
>> +        self.returns_whitelist: List[str] = []
>>           # Whitelist of entities allowed to violate case conventions
>> -        self.name_case_whitelist = []
>> +        self.name_case_whitelist: List[str] = []
>>   
>>   
>>   class QAPISourceInfo:
>> -    def __init__(self, fname, line, parent):
>> +    T = TypeVar('T', bound='QAPISourceInfo')
>> +
>> +    def __init__(self: T, fname: str, line: int, parent: Optional[T]):
> 
> And not this... to tune my review approach, should I assume that this
> series intends to add complete type hints or not?
> 

This is a mypy quirk you've discovered that I've simply forgotten about.

When __init__ has *no* arguments, you need to annotate its return to 
explain to mypy that you have fully typed that method. It's a sentinel 
that says "Please type check this class!"

When __init__ has some arguments, you only need to type those arguments 
and not the return type. The sentinel is not needed.

__init__ *never* returns anything, so I opted to omit this useless 
annotation whenever it was possible to do so.

> - Cleber.
> 


