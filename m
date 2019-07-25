Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D310C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 06:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034E32173E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 06:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034E32173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqWth-0007NF-1l
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 02:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39631)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hqWtW-0006uE-Q8
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 02:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hqWtV-000846-Co
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 02:06:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59002)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hqWtS-00080f-8R; Thu, 25 Jul 2019 02:06:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C80A6A3B5F;
 Thu, 25 Jul 2019 06:06:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-30.ams2.redhat.com
 [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDC4A5D71A;
 Thu, 25 Jul 2019 06:06:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 62003113865F; Thu, 25 Jul 2019 08:06:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
References: <20190717173937.18747-1-jsnow@redhat.com>
 <87imrsqbrj.fsf@dusky.pond.sub.org>
 <f06c477a-0334-f38c-038e-befbaf826ee1@redhat.com>
Date: Thu, 25 Jul 2019 08:06:14 +0200
In-Reply-To: <f06c477a-0334-f38c-038e-befbaf826ee1@redhat.com> (John Snow's
 message of "Wed, 24 Jul 2019 18:06:23 -0400")
Message-ID: <87lfwmk5rd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 25 Jul 2019 06:06:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] qapi: add dirty-bitmaps to
 query-named-block-nodes result
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 7/24/19 12:47 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>
>>> Let's add a possibility to query dirty-bitmaps not only on root nodes.
>>> It is useful when dealing both with snapshots and incremental backups.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> [Added deprecation information. --js]
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  block/qapi.c         |  5 +++++
>>>  qapi/block-core.json |  6 +++++-
>>>  qemu-deprecated.texi | 12 ++++++++++++
>>>  3 files changed, 22 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/qapi.c b/block/qapi.c
>>> index 917435f022..15f1030264 100644
>>> --- a/block/qapi.c
>>> +++ b/block/qapi.c
>>> @@ -79,6 +79,11 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>>>          info->backing_file = g_strdup(bs->backing_file);
>>>      }
>>>  
>>> +    if (!QLIST_EMPTY(&bs->dirty_bitmaps)) {
>>> +        info->has_dirty_bitmaps = true;
>>> +        info->dirty_bitmaps = bdrv_query_dirty_bitmaps(bs);
>>> +    }
>>> +
>>>      info->detect_zeroes = bs->detect_zeroes;
>>>  
>>>      if (blk && blk_get_public(blk)->throttle_group_member.throttle_state) {
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 0d43d4f37c..9210ae233d 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -360,6 +360,9 @@
>>>  # @write_threshold: configured write threshold for the device.
>>>  #                   0 if disabled. (Since 2.3)
>>>  #
>>> +# @dirty-bitmaps: dirty bitmaps information (only present if node
>>> +#                 has one or more dirty bitmaps) (Since 4.2)
>>> +#
>>>  # Since: 0.14.0
>>>  #
>>>  ##
>>> @@ -378,7 +381,7 @@
>>>              '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
>>>              '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
>>>              '*iops_size': 'int', '*group': 'str', 'cache': 'BlockdevCacheInfo',
>>> -            'write_threshold': 'int' } }
>>> +            'write_threshold': 'int', '*dirty-bitmaps': ['BlockDirtyInfo'] } }
>>>  
>>>  ##
>>>  # @BlockDeviceIoStatus:
>>> @@ -656,6 +659,7 @@
>>>  #
>>>  # @dirty-bitmaps: dirty bitmaps information (only present if the
>>>  #                 driver has one or more dirty bitmaps) (Since 2.0)
>>> +#                 Deprecated in 4.2; see BlockDirtyInfo instead.
>>>  #
>>>  # @io-status: @BlockDeviceIoStatus. Only present if the device
>>>  #             supports it and the VM is configured to stop on errors
>>> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>>> index c90b08d553..6374b66546 100644
>>> --- a/qemu-deprecated.texi
>>> +++ b/qemu-deprecated.texi
>>> @@ -134,6 +134,18 @@ The ``status'' field of the ``BlockDirtyInfo'' structure, returned by
>>>  the query-block command is deprecated. Two new boolean fields,
>>>  ``recording'' and ``busy'' effectively replace it.
>>>  
>>> +@subsection query-block result field dirty-bitmaps (Since 4.2)
>>> +
>>> +The ``dirty-bitmaps`` field of the ``BlockInfo`` structure, returned by
>>> +the query-block command is itself now deprecated. The ``dirty-bitmaps``
>>> +field of the ``BlockDeviceInfo`` struct should be used instead, which is the
>>> +type of the ``inserted`` field in query-block replies, as well as the
>>> +type of array items in query-named-block-nodes.
>> 
>> Would the text be clearer if it talked only about commands, not about
>> types?
>> 
>> Here's my (laconic) try:
>> 
>>    @subsection query-block result field dirty-bitmaps (Since 4.2)
>> 
>>    In the result of query-block, member ``dirty-bitmaps'' has been moved
>>    into member ``inserted''.
>> 
>
> Yeah, that's probably better in terms of strictly what the deprecation
> is. I was trying to imply that the output will also now be visible in
> other commands as well, but that's not the deprecation -- that's the new
> feature.
>
> ACK
>
>> Aside: same for existing @subsection query-block result field
>> dirty-bitmaps[i].status (since 4.0).
>> 
>
> (Probably not worth editing deprecation text that was already published.)

Maybe, maybe not.  I'm not making demands.

>>> +Since the ``dirty-bitmaps`` field is optionally present in both the old and
>>> +new locations, clients must use introspection to learn where to anticipate
>>> +the field if/when it does appear in command output.
>>> +
>> 
>> I find this hint a bit confusing.  Do we need it?
>> 
>
> I think so, yes: it's nice to inform readers of how to cope with the
> deprecation.
>
>> If yes, laconic me again:
>> 
>>    Clients should use introspection to learn whether ``dirty-bitmaps'' is
>>    in the new location.
>> 
>
> Too terse. I want my documentation to greet me in the morning by reading
> me the local newspaper while I brush my teeth.
>
> Yours says the "how", but I think a hint should have the "why":
>
> "Since the ``dirty-bitmaps`` field is not always present in command
> output, Clients should use introspection to learn the location of this
> field."

This is clearer than the text in Vladimir's patch.  It made me
understand why you want to talk about optional.  See, I've been peddling
the introspection kool-aid long enough to take "use introspection to
detect interface changes" for granted.  The idea that anyone would try
something like "if what query-block just gave me doesn't have
dirty-bitmaps in the new location, look for it in the old location" just
didn't come to me.

However, dirty-bitmaps being optional is *not* why you shouldn't do
that!  In fact, doing it is not even wrong.  It only gets wrong when you
do it wrongly.

Wrong: if what query-block just gave me doesn't have dirty-bitmaps in
the new location, only look for it in the old location from now on.

Correct: if what query-block just gave me doesn't have dirty-bitmaps in
the new location, look for it in the old location this time.  Next time,
do the same: try the new location first, then the old location.

Also correct: if what query-block just gave me doesn't have
dirty-bitmaps in the new location, look for it in the old location.
Once I've found it in either location, keep looking for it only there in
the future.  But why would I want to do that?  It's more complicated
than the previous one for no gain.

Correct and preferred: use introspection.  You need to use it anyway to
detect changes in arguments, so why do something else for changes in
results.  Have some kool-aid!

> But I'm only willing to give you a self-deprecating joke and a final
> nudge to keep a more informative hint, and then I'll capitulate and take
> your suggestion if you give me a stern look.

No, I'm giving you a friendly "use your judgement" instead.  You may
well be a better judge of what our users need here, because you're less
deep into introspection than me, and so are our users.

> --js
>
>>>  @subsection query-cpus (since 2.12.0)
>>>  
>>>  The ``query-cpus'' command is replaced by the ``query-cpus-fast'' command.

