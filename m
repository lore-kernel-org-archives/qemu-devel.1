Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE32C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9850722276
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFC17NbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9850722276
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQta2-0002Jr-Ni
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQtWu-0007uW-FN
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:37:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQtWs-0007mD-2r
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602254273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3kb2aJP+fGGJyzJTCk5ai8xQsMc5oS/xTCTfQq32d0=;
 b=KFC17NbKN0oSyAyHc3bdxxY6+SqT806kCcLY3xeRANwql48yk2VEFWFQQaNEci5VoS4giP
 AVRVq6wdJCNXtK/3i0ZzNjB9v5vxpfKj0Y54DrUF8livdjVGWijxRNchQZrIq6V4QJG7Hw
 2WArcpN9iX5uszGfxUKvPvYIURHs2YQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-m-_huOarO8yknAO40yqtXg-1; Fri, 09 Oct 2020 10:37:51 -0400
X-MC-Unique: m-_huOarO8yknAO40yqtXg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 786331868424
 for <qemu-devel@nongnu.org>; Fri,  9 Oct 2020 14:37:50 +0000 (UTC)
Received: from [10.10.112.203] (ovpn-112-203.rdu2.redhat.com [10.10.112.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E91B86266E;
 Fri,  9 Oct 2020 14:37:49 +0000 (UTC)
Subject: Re: [PATCH v5 24/36] qapi/source.py: add type hint annotations
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-25-jsnow@redhat.com>
 <87lfgicktb.fsf@dusky.pond.sub.org>
 <b4f6d2bb-37bb-5510-1fb5-479a3ca55b29@redhat.com>
 <87d01t2joa.fsf@dusky.pond.sub.org>
 <e4284cb2-0758-d5bb-e331-08eeeef3a553@redhat.com>
Message-ID: <88a153e9-4d0e-e7ab-6831-f7b670b498b5@redhat.com>
Date: Fri, 9 Oct 2020 10:37:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e4284cb2-0758-d5bb-e331-08eeeef3a553@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/9/20 10:30 AM, John Snow wrote:
> On 10/8/20 4:42 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>>
>>> On 10/7/20 7:55 AM, Markus Armbruster wrote:
>>>> John Snow <jsnow@redhat.com> writes:
>>>>
>>>>> Annotations do not change runtime behavior.
>>>>> This commit *only* adds annotations.
>>>>>
>>>>> A note on typing of __init__: mypy requires init functions with no
>>>>> parameters to document a return type of None to be considered fully
>>>>> typed. In the case when there are input parameters, None may be 
>>>>> omitted.
>>>>>
>>>>> Since __init__ may never return any value, it is preferred to omit the
>>>>> return annotation whenever possible.
>>>>>
>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>>>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>>>>> Tested-by: Cleber Rosa <crosa@redhat.com>
>>>>> ---
>>>>>    scripts/qapi/mypy.ini  |  5 -----
>>>>>    scripts/qapi/source.py | 31 ++++++++++++++++++-------------
>>>>>    2 files changed, 18 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
>>>>> index 8ab9ac52cc4..1b8555dfa39 100644
>>>>> --- a/scripts/qapi/mypy.ini
>>>>> +++ b/scripts/qapi/mypy.ini
>>>>> @@ -34,11 +34,6 @@ disallow_untyped_defs = False
>>>>>    disallow_incomplete_defs = False
>>>>>    check_untyped_defs = False
>>>>>    -[mypy-qapi.source]
>>>>> -disallow_untyped_defs = False
>>>>> -disallow_incomplete_defs = False
>>>>> -check_untyped_defs = False
>>>>> -
>>>>>    [mypy-qapi.types]
>>>>>    disallow_untyped_defs = False
>>>>>    disallow_incomplete_defs = False
>>>>> diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
>>>>> index e97b9a8e15e..1cc6a5b82dc 100644
>>>>> --- a/scripts/qapi/source.py
>>>>> +++ b/scripts/qapi/source.py
>>>>> @@ -11,37 +11,42 @@
>>>>>      import copy
>>>>>    import sys
>>>>> +from typing import List, Optional, TypeVar
>>>>>    class QAPISchemaPragma:
>>>>> -    def __init__(self):
>>>>> +    def __init__(self) -> None:
>>>>>            # Are documentation comments required?
>>>>>            self.doc_required = False
>>>>>            # Whitelist of commands allowed to return a non-dictionary
>>>>> -        self.returns_whitelist = []
>>>>> +        self.returns_whitelist: List[str] = []
>>>>>            # Whitelist of entities allowed to violate case conventions
>>>>> -        self.name_case_whitelist = []
>>>>> +        self.name_case_whitelist: List[str] = []
>>>>>    class QAPISourceInfo:
>>>>> -    def __init__(self, fname, line, parent):
>>>>> +    T = TypeVar('T', bound='QAPISourceInfo')
>>>>> +
>>>>> +    def __init__(self: T, fname: str, line: int, parent: 
>>>>> Optional[T]):
>>>>
>>>> More ignorant questions (I'm abusing the review process to learn Python
>>>> type hints)...
>>>>
>>>> Why do you need to annotate self here, but not elsewhere?
>>>
>>> This is admittedly me being a little extra, but I thought it was a
>>> good way to show a pattern for people who maybe hadn't been exposed to
>>> it yet.
>>>
>>> This is a pattern that allows for subclassing. I am stating that this
>>> __init__ method takes a parent of the same type as itself, whatever
>>> that happens to actually be.
>>>
>>> T is a TypeVar that we can use for Generics. By declaring the type of
>>> self as that TypeVar, we bind T to self's type. When we annotate the
>>> parent as a T, we are enforcing that the parent we receive is of the
>>> same type as ourselves.
>>>
>>> (Yep, we don't actually subclass QAPISourceInfo and I don't have plans
>>> to. It felt slightly icky to hard-code the class type name, though. I
>>> try to avoid that whenever I can. I'm not sure I would go so far as to
>>> call it a code smell or an antipattern, but it's something I tend to
>>> avoid anyway.)
>>
>> Say I define class QSISub as a direct subclass of QAPISourceInfo, and
>> let it inherit __init__().  What's the type of QSISub.__init__()'s
>> parameter @parent?
>>
>> According to my reading of your explanation, it's QSISub.  Correct?
>>
> 
> That's right.
> 
> (I'm realizing that this is maybe not a constraint that we should even 
> anticipate here, because maybe we don't wish to say that the parent 
> should always be of the same type. but hey, it led to a good mypy lesson.
> 
> I'm going to edit it to do the simpler thing for now and leave well 
> enough alone. There's another chance to see an interesting pattern of 
> TypeVars in the error series in part 4 that I think is actually more 
> explicitly appropriate.)
> 
>> If we used QAPISourceInfo instead of T for @parent, then it would be
>> QAPISourceInfo.  Correct?
>>
> 
> Yup!
> 
> Here's a little sample program that shows what this kind of typing does:
> 
> ```
> from typing import TypeVar, Optional
> 
> class Example:
>      T = TypeVar('T', bound='Example')
>      def __init__(self: T, parent: Optional[T] = None):
>          self.parent = parent
> 
> class SubExample(Example):
>      pass
> 
> 
> x = Example()
> y = Example(x)
> z = SubExample()
> a = Example(x)            # OK
> b = Example(z)            # OK
> c = SubExample(x)         # BZZZT
> d = SubExample(z)         # OK
> ```
> 
> If you check this with mypy, you'll get this error:
> 
> ```
> test.py:17: error: Argument 1 to "SubExample" has incompatible type 
> "Example"; expected "Optional[SubExample]"
> Found 1 error in 1 file (checked 1 source file)
> ```
> 
>> Now, perhaps any QAPISourceInfo will do as @parent, perhaps it really
>> needs to be a QSISub.  We can't know when we write QAPISourceInfo.  But
>> we don't *have* to get this exactly right for all future subclasses,
>> because I can always override __init__() when inheritance doesn't give
>> me the __init__() I want.  Correct?
>>
> 
> You could, but I suggested on IRC the other day that I am not fully 
> comfortable with the LSP rules that mypy (sometimes?) enforces. I tend 
> not to want to override init with narrower types if I can avoid it, but 
> it is true that we do this quite a lot in the codebase already.
> 
> (I believe I have seen mypy throw errors about this on occasion, but I 
> can't pinpoint the exact circumstances in which it does. It's a point of 
> confusion for me.)
> 
>> Say I override __init__(), and have it call super().__init__().  I have
>> to pass it a QAPISourceInfo @parent.  A QSISub will do (it's a subtype).
>> Correct?
>>
>> One more: is bound='QAPISourceInfo' strictly needed?
>>
> 
> I'm not sure if bound is strictly required or not. mypy docs just use it 
> outright and don't mention why:
> 
> https://mypy.readthedocs.io/en/stable/generics.html#generic-methods-and-generic-self 
> 
> 
> Generally, this constrains a TypeVar to some upper bound, see --
> 
> https://mypy.readthedocs.io/en/stable/generics.html#type-variables-with-upper-bounds 
> 
> 
> -- but in this case, we're only using that TypeVar for an init method 
> that only exists for this type and below, so it might be redundant.
> 
> I modified my example program to remove the bound and it appears to fail 
> in the same exact way, so it might be pointless in this case. It might 
> have a stronger use if you want to re-use the 'T' typevar elsewhere 
> where it isn't implicitly bound by the 'self' argument. Maybe it has 
> implications for multi-inheritance too, I've not tested it to that level.
> 

SPOKE TOO SOON, ADDENDUM:

Adding bound= is still necessary to allow type inference to assume the 
minimal base form. It's not needed for my toy example because I don't do 
anything *with* the variable.

In this case, though, the next_line method needs help:

     def next_line(self: T) -> T:
	info = copy.copy(self)
         info.line += 1
         return info

Now, when we return a copy of ourselves, we are going to return 
something that is the same type as ourselves. If we remove the bound 
from the TypeVar here, "info.line" will become an error because mypy 
cannot infer the minimum form.

(It doesn't seem smart enough to notice that the class it is defined in 
does not inherit from anywhere, so it MUST be at least a QAPISourceInfo.)

So I am going to:

(1) Make __init__'s typing less dynamic, because it's not really needed.
(2) Leave the TypeVar in for the benefit of next_line().

--js


