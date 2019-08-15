Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE976C31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 10:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45AA208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 10:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45AA208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyDL2-0005tJ-Rm
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 06:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1hyDKC-0005IO-CP
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hyDKA-00080w-HV
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 06:49:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hyDK6-0007yo-NL; Thu, 15 Aug 2019 06:49:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23C3BC049E17;
 Thu, 15 Aug 2019 10:49:37 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-12.ams2.redhat.com [10.36.117.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A05E91000343;
 Thu, 15 Aug 2019 10:49:29 +0000 (UTC)
Date: Thu, 15 Aug 2019 12:49:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190815104928.GC7415@linux.fritz.box>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 15 Aug 2019 10:49:37 +0000 (UTC)
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

Am 14.08.2019 um 21:27 hat John Snow geschrieben:
> 
> 
> On 8/14/19 6:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> > To get rid of implicit filters related workarounds in future let's
> > deprecate them now.
> > 
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >  qemu-deprecated.texi      |  7 +++++++
> >  qapi/block-core.json      |  6 ++++--
> >  include/block/block_int.h | 10 +++++++++-
> >  blockdev.c                | 10 ++++++++++
> >  4 files changed, 30 insertions(+), 3 deletions(-)
> > 
> > diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> > index 2753fafd0b..8222440148 100644
> > --- a/qemu-deprecated.texi
> > +++ b/qemu-deprecated.texi
> > @@ -183,6 +183,13 @@ the 'wait' field, which is only applicable to sockets in server mode
> >  
> >  Use blockdev-mirror and blockdev-backup instead.
> >  
> > +@subsection implicit filters (since 4.2)
> > +
> > +Mirror and commit jobs inserts filters, which becomes implicit if user
> > +omitted filter-node-name parameter. So omitting it is deprecated, set it
> > +always. Note, that drive-mirror don't have this parameter, so it will
> > +create implicit filter anyway, but drive-mirror is deprecated itself too.
> > +
> >  @section Human Monitor Protocol (HMP) commands
> >  
> >  @subsection The hub_id parameter of 'hostfwd_add' / 'hostfwd_remove' (since 3.1)
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 4e35526634..0505ac9d8b 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -1596,7 +1596,8 @@
> >  # @filter-node-name: the node name that should be assigned to the
> >  #                    filter driver that the commit job inserts into the graph
> >  #                    above @top. If this option is not given, a node name is
> > -#                    autogenerated. (Since: 2.9)
> > +#                    autogenerated. Omitting this option is deprecated, it will
> > +#                    be required in future. (Since: 2.9)
> >  #
> >  # @auto-finalize: When false, this job will wait in a PENDING state after it has
> >  #                 finished its work, waiting for @block-job-finalize before
> > @@ -2249,7 +2250,8 @@
> >  # @filter-node-name: the node name that should be assigned to the
> >  #                    filter driver that the mirror job inserts into the graph
> >  #                    above @device. If this option is not given, a node name is
> > -#                    autogenerated. (Since: 2.9)
> > +#                    autogenerated. Omitting this option is deprecated, it will
> > +#                    be required in future. (Since: 2.9)
> >  #
> >  # @copy-mode: when to copy data to the destination; defaults to 'background'
> >  #             (Since: 3.0)
> > diff --git a/include/block/block_int.h b/include/block/block_int.h
> > index 3aa1e832a8..624da0b4a2 100644
> > --- a/include/block/block_int.h
> > +++ b/include/block/block_int.h
> > @@ -762,7 +762,15 @@ struct BlockDriverState {
> >      bool sg;        /* if true, the device is a /dev/sg* */
> >      bool probed;    /* if true, format was probed rather than specified */
> >      bool force_share; /* if true, always allow all shared permissions */
> > -    bool implicit;  /* if true, this filter node was automatically inserted */
> > +
> > +    /*
> > +     * @implicit field is deprecated, don't set it to true for new filters.
> > +     * If true, this filter node was automatically inserted and user don't
> > +     * know about it and unprepared for any effects of it. So, implicit
> > +     * filters are workarounded and skipped in many places of the block
> > +     * layer code.
> > +     */
> > +    bool implicit;
> >  
> >      BlockDriver *drv; /* NULL means no media */
> >      void *opaque;
> > diff --git a/blockdev.c b/blockdev.c
> > index 36e9368e01..b3cfaccce1 100644
> > --- a/blockdev.c
> > +++ b/blockdev.c
> > @@ -3292,6 +3292,11 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
> >      BlockdevOnError on_error = BLOCKDEV_ON_ERROR_REPORT;
> >      int job_flags = JOB_DEFAULT;
> >  
> > +    if (!has_filter_node_name) {
> > +        warn_report("Omitting filter-node-name parameter is deprecated, it "
> > +                    "will be required in future");
> > +    }
> > +
> >      if (!has_speed) {
> >          speed = 0;
> >      }
> > @@ -3990,6 +3995,11 @@ void qmp_blockdev_mirror(bool has_job_id, const char *job_id,
> >      Error *local_err = NULL;
> >      int ret;
> >  
> > +    if (!has_filter_node_name) {
> > +        warn_report("Omitting filter-node-name parameter is deprecated, it "
> > +                    "will be required in future");
> > +    }
> > +
> >      bs = qmp_get_root_bs(device, errp);
> >      if (!bs) {
> >          return;
> > 
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
> 
> Part of my motivation is to facilitate a more aggressive deprecation of
> legacy features by ensuring that we are able to rigorously notify users
> through any means that they need to adjust their scripts.

Who would read this, though? In the best case it ends up deep in a
libvirt log that nobody will look at because there was no error. In the
more common case, the debug level is configured so that QMP traffic
isn't even logged.

Kevin

