Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23363C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 05:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2D72173B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 05:26:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2D72173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hurz3-0004zB-4B
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 01:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49692)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1huryf-0004Yi-Kf
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 01:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hurye-0003Nh-GQ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 01:25:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hurye-0003Mc-8y
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 01:25:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5009C300B912;
 Tue,  6 Aug 2019 05:25:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 750FE19C7F;
 Tue,  6 Aug 2019 05:25:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DAE6A1138619; Tue,  6 Aug 2019 07:25:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
References: <1564684930-107089-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <87imrfkdgm.fsf@dusky.pond.sub.org>
 <c11463f0-6cf1-7249-f4c6-2af8ae10ad19@virtuozzo.com>
Date: Tue, 06 Aug 2019 07:25:33 +0200
In-Reply-To: <c11463f0-6cf1-7249-f4c6-2af8ae10ad19@virtuozzo.com> (Andrey
 Shinkevich's message of "Mon, 5 Aug 2019 15:09:30 +0000")
Message-ID: <87mugmsw4y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 06 Aug 2019 05:25:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] make check-unit: use after free in
 test-opts-visitor
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
Cc: Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Andrey Shinkevich <andrey.shinkevich@virtuozzo.com> writes:

> On 02/08/2019 14:34, Markus Armbruster wrote:
>> Andrey Shinkevich <andrey.shinkevich@virtuozzo.com> writes:
>> 
>>> In struct OptsVisitor, repeated_opts member points to a list in the
>>> unprocessed_opts hash table after the list has been destroyed. A
>>> subsequent call to visit_type_int() references the deleted list. It
>>> results in use-after-free issue.
>> 
>> Let's mention the reproducer: valgrind tests/test/opts-visitor.
>> 
>>>                                   Also, the Visitor object call back
>>> functions are supposed to set the Error parameter in case of failure.
>> 
>> As far as I can tell, they all do.  The only place where you set an
>> error is the new failure you add to lookup_scalar().
>> 
>
> The story behind the comment is that the original 
> tests/test-opts-visitor fails being run under the Valgrind with the 
> error message:
>
> test-opts-visitor: util/error.c:276: error_free_or_abort: Assertion 
> `errp && *errp' failed.
>
> coming from
>
> assert(errp && *errp);
> error_free_or_abort (util/error.c:276)
> test_opts_range_beyond (tests/test-opts-visitor.c:241)
>
> because g_queue_peek_head() returns NULL under the Valgrind and errp 
> stays unset.
>
> Without the Valgrind, the g_queue_peek_head() returns a non-zero pointer 
> and the opts_type_int64() sets the following error:
>
> "Parameter '\340F\212\274\267U' expects an int64 value or range", 
> err_class = ERROR_CLASS_GENERIC_ERROR, src = 0x55b7bbc02163 
> "qapi/opts-visitor.c",
>    func = 0x55b7bbc02410 <__func__.14916> "opts_type_int64", line = 433, 
> hint = 0x0}
>
> so, error_free_or_abort() doesn't abort and the test case passes.
>
> I will remove the comment in v3.

Thanks.

[...]
>>> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
>>> index 324b197..23ac383 100644
>>> --- a/qapi/opts-visitor.c
>>> +++ b/qapi/opts-visitor.c
[...]
>>> @@ -289,8 +302,11 @@ opts_end_list(Visitor *v, void **obj)
>>>   
>>>       assert(ov->list_mode == LM_IN_PROGRESS ||
>>>              ov->list_mode == LM_SIGNED_INTERVAL ||
>>> -           ov->list_mode == LM_UNSIGNED_INTERVAL);
>>> -    ov->repeated_opts = NULL;
>>> +           ov->list_mode == LM_UNSIGNED_INTERVAL ||
>>> +           ov->list_mode == LM_TRAVERSED);
>>> +    if (ov->list_mode != LM_TRAVERSED) {
>>> +        ov->repeated_opts = NULL;
>>> +    }
>> 
>> What's wrong with zapping ov->repeated_opts unconditionally?
>> 
>>>       ov->list_mode = LM_NONE;
>>>   }
>>>   
>>> @@ -306,6 +322,10 @@ lookup_scalar(const OptsVisitor *ov, const char *name, Error **errp)
>>>           list = lookup_distinct(ov, name, errp);
>>>           return list ? g_queue_peek_tail(list) : NULL;
>>>       }
>>> +    if (ov->list_mode == LM_TRAVERSED) {
>>> +        error_setg(errp, QERR_INVALID_PARAMETER, name);
>> 
>> Beware, @name is null when visiting list members.  The test still passes
>> for me, since g_strdup_vprintf() formats a null argument to %s as
>> "(null)".
>> 
>> For what it's worth, the qobject input visitor uses
>> QERR_MISSING_PARAMETER with a made-up name.  Computing the name is
>> pretty elaborate, see full_name_nth().  I'd rather not duplicate that
>> here.
>> 
>> Suggest something like
>> 
>>             error_setg(errp, "Fewer list elements than expected");
>> 
>> The error message fails to mention the name of the list.  Bad, but the
>> error is a corner case; we don't normally visit beyond the end of the
>> list.  For a better message, we'd have to have start_list() store its
>> @name in struct OptsVisitor.  I'm not asking you to do that now.
>> 
>
> Will I do that work to add the @name of the list to the struct 
> OptsVisitor in a following series?

Entirely up to you.  To be honest, I'm not sure it's worth the trouble.

>>> +        return NULL;
>>> +    }
>>>       assert(ov->list_mode == LM_IN_PROGRESS);
>>>       return g_queue_peek_head(ov->repeated_opts);
>>>   }
>> 
>> I checked the remaining uses of ->list_mode, and I think they are okay.
>> 
> Thank you. I also had not noticed any potential issue with the list_mode.

Good :)

