Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D8EC04E87
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 11:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F292173C
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 11:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F292173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35113 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQre4-0005WE-Ua
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 07:00:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hQrcC-0004D2-JT
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hQrSl-0007WU-B5
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:48:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hQrSl-0007Vz-5o
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:48:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C7483680F
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 10:48:42 +0000 (UTC)
Received: from redhat.com (ovpn-116-74.ams2.redhat.com [10.36.116.74])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AE11B5B7A9;
	Wed, 15 May 2019 10:48:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
In-Reply-To: <87tvf8svr3.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Mon, 08 Apr 2019 11:15:44 +0200")
References: <20190403114958.3705-1-quintela@redhat.com>
	<20190403114958.3705-7-quintela@redhat.com>
	<87tvf8svr3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Wed, 15 May 2019 12:48:38 +0200
Message-ID: <87d0kkj8mx.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Wed, 15 May 2019 10:48:42 +0000 (UTC)
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>
>> ---
>> Rename it to NONE

>> @@ -1822,6 +1826,19 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
>>          p->has_multifd_channels = true;
>>          visit_type_int(v, param, &p->multifd_channels, &err);
>>          break;
>> +    case MIGRATION_PARAMETER_MULTIFD_COMPRESS:
>> +        p->has_multifd_compress = true;
>> +        visit_type_enum(v, param, &compress_type,
>> +                        &MultifdCompress_lookup, &err);
>
> visit_type_MultifdCompress(), please.

done.

Interesting that I can

#include "qapi/qapi-visit-common.h"

but not what I would expect/want:

#include "qapi/qapi-visit.h"

Perhaps we should remove

#include "qapi-visit-target.h"

from there?

Anyways, independent of this patch.

>> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
>> index 5da1439a8b..7c8e71532f 100644
>> --- a/hw/core/qdev-properties.c
>> +++ b/hw/core/qdev-properties.c
>> @@ -645,6 +645,17 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
>>      .set_default_value = set_default_value_enum,
>>  };
>>  
>> +/* --- MultifdCompress --- */
>> +
>> +const PropertyInfo qdev_prop_multifd_compress = {
>> +    .name = "MultifdCompress",
>> +    .description = "multifd_compress values",
>
> Similar property declarations list the valid values in .description.

Fixed, thanks.

>>  
>> +#define DEFINE_PROP_MULTIFD_COMPRESS(_n, _s, _f, _d) \
>> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compress, MultifdCompress)
>> +
>
> As long as qdev_prop_multifd_compress is exposed in qdev-properties.h,
> hiding the macro using it doesn't make sense to me.

Where do you want it to be?  This should only be used here, but if you
want it anywhere else, told me where.


>> +##
>> +# @MultifdCompress:
>> +#
>> +# An enumeration of multifd compression.
>> +#
>> +# @none: no compression.
>> +#
>> +# Since: 4.1
>> +#
>> +##
>> +{ 'enum': 'MultifdCompress',
>> +  'data': [ 'none' ] }
>
> Any particular reason for putting this in common.json?  As is, it looks
> rather migration-specific to me...

Not sure if with new "qapi" compiler it works, it used to be that it
failed if you declared an enum anywhere else.  See how I have to put
property info into qdev-properties.c instead of any migration file.


Thanks, Juan.

