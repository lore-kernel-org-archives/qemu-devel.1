Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DF0C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:42:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2EE2082E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2EE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42952 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haGoX-0007jJ-Ow
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 05:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46375)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1haGlm-0006ny-5o
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1haGlj-00012c-LT
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:39:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1haGlh-0000mU-KF
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:39:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8E89F87642
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 09:38:47 +0000 (UTC)
Received: from redhat.com (ovpn-116-138.ams2.redhat.com [10.36.116.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9D725C219;
 Mon, 10 Jun 2019 09:38:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
In-Reply-To: <87zhnn3f5o.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Wed, 15 May 2019 17:34:27 +0200")
References: <20190515121544.4597-1-quintela@redhat.com>
 <20190515121544.4597-6-quintela@redhat.com>
 <87zhnn3f5o.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Mon, 10 Jun 2019 11:38:44 +0200
Message-ID: <87v9xdvkyj.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 10 Jun 2019 09:38:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 5/8] migration: Add multifd-compress
 parameter
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>> +    case MIGRATION_PARAMETER_MULTIFD_COMPRESS:
>> +        p->has_multifd_compress = true;
>> +        visit_type_MultifdCompress(v, param, &compress_type, &err);
>> +        if (err) {
>> +            break;
>> +        }
>> +        if (compress_type < 0 || compress_type >= MULTIFD_COMPRESS__MAX) {
>> +            error_setg(&err, "Invalid multifd_compress option %s", valuestr);
>> +            break;
>> +        }
>
> This should never happen.  If you want to check anyway, make it an
> assertion.
>
> Just in case you don't believe me, or are curious:
>
> visit_type_MultifdCompress() wraps around visit_type_enum(), passing it
> &MultifdCompress_lookup.
>
> Since @v is an input visitor, visit_type_enum() wraps around
> input_type_enum().
>
> input_type_enum() computes the value to store in @compress_type with
> qapi_enum_parse().
>
> To get here, visit_type_MultifdCompress() must have succeeded,
> i.e. visit_type_enum(), input_type_enum() and qapi_enum_parse() all
> succeded.
>
> On success, qapi_enum_parse() returns one of the values in
> MultifdCompress_lookup, i.e. a member of enum MultifdCompress other than
> MULTIFD_COMPRESS__MAX.

Fixed, thanks.

>> @@ -3353,6 +3362,9 @@ void migration_global_dump(Monitor *mon)
>>  #define DEFINE_PROP_MIG_CAP(name, x)             \
>>      DEFINE_PROP_BOOL(name, MigrationState, enabled_capabilities[x], false)
>>  
>> +#define DEFINE_PROP_MULTIFD_COMPRESS(_n, _s, _f, _d) \
>> +    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_multifd_compress, MultifdCompress)
>> +
>
> Did you forget to move this?

It appears that yes.  I tried to move the other part out of
qdev-properties, failed.  And then forgot to move this bit.

Thanks.

Later, Juan.

