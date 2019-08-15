Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94538C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 19:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6939A20656
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 19:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6939A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46593 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyLNb-0003JY-7y
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 15:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1hyLMl-0002Nv-Gp
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 15:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hyLMi-0002Wg-HE
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 15:24:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hyLMb-0002Og-S1; Thu, 15 Aug 2019 15:24:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 590708535C;
 Thu, 15 Aug 2019 19:24:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 677F1100194E;
 Thu, 15 Aug 2019 19:24:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C650A1136444; Thu, 15 Aug 2019 21:24:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <20190815104928.GC7415@linux.fritz.box>
 <9c290e4e-1d3b-bc6e-c6e6-28a0414b866e@redhat.com>
 <20190815164821.GE7415@linux.fritz.box>
Date: Thu, 15 Aug 2019 21:24:34 +0200
In-Reply-To: <20190815164821.GE7415@linux.fritz.box> (Kevin Wolf's message of
 "Thu, 15 Aug 2019 18:48:21 +0200")
Message-ID: <87a7caut8t.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 15 Aug 2019 19:24:44 +0000 (UTC)
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, den@openvz.org, mreitz@redhat.com,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 15.08.2019 um 18:07 hat John Snow geschrieben:
>> 
>> 
>> On 8/15/19 6:49 AM, Kevin Wolf wrote:
>> > Am 14.08.2019 um 21:27 hat John Snow geschrieben:
>> >>
>> >>
>> >> On 8/14/19 6:07 AM, Vladimir Sementsov-Ogievskiy wrote:
>> >>> To get rid of implicit filters related workarounds in future let's
>> >>> deprecate them now.
>> >>>
>> >>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> >>> ---
>> >>>  qemu-deprecated.texi      |  7 +++++++
>> >>>  qapi/block-core.json      |  6 ++++--
>> >>>  include/block/block_int.h | 10 +++++++++-
>> >>>  blockdev.c                | 10 ++++++++++
>> >>>  4 files changed, 30 insertions(+), 3 deletions(-)
>> >>>
>> >>> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>> >>> index 2753fafd0b..8222440148 100644
>> >>> --- a/qemu-deprecated.texi
>> >>> +++ b/qemu-deprecated.texi
>> >>> @@ -183,6 +183,13 @@ the 'wait' field, which is only applicable to sockets in server mode
>> >>>  
>> >>>  Use blockdev-mirror and blockdev-backup instead.
>> >>>  
>> >>> +@subsection implicit filters (since 4.2)
>> >>> +
>> >>> +Mirror and commit jobs inserts filters, which becomes implicit if user
>> >>> +omitted filter-node-name parameter. So omitting it is deprecated, set it
>> >>> +always. Note, that drive-mirror don't have this parameter, so it will
>> >>> +create implicit filter anyway, but drive-mirror is deprecated itself too.
>> >>> +
>> >>>  @section Human Monitor Protocol (HMP) commands
>> >>>  
>> >>>  @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (since 3.1)
>> >>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> >>> index 4e35526634..0505ac9d8b 100644
>> >>> --- a/qapi/block-core.json
>> >>> +++ b/qapi/block-core.json
>> >>> @@ -1596,7 +1596,8 @@
>> >>>  # @filter-node-name: the node name that should be assigned to the
>> >>>  #                    filter driver that the commit job inserts into the graph
>> >>>  #                    above @top. If this option is not given, a node name is
>> >>> -#                    autogenerated. (Since: 2.9)
>> >>> +#                    autogenerated. Omitting this option is deprecated, it will
>> >>> +#                    be required in future. (Since: 2.9)
>> >>>  #
>> >>>  # @auto-finalize: When false, this job will wait in a PENDING state after it has
>> >>>  #                 finished its work, waiting for @block-job-finalize before
>> >>> @@ -2249,7 +2250,8 @@
>> >>>  # @filter-node-name: the node name that should be assigned to the
>> >>>  #                    filter driver that the mirror job inserts into the graph
>> >>>  #                    above @device. If this option is not given, a node name is
>> >>> -#                    autogenerated. (Since: 2.9)
>> >>> +#                    autogenerated. Omitting this option is deprecated, it will
>> >>> +#                    be required in future. (Since: 2.9)
>> >>>  #
>> >>>  # @copy-mode: when to copy data to the destination; defaults to 'background'
>> >>>  #             (Since: 3.0)
>> >>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> >>> index 3aa1e832a8..624da0b4a2 100644
>> >>> --- a/include/block/block_int.h
>> >>> +++ b/include/block/block_int.h
>> >>> @@ -762,7 +762,15 @@ struct BlockDriverState {
>> >>>      bool sg;        /* if true, the device is a /dev/sg* */
>> >>>      bool probed;    /* if true, format was probed rather than specified */
>> >>>      bool force_share; /* if true, always allow all shared permissions */
>> >>> -    bool implicit;  /* if true, this filter node was automatically inserted */
>> >>> +
>> >>> +    /*
>> >>> +     * @implicit field is deprecated, don't set it to true for new filters.
>> >>> +     * If true, this filter node was automatically inserted and user don't
>> >>> +     * know about it and unprepared for any effects of it. So, implicit
>> >>> +     * filters are workarounded and skipped in many places of the block
>> >>> +     * layer code.
>> >>> +     */
>> >>> +    bool implicit;
>> >>>  
>> >>>      BlockDriver *drv; /* NULL means no media */
>> >>>      void *opaque;
>> >>> diff --git a/blockdev.c b/blockdev.c
>> >>> index 36e9368e01..b3cfaccce1 100644
>> >>> --- a/blockdev.c
>> >>> +++ b/blockdev.c
>> >>> @@ -3292,6 +3292,11 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
>> >>>      BlockdevOnError on_error = BLOCKDEV_ON_ERROR_REPORT;
>> >>>      int job_flags = JOB_DEFAULT;
>> >>>  
>> >>> +    if (!has_filter_node_name) {
>> >>> +        warn_report("Omitting filter-node-name parameter is deprecated, it "
>> >>> +                    "will be required in future");
>> >>> +    }
>> >>> +
>> >>>      if (!has_speed) {
>> >>>          speed = 0;
>> >>>      }
>> >>> @@ -3990,6 +3995,11 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
>> >>>      Error *local_err = NULL;
>> >>>      int ret;
>> >>>  
>> >>> +    if (!has_filter_node_name) {
>> >>> +        warn_report("Omitting filter-node-name parameter is deprecated, it "
>> >>> +                    "will be required in future");
>> >>> +    }
>> >>> +
>> >>>      bs = qmp_get_root_bs(device, errp);
>> >>>      if (!bs) {
>> >>>          return;
>> >>>
>> >>
>> >> This might be OK to do right away, though.
>> >>
>> >> I asked Markus this not too long ago; do we want to amend the QAPI
>> >> schema specification to allow commands to return with "Warning" strings,
>> >> or "Deprecated" stings to allow in-band deprecation notices for cases
>> >> like these?
>> >>
>> >> example:
>> >>
>> >> { "return": {},
>> >>   "deprecated": True,
>> >>   "warning": "Omitting filter-node-name parameter is deprecated, it will
>> >> be required in the future"
>> >> }
>> >>
>> >> There's no "error" key, so this should be recognized as success by
>> >> compatible clients, but they'll definitely see the extra information.
>> >>
>> >> Part of my motivation is to facilitate a more aggressive deprecation of
>> >> legacy features by ensuring that we are able to rigorously notify users
>> >> through any means that they need to adjust their scripts.
>> > 
>> > Who would read this, though? In the best case it ends up deep in a
>> > libvirt log that nobody will look at because there was no error. In the
>> > more common case, the debug level is configured so that QMP traffic
>> > isn't even logged.
>> > 
>> > Kevin
>> > 
>> 
>> I believe you are right, but I also can't shake the feeling that this
>> attitude ensures that we'll never find a way to expose this information
>> to the end-user. Is this not too defeatist?
>
> I think the discussed approach that seemed most likely to me to succeed
> was adding a command line option that makes QEMU just crash if you use a
> deprecated feature, and enable that in libvirt test cases (or possibly
> even any non-release builds, though maybe it's a bit harsh there).

Yup.  BoF minutes: "The one way to get people read log files is crashing
their application."

>> I think deprecation notices in the QMP stream has two benefits:
>> 
>> 1) Any direct usages via qmp-shell or manual JSON connection are likely
>> to see this message in development or testing. I feel the usage of QEMU
>> directly is more likely to increase with time as other stacks seek to
>> work around libvirt.
>> 
>> [Whether or not they should is another question, but I believe the
>> current reality to be that people are trying to.]
>
> I don't know about other people, but as a human user, I don't care about
> deprecation notices. As long as something works, I use it, and once I
> get an error message back, I'll use something else.
>
> If I manually enter drive_mirror and get a warning back, that doesn't
> tell me that libvirt still does the same thing and needs to be fixed. It
> just tells me that in the future I might need to change the commands
> that I use manually.
>
> I guess this would still prevent adding new libvirt features that build
> on deprecated QEMU features because some manual testing will be involved
> there. But was this ever a problem?

You're right in that relying on *humans* to read the machine-readable
deprecation notice probaly won't work for old client code trying to use
newly deprecated QMP.  It should work for new client code trying to use
already deprecated QMP.

>> 2) Programmatic deprecation notices can't be presented to a user at all
>> if we don't send them; at least this way it becomes libvirt's problem
>> over what to do with them. Perhaps even just in testing and regression
>> suites libvirt can assert that it sees no deprecation warnings (or
>> whitelist certain ones it knows about.)
>> 
>> In the case of libvirt, it's not even necessarily about making sure the
>> end user sees it, because it isn't even necessarily the user's fault --
>> it's libvirt's. This is a sure-fire programmatic way to communicate
>> compatibility changes to libvirt.
>
> If libvirt uses this to make test cases fail, it could work.

Yes.

However, ensuring tests fail whenever libvirt receives a deprecation
notice via QMP seems harder than having them pass --future to QEMU to
make it crash instead of sending such a notice.

Let's assume all libvirt ever does with deprecation notices is logging
them.  Would that solve the problem of reliably alerting libvirt
developers to deprecation issues?  Nope.  But it could help
occasionally.

