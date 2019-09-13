Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115A2C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C950A20717
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C950A20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8ngy-0002ME-Tj
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8ngC-0001gr-1J
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8ng8-0000ee-OU
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:40:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50510)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8ng8-0000dK-H2
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:40:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A601C315C017;
 Fri, 13 Sep 2019 15:40:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A58F15D9C3;
 Fri, 13 Sep 2019 15:39:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 37C04113865F; Fri, 13 Sep 2019 17:39:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-16-armbru@redhat.com>
 <1b10e16d-9377-38ae-08ce-3bc0f8fc39d2@redhat.com>
Date: Fri, 13 Sep 2019 17:39:58 +0200
In-Reply-To: <1b10e16d-9377-38ae-08ce-3bc0f8fc39d2@redhat.com> (Eric Blake's
 message of "Tue, 10 Sep 2019 12:37:43 -0500")
Message-ID: <8736h08asx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 13 Sep 2019 15:40:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 15/16] docs/devel/qapi-code-gen: Improve
 QAPI schema language doc
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
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/10/19 1:37 AM, Markus Armbruster wrote:
>> We document the language by giving patterns of valid JSON objects.
>> The patterns contain placeholders we don't define anywhere; their
>> names have to speak for themselves.  I guess they do, but I'd prefer a
>> bit more rigor.  Provide a grammar instead, and rework the text
>> accordingly.
>> 
>> Documentation for QAPI schema conditionals (commit 967c885108,
>> 6cc32b0e14, 87adbbffd4..3e270dcacc) and feature flags (commit
>> 6a8c0b5102) was bolted on.  The sections documenting types, commands
>> and events don't mention them.  Section "Features" and "Configuring
>> the schema" then provide additional syntax for types, commands and
>> events.  I hate that.  Fix the sections documenting types, commands
>> and events to provide accurate syntax, and point to "Features" and
>> "Configuring the schema" for details.
>> 
>> We talk about "(top-level) expressions other than include and pragma".
>> Adopt more convenient terminology: a (top-level) expression is either
>> a directive (include or pragma) or a definition (anything else).
>> 
>> Avoid the terms "dictionary" and "key".  Stick to JSON terminology
>> "object" and "member name" instead.
>> 
>> While there, make spacing more consistent.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  docs/devel/qapi-code-gen.txt | 592 ++++++++++++++++++++++-------------
>>  1 file changed, 369 insertions(+), 223 deletions(-)
>
>>  
>> -The order of keys within JSON objects does not matter unless
>> +* Production rules look like non-terminal = expression
>> +* Concatenation: Expression A B matches expression A, then B
>> +* Alternation: Expression A | B matches expression A or B
>> +* Repetition: Expression A... matches zero or more occurences of
>
> occurrences

Will fix.

>> +  expression A; expression A, ... likewise, but separated by ,
>
> worth calling out that trailing , are not allowed?

Doesn't "separated by" imply that?

> Is the 'expression A;' a copy-paste from RFC text, irrelevant to our
> usage here?

What about

    * Repetition: Expression A... matches zero or more occurences of
      expression A
    * Repetition: Expression A, ... matches zero or more occurences of
      expression A separated by ,

>> +* Grouping: Expression ( A ) matches expression A
>> +* JSON's structural characters are terminals: { } [ ] : ,
>> +* JSON's literal names are terminals: false true null
>> +* String literals enclosed in 'single quotes' are terminal, and match
>> +  this JSON string, with a leading '*' stripped off
>> +* When JSON object member's name starts with '*', the member is
>> +  optional.
>> +* The symbol STRING is a terminal, and matches any JSON string
>> +* The symbol BOOL is a terminal, and matches JSON false or true
>> +* ALL-CAPS words other than STRING are non-terminals
>> +
>> +The order of members within JSON objects does not matter unless
>>  explicitly noted.
>>  
>
>> +A QAPI schema consists of a series of top-level expressions:
>> +
>> +    SCHEMA = TOP-LEVEL-EXPR...
>> +
>> +The top-level expressions are all JSON objects.  Their order does not
>> +matter.
>
> Is that always true for all directives?

Yes from a purely semantic point of view.

No when you look at the generated text: that's in source order.  Should
not matter for C.  Does matter for documentation.

See also discussion of previous patch.

> Would it be worth reformulating as something like:
>
> SCHEMA = DIRECTIVE... DEFINITION...
>
> allowing zero-or-more of either, but where directives come first?

Language change.  Not sure anything outside tests would break.  But why
bother?

>> +
>> +A top-level expressions is either a directive or a definition:
>> +
>> +    TOP-LEVEL-EXPR = DIRECTIVE | DEFINITION
>> +
>> +There are two kinds of directives and six kinds of definitions:
>> +
>> +    DIRECTIVE = INCLUDE | PRAGMA
>> +    DEFINITION = ENUM | STRUCT | UNION | ALTERNATE | COMMAND | EVENT
>> +
>> +These are discussed in detail below.
>>  
>>  
>
>>  === Pragma directives ===
>>  
>> -Usage: { 'pragma': DICT }
>> +Syntax:
>> +    PRAGMA = { 'pragma': { '*doc-required': BOOL },
>> +                           '*returns-whitelist': [ STRING, ... ],
>> +                           '*name-case-whitelist': [ STRING, ... ] }
>
> This has matched {}, but looks wrong.  I think you meant
>
> PRAGMA = { 'pragma': { '*doc-required': BOOL,
>                        '*returns-whitelist': [ STRING, ... ],
>                        '*name-case-whitelist': [ STRING, ... ] } }

Good catch.

>>  === Enumeration types ===
>>  
>> -Usage: { 'enum': STRING, 'data': ARRAY-OF-STRING }
>> -       { 'enum': STRING, '*prefix': STRING, 'data': ARRAY-OF-STRING }
>> +Syntax:
>> +    ENUM = { 'enum': STRING,
>> +             'data': [ ENUM-VALUE, ... ],
>> +             '*prefix': STRING,
>> +             '*if': COND }
>> +    ENUM-VALUE = STRING
>> +               | { 'name': STRING, '*if': COND }
>>  
>
>> +=== Type references and array types ===
>> +
>> +Syntax:
>> +    TYPE-REF = STRING | ARRAY-TYPE
>> +    ARRAY-TYPE = [ STRING ]
>
> As written (and enforced by current code), we don't allow 2-d arrays; if
> we ever decide we need that, we'd rewrite to ARRAY-TYPE = [ ARRAY-TYPE ]
>
>>  === Struct types ===
>>  
>> -Usage: { 'struct': STRING, 'data': DICT, '*base': STRUCT-NAME }
>> +Syntax:
>> +    STRUCT = { 'struct': STRING,
>> +               'data': MEMBERS,
>> +               '*base': STRING,
>> +               '*if': COND,
>> +               '*features': FEATURES }
>> +    MEMBERS = { MEMBER, ... }
>> +    MEMBER = STRING : TYPE-REF
>> +           | STRING : { 'type': TYPE-REF, '*if': COND }
>
> Down the road, we'll probably be amending this line:
>
>  | STRING : { 'type': TYPE-REF, '*if': COND, '*default': VALUE }
>
> with appropriate documentation on how VALUE must match type.

We've wanted that for a while.  Max has patches:

    [PATCH v4 00/14] block: Try to create well-typed json:{} filenames

They need review.

>>  === Union types ===
>>  
>> -Usage: { 'union': STRING, 'data': DICT }
>> -or:    { 'union': STRING, 'data': DICT, 'base': STRUCT-NAME-OR-DICT,
>> -         'discriminator': ENUM-MEMBER-OF-BASE }
>> -
>> -Union types are used to let the user choose between several different
>> -variants for an object.  There are two flavors: simple (no
>> -discriminator or base), and flat (both discriminator and base).  A union
>> -type is defined using a data dictionary as explained in the following
>> -paragraphs.  Unions must have at least one branch.
>> +Syntax:
>> +    UNION = { 'union': STRING,
>> +              'data': BRANCHES,
>> +              '*if': COND }
>> +          | { 'union': STRING,
>> +              'data': BRANCHES,
>> +              'base': ( MEMBERS | STRING ),
>> +              'discriminator': STRING,
>> +              '*if': COND }
>> +    BRANCHES = { BRANCH, ... }
>
> This syntactically allows zero or more branches per the intro, but in
> code we semantically require at least one.  Is that a problem?

A flat union with *no* branches is actually valid as long as the
discriminator enum has values.

Not possible for simple unions and alternates, where the enum is
inferred.  Could turn the semantic constraint into syntax just for them,
but I feel it's too much notational overhead.

Besides, I'm sitting on patches that separate checking this second layer
of syntax from checking semantics, and "unions need branches" ends up in
the semantics part.  That's another reason for not doing it in syntax
here.

>> +    BRANCH = STRING : TYPE-REF
>> +           | STRING : { 'type': TYPE-REF, '*if': COND }
>> +
>> +Member 'union' names the union type.
>> +
>> +There are two flavors of union types: simple (no discriminator or
>> +base), and flat (both discriminator and base).
>> +
>> +Each BRANCH of the 'data' object defines a branch of the union.  A
>> +union must have at least one branch.
>
> Is it worth trying to represent one-or-more in the grammar, in a
> different manner than zero-or-more?

If we needed it multiple times, then something like

    * Repetition: Expression A * matches zero or more occurences of
      expression A
    * Repetition: Expression A, * matches zero or more occurences of
      expression A separated by ,
    * Repetition: Expression A + matches one or more occurences of
      expression A
    * Repetition: Expression A, + matches one or more occurences of
      expression A separated by ,

could be helpful.  But I can't see the need right now.

>> +
>> +All flat union branches must be of struct type.
>> +
>
> We may eventually relax that to permit another union, hopefully we
> remember to fix the docs when doing so.
>
>> +In the Client JSON Protocol, a flat union is represented by an object
>> +with the common members (from the base type) and the selected branch's
>> +members.  The two sets of member names must be disjoint.  Member
>> +'discriminator' must name a non-optional enum-typed member of the base
>> +struct.
>
> We've already had patches proposed for relaxing that to allow an
> optional discriminator as a way to select a default branch.  They'll
> have to be rebased on top of this.

*If* we decide we the benefit is worth the complexity.

>>  === Configuring the schema ===
>>  
>> -The 'struct', 'enum', 'union', 'alternate', 'command' and 'event'
>> -top-level expressions can take an 'if' key.  Its value must be a string
>> -or a list of strings.  A string is shorthand for a list containing just
>> -that string.  The code generated for the top-level expression will then
>> -be guarded by #if COND for each COND in the list.
>> +Syntax:
>> +    COND = STRING
>> +         | [ STRING, ... ]
>> +
>> +All definitions take an optional 'if' member.  Its value must be a
>> +string or a list of strings.  A string is shorthand for a list
>> +containing just that string.  The code generated for the definition
>> +will then be guarded by #if COND for each COND in the list.
>
> Should this read 'guarded by #if STRING for each STRING in the COND list'?

Yes, that's better.

>> -==== Expression documentation ====
>> +==== Definition documentation ====
>>  
>> -Expressions other than include and pragma directives may be preceded
>> -by a documentation block.  Such blocks are called expression
>> -documentation blocks.
>> +Definition documentation, if present, must immediately precede the
>> +definition it documents.
>>  
>> -When documentation is required (see pragma 'doc-required'), expression
>> -documentation blocks are mandatory.
>> +When documentation is required (see pragma 'doc-required'), every
>> +definition must have documentation.
>>  
>> -The documentation block consists of a first line naming the
>> -expression, an optional overview, a description of each argument (for
>> -commands and events) or member (for structs, unions and alternates),
>> -and optional tagged sections.
>> +Definition documentation starts with a line naming the definition,
>> +followed by an optional overview, a description of each argument (for
>> +commands and events), member (for structs and unions), branch (for
>> +alternates), or value (for enums), and finally optional tagged
>> +sections.
>>  
>>  FIXME: the parser accepts these things in almost any order.
>> +FIXME: union branches should be described, too.
>>  
>> -Extensions added after the expression was first released carry a
>> +Extensions added after the definition was first released carry a
>>  '(since x.y.z)' comment.
>
> Not this patch's problem - but we are inconsistent between x.y and x.y.z.
>
> There are a couple of typo or grammar fixes worth fixing, but I'm
> comfortable enough giving:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

