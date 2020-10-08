Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB467C46466
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4712820578
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZMuZw34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4712820578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYCM-0006pn-Rv
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 11:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQYAZ-0005PB-Hc
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:49:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQYAX-0002SB-1p
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602172164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vh89ze9xd+EWtVHFBPaOOqel3MQAorfH7tny45RTgSA=;
 b=SZMuZw34Iv9Cyz0lr12G79JTp2niV8ifz3LZ3bOI/4Y3ye5anfi94mnbZHCK3h7KxrDqLf
 UxhENvPwhZ7gWa8PSr6O5Z+HtbBrVpnn69DSNTuvrXFWiLQ+uJS1T3D2vLCY+EcJbpiELe
 MB6wprcALqPKuheIKsCmGkBqK2r6WuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-PbpMlZKlO92pgkrvwxTtgA-1; Thu, 08 Oct 2020 11:49:21 -0400
X-MC-Unique: PbpMlZKlO92pgkrvwxTtgA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 441DE8F68FD
 for <qemu-devel@nongnu.org>; Thu,  8 Oct 2020 15:49:20 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3378277D42;
 Thu,  8 Oct 2020 15:49:19 +0000 (UTC)
Subject: Re: [PATCH v5 34/36] qapi/visit.py: assert tag_member contains a
 QAPISchemaEnumType
To: Markus Armbruster <armbru@redhat.com>
References: <20201005195158.2348217-1-jsnow@redhat.com>
 <20201005195158.2348217-35-jsnow@redhat.com>
 <87mu0yb40j.fsf@dusky.pond.sub.org>
 <e986d234-293e-a663-a9f5-74831af43c3e@redhat.com>
 <87zh4x13z6.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <23ca848a-b472-cb34-31d2-a0cefbdf27d8@redhat.com>
Date: Thu, 8 Oct 2020 11:49:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87zh4x13z6.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 5:06 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> On 10/7/20 8:43 AM, Markus Armbruster wrote:
>>> John Snow <jsnow@redhat.com> writes:
>>>
>>>> This is true by design, but not presently able to be expressed in the
>>>> type system. An assertion helps mypy understand our constraints.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>>>> Reviewed-by: Cleber Rosa <crosa@redhat.com>
>>>> ---
>>>>    scripts/qapi/visit.py | 12 +++++++-----
>>>>    1 file changed, 7 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
>>>> index 14f30c228b7..4f11fd325b8 100644
>>>> --- a/scripts/qapi/visit.py
>>>> +++ b/scripts/qapi/visit.py
>>>> @@ -22,7 +22,7 @@
>>>>        mcgen,
>>>>    )
>>>>    from .gen import QAPISchemaModularCVisitor, ifcontext
>>>> -from .schema import QAPISchemaObjectType
>>>> +from .schema import QAPISchemaEnumType, QAPISchemaObjectType
>>>>      
>>>>    def gen_visit_decl(name, scalar=False):
>>>> @@ -84,15 +84,17 @@ def gen_visit_object_members(name, base, members, variants):
>>>>            ret += gen_endif(memb.ifcond)
>>>>          if variants:
>>>> +        tag_member = variants.tag_member
>>>> +        assert isinstance(tag_member.type, QAPISchemaEnumType)
>>> I'm curious: do you need the local variable to make the assertion
>>> stick?
>>>
>>
>> No, but it only sticks to the binding and not the
>> data. i.e. assertions to downcast work on the *name*.
> 
> Would it stick to variants.tag_member, too?
> 

As long as variants isn't re-bound in that scope, it should stick within 
that scope, yeah. (I think. Didn't test. It's my expectation.)

> I'm asking to learn, not to find a reason to make you change your patch.
> 
>> (This comes up somewhere in the schema.py patches where I make a
>> change that looks completely pointless, but it makes mypy happy.)
>>
>> I could have left it alone. I just saw a lot of repeated multi-dots
>> and habitually created a temporary local for the purpose.
> 
> Matter of taste.  Long chains of dots make the code hard to read because
> they are so long.  Temporary variable make it hard to read because you
> have to remember what they mean.  Tradeoff.  I come up with cases I find
> hard to decide all too often.
> 
> In case the local variable isn't needed for mypy: when you throw in
> something that isn't needed for the patch's stated purpose, it's best to
> mention it in the commit message, because not mentioning it is a review
> comment magnet :)
> 
> Put yourself in the reviewers shoes.  Your lovingly crafted commit
> message puts him into a positive mood.  He nods along while reading your
> obvious patch at a good pace.  And then he runs smack into the
> unexpected unrelated part, and stops: oh, what's going on here?  Back up
> some and read more slowly to make sure I understand.
> 

Yeah, understood. Well, part of it is knowing the review style of your 
reviewer too. It's been a while since we've personally swapped patches.

The actual process for much of this was: "There is an error! let me fix 
that error."

And then I do that, but I do so using idioms and patterns I'm familiar 
or comfortable with. And then post-hoc, not 100% of them were 
necessarily required, strictly, to fix the problem. Most of this series 
was written "one file at a time", and then split out post-fact into 
little per-warning changes.

I didn't even send part 1 until I finished typing the *entire* package, 
to make sure that things were as correct as possible from the very first 
commit.

I often don't really even notice that little changes aren't strictly 
necessary until they're challenged, it's usually not a conscious choice 
to try and sneak stuff in.

Still always trying to find a balance between "Easy to maintain and 
iterate" and "easy to review." Tough line for me.

>>>> +
>>>>            ret += mcgen('''
>>>>        switch (obj->%(c_name)s) {
>>>>    ''',
>>>> -                     c_name=c_name(variants.tag_member.name))
>>>> +                     c_name=c_name(tag_member.name))
>>>>              for var in variants.variants:
>>>> -            case_str = c_enum_const(variants.tag_member.type.name,
>>>> -                                    var.name,
>>>> -                                    variants.tag_member.type.prefix)
>>>> +            case_str = c_enum_const(tag_member.type.name, var.name,
>>>> +                                    tag_member.type.prefix)
>>>>                ret += gen_if(var.ifcond)
>>>>                if var.type.name == 'q_empty':
>>>>                    # valid variant and nothing to do


