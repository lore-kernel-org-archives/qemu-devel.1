Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17877C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:04:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF805206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF805206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJ8b-00064J-Dq
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iIH4K-000746-2y
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 14:52:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iIH4H-0000tI-O3
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 14:52:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36466)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iIH4H-0000s7-Fv
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 14:52:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0A96018C4283;
 Wed,  9 Oct 2019 18:52:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 52EE75D6B2;
 Wed,  9 Oct 2019 18:52:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C8E8B1138619; Wed,  9 Oct 2019 20:51:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 01/31] errp: rename errp to errp_in where it is
 IN-argument
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
 <20191001155319.8066-2-vsementsov@virtuozzo.com>
 <878spvmwns.fsf@dusky.pond.sub.org>
 <c393e6cc-ae34-78bb-2b7a-53ab6ed1dbae@virtuozzo.com>
Date: Wed, 09 Oct 2019 20:51:56 +0200
In-Reply-To: <c393e6cc-ae34-78bb-2b7a-53ab6ed1dbae@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 9 Oct 2019 09:42:46 +0000")
Message-ID: <87eezlzr8z.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Wed, 09 Oct 2019 18:52:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 08.10.2019 12:08, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
[...]
>>> diff --git a/util/error.c b/util/error.c
>>> index d4532ce318..b3ff3832d6 100644
>>> --- a/util/error.c
>>> +++ b/util/error.c
>>> @@ -271,11 +271,11 @@ void error_free(Error *err)
>>>       }
>>>   }
>>>   
>>> -void error_free_or_abort(Error **errp)
>>> +void error_free_or_abort(Error **errp_in)
>>>   {
>>> -    assert(errp && *errp);
>>> -    error_free(*errp);
>>> -    *errp = NULL;
>>> +    assert(errp_in && *errp_in);
>>> +    error_free(*errp_in);
>>> +    *errp_in = NULL;
>>>   }
>>>   
>>>   void error_propagate(Error **dst_errp, Error *local_err)
>> 
>> This functions frees the error.  It leaves nothing for the caller to
>> clean up.
>> 
>> All callers pass &ERR, where ERR is a local variable.  We can peel off
>> an indirection.
>
>
> But if we drop indirection, we'll have to set local variable to NULL by
> hand. Is it good?
>
> Look at test_keyval_parse_list() for example: it uses local err object
> several times, so it depends on the fact that error_free_or_abort
> sets pointer to NULL.

You're right, peeling off the indirection would make
error_free_or_abort() worse.

It's a convenience function for tests.  Confusion seems unlikely to me.
Let's not worry about it.

