Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AC9C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C64206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C64206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8mVB-000842-0W
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 10:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i8mU1-0007BR-PR
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i8mU0-0008PS-BN
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:23:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i8mU0-0008PF-4L
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:23:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2E7C6109EFC4;
 Fri, 13 Sep 2019 14:23:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E449E5D717;
 Fri, 13 Sep 2019 14:23:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 754B3113865F; Fri, 13 Sep 2019 16:23:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190910063724.28470-1-armbru@redhat.com>
 <20190910063724.28470-5-armbru@redhat.com>
 <06d179fd-e96a-7560-4fcc-a2271ab0b4b7@redhat.com>
Date: Fri, 13 Sep 2019 16:23:24 +0200
In-Reply-To: <06d179fd-e96a-7560-4fcc-a2271ab0b4b7@redhat.com> (Eric Blake's
 message of "Tue, 10 Sep 2019 10:10:41 -0500")
Message-ID: <87impw9swz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 13 Sep 2019 14:23:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 04/16] docs/devel/qapi-code-gen: Minor
 specification fixes
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
>> The specification claims "Each expression that isn't an include
>> directive may be preceded by a documentation block", but the code also
>> rejects them for pragma directives.  The code is correct.  Fix the
>> specification.
>> 
>> The specification reserves member names starting with 'has_', but the
>> code also reserves name 'u'.  Fix the specification.
>
> Reservation of 'u' was done in 5e59baf9 (and claimed we could add a
> munge to q_u in the future if we ever needed a name 'u' after all).

Yes.

has_ could be munged away, too.

>> The specification claims "The string 'max' is not allowed as an enum
>> value".  Untrue.  Fix the specification.  While there, delete the
>> naming advice, because it's redundant with the naming rules in section
>> "Schema overview"
>
> Used to be true; missed when commit 7fb1cf16 got rid of the collision.

Correct.

>> The specification claims "No branch of the union can be named 'max',
>> as this would collide with the implicit enum".  Untrue.  Fix the
>> specification.
>
> Fixed around the same time (although I didn't check if it was in the
> same commit)
>
>> 
>> The specification claims "It is not allowed to name an event 'MAX',
>> since the generator also produces a C enumeration of all event names
>> with a generated _MAX value at the end."  Untrue.  Fix the
>> specification.
>
> And similar comment.
>
> I don't know if you want to do exact commit ids where all of these doc
> problems were introduced (because of code patches that lifted the
> limitations).

I'm (overly?) fond of git archeology myself, but I found these bugs
while fighting crocodiles in the swamp, so I couldn't indulge.

>> The specification claims "All branches of the union must be complex
>> types", but the code permits only struct types.  The code is correct.
>> Fix the specification.
>> 
>> The specification claims a command's return type "must be the string
>> name of a complex or built-in type, a one-element array containing the
>> name of a complex or built-in type" unless the command is in pragma
>> 'returns-whitelist'.  The code does not permit built-in types.  Fix
>> the specification.
>
> Umm:
>
> qapi/migration.json:{ 'command': 'query-migrate-cache-size', 'returns':
> 'int' }
>
> I don't know if we use an array of a built-in-type, but we definitely
> have unfortunate commands that return a non-JSON-object.  [1]
>
>>  A flat union definition avoids nesting on the wire, and specifies a
>>  set of common members that occur in all variants of the union.  The
>>  'base' key must specify either a type name (the type must be a
>>  struct, not a union), or a dictionary representing an anonymous type.
>> -All branches of the union must be complex types, and the top-level
>> +All branches of the union must be struct types, and the top-level
>
> We have hit cases where it might have been nicer to permit a flat union
> whose branch is itself another flat union.  But until we actually code
> that up to work, this is accurate.
>
>
>> @@ -578,8 +578,8 @@ The 'returns' member describes what will appear in the "return" member
>>  of a Client JSON Protocol reply on successful completion of a command.
>>  The member is optional from the command declaration; if absent, the
>>  "return" member will be an empty dictionary.  If 'returns' is present,
>> -it must be the string name of a complex or built-in type, a
>> -one-element array containing the name of a complex or built-in type.
>> +it must be the string name of a complex type, or a
>> +one-element array containing the name of a complex type.
>>  To return anything else, you have to list the command in pragma
>>  'returns-whitelist'.  If you do this, the command cannot be extended
>>  to return additional information in the future.  Use of
>
> [1] Aha - it's 'returns-whitelist' that makes the difference.  Okay,
> your wording change here makes sense: a built-in is NOT permitted UNLESS
> you whitelist it.
>
> Summary: you may want to improve the commit message with git
> archaeology, but the wording changes themselves make sense.

I'll see what I can do without too much effort.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

