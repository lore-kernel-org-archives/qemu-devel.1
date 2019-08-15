Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F47C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2BDA2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BDA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyGaK-0002vE-2V
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 10:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1hyGYN-0001uD-7y
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hyGYH-0000tC-3k
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:16:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60266)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hyGY7-0000qR-Ps; Thu, 15 Aug 2019 10:16:19 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16F4CC05AA6B;
 Thu, 15 Aug 2019 14:16:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5C12100194E;
 Thu, 15 Aug 2019 14:16:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 15E201DB1049; Thu, 15 Aug 2019 16:16:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
Date: Thu, 15 Aug 2019 16:16:01 +0200
In-Reply-To: <3eded188-0161-d494-194c-9d67da644eb1@redhat.com> (John Snow's
 message of "Wed, 14 Aug 2019 15:27:50 -0400")
Message-ID: <8736i2zf8e.fsf_-_@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 15 Aug 2019 14:16:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] Exposing feature deprecation to machine clients (was:
 [PATCH 2/2] qapi: deprecate implicit filters)
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 8/14/19 6:07 AM, Vladimir Sementsov-Ogievskiy wrote:
>> To get rid of implicit filters related workarounds in future let's
>> deprecate them now.
>> 
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
[...]
>> diff --git a/blockdev.c b/blockdev.c
>> index 36e9368e01..b3cfaccce1 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -3292,6 +3292,11 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
>>      BlockdevOnError on_error = BLOCKDEV_ON_ERROR_REPORT;
>>      int job_flags = JOB_DEFAULT;
>>  
>> +    if (!has_filter_node_name) {
>> +        warn_report("Omitting filter-node-name parameter is deprecated, it "
>> +                    "will be required in future");
>> +    }
>> +
>>      if (!has_speed) {
>>          speed = 0;
>>      }
>> @@ -3990,6 +3995,11 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
>>      Error *local_err = NULL;
>>      int ret;
>>  
>> +    if (!has_filter_node_name) {
>> +        warn_report("Omitting filter-node-name parameter is deprecated, it "
>> +                    "will be required in future");
>> +    }
>> +
>>      bs = qmp_get_root_bs(device, errp);
>>      if (!bs) {
>>          return;
>> 
>
> This might be OK to do right away, though.
>
> I asked Markus this not too long ago; do we want to amend the QAPI
> schema specification to allow commands to return with "Warning" strings,
> or "Deprecated" stings to allow in-band deprecation notices for cases
> like these?
>
> example:
>
> { "return": {},
>   "deprecated": True,
>   "warning": "Omitting filter-node-name parameter is deprecated, it will
> be required in the future"
> }
>
> There's no "error" key, so this should be recognized as success by
> compatible clients, but they'll definitely see the extra information.

This is a compatible evolution of the QMP protocol.

> Part of my motivation is to facilitate a more aggressive deprecation of
> legacy features by ensuring that we are able to rigorously notify users
> through any means that they need to adjust their scripts.

Yes, we should help libvirt etc. with detecting use of deprecated
features.  We discussed this at the KVM Forum 2018 BoF on deprecating
stuff.  Minutes:

    Message-ID: <87mur0ls8o.fsf@dusky.pond.sub.org>
    https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.html

Last item is relevant here.

Adding deprecation information to QMP's success response belongs to "We
can also pass the buck to the next layer up", next to "emit a QMP
event".

Let's compare the two, i.e. "deprecation info in success response"
vs. "deprecation event".

1. Possible triggers

Anything we put in the success response should only ever apply to the
(successful) command.  So this one's limited to QMP commands.

A QMP event is not limited to QMP commands.  For instance, it could be
emitted for deprecated CLI features (long after the fact, in addition to
human-readable warnings on stderr), or when we detect use of a
deprecated feature only after we sent the success response, say in a
job.  Neither use case is particularly convincing.  Reporting use of
deprecated CLI in QMP feels like a work-around for the CLI's
machine-unfriendliness.  Job-like commands should really check their
arguments upfront.

2. Connection to trigger

Connecting responses to commands is the QMP protocol's responsibility.
Transmitting deprecation information in the response trivially ties it
to the offending command.

The QMP protocol doesn't tie events to anything.  Thus, a deprecation
event needs an event-specific tie to its trigger.

The obvious way to tie it to a command mirrors how the QMP protocol ties
responses to commands: by command ID.  The event either has to be sent
just to the offending monitor (currently, all events are broadcast to
all monitors), or include a suitable monitor ID.

For non-command triggers, we'd have to invent some other tie.

3. Interface complexity

Tying the event to some arbitrary trigger adds complexity.

Do we need non-command triggers, and badly enough to justify the
additional complexity?

4. Implementation complexity 

Emitting an event could be as simple as

    qapi_event_send_deprecated(qmp_command_id(),
                               "Omitting 'filter-node-name'");

where qmp_command_id() returns the ID of the currently executing
command.  Making qmp_command_id() work is up to the QMP core.  Simple
enough as long as each QMP command runs to completion before its monitor
starts the next one.

The event is "fire and forget".  There is no warning object propagated
up the call chain into the QMP core like errors objects are.

"Fire and forget" is ideal for letting arbitrary code decide "this is
deprecated".

Note the QAPI schema remains untouched.

Unlike an event, which can be emitted anywhere, the success response
gets built in the QMP core.  To have the core add deprecation info to
it, we need to get the info to the core.

If deprecation info originates in command code, like errors do, we need
to propagate it up the call chain into the QMP core like errors.

Propagating errors is painful.  It has caused massive churn all over the
place.

I don't think we can hitch deprecation info to the existing error
propagation, since we need to take the success path back to the QMP
core, not an error path.

Propagating a second object for warnings... thanks, but no thanks.

The QMP core could provide a function for recording deprecation info for
the currently executing QMP command.  This is how we used to record
errors in QMP commands, until Anthony rammed through what we have now.
The commit messages (e.g. d5ec4f27c38) provide no justification.  I
dimly recall adamant (oral?) claims that recording errors in the Monitor
object cannot work for us.

I smell a swamp.

Can we avoid plumbing deprecation info from command code to QMP core?
Only if the QMP core itself can recognize deprecated interfaces.  I
believe it can for the cases we can expose in introspecion.  Let me
explain.

Kevin recently added "features" to the QAPI schema language.  The
implementation is incomplete, but that's detail.  The idea is to tack a
"deprecated" feature to deprecated stuff in the QAPI schema.

Commands and arguments need to support features for that.
Implementation should be relatively straightforward.

Deprecating an argument's optionalness may require a
"optional-deprecated" feature.  I've seen more elegant designs, but I've
also seen plenty of uglier ones.

Note that features are tied to schema syntax.  To express semantically
conditional deprecation like "if you specify argument FOO, then not
specifying argument BAR is deprecated", we'd have to add a language for
these conditions.  Uh, not now, maybe never.

The primary use of having deprecation defined in the QAPI schema is
introspection.  The BoF minutes mention this, too.

A secondary use could be detecting use of deprecated features right in
the QMP core.  No need for ad hoc code in commands, no need for plumbing
information from there to the QMP core.

I'd like to pursue this idea, then see how well it suits our deprecation
needs.

