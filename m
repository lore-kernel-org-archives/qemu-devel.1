Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83815C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 22:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD194206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 22:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLnB/f18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD194206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIfso-0003hO-Iw
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 18:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIfrX-0002jR-3I
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 18:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIfrU-0007fe-CQ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 18:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600295110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UcRDqCo6NK5l1vF9GKZHmI737xr7NANUPqKCdW3QC7k=;
 b=WLnB/f18tfUTM9u0zdE7IjEhmgLxWmCX3dr2PFZiNYhmLtVdtOWWGXJn99hIpcyeAI9qGP
 59K/tSNh1Ej/40vRtsso+1dlzFOdVom1woG3QHZcJDX7b9Xwkc+3oreSdZWEDbZFRKK38R
 P18lmgfoDWwKOthv0tTWqD0rMRjUaEQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-xcxSMhk_Mj-D8nU9U-Nh9w-1; Wed, 16 Sep 2020 18:25:07 -0400
X-MC-Unique: xcxSMhk_Mj-D8nU9U-Nh9w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AE4580572E;
 Wed, 16 Sep 2020 22:25:06 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3021F5D9E8;
 Wed, 16 Sep 2020 22:25:05 +0000 (UTC)
Subject: Re: [PATCH 09/37] qapi/common.py: Add indent manager
To: Markus Armbruster <armbru@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-10-jsnow@redhat.com>
 <87k0wtiwlb.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <37ea889c-746e-bea9-a719-6bee9e86f1a8@redhat.com>
Date: Wed, 16 Sep 2020 18:25:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87k0wtiwlb.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 9/16/20 11:13 AM, Markus Armbruster wrote:
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
>> ---
>>   scripts/qapi/common.py | 50 +++++++++++++++++++++++++++++-------------
>>   scripts/qapi/visit.py  |  7 +++---
>>   2 files changed, 38 insertions(+), 19 deletions(-)
>>
>> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
>> index 4fb265a8bf..87d87b95e5 100644
>> --- a/scripts/qapi/common.py
>> +++ b/scripts/qapi/common.py
>> @@ -93,33 +93,53 @@ def c_name(name, protect=True):
>>   pointer_suffix = ' *' + eatspace
>>   
>>   
>> -def genindent(count):
>> -    ret = ''
>> -    for _ in range(count):
>> -        ret += ' '
>> -    return ret
>> +class Indent:
> 
> Since this class name will be used just once...  Indentation or
> IndentationManager?
> 

Indentation is fine, if you'd like. IndentationManager makes me feel 
ashamed for writing this patch, like I am punishing myself with Java.

>> +    """
>> +    Indent-level management.
>>   
>> +    :param initial: Initial value, default 0.
> 
> The only caller passes 0.
> 
> Let's drop the parameter, and hardcode the default initial value until
> we have an actual use for another initial value.
> 

The parameter is nice because it gives meaning to the output of repr(), 
see below.

>> +    """
>> +    def __init__(self, initial: int = 0) -> None:
>> +        self._level = initial
>>   
>> -indent_level = 0
>> +    def __int__(self) -> int:
>> +        """Return the indent as an integer."""
> 
> Isn't "as an integer" obvious?

Just a compulsion to write complete sentences that got lost in the sea 
of many patches. I'll nix this one, because dunder methods do not need 
to be documented.

> 
> Let's replace "the indent" by "the indentation" globally.
> 

They're both cromulent as nouns and one is shorter.

I'll switch in good faith; do you prefer "Indentation" as a noun?

>> +        return self._level
>>   
>> +    def __repr__(self) -> str:
>> +        return "{}({:d})".format(type(self).__name__, self._level)
> 
> Is __repr__ needed?
> 

Yes; it's used in the underflow exception , and it is nice when using 
the python shell interactively.

repr(Indent(4)) == "Indent(4)"

>>   
>> -def push_indent(indent_amount=4):
>> -    global indent_level
>> -    indent_level += indent_amount
>> +    def __str__(self) -> str:
>> +        """Return the indent as a string."""
>> +        return ' ' * self._level
>>   
>> +    def __bool__(self) -> bool:
>> +        """True when there is a non-zero indent."""
>> +        return bool(self._level)
> 
> This one lets us shorten
> 
>      if int(INDENT):
> 
> to
> 
>      if INDENT:
> 
> There's just one instance.  Marginal.  I'm not rejecting it.
> 

Yep, it's trivial in either direction. Still, because it's a custom 
type, I thought I'd be courteous and have it support bool().

>> -def pop_indent(indent_amount=4):
>> -    global indent_level
>> -    indent_level -= indent_amount
>> +    def push(self, amount: int = 4) -> int:
>> +        """Push `amount` spaces onto the indent, default four."""
>> +        self._level += amount
>> +        return self._level
>> +
>> +    def pop(self, amount: int = 4) -> int:
>> +        """Pop `amount` spaces off of the indent, default four."""
>> +        if self._level < amount:
>> +            raise ArithmeticError(
>> +                "Can't pop {:d} spaces from {:s}".format(amount, repr(self)))
>> +        self._level -= amount
>> +        return self._level
> 
> The push / pop names never made sense.  The functions don't push onto /
> pop from a stack, they increment / decrement a counter, and so do the
> methods.  Good opportunity to fix the naming.
> 

OK.

I briefly thought about using __isub__ and __iadd__ to support e.g. 
indent += 4, but actually it'd be annoying to have to specify 4 everywhere.

Since you didn't suggest anything, I am going to change it to 'increase' 
and 'decrease'.

> The @amount parameter has never been used.  I don't mind keeping it.
> 
I'll keep it, because I like having the default amount show up in the 
signature instead of as a magic constant in the function body.

>> +
>> +
>> +INDENT = Indent(0)
> 
> Uh, does this really qualify as a constant?  It looks quite variable to
> me...
> 

Ever make a mistake? I thought I did once, but I was mistaken.

>>   # Generate @code with @kwds interpolated.
>>   # Obey indent_level, and strip eatspace.
>>   def cgen(code, **kwds):
>>       raw = code % kwds
>> -    if indent_level:
>> -        indent = genindent(indent_level)
>> -        raw, _ = re.subn(r'^(?!(#|$))', indent, raw, flags=re.MULTILINE)
>> +    if INDENT:
>> +        raw, _ = re.subn(r'^(?!(#|$))', str(INDENT), raw, flags=re.MULTILINE)
>>       return re.sub(re.escape(eatspace) + r' *', '', raw)
>>   
>>   
>> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
>> index 31bf46e7f7..66ce3dc52e 100644
>> --- a/scripts/qapi/visit.py
>> +++ b/scripts/qapi/visit.py
>> @@ -19,8 +19,7 @@
>>       gen_endif,
>>       gen_if,
>>       mcgen,
>> -    pop_indent,
>> -    push_indent,
>> +    INDENT,
>>   )
>>   from .gen import QAPISchemaModularCVisitor, ifcontext
>>   from .schema import QAPISchemaObjectType
>> @@ -68,7 +67,7 @@ def gen_visit_object_members(name, base, members, variants):
>>       if (visit_optional(v, "%(name)s", &obj->has_%(c_name)s)) {
>>   ''',
>>                            name=memb.name, c_name=c_name(memb.name))
>> -            push_indent()
>> +            INDENT.push()
>>           ret += mcgen('''
>>       if (!visit_type_%(c_type)s(v, "%(name)s", &obj->%(c_name)s, errp)) {
>>           return false;
>> @@ -77,7 +76,7 @@ def gen_visit_object_members(name, base, members, variants):
>>                        c_type=memb.type.c_name(), name=memb.name,
>>                        c_name=c_name(memb.name))
>>           if memb.optional:
>> -            pop_indent()
>> +            INDENT.pop()
>>               ret += mcgen('''
>>       }
>>   ''')


