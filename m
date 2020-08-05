Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2F6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861912177B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 08:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/3a9ego"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861912177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3EVt-0002LC-Qm
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 04:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3EV6-0001pP-0C
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:10:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3EV3-00046f-0j
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 04:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596615011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bep+JB0Had36Fj+mbPThwZ+UoyS6I65FQ6LDXC+JzgE=;
 b=d/3a9ego9GMliqHJedU+dLfBJD65fb15rkLtHCTw2BeTSZcCdOA7EF3RG/LQQOvmLBJfiA
 gTg7LMPBdrS7evc913PcM7CYcy8SF5uWV0E8TcOrVStxb/MRGmjTw2JbimoHyDODt80yn4
 QDvxEfDwbpA41iaxOsZhWsrgplYx2ks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-1NusTTNFMFCg4UWdGgo4wg-1; Wed, 05 Aug 2020 04:10:08 -0400
X-MC-Unique: 1NusTTNFMFCg4UWdGgo4wg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C85A79ECC
 for <qemu-devel@nongnu.org>; Wed,  5 Aug 2020 08:10:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45940275E4C;
 Wed,  5 Aug 2020 08:10:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B954A1141D60; Wed,  5 Aug 2020 10:10:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: qapi-schema esotera
References: <5bfa3895-304d-8372-c0db-fda4c1a1ba59@redhat.com>
 <dc0a16e2-365f-a9e6-03df-b70f97dd7407@redhat.com>
 <64792de9-6719-3987-a66b-aed8cca61572@redhat.com>
 <875z9zgel3.fsf@dusky.pond.sub.org>
 <d3c59a98-b29f-1d80-e726-c656cd54bcd2@redhat.com>
Date: Wed, 05 Aug 2020 10:10:05 +0200
In-Reply-To: <d3c59a98-b29f-1d80-e726-c656cd54bcd2@redhat.com> (John Snow's
 message of "Tue, 4 Aug 2020 14:15:43 -0400")
Message-ID: <87eeol5x9e.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 04:10:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 8/4/20 1:33 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>>
>>> On 8/3/20 1:25 PM, Eric Blake wrote:
>>>> On 8/3/20 11:49 AM, John Snow wrote:
>>>>> UNION is split into two primary forms:
>>>>>
>>>>> 1. Simple (No discriminator nor base)
>>>>> 2. Flat (Discriminator and base)
>>>>>
>>>>> In expr.py, I notice that we modify the perceived type of the
>>>>> 'type' expression based on the two union forms.
>>>>>
>>>>> 1a. Simple unions allow Array[T]
>>>>> 1b. Flat unions disallow Array[T]
>>>>
>>>> Rather, branches in a simple unions are syntactic sugar for a
>>>> wrapper struct that contains a single member 'data'; because of that
>>>> extra nesting, the type of that single member is unconstrained.  In
>>>> flat unionw, the type MUST be a QAPI struct, because its members
>>>> will be used inline; as currently coded, this prevents the use of an
>>>> intrinsic type ('int', 'str') or an array type.
>>>>
>>>
>>> I meant syntactically here, to be clear. I'm looking at expr.py -- if
>>> there are deeper constraints on the semantics of the information
>>> provided, that happens later.
>>>
>>> Specifically, check_union's use of check_type() changes depending on
>>> the form of the union. One allows a string, the other allows a List of
>>> strings, provided the list is precisely one element long.
>>>
>>>> If you need to use an array type in a flat union, you can't do:
>>>>
>>>> { 'union' ...
>>>>     'data': { 'foo': [ 'MyBranch' ] } }
>>>>
>>>> but you can provide a wrapper type yourself:
>>>>
>>>> { 'struct': 'MyBranch', 'data': { 'array': [ 'MyType' ] } }
>>>> { 'union' ...
>>>>     'data': { 'foo': 'MyBranch' } }
>>>>
>>>>>
>>>>>   From the docs:
>>>>>
>>>>> Syntax:
>>>>>       UNION = { 'union': STRING,
>>>>>                 'data': BRANCHES,
>>>>>                 '*if': COND,
>>>>>                 '*features': FEATURES }
>>>>>             | { 'union': STRING,
>>>>>                 'data': BRANCHES,
>>>>>                 'base': ( MEMBERS | STRING ),
>>>>>                 'discriminator': STRING,
>>>>>                 '*if': COND,
>>>>>                 '*features': FEATURES }
>>>>>       BRANCHES = { BRANCH, ... }
>>>>>       BRANCH = STRING : TYPE-REF
>>>>>              | STRING : { 'type': TYPE-REF, '*if': COND }
>>>>>
>>>>> Both arms use the same "BRANCHES" grammar production, which both
>>>>> use TYPE-REF.
>>>>>
>>>>>       TYPE-REF = STRING | ARRAY-TYPE
>>>>>       ARRAY-TYPE = [ STRING ]
>>>>>
>>>>> Implying that List[T] should be allowed for both productions.
>>>>> Can I ask for a ruling from the judges?
>>>>
>>>> As you found, the docs are a bit misleading; the semantic constraint
>>>> on flat union branches being a struct (because they will be inlined)
>>>> prevents the use of type-refs that are valid in simple unions (where
>>>> those simple types will be wrapped in an implicit struct).  A patch
>>>> to improve the docs would be a reasonable idea.
>>>>
>>>
>>> Yes. I was working on a YAML prototype and I am trying to follow the
>>> existing parser as closely as possible. In some cases, this highlights
>>> differences between the grammar as advertised and what the parser
>>> actually does.
>>
>> Please report all such differences, so we can fix them.
>>
> You have been the delightful beneficiary of all doubts thus far, I
> promise. I am not aware of more discrepancies at the moment, but I
> didn't finish my prototype, either.
>
>>> If we are to keep the current state of things, splitting UNION into
>>> two separate productions might be nice.
>>
>> It *is* two productions, joined with |.
>>
> I ... yes. Technically correct. I had meant separating them out even
> further in the docs, which I suppose implies two top-level construct
> names with how you have the grammar laid out.
>
> I see you want to get rid of one of these productions, though, so
> don't worry about this thought of mine. We can simplify in the other
> direction.
>
>> The work unions really, really need is:
>>
>> * Eliminate the simple union sugar.
>>
> What do you mean by "simple union sugar"? Wait, before you answer, let
> me make sure I have the nuances of the forms straight in my head.
>
> The following is my attempt to summarize what I know about these forms.
> (Please correct me where I am mistaken.)
>
> ALTERNATE is like an untagged union with no discriminator/tag on the
> wire. I think of a pure C union when I think of this form. The forms
> you can use are limited, based on our ability to differentiate them
> upon parsing.

An alternate type is like a union type, except there is no
discriminator on the wire.  Instead, the branch to use is inferred
from the value.  An alternate can only express a choice between types
represented differently on the wire.

> SIMPLE UNION takes no `discriminator` or `base` parameter in the QAPI
> specification. However, the wire format is not an undifferentiated
> union.
>
> { 'union': 'foobar',
>   'data': { 'a': 'TypeA',
>             'b': 'TypeB' } }
>
> Enjoys life at runtime as:
>
> { "type": ['a' | 'b'],
>   "data": ... }
>
> (with TypeA or TypeB's definition filling in for the ellipsis as
> denoted by the type field.)

Yes.

> FLAT UNION has a more complex definitional form. It specifies a base
> type reference by name *or* defined in-line. It also specifies a
> discriminator, which must be an enumerated type in the base.
>
> For data, it no longer allows you to specify List[T] as a member type.
>
> For inline definitions of base, it uses a version of type info that
> also allows the FEATURES field.
>
> (Deep breath).
>
> So, when you say remove "simple union sugar", do you mean the entirety
> of the tagged union form? What do we replace it by?

A simple union can always be re-written as a flat union where the base
class has a single member named 'type', and where each branch of the
union has a struct with a single member named 'data'.  That is,

 { 'union': 'Simple', 'data': { 'one': 'str', 'two': 'int' } }

is identical on the wire to:

 { 'enum': 'Enum', 'data': ['one', 'two'] }
 { 'struct': 'Branch1', 'data': { 'data': 'str' } }
 { 'struct': 'Branch2', 'data': { 'data': 'int' } }
 { 'union': 'Flat': 'base': { 'type': 'Enum' }, 'discriminator': 'type',
   'data': { 'one': 'Branch1', 'two': 'Branch2' } }

This is from docs/devel/qapi-code-gen.txt.  One to put under your pillow
:)

> (Hardcoded, but compatible flat unions that use "type" field as
> discriminator to ensure backwards compatibility?)

Yes.

The one reason why I haven't done so already is the notational
overhead.  Therefore:

>> * Make flat unions less cumbersome to write.  I'd like to fuse struct
>>    and union into a single object type, like introspect.json already
>>    does.
>>
> Can you share what you have in mind for how to fuse 'struct' and
> discriminated unions? At the high QAPI grammatical level; no need to
> delve into code generator details.
>
> (Unless you want to, and then I'll read them.)

An object type similar to a Pascal variant record / Ada discriminated
type: any number of common members, plus any number of variants.  If
there are variants, then there is an additional common member, the tag.

introspect.json already works that way: have a look at SchemaInfoObject.

The part that takes actual thought is the QAPI schema language design:
how can we write such types with much less overhead than flat unions?

Listing the common members in 'base' when there are variants, but in
'data' when there are none, is a complication we can do without.

Sometimes, we want to reuse an existing enumeration type as for the tag.
Sometimes, we'd rather derive one from the variants.

Sometimes, we want to reuse an existing struct type for a variant.
Sometimes, we'd rather define the variant inline.

The spartan lower layer syntax will force some compromises.  For
instance, we can't do inline variants like

    { 'union' : 'InputEvent',
      'data'  : {
        'key: { 'key': 'KeyValue', 'down': 'bool' }
        ... } }

because we need the { } form for specifying properties other than the
type, e.g.

    { 'union': 'BlockdevOptions',
      ...
      'data': {
        ...  
        'replication': { 'type': 'BlockdevOptionsReplication',
                         'if': 'defined(CONFIG_REPLICATION)' },
        ... } }

Questions?

>> The former is a matter of massaging the schema and simplifying code.
>> The latter requires actual thought.  No big deal, just takes time, and
>> time is always in short supply.
>>
>
>
> --js


