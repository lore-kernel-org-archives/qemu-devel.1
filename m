Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60608C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8C52137B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyuPD8te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8C52137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIyWn-0002iT-Dl
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIyU2-0001Tj-QZ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:18:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIyTz-0008Cq-T4
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600366690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QtqKI2rT0OVk41taCapzcwPTjjMwiwvysKm37WcO2XI=;
 b=AyuPD8teMdJfOw95bWmg8usIaCyZExUFNCKn0BblLipcE6tsxtonPQSGCdHiOdHkpwBPJy
 bu7IvORtKckplhI1+AgFDJKzszhmag8BzUhLM1jsUI0tBJxsRci4f6k319IzBnEPxicasn
 Z3z32NYK/VLZg+ok9D+VuHamHEzCM30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-rRmt9ikoM_eto731L-kwAw-1; Thu, 17 Sep 2020 14:18:05 -0400
X-MC-Unique: rRmt9ikoM_eto731L-kwAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29EC51007B2C;
 Thu, 17 Sep 2020 18:18:04 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E46D968871;
 Thu, 17 Sep 2020 18:18:02 +0000 (UTC)
Subject: Re: [PATCH 13/37] qapi/common.py: add notational type hints
To: Markus Armbruster <armbru@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-14-jsnow@redhat.com>
 <87h7rwpj8d.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <d1f725b3-c23c-d619-5cd2-ead63e3faa9a@redhat.com>
Date: Thu, 17 Sep 2020 14:18:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87h7rwpj8d.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 10:32 AM, Markus Armbruster wrote:
> Question on the subject line: what makes a type hint notational?
> 

My cover letter explains that every time I use this phrase, I mean to 
state that "This patch adds exclusively type notations and makes no 
functional changes to the runtime operation whatsoever."

i.e. notations-only.

> John Snow <jsnow@redhat.com> writes:
> 
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/common.py | 27 ++++++++++++++++-----------
>>   1 file changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index 4c079755d3..af01348b35 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -12,6 +12,7 @@
>>   # See the COPYING file in the top-level directory.
>>   
>>   import re
>> +from typing import Optional, Union, Sequence
>>   
>>   
>>   EATSPACE = '\033EATSPACE.'
>> @@ -22,7 +23,7 @@
>>   # ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
>>   # ENUM_NAME -> ENUM_NAME, ENUM_NAME1 -> ENUM_NAME1, ENUM_Name2 -> ENUM_NAME2
>>   # ENUM24_Name -> ENUM24_NAME
>> -def camel_to_upper(value):
>> +def camel_to_upper(value: str) -> str:
>>       c_fun_str = c_name(value, False)
>>       if value.isupper():
>>           return c_fun_str
>> @@ -41,7 +42,9 @@ def camel_to_upper(value):
>>       return new_name.lstrip('_').upper()
>>   
>>   
>> -def c_enum_const(type_name, const_name, prefix=None):
>> +def c_enum_const(type_name: str,
>> +                 const_name: str,
>> +                 prefix: Optional[str] = None) -> str:
>>       if prefix is not None:
>>           type_name = prefix
>>       return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
>> @@ -56,7 +59,7 @@ def c_enum_const(type_name, const_name, prefix=None):
>>   # into substrings of a generated C function name.
>>   # '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
>>   # protect=True: 'int' -> 'q_int'; protect=False: 'int' -> 'int'
>> -def c_name(name, protect=True):
>> +def c_name(name: str, protect: bool = True) -> str:
>>       # ANSI X3J11/88-090, 3.1.1
>>       c89_words = set(['auto', 'break', 'case', 'char', 'const', 'continue',
>>                        'default', 'do', 'double', 'else', 'enum', 'extern',
>> @@ -134,24 +137,24 @@ def pop(self, amount: int = 4) -> int:
>>   
>>   # Generate @code with @kwds interpolated.
>>   # Obey INDENT level, and strip EATSPACE.
>> -def cgen(code, **kwds):
>> +def cgen(code: str, **kwds: Union[str, int]) -> str:
> 
> Hmm.
> 
> The @kwds values can be anything, provided they match the conversion
> specifiers in @code:
> 
>>       raw = code % kwds
> 
> Your type hint adds a restriction that wasn't there before.
> 
> Is there a better way?
> 

Maybe there are format-like type annotation tricks you can do to enforce 
this, but I did not research them. I tried to resist "improving" our 
usage of the old % formatter prematurely. I may do a wholesale f-string 
conversion at some point, but not now, it's not important.

In practice, we pass strings and integers. This typing *is* artificially 
restrictive, though. We can declare the type to be "Any" and allow the 
function to fail or succeed at runtime if you'd prefer.

>>       if INDENT:
>>           raw, _ = re.subn(r'^(?!(#|$))', str(INDENT), raw, flags=re.MULTILINE)
>>       return re.sub(re.escape(EATSPACE) + r' *', '', raw)
>>   
>>   
>> -def mcgen(code, **kwds):
>> +def mcgen(code: str, **kwds: Union[str, int]) -> str:
> 
> Likewise.
> 

Unresearched idea: It's possible that we can subclass the 
string.Formatter class and extend it to perform our special variable 
replacements (chomping EATSPACE, etc.)

And *maybe* because it inherits from the standard formatter, we would 
benefit from any analysis Mypy performs on such things.

Basically, replace mcgen/cgen with class CFormatter(string.Formatter).

(maybe. assume that none of what I just said will work or is feasible.)

--js


