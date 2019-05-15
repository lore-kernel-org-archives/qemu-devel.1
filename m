Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0FFC04E87
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCEB2084E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCEB2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36489 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQt2L-00082h-Nv
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 08:29:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQt11-0007N0-Gt
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQt10-0006Fv-99
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:28:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQt10-0006Aq-0e
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:28:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49E0B37F46
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 12:28:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 16CFE5C236;
	Wed, 15 May 2019 12:28:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 8CB5911385E4; Wed, 15 May 2019 14:28:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
References: <20190403114958.3705-1-quintela@redhat.com>
	<20190403114958.3705-7-quintela@redhat.com>
	<87tvf8svr3.fsf@dusky.pond.sub.org> <87d0kkj8mx.fsf@trasno.org>
Date: Wed, 15 May 2019 14:28:05 +0200
In-Reply-To: <87d0kkj8mx.fsf@trasno.org> (Juan Quintela's message of "Wed, 15
	May 2019 12:48:38 +0200")
Message-ID: <87a7fn7vhm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 15 May 2019 12:28:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 6/8] migration: Add multifd-compress
 parameter
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Juan Quintela <quintela@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> wrote:
>> Juan Quintela <quintela@redhat.com> writes:
>>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>
>>> ---
>>> Rename it to NONE
>
>>> @@ -1822,6 +1826,19 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>>          p->has_multifd_channels = true;
>>>          visit_type_int(v, param, &p->multifd_channels, &err);
>>>          break;
>>> +    case MIGRATION_PARAMETER_MULTIFD_COMPRESS:
>>> +        p->has_multifd_compress = true;
>>> +        visit_type_enum(v, param, &compress_type,
>>> +                        &MultifdCompress_lookup, &err);
>>
>> visit_type_MultifdCompress(), please.
>
> done.
>
> Interesting that I can
>
> #include "qapi/qapi-visit-common.h"
>
> but not what I would expect/want:
>
> #include "qapi/qapi-visit.h"

I guess you tried to include it into target-independent code, which
doesn't work since we added target conditionals like

    { 'command': 'rtc-reset-reinjection',
      'if': 'defined(TARGET_I386)' }

Adding these (merge commit a0430dd8abb) was only possible because the
code generated from the QAPI schema mirrors the QAPI schema's modular
structure: just like qapi-schema.json includes its sub-modules such as
common.json, the generated qapi-visit.h includes the headers generated
for its sub-modules such as qapi-visit-common.h.  See commit 252dc3105f
"qapi: Generate separate .h, .c for each module".

The original motivation for this modularization was actually compile
time.  Before modularization, touching the QAPI schema typically
recompiled everything using QAPI, which nowadays means pretty much
everything.  Modularization let me replace "include all generated QAPI
stuff" by "include just the generated QAPI stuff I actually need", for
*massive* compile time improvements.

Back to target conditionals.  Right now, we confine them to sub-module
target.json.  This means the headers generated for this sub-module, such
as qapi-visit-target.h, can only be included into target-dependent code.
Since qapi-visit.h includes all sub-modules, it can also only be
included there.

> Perhaps we should remove
>
> #include "qapi-visit-target.h"
>
> from there?

No for two reasons:

1. The code generating qapi-visit.h has no idea which sub-modules are
target-specific.

2. You shouldn't include qapi-visit.h anyway, it's bad for compile time.

> Anyways, independent of this patch.

Yes.

>>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>>> index 5da1439a8b..7c8e71532f 100644
>>> --- a/hw/core/qdev-properties.c
>>> +++ b/hw/core/qdev-properties.c
>>> @@ -645,6 +645,17 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
>>>      .set_default_value = set_default_value_enum,
>>>  };
>>>  
>>> +/* --- MultifdCompress --- */
>>> +
>>> +const PropertyInfo qdev_prop_multifd_compress = {
>>> +    .name = "MultifdCompress",
>>> +    .description = "multifd_compress values",
>>
>> Similar property declarations list the valid values in .description.
>
> Fixed, thanks.
>
>>>  
>>> +#define DEFINE_PROP_MULTIFD_COMPRESS(_n, _s, _f, _d) \
>>> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compress, MultifdCompress)
>>> +
>>
>> As long as qdev_prop_multifd_compress is exposed in qdev-properties.h,
>> hiding the macro using it doesn't make sense to me.
>
> Where do you want it to be?  This should only be used here, but if you
> want it anywhere else, told me where.

Put the declaration of qdev_prop_multifd_compress and the macro in the
same source file.  Simplest: qdev-properties.h.

>>> +##
>>> +# @MultifdCompress:
>>> +#
>>> +# An enumeration of multifd compression.
>>> +#
>>> +# @none: no compression.
>>> +#
>>> +# Since: 4.1
>>> +#
>>> +##
>>> +{ 'enum': 'MultifdCompress',
>>> +  'data': [ 'none' ] }
>>
>> Any particular reason for putting this in common.json?  As is, it looks
>> rather migration-specific to me...
>
> Not sure if with new "qapi" compiler it works, it used to be that it
> failed if you declared an enum anywhere else.  See how I have to put
> property info into qdev-properties.c instead of any migration file.

You can certainly declare enums anywhere, you just have to make sure to
include the right headers in the right places, just like for manually
written enums in C headers.

Rules for modular QAPI schema:

1. If module A uses an entity defined in module B, A must include B

   Example: since migration.json uses MultifdCompress defined in
   common.json, migration.json must include common.json (it does).

2. No circular includes, ever.

3. Try to avoid cross-module dependencies

   Example: migration.json uses MultifdCompress defined in common.json.
   This is a cross-module dependency.  Can we avoid it by moving
   MultifdCompress into migration.json?

   The QAPI schema would be just fine with such a move, but C code using
   the generated headers might be unhappy, because it now has to include
   qapi-types-migration.h instead of just qapi-types-common.h.

   My question was: is C code really unhappy?  Please find out and tell
   me.

