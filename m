Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1897DC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:10:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78BB20644
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78BB20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyIKc-0006T0-Se
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hyIIP-0004NU-A8
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hyIIL-0006I7-7t
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:08:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38946)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hyII9-00069t-IT; Thu, 15 Aug 2019 12:07:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B14858E37A;
 Thu, 15 Aug 2019 16:07:56 +0000 (UTC)
Received: from [10.18.17.169] (dhcp-17-169.bos.redhat.com [10.18.17.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 797055D6A9;
 Thu, 15 Aug 2019 16:07:50 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <20190815104928.GC7415@linux.fritz.box>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9c290e4e-1d3b-bc6e-c6e6-28a0414b866e@redhat.com>
Date: Thu, 15 Aug 2019 12:07:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815104928.GC7415@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 15 Aug 2019 16:07:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] qapi: deprecate implicit filters
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
Cc: qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com, armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/15/19 6:49 AM, Kevin Wolf wrote:
> Am 14.08.2019 um 21:27 hat John Snow geschrieben:
>>
>>
>> On 8/14/19 6:07 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> To get rid of implicit filters related workarounds in future let's
>>> deprecate them now.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>  qemu-deprecated.texi      |  7 +++++++
>>>  qapi/block-core.json      |  6 ++++--
>>>  include/block/block_int.h | 10 +++++++++-
>>>  blockdev.c                | 10 ++++++++++
>>>  4 files changed, 30 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>>> index 2753fafd0b..8222440148 100644
>>> --- a/qemu-deprecated.texi
>>> +++ b/qemu-deprecated.texi
>>> @@ -183,6 +183,13 @@ the 'wait' field, which is only applicable to sockets in server mode
>>>  
>>>  Use blockdev-mirror and blockdev-backup instead.
>>>  
>>> +@subsection implicit filters (since 4.2)
>>> +
>>> +Mirror and commit jobs inserts filters, which becomes implicit if user
>>> +omitted filter-node-name parameter. So omitting it is deprecated, set it
>>> +always. Note, that drive-mirror don't have this parameter, so it will
>>> +create implicit filter anyway, but drive-mirror is deprecated itself too.
>>> +
>>>  @section Human Monitor Protocol (HMP) commands
>>>  
>>>  @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (since 3.1)
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 4e35526634..0505ac9d8b 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -1596,7 +1596,8 @@
>>>  # @filter-node-name: the node name that should be assigned to the
>>>  #                    filter driver that the commit job inserts into the graph
>>>  #                    above @top. If this option is not given, a node name is
>>> -#                    autogenerated. (Since: 2.9)
>>> +#                    autogenerated. Omitting this option is deprecated, it will
>>> +#                    be required in future. (Since: 2.9)
>>>  #
>>>  # @auto-finalize: When false, this job will wait in a PENDING state after it has
>>>  #                 finished its work, waiting for @block-job-finalize before
>>> @@ -2249,7 +2250,8 @@
>>>  # @filter-node-name: the node name that should be assigned to the
>>>  #                    filter driver that the mirror job inserts into the graph
>>>  #                    above @device. If this option is not given, a node name is
>>> -#                    autogenerated. (Since: 2.9)
>>> +#                    autogenerated. Omitting this option is deprecated, it will
>>> +#                    be required in future. (Since: 2.9)
>>>  #
>>>  # @copy-mode: when to copy data to the destination; defaults to 'background'
>>>  #             (Since: 3.0)
>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>> index 3aa1e832a8..624da0b4a2 100644
>>> --- a/include/block/block_int.h
>>> +++ b/include/block/block_int.h
>>> @@ -762,7 +762,15 @@ struct BlockDriverState {
>>>      bool sg;        /* if true, the device is a /dev/sg* */
>>>      bool probed;    /* if true, format was probed rather than specified */
>>>      bool force_share; /* if true, always allow all shared permissions */
>>> -    bool implicit;  /* if true, this filter node was automatically inserted */
>>> +
>>> +    /*
>>> +     * @implicit field is deprecated, don't set it to true for new filters.
>>> +     * If true, this filter node was automatically inserted and user don't
>>> +     * know about it and unprepared for any effects of it. So, implicit
>>> +     * filters are workarounded and skipped in many places of the block
>>> +     * layer code.
>>> +     */
>>> +    bool implicit;
>>>  
>>>      BlockDriver *drv; /* NULL means no media */
>>>      void *opaque;
>>> diff --git a/blockdev.c b/blockdev.c
>>> index 36e9368e01..b3cfaccce1 100644
>>> --- a/blockdev.c
>>> +++ b/blockdev.c
>>> @@ -3292,6 +3292,11 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
>>>      BlockdevOnError on_error = BLOCKDEV_ON_ERROR_REPORT;
>>>      int job_flags = JOB_DEFAULT;
>>>  
>>> +    if (!has_filter_node_name) {
>>> +        warn_report("Omitting filter-node-name parameter is deprecated, it "
>>> +                    "will be required in future");
>>> +    }
>>> +
>>>      if (!has_speed) {
>>>          speed = 0;
>>>      }
>>> @@ -3990,6 +3995,11 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
>>>      Error *local_err = NULL;
>>>      int ret;
>>>  
>>> +    if (!has_filter_node_name) {
>>> +        warn_report("Omitting filter-node-name parameter is deprecated, it "
>>> +                    "will be required in future");
>>> +    }
>>> +
>>>      bs = qmp_get_root_bs(device, errp);
>>>      if (!bs) {
>>>          return;
>>>
>>
>> This might be OK to do right away, though.
>>
>> I asked Markus this not too long ago; do we want to amend the QAPI
>> schema specification to allow commands to return with "Warning" strings,
>> or "Deprecated" stings to allow in-band deprecation notices for cases
>> like these?
>>
>> example:
>>
>> { "return": {},
>>   "deprecated": True,
>>   "warning": "Omitting filter-node-name parameter is deprecated, it will
>> be required in the future"
>> }
>>
>> There's no "error" key, so this should be recognized as success by
>> compatible clients, but they'll definitely see the extra information.
>>
>> Part of my motivation is to facilitate a more aggressive deprecation of
>> legacy features by ensuring that we are able to rigorously notify users
>> through any means that they need to adjust their scripts.
> 
> Who would read this, though? In the best case it ends up deep in a
> libvirt log that nobody will look at because there was no error. In the
> more common case, the debug level is configured so that QMP traffic
> isn't even logged.
> 
> Kevin
> 

I believe you are right, but I also can't shake the feeling that this
attitude ensures that we'll never find a way to expose this information
to the end-user. Is this not too defeatist?

I think deprecation notices in the QMP stream has two benefits:

1) Any direct usages via qmp-shell or manual JSON connection are likely
to see this message in development or testing. I feel the usage of QEMU
directly is more likely to increase with time as other stacks seek to
work around libvirt.

[Whether or not they should is another question, but I believe the
current reality to be that people are trying to.]

2) Programmatic deprecation notices can't be presented to a user at all
if we don't send them; at least this way it becomes libvirt's problem
over what to do with them. Perhaps even just in testing and regression
suites libvirt can assert that it sees no deprecation warnings (or
whitelist certain ones it knows about.)

In the case of libvirt, it's not even necessarily about making sure the
end user sees it, because it isn't even necessarily the user's fault --
it's libvirt's. This is a sure-fire programmatic way to communicate
compatibility changes to libvirt.

--js

