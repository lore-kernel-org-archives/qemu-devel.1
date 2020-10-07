Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A47C47423
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78E22064E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ay03qhK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78E22064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCHE-00060o-N0
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQBvi-00073C-SY
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:04:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQBvd-0001es-Pu
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602086671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iWleI57e3a4PMyjQLi9oMuP+VZ10hg/TYZIgZHs76A0=;
 b=ay03qhK3UgEJzuFF6Rc1i3MgrM8CPUnsZt4Ij6FAE2LEd8/W7fTRG2msIAA0tY+5ceZo2f
 CV4sh+YeAFzAYnW/bV0WSGa2VjZWXnOVoA2Mzv+K27mJ9YABhAmRnca/c3j5dSjubOO1pA
 TPgUJSX86Hg523gqWeIS/wildGV2ELY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-Es-5BautOXmrcphl7ldU6A-1; Wed, 07 Oct 2020 12:04:29 -0400
X-MC-Unique: Es-5BautOXmrcphl7ldU6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE24218A822E
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 16:04:27 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E033C5C1BD;
 Wed,  7 Oct 2020 16:04:26 +0000 (UTC)
Subject: Re: [PATCH v5 24/36] qapi/source.py: add type hint annotations
To: Markus Armbruster <armbru@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-25-jsnow@redhat.com>
 <87lfgicktb.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <b4f6d2bb-37bb-5510-1fb5-479a3ca55b29@redhat.com>
Date: Wed, 7 Oct 2020 12:04:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87lfgicktb.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 7:55 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> Annotations do not change runtime behavior.
>> This commit *only* adds annotations.
>>
>> A note on typing of __init__: mypy requires init functions with no
>> parameters to document a return type of None to be considered fully
>> typed. In the case when there are input parameters, None may be omitted.
>>
>> Since __init__ may never return any value, it is preferred to omit the
>> return annotation whenever possible.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>> Tested-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>   scripts/qapi/mypy.ini  |  5 -----
>>   scripts/qapi/source.py | 31 ++++++++++++++++++-------------
>>   2 files changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
>> index 8ab9ac52cc4..1b8555dfa39 100644
>> --- a/scripts/qapi/mypy.ini
>> +++ b/scripts/qapi/mypy.ini
>> @@ -34,11 +34,6 @@ disallow_untyped_defs = False
>>   disallow_incomplete_defs = False
>>   check_untyped_defs = False
>>   
>> -[mypy-qapi.source]
>> -disallow_untyped_defs = False
>> -disallow_incomplete_defs = False
>> -check_untyped_defs = False
>> -
>>   [mypy-qapi.types]
>>   disallow_untyped_defs = False
>>   disallow_incomplete_defs = False
>> diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
>> index e97b9a8e15e..1cc6a5b82dc 100644
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
> More ignorant questions (I'm abusing the review process to learn Python
> type hints)...
> 
> Why do you need to annotate self here, but not elsewhere?
> 

This is admittedly me being a little extra, but I thought it was a good 
way to show a pattern for people who maybe hadn't been exposed to it yet.

This is a pattern that allows for subclassing. I am stating that this 
__init__ method takes a parent of the same type as itself, whatever that 
happens to actually be.

T is a TypeVar that we can use for Generics. By declaring the type of 
self as that TypeVar, we bind T to self's type. When we annotate the 
parent as a T, we are enforcing that the parent we receive is of the 
same type as ourselves.

(Yep, we don't actually subclass QAPISourceInfo and I don't have plans 
to. It felt slightly icky to hard-code the class type name, though. I 
try to avoid that whenever I can. I'm not sure I would go so far as to 
call it a code smell or an antipattern, but it's something I tend to 
avoid anyway.)

> Why do you use T instead of QAPISourceInfo?
> 
>>           self.fname = fname
>>           self.line = line
>>           self.parent = parent
>> -        self.pragma = parent.pragma if parent else QAPISchemaPragma()
>> -        self.defn_meta = None
>> -        self.defn_name = None
>> +        self.pragma: QAPISchemaPragma = (
>> +            parent.pragma if parent else QAPISchemaPragma()
>> +        )
> 
> Type inference fail?
> 

Yes:

qapi/source.py:34: error: Cannot determine type of 'pragma'
Found 1 error in 1 file (checked 14 source files)

>> +        self.defn_meta: Optional[str] = None
>> +        self.defn_name: Optional[str] = None
>>   
>> -    def set_defn(self, meta, name):
>> +    def set_defn(self, meta: str, name: str) -> None:
>>           self.defn_meta = meta
>>           self.defn_name = name
>>   
>> -    def next_line(self):
>> +    def next_line(self: T) -> T:
>>           info = copy.copy(self)
>>           info.line += 1
>>           return info
>>   
>> -    def loc(self):
>> +    def loc(self) -> str:
>>           if self.fname is None:
>>               return sys.argv[0]
>>           ret = self.fname
>> @@ -49,13 +54,13 @@ def loc(self):
>>               ret += ':%d' % self.line
>>           return ret
>>   
>> -    def in_defn(self):
>> +    def in_defn(self) -> str:
>>           if self.defn_name:
>>               return "%s: In %s '%s':\n" % (self.fname,
>>                                             self.defn_meta, self.defn_name)
>>           return ''
>>   
>> -    def include_path(self):
>> +    def include_path(self) -> str:
>>           ret = ''
>>           parent = self.parent
>>           while parent:
>> @@ -63,5 +68,5 @@ def include_path(self):
>>               parent = parent.parent
>>           return ret
>>   
>> -    def __str__(self):
>> +    def __str__(self) -> str:
>>           return self.include_path() + self.in_defn() + self.loc()


