Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33141C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C56D2168B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuKUl7KM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C56D2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQDsp-0002ct-Bf
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 14:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQDrl-0002AH-PY
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQDrj-0005Rs-Fl
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:08:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602094118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YcJfQ/HnFLSPuGUUaCy3jliGWVn5YAGiy5gfRONdT6c=;
 b=EuKUl7KMYHzdITjfHq6+wDgYSRtI430/L/v+SXuDa9g0S52N7qSmYzMLW8V+Q4CPx8VSKQ
 CHAAbAC9wRipskDm9Ms8wCYl3fg693PHrqJFSIRkv6CuyJorvBloCz79qaryiouHID7l/9
 CT6nHS7oKHE69Cz06fhKAMRWbuCCDr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-tQf6zMhXMhOHk89UtSr4ow-1; Wed, 07 Oct 2020 14:08:35 -0400
X-MC-Unique: tQf6zMhXMhOHk89UtSr4ow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B968D420EA
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 18:08:34 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC9A276642;
 Wed,  7 Oct 2020 18:08:33 +0000 (UTC)
Subject: Re: [PATCH v5 11/36] qapi/common.py: Add indent manager
To: Markus Armbruster <armbru@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-12-jsnow@redhat.com>
 <87d01uifmn.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <0a507019-1e59-2967-9c7a-fa3712a74ae0@redhat.com>
Date: Wed, 7 Oct 2020 14:08:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87d01uifmn.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On 10/7/20 4:50 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> Code style tools really dislike the use of global keywords, because it
>> generally involves re-binding the name at runtime which can have strange
>> effects depending on when and how that global name is referenced in
>> other modules.
>>
>> Make a little indent level manager instead.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> 
> Intentation is a job for QAPIGen (and its subtypes).  But if this patch
> is easier to achieve this series' goal, I don't mind.
> 

I agree, but refactoring it properly is beyond my capacity right now.

This was the dumbest thing I could do to get pylint/mypy passing, which 
required the elimination (or suppression) of the global keyword.

Creating a stateful object was the fastest way from A to B.

>> ---
>>   scripts/qapi/common.py | 49 ++++++++++++++++++++++++++++--------------
>>   scripts/qapi/visit.py  |  7 +++---
>>   2 files changed, 36 insertions(+), 20 deletions(-)
>>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index cee63eb95c7..b35318b72cf 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -93,33 +93,50 @@ def c_name(name, protect=True):
>>   pointer_suffix = ' *' + eatspace
>>   
>>   
>> -def genindent(count):
>> -    ret = ''
>> -    for _ in range(count):
>> -        ret += ' '
>> -    return ret
>> +class Indentation:
>> +    """
>> +    Indentation level management.
>>   
>> +    :param initial: Initial number of spaces, default 0.
>> +    """
>> +    def __init__(self, initial: int = 0) -> None:
>> +        self._level = initial
>>   
>> -indent_level = 0
>> +    def __int__(self) -> int:
>> +        return self._level
>>   
>> +    def __repr__(self) -> str:
>> +        return "{}({:d})".format(type(self).__name__, self._level)
>>   
>> -def push_indent(indent_amount=4):
>> -    global indent_level
>> -    indent_level += indent_amount
>> +    def __str__(self) -> str:
>> +        """Return the current indentation as a string of spaces."""
>> +        return ' ' * self._level
>>   
>> +    def __bool__(self) -> bool:
>> +        """True when there is a non-zero indentation."""
>> +        return bool(self._level)
>>   
>> -def pop_indent(indent_amount=4):
>> -    global indent_level
>> -    indent_level -= indent_amount
>> +    def increase(self, amount: int = 4) -> None:
>> +        """Increase the indentation level by ``amount``, default 4."""
>> +        self._level += amount
>> +
>> +    def decrease(self, amount: int = 4) -> None:
>> +        """Decrease the indentation level by ``amount``, default 4."""
>> +        if self._level < amount:
>> +            raise ArithmeticError(
>> +                f"Can't remove {amount:d} spaces from {self!r}")
> 
> Raise a fancy error when there's an actual need for it.  You're not
> coding a framework thousands of people you never heard of will put to
> uses you cannot imagine.
> 

It's not fancy, it's just a normal built-in exception, like 
AssertionError or any other:

Traceback (most recent call last):
   File "<stdin>", line 1, in <module>
ArithmeticError: Can't remove 4 spaces from Indent(0)

vs

Traceback (most recent call last):
   File "<stdin>", line 1, in <module>
AssertionError: Can't remove 4 spaces from Indent(0)


I feel like it's kind of a lateral move? I realize you feel this is an 
overfancy class doing what we hope is a temporary job, and that I have 
overengineered the hell out of a tiny do-nothing class... but I suppose 
that's also why I feel weird changing it around so much to accomplish so 
little.

Differences in style, I suppose.

Feel free to change it around to suit your tastes, I don't think it's 
worth spending a lot of ping-pong time on this paintsink in particular.

--js

>> +        self._level -= amount
>> +
>> +
>> +indent = Indentation()
>>   
>>   
>>   # Generate @code with @kwds interpolated.
>> -# Obey indent_level, and strip eatspace.
>> +# Obey indent, and strip eatspace.
>>   def cgen(code, **kwds):
>>       raw = code % kwds
>> -    if indent_level:
>> -        indent = genindent(indent_level)
>> -        raw = re.sub(r'^(?!(#|$))', indent, raw, flags=re.MULTILINE)
>> +    if indent:
>> +        raw = re.sub(r'^(?!(#|$))', str(indent), raw, flags=re.MULTILINE)
>>       return re.sub(re.escape(eatspace) + r' *', '', raw)
>>   
>>   
>> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
>> index 808410d6f1b..14f30c228b7 100644
>> --- a/scripts/qapi/visit.py
>> +++ b/scripts/qapi/visit.py
>> @@ -18,9 +18,8 @@
>>       c_name,
>>       gen_endif,
>>       gen_if,
>> +    indent,
>>       mcgen,
>> -    pop_indent,
>> -    push_indent,
>>   )
>>   from .gen import QAPISchemaModularCVisitor, ifcontext
>>   from .schema import QAPISchemaObjectType
>> @@ -69,7 +68,7 @@ def gen_visit_object_members(name, base, members, variants):
>>       if (visit_optional(v, "%(name)s", &obj->has_%(c_name)s)) {
>>   ''',
>>                            name=memb.name, c_name=c_name(memb.name))
>> -            push_indent()
>> +            indent.increase()
>>           ret += mcgen('''
>>       if (!visit_type_%(c_type)s(v, "%(name)s", &obj->%(c_name)s, errp)) {
>>           return false;
>> @@ -78,7 +77,7 @@ def gen_visit_object_members(name, base, members, variants):
>>                        c_type=memb.type.c_name(), name=memb.name,
>>                        c_name=c_name(memb.name))
>>           if memb.optional:
>> -            pop_indent()
>> +            indent.decrease()
>>               ret += mcgen('''
>>       }
>>   ''')


