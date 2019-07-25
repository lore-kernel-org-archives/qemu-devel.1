Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C47AC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D978022BED
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D978022BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqgMw-00040Z-SF
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 12:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58293)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hqgMl-0003Zs-GX
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hqgMj-0003jo-RQ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:13:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47914)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hqgMg-0003fs-Ev; Thu, 25 Jul 2019 12:13:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3CD8C81F19;
 Thu, 25 Jul 2019 16:13:08 +0000 (UTC)
Received: from [10.18.17.145] (dhcp-17-145.bos.redhat.com [10.18.17.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D2501001281;
 Thu, 25 Jul 2019 16:13:04 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>
References: <20190717173937.18747-1-jsnow@redhat.com>
 <87imrsqbrj.fsf@dusky.pond.sub.org>
 <f06c477a-0334-f38c-038e-befbaf826ee1@redhat.com>
 <87lfwmk5rd.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <68a71db9-ffe1-6a00-8d01-17fd35fac0f1@redhat.com>
Date: Thu, 25 Jul 2019 12:13:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87lfwmk5rd.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 25 Jul 2019 16:13:08 +0000 (UTC)
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



On 7/25/19 2:06 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> On 7/24/19 12:47 AM, Markus Armbruster wrote:
>>> John Snow <jsnow@redhat.com> writes:
>>>
>>>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>
>>>> Let's add a possibility to query dirty-bitmaps not only on root nodes.
>>>> It is useful when dealing both with snapshots and incremental backups.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> [Added deprecation information. --js]
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>  block/qapi.c         |  5 +++++
>>>>  qapi/block-core.json |  6 +++++-
>>>>  qemu-deprecated.texi | 12 ++++++++++++
>>>>  3 files changed, 22 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/qapi.c b/block/qapi.c
>>>> index 917435f022..15f1030264 100644
>>>> --- a/block/qapi.c
>>>> +++ b/block/qapi.c
>>>> @@ -79,6 +79,11 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>>>>          info->backing_file = g_strdup(bs->backing_file);
>>>>      }
>>>>  
>>>> +    if (!QLIST_EMPTY(&bs->dirty_bitmaps)) {
>>>> +        info->has_dirty_bitmaps = true;
>>>> +        info->dirty_bitmaps = bdrv_query_dirty_bitmaps(bs);
>>>> +    }
>>>> +
>>>>      info->detect_zeroes = bs->detect_zeroes;
>>>>  
>>>>      if (blk && blk_get_public(blk)->throttle_group_member.throttle_state) {
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index 0d43d4f37c..9210ae233d 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -360,6 +360,9 @@
>>>>  # @write_threshold: configured write threshold for the device.
>>>>  #                   0 if disabled. (Since 2.3)
>>>>  #
>>>> +# @dirty-bitmaps: dirty bitmaps information (only present if node
>>>> +#                 has one or more dirty bitmaps) (Since 4.2)
>>>> +#
>>>>  # Since: 0.14.0
>>>>  #
>>>>  ##
>>>> @@ -378,7 +381,7 @@
>>>>              '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
>>>>              '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
>>>>              '*iops_size': 'int', '*group': 'str', 'cache': 'BlockdevCacheInfo',
>>>> -            'write_threshold': 'int' } }
>>>> +            'write_threshold': 'int', '*dirty-bitmaps': ['BlockDirtyInfo'] } }
>>>>  
>>>>  ##
>>>>  # @BlockDeviceIoStatus:
>>>> @@ -656,6 +659,7 @@
>>>>  #
>>>>  # @dirty-bitmaps: dirty bitmaps information (only present if the
>>>>  #                 driver has one or more dirty bitmaps) (Since 2.0)
>>>> +#                 Deprecated in 4.2; see BlockDirtyInfo instead.
>>>>  #
>>>>  # @io-status: @BlockDeviceIoStatus. Only present if the device
>>>>  #             supports it and the VM is configured to stop on errors
>>>> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>>>> index c90b08d553..6374b66546 100644
>>>> --- a/qemu-deprecated.texi
>>>> +++ b/qemu-deprecated.texi
>>>> @@ -134,6 +134,18 @@ The ``status'' field of the ``BlockDirtyInfo'' structure, returned by
>>>>  the query-block command is deprecated. Two new boolean fields,
>>>>  ``recording'' and ``busy'' effectively replace it.
>>>>  
>>>> +@subsection query-block result field dirty-bitmaps (Since 4.2)
>>>> +
>>>> +The ``dirty-bitmaps`` field of the ``BlockInfo`` structure, returned by
>>>> +the query-block command is itself now deprecated. The ``dirty-bitmaps``
>>>> +field of the ``BlockDeviceInfo`` struct should be used instead, which is the
>>>> +type of the ``inserted`` field in query-block replies, as well as the
>>>> +type of array items in query-named-block-nodes.
>>>
>>> Would the text be clearer if it talked only about commands, not about
>>> types?
>>>
>>> Here's my (laconic) try:
>>>
>>>    @subsection query-block result field dirty-bitmaps (Since 4.2)
>>>
>>>    In the result of query-block, member ``dirty-bitmaps'' has been moved
>>>    into member ``inserted''.
>>>
>>
>> Yeah, that's probably better in terms of strictly what the deprecation
>> is. I was trying to imply that the output will also now be visible in
>> other commands as well, but that's not the deprecation -- that's the new
>> feature.
>>
>> ACK
>>
>>> Aside: same for existing @subsection query-block result field
>>> dirty-bitmaps[i].status (since 4.0).
>>>
>>
>> (Probably not worth editing deprecation text that was already published.)
> 
> Maybe, maybe not.  I'm not making demands.
> 
>>>> +Since the ``dirty-bitmaps`` field is optionally present in both the old and
>>>> +new locations, clients must use introspection to learn where to anticipate
>>>> +the field if/when it does appear in command output.
>>>> +
>>>
>>> I find this hint a bit confusing.  Do we need it?
>>>
>>
>> I think so, yes: it's nice to inform readers of how to cope with the
>> deprecation.
>>
>>> If yes, laconic me again:
>>>
>>>    Clients should use introspection to learn whether ``dirty-bitmaps'' is
>>>    in the new location.
>>>
>>
>> Too terse. I want my documentation to greet me in the morning by reading
>> me the local newspaper while I brush my teeth.
>>
>> Yours says the "how", but I think a hint should have the "why":
>>
>> "Since the ``dirty-bitmaps`` field is not always present in command
>> output, Clients should use introspection to learn the location of this
>> field."
> 
> This is clearer than the text in Vladimir's patch.  It made me

Now, now. That confusing text is entirely my own creation. Let's not
charge Vladimir with my error :)

> understand why you want to talk about optional.  See, I've been peddling
> the introspection kool-aid long enough to take "use introspection to
> detect interface changes" for granted.  The idea that anyone would try
> something like "if what query-block just gave me doesn't have
> dirty-bitmaps in the new location, look for it in the old location" just
> didn't come to me.
> 
> However, dirty-bitmaps being optional is *not* why you shouldn't do
> that!  In fact, doing it is not even wrong.  It only gets wrong when you
> do it wrongly.
> 
> Wrong: if what query-block just gave me doesn't have dirty-bitmaps in
> the new location, only look for it in the old location from now on.
> 
> Correct: if what query-block just gave me doesn't have dirty-bitmaps in
> the new location, look for it in the old location this time.  Next time,
> do the same: try the new location first, then the old location.
> 
> Also correct: if what query-block just gave me doesn't have
> dirty-bitmaps in the new location, look for it in the old location.
> Once I've found it in either location, keep looking for it only there in
> the future.  But why would I want to do that?  It's more complicated
> than the previous one for no gain.
> 
> Correct and preferred: use introspection.  You need to use it anyway to
> detect changes in arguments, so why do something else for changes in
> results.  Have some kool-aid!
> 
>> But I'm only willing to give you a self-deprecating joke and a final
>> nudge to keep a more informative hint, and then I'll capitulate and take
>> your suggestion if you give me a stern look.
> 
> No, I'm giving you a friendly "use your judgement" instead.  You may
> well be a better judge of what our users need here, because you're less
> deep into introspection than me, and so are our users.
> 

Aw, I was hoping you'd laugh.

I'll send a new patch, actually.

--js

