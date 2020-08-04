Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A787C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 18:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 563D220792
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 18:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U90zG9R+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563D220792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k31V3-0005e5-HX
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 14:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k31Th-0005Bh-HR
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:15:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60435
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k31Te-00073w-3P
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 14:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596564952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AjLZoWomH/q0XQPfbNFBybTqJHIaWi3feJ7Tgy+cG1U=;
 b=U90zG9R+bjkEkvtptnxjNMNbvbtZaBJExPieK9vyK3QX2HGvb7n+i9cvdhvUBaDpRHtD8a
 8Xuo90jl4ycpw6RCLkr/wRkpu8YxDBEjwDfXQzLgsRyyWRTXFeTBRq2Bg2EKv2TYJr7Uot
 PlbWwcNbgYRxcB759gqjzdK4oRZom+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-mJN4uZOMMI2vVyk0cjAH1A-1; Tue, 04 Aug 2020 14:15:46 -0400
X-MC-Unique: mJN4uZOMMI2vVyk0cjAH1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E9031DE0
 for <qemu-devel@nongnu.org>; Tue,  4 Aug 2020 18:15:45 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-117-179.rdu2.redhat.com [10.10.117.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F2C17B900;
 Tue,  4 Aug 2020 18:15:44 +0000 (UTC)
Subject: Re: qapi-schema esotera
To: Markus Armbruster <armbru@redhat.com>
References: <5bfa3895-304d-8372-c0db-fda4c1a1ba59@redhat.com>
 <dc0a16e2-365f-a9e6-03df-b70f97dd7407@redhat.com>
 <64792de9-6719-3987-a66b-aed8cca61572@redhat.com>
 <875z9zgel3.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <d3c59a98-b29f-1d80-e726-c656cd54bcd2@redhat.com>
Date: Tue, 4 Aug 2020 14:15:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <875z9zgel3.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On 8/4/20 1:33 AM, Markus Armbruster wrote:
 > John Snow <jsnow@redhat.com> writes:
 >
 >> On 8/3/20 1:25 PM, Eric Blake wrote:
 >>> On 8/3/20 11:49 AM, John Snow wrote:
 >>>> UNION is split into two primary forms:
 >>>>
 >>>> 1. Simple (No discriminator nor base)
 >>>> 2. Flat (Discriminator and base)
 >>>>
 >>>> In expr.py, I notice that we modify the perceived type of the
 >>>> 'type' expression based on the two union forms.
 >>>>
 >>>> 1a. Simple unions allow Array[T]
 >>>> 1b. Flat unions disallow Array[T]
 >>>
 >>> Rather, branches in a simple unions are syntactic sugar for a
 >>> wrapper struct that contains a single member 'data'; because of that
 >>> extra nesting, the type of that single member is unconstrained.  In
 >>> flat unionw, the type MUST be a QAPI struct, because its members
 >>> will be used inline; as currently coded, this prevents the use of an
 >>> intrinsic type ('int', 'str') or an array type.
 >>>
 >>
 >> I meant syntactically here, to be clear. I'm looking at expr.py -- if
 >> there are deeper constraints on the semantics of the information
 >> provided, that happens later.
 >>
 >> Specifically, check_union's use of check_type() changes depending on
 >> the form of the union. One allows a string, the other allows a List of
 >> strings, provided the list is precisely one element long.
 >>
 >>> If you need to use an array type in a flat union, you can't do:
 >>>
 >>> { 'union' ...
 >>>     'data': { 'foo': [ 'MyBranch' ] } }
 >>>
 >>> but you can provide a wrapper type yourself:
 >>>
 >>> { 'struct': 'MyBranch', 'data': { 'array': [ 'MyType' ] } }
 >>> { 'union' ...
 >>>     'data': { 'foo': 'MyBranch' } }
 >>>
 >>>>
 >>>>   From the docs:
 >>>>
 >>>> Syntax:
 >>>>       UNION = { 'union': STRING,
 >>>>                 'data': BRANCHES,
 >>>>                 '*if': COND,
 >>>>                 '*features': FEATURES }
 >>>>             | { 'union': STRING,
 >>>>                 'data': BRANCHES,
 >>>>                 'base': ( MEMBERS | STRING ),
 >>>>                 'discriminator': STRING,
 >>>>                 '*if': COND,
 >>>>                 '*features': FEATURES }
 >>>>       BRANCHES = { BRANCH, ... }
 >>>>       BRANCH = STRING : TYPE-REF
 >>>>              | STRING : { 'type': TYPE-REF, '*if': COND }
 >>>>
 >>>> Both arms use the same "BRANCHES" grammar production, which both
 >>>> use TYPE-REF.
 >>>>
 >>>>       TYPE-REF = STRING | ARRAY-TYPE
 >>>>       ARRAY-TYPE = [ STRING ]
 >>>>
 >>>> Implying that List[T] should be allowed for both productions.
 >>>> Can I ask for a ruling from the judges?
 >>>
 >>> As you found, the docs are a bit misleading; the semantic constraint
 >>> on flat union branches being a struct (because they will be inlined)
 >>> prevents the use of type-refs that are valid in simple unions (where
 >>> those simple types will be wrapped in an implicit struct).  A patch
 >>> to improve the docs would be a reasonable idea.
 >>>
 >>
 >> Yes. I was working on a YAML prototype and I am trying to follow the
 >> existing parser as closely as possible. In some cases, this highlights
 >> differences between the grammar as advertised and what the parser
 >> actually does.
 >
 > Please report all such differences, so we can fix them.
 >
You have been the delightful beneficiary of all doubts thus far, I 
promise. I am not aware of more discrepancies at the moment, but I 
didn't finish my prototype, either.

 >> If we are to keep the current state of things, splitting UNION into
 >> two separate productions might be nice.
 >
 > It *is* two productions, joined with |.
 >
I ... yes. Technically correct. I had meant separating them out even 
further in the docs, which I suppose implies two top-level construct 
names with how you have the grammar laid out.

I see you want to get rid of one of these productions, though, so don't 
worry about this thought of mine. We can simplify in the other direction.

 > The work unions really, really need is:
 >
 > * Eliminate the simple union sugar.
 >
What do you mean by "simple union sugar"? Wait, before you answer, let 
me make sure I have the nuances of the forms straight in my head.

The following is my attempt to summarize what I know about these forms.
(Please correct me where I am mistaken.)

ALTERNATE is like an untagged union with no discriminator/tag on the 
wire. I think of a pure C union when I think of this form. The forms you 
can use are limited, based on our ability to differentiate them upon 
parsing.

SIMPLE UNION takes no `discriminator` or `base` parameter in the QAPI 
specification. However, the wire format is not an undifferentiated union.

{ 'union': 'foobar',
   'data': { 'a': 'TypeA',
             'b': 'TypeB' } }

Enjoys life at runtime as:

{ "type": ['a' | 'b'],
   "data": ... }

(with TypeA or TypeB's definition filling in for the ellipsis as denoted 
by the type field.)


FLAT UNION has a more complex definitional form. It specifies a base 
type reference by name *or* defined in-line. It also specifies a 
discriminator, which must be an enumerated type in the base.

For data, it no longer allows you to specify List[T] as a member type.

For inline definitions of base, it uses a version of type info that also 
allows the FEATURES field.

(Deep breath).

So, when you say remove "simple union sugar", do you mean the entirety 
of the tagged union form? What do we replace it by?

(Hardcoded, but compatible flat unions that use "type" field as 
discriminator to ensure backwards compatibility?)

 > * Make flat unions less cumbersome to write.  I'd like to fuse struct
 >    and union into a single object type, like introspect.json already
 >    does.
 >
Can you share what you have in mind for how to fuse 'struct' and 
discriminated unions? At the high QAPI grammatical level; no need to 
delve into code generator details.

(Unless you want to, and then I'll read them.)

 > The former is a matter of massaging the schema and simplifying code.
 > The latter requires actual thought.  No big deal, just takes time, and
 > time is always in short supply.
 >


--js


