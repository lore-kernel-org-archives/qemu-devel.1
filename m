Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127A6C2BBD1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E206221E3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wss59t7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E206221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIxYt-0005l1-8o
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 13:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIxY9-0005J9-At
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIxY6-0007Za-8Y
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600363100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1okEQhihADjDEY3mxUsTAZFrzMm4w42lvgu90Li9yfI=;
 b=Wss59t7r8c5GM8YmxKCn/R4/DcY0ih0N/xJhbuOSFN6iiKlRoEqVTBvnP7z+/p9VT7Bv8K
 e31Gz43Edw/TuuaH77kteFkoDx/SVs6VX0UWMC5boBmbbEWuYgU3q3DRfTNuiXWfdbCBh3
 0K4IGl7p2xI1td6JePhNKTHO5Z/igVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-pTceZSkBNlmBvav3CiNUlQ-1; Thu, 17 Sep 2020 13:18:18 -0400
X-MC-Unique: pTceZSkBNlmBvav3CiNUlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACCCE107464E;
 Thu, 17 Sep 2020 17:18:17 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86B1068864;
 Thu, 17 Sep 2020 17:18:16 +0000 (UTC)
Subject: Re: [PATCH 09/37] qapi/common.py: Add indent manager
To: Markus Armbruster <armbru@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-10-jsnow@redhat.com>
 <87k0wtiwlb.fsf@dusky.pond.sub.org>
 <37ea889c-746e-bea9-a719-6bee9e86f1a8@redhat.com>
 <87v9gcesh8.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <301fb683-9b57-d355-3b08-776ab4869975@redhat.com>
Date: Thu, 17 Sep 2020 13:18:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87v9gcesh8.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 4:07 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> On 9/16/20 11:13 AM, Markus Armbruster wrote:
>>> John Snow <jsnow@redhat.com> writes:
>>>


>>> Let's replace "the indent" by "the indentation" globally.
>>>
>>
>> They're both cromulent as nouns and one is shorter.
>>
>> I'll switch in good faith; do you prefer "Indentation" as a noun?
> 
> Use of "indent" as a noun was new to me, but what do I know; you're the
> native speaker.  Use your judgement.  Applies to the class name, too.
> 

I made the change; see gitlab commits or wait for v2 to see if it reads 
better to you.

>>>> +        return self._level
>>>>    +    def __repr__(self) -> str:
>>>> +        return "{}({:d})".format(type(self).__name__, self._level)
>>> Is __repr__ needed?
>>>
>>
>> Yes; it's used in the underflow exception , and it is nice when using
>> the python shell interactively.
>>
>> repr(Indent(4)) == "Indent(4)"
> 
> Meh.  There's another three dozen classes for you to put lipstick on :)
> 

We'll get to them in due time. For now, please admire the lipstick.


>>>> +    def pop(self, amount: int = 4) -> int:
>>>> +        """Pop `amount` spaces off of the indent, default four."""
>>>> +        if self._level < amount:
>>>> +            raise ArithmeticError(
>>>> +                "Can't pop {:d} spaces from {:s}".format(amount, repr(self)))
> 
> I think assert(amount <= self._level) would do just fine.
> 

Secretly, asserts can be disabled in Python just like they can in C code.

My habit: if it's something that should already be true given the nature 
of how the code is laid out, use an assertion. If I am preventing an 
erroneous state (Especially from callers in other modules), explicitly 
raise an exception.

(See the gitlab branch for the updated version of this patch, which has 
changed the code slightly.)

>>>> +        self._level -= amount
>>>> +        return self._level
>>> The push / pop names never made sense.  The functions don't push
>>> onto /
>>> pop from a stack, they increment / decrement a counter, and so do the
>>> methods.  Good opportunity to fix the naming.
>>>
>>
>> OK.
>>
>> I briefly thought about using __isub__ and __iadd__ to support
>> e.g. indent += 4, but actually it'd be annoying to have to specify 4
>> everywhere.
>>
>> Since you didn't suggest anything, I am going to change it to
>> 'increase' and 'decrease'.
> 
> Works for me.  So would inc and dec.
> 

increase and decrease it is.

>>> The @amount parameter has never been used.  I don't mind keeping it.
>>>
>> I'll keep it, because I like having the default amount show up in the
>> signature instead of as a magic constant in the function body.
>>
>>>> +
>>>> +
>>>> +INDENT = Indent(0)
>>> Uh, does this really qualify as a constant?  It looks quite variable
>>> to
>>> me...
>>>
>>
>> Ever make a mistake? I thought I did once, but I was mistaken.
> 
> "If I had any humility, I'd be perfect!"
> 

:)


