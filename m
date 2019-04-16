Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0B7C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 06:35:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B00552073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 06:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00552073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60167 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGHgj-00038N-Uc
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 02:35:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGHfz-0002ki-V1
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGHfx-000157-Sk
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:34:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hGHfv-00014S-Tn
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 02:34:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A92873082B1E;
	Tue, 16 Apr 2019 06:34:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 526175C1B4;
	Tue, 16 Apr 2019 06:34:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id EBEAA1138648; Tue, 16 Apr 2019 08:34:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20190413160732.55505-1-vsementsov@virtuozzo.com>
	<87zhorbytu.fsf@dusky.pond.sub.org>
	<3381f703-4fc1-ac3c-658c-f7399403acf9@virtuozzo.com>
	<874l6za00z.fsf@dusky.pond.sub.org>
	<e432f8cf-4014-8175-4a56-167a14534528@virtuozzo.com>
Date: Tue, 16 Apr 2019 08:34:32 +0200
In-Reply-To: <e432f8cf-4014-8175-4a56-167a14534528@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Mon, 15 Apr 2019 13:35:59 +0000")
Message-ID: <87k1fu791j.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 16 Apr 2019 06:34:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] util/error: do not free error on
 error_abort
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416063432.1WKP7-10aM-Gvi1tOzM6iP3b2pCloAhF_ye36qwyZUY@z>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 15.04.2019 16:08, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>> 
>>> 15.04.2019 8:51, Markus Armbruster wrote:
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>>>>
>>>>> It would be nice to have Error object not freed away when debugging a
>>>>> coredump.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>> ---
>>>>>    util/error.c | 8 +++++---
>>>>>    1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/util/error.c b/util/error.c
>>>>> index 934a78e1b1..f9180c0f30 100644
>>>>> --- a/util/error.c
>>>>> +++ b/util/error.c
>>>>> @@ -32,9 +32,11 @@ Error *error_fatal;
>>>>>    static void error_handle_fatal(Error **errp, Error *err)
>>>>>    {
>>>>>        if (errp == &error_abort) {
>>>>> -        fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
>>>>> -                err->func, err->src, err->line);
>>>>> -        error_report_err(err);
>>>>> +        error_report("Unexpected error in %s() at %s:%d: %s",
>>>>> +                     err->func, err->src, err->line, error_get_pretty(err));
>>>>> +        if (err->hint) {
>>>>> +            error_printf_unless_qmp("%s", err->hint->str);
>>>>> +        }
>>>>>            abort();
>>>>>        }
>>>>>        if (errp == &error_fatal) {
>>>>
>>>> No objections to not freeing the error object on the path to abort().
>>>>
>>>> You also format the error message differently.  Commit 1e9b65bb1ba's
>>>> example
>>>>
>>>>           Unexpected error in parse_block_error_action() at .../qemu/blockdev.c:322:
>>>>           qemu-system-x86_64: -drive if=none,werror=foo: 'foo' invalid write error action
>>>>           Aborted (core dumped)
>>>>
>>>> changes to (guesswork, not tested):
>>>>
>>>>           qemu-system-x86_64: -drive if=none,werror=foo: Unexpected error in parse_block_error_action() at .../qemu/blockdev.c:322: 'foo' invalid write error action
>>>>           Aborted (core dumped)
>>>
>>> hm. checkpatch don't allow to put \n into error_report. So, should I call error_report twice?
>>>
>>> Transition from fprintf to error_report is OK for you?
>> 
>> Let's simply not mess with the formatting at all.  Something like:
>> 
>> (1) Inline error_report_err(), delete the error_free()
>> 
>> (2) Optional: replace fprintf() by error_printf()
>> 
>> (3) Optional: clean up the additional copy of
>> 
>>          if (err->hint) {
>>              error_printf_unless_qmp("%s", err->hint->str);
>>          }
>> 
>> (3a) Either create a helper function, replacing all three copies,
>> 
>> (3b) Or simply delete the new copy from the path leading to abort(),
>>       since the hint is unlikely to be useful there.
>> 
>
> Why we print error always but hint only "unless_qmp"?

"Hints" are intended for giving hints to a human user (although they are
misused for other purposes in places):

/*
 * Append a printf-style human-readable explanation to an existing error.
 * If the error is later reported to a human user with
 * error_report_err() or warn_report_err(), the hints will be shown,
 * too.  If it's reported via QMP, the hints will be ignored.
 * Intended use is adding helpful hints on the human user interface,
 * e.g. a list of valid values.  It's not for clarifying a confusing
 * error message.
 * @errp may be NULL, but not &error_fatal or &error_abort.
 * Trivially the case if you call it only after error_setg() or
 * error_propagate().
 * May be called multiple times.  The resulting hint should end with a
 * newline.
 */
void error_append_hint(Error **errp, const char *fmt, ...)
    GCC_FMT_ATTR(2, 3);

