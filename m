Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886F9C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 06:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBC520880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 06:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBC520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnH19-0003Av-Dp
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 02:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58842)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hnH0x-0002hb-MJ
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 02:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hnH0w-0006vy-Az
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 02:32:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60224)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hnH0t-0006tW-DW; Tue, 16 Jul 2019 02:32:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 70600307D848;
 Tue, 16 Jul 2019 06:32:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 969A95C221;
 Tue, 16 Jul 2019 06:32:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EC4D411386A0; Tue, 16 Jul 2019 08:32:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
References: <20190530143941.241963-1-vsementsov@virtuozzo.com>
 <c7ef8501-0c9f-f21b-1b60-dcd7dba03557@redhat.com>
 <f9af022a-7acf-bb1c-3d2c-b095bff2e251@redhat.com>
 <2a9f6327-1cb6-78eb-ad10-93a33c6e754c@redhat.com>
 <87a7ew9p3o.fsf@dusky.pond.sub.org>
 <4ee9736d-4e49-6572-e6e8-94739d155323@redhat.com>
Date: Tue, 16 Jul 2019 08:32:28 +0200
In-Reply-To: <4ee9736d-4e49-6572-e6e8-94739d155323@redhat.com> (John Snow's
 message of "Mon, 15 Jul 2019 20:13:13 -0400")
Message-ID: <874l3mqykj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 16 Jul 2019 06:32:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qapi: add dirty-bitmaps to
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 nshirokovskiy@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 6/5/19 8:46 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> On 5/31/19 10:55 AM, Eric Blake wrote:
>>>> On 5/30/19 11:26 AM, John Snow wrote:
>>>>>
>>>>>
>>>>> On 5/30/19 10:39 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Let's add a possibility to query dirty-bitmaps not only on root nodes.
>>>>>> It is useful when dealing both with snapshots and incremental backups.
>>>>>>
>>>>
>>>>>> +++ b/block/qapi.c
>>>>>> @@ -78,6 +78,11 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>>>>>>          info->backing_file = g_strdup(bs->backing_file);
>>>>>>      }
>>>>>>  
>>>>>> +    if (!QLIST_EMPTY(&bs->dirty_bitmaps)) {
>>>>>> +        info->has_dirty_bitmaps = true;
>>>>>> +        info->dirty_bitmaps = bdrv_query_dirty_bitmaps(bs);
>>>>>> +    }
>>>>>> +
>>>>>>      info->detect_zeroes = bs->detect_zeroes;
>>>>>>  
>>>>>>      if (blk && blk_get_public(blk)->throttle_group_member.throttle_state) {
>>>>>>
>>>>>
>>>>> So query-block uses bdrv_query_info, which calls bdrv_block_device_info,
>>>>> so we'll duplicate the bitmap output when doing the old-fashioned block
>>>>> query, but that's probably harmless overall.
>>>>
>>>> We already know that none of our existing query- interfaces are sane
>>>> (either too little information, or too much).  Duplication starts to
>>>> push an interface towards too much (it takes processor time to bundle up
>>>> the extra JSON, especially if the other end is not going to care if it
>>>> was present). I know Kevin still has somewhere on his to-do list the
>>>> implementation of a saner query- command for the information we really
>>>> want (about each block, without redundant information, and where we
>>>> don't repeat information in a nested manner, but where we also don't
>>>> omit information that would otherwise require multiple existing query-
>>>> to reconstruct).
>>>>
>>>>>
>>>>> We can continue to support the output in both places, or we could opt to
>>>>> deprecate the older interface; I think this is one of the last chances
>>>>> we'd get to do so before libvirt and wider adoption.
>>>>>
>>>>> I think that's probably Eric's choice.
>>>>
>>>> If you want to try to deprecate the old location, introspection at least
>>>> works to allow libvirt to know which place to look for it on a given
>>>> qemu. If you don't think deprecation is necessary, the duplication is
>>>> probably tolerable for now (as ideally we'd be deprecating ALL of our
>>>> not-quite-perfect query- block interfaces in favor of whatever sane
>>>> interface Kevin comes up with).
>>>>
>>>
>>> It sounds like it's probably the right move to deprecate the entire
>>> legacy interface, but still... If you have 20 or 30 bitmaps on a root
>>> node, you will see 40 or 60 entries.
>>>
>>> What's the smart way to deprecate it? We're not adding new flags or
>>> showing new arguments or anything. There might not be bitmaps, so you
>>> can't rely on that field being present or absent.
>>>
>>> Recommendations?
>> 
>> Kevin's "[PATCH v4 0/6] file-posix: Add dynamic-auto-read-only QAPI
>> feature" adds "feature flags" to the QAPI schema language, limited to
>> struct types, because that's what he needs.  They're visible in
>> introspection.  I intend to complete his work, so we can tack
>> "deprecated" feature flags to pretty much anything
>> 
>> Could that address your need?
>> 
>
> Hi Markus, digging this up again.
>
> In brief, we are displaying bitmap info in the "wrong" part of the query
> result (attached to drive instead of node) and would like to change it.

I lack context: which query command, which part of its result?

> I'd like to avoid reporting bitmaps in both locations permanently, so if
> we have a plan to deprecate reporting bitmaps in the old location, I
> will tolerate the duplicated output temporarily.

How bulky is the bitmap report?

> Keeping in mind the bitmap fields are optional (so they can be absent
> from both the new and old locations), what plan can we implement?

"Optional" is a syntactic thing, which ought to be backed by a semantic
"present iff" condition.  Have we specified such conditions?

> Perhaps I can add a feature flag "has-node-bitmaps" for 4.2. Then, for
> the next three versions, I will report bitmaps from both locations.
> Then, in 5.2+ I will remove the old location.

For how long has the bitmap been in the "wrong" place?  Any known
consumers?

> A client knows it can find bitmaps (if there are any) in the new
> location if the feature flag is set. Otherwise, it should look in the
> old location.
>
> I think I've convinced myself that this is correct, so correct me if I
> am wrong.

Sounds like a valid use of feature flags to me.  However, feature flags
are best used as a last resort.  With answers to my questions, I should
be able to compare the feature flags solution to possible alternatives.

