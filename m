Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1810FC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE96A2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE96A2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAUsd-0006ll-PM
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 04:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iAUrl-0005zR-Dn
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 03:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iAUrj-0004gt-HG
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 03:59:09 -0400
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:56843)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iAUrj-0004g5-6Q
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 03:59:07 -0400
Received: from player697.ha.ovh.net (unknown [10.108.54.172])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 28DA71E0D8B
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 09:59:04 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id 987F59F3DAB3;
 Wed, 18 Sep 2019 07:58:29 +0000 (UTC)
Date: Wed, 18 Sep 2019 09:58:27 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190918095827.39b410f8@bahia.lan>
In-Reply-To: <09d047e3-7bc2-892d-31dc-9f9201b99862@virtuozzo.com>
References: <156871562997.196432.17776290406203122029.stgit@bahia.lan>
 <156871564329.196432.5930574495661947805.stgit@bahia.lan>
 <5dba090e-8a59-6f42-a93a-eb676422211e@virtuozzo.com>
 <20190917173756.5ff0e571@bahia.lan>
 <09d047e3-7bc2-892d-31dc-9f9201b99862@virtuozzo.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 16413368844630071635
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudejgdduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.124.17
Subject: Re: [Qemu-devel] [PATCH 02/17] block: Pass local error object
 pointer to error_append_hint()
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eric Farman <farman@linux.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Yuval Shaia <yuval.shaia@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019 17:40:11 +0000
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> 17.09.2019 18:37, Greg Kurz wrote:
> > On Tue, 17 Sep 2019 13:25:03 +0000
> > Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> > 
> >> 17.09.2019 13:20, Greg Kurz wrote:
> >>> Ensure that hints are added even if errp is &error_fatal or &error_abort.
> >>>
> >>> Signed-off-by: Greg Kurz <groug@kaod.org>
> >>> ---
> >>>    block/backup.c       |    7 +++++--
> >>>    block/dirty-bitmap.c |    7 +++++--
> >>>    block/file-posix.c   |   20 +++++++++++++-------
> >>>    block/gluster.c      |   23 +++++++++++++++--------
> >>>    block/qcow.c         |   10 ++++++----
> >>>    block/qcow2.c        |    7 +++++--
> >>>    block/vhdx-log.c     |    7 +++++--
> >>>    block/vpc.c          |    7 +++++--
> >>>    8 files changed, 59 insertions(+), 29 deletions(-)
> >>>
> >>> diff --git a/block/backup.c b/block/backup.c
> >>> index 763f0d7ff6db..d8c422a0e3bc 100644
> >>> --- a/block/backup.c
> >>> +++ b/block/backup.c
> >>> @@ -602,11 +602,14 @@ static int64_t backup_calculate_cluster_size(BlockDriverState *target,
> >>>                        BACKUP_CLUSTER_SIZE_DEFAULT);
> >>>            return BACKUP_CLUSTER_SIZE_DEFAULT;
> >>>        } else if (ret < 0 && !target->backing) {
> >>> -        error_setg_errno(errp, -ret,
> >>> +        Error *local_err = NULL;
> >>> +
> >>> +        error_setg_errno(&local_err, -ret,
> >>>                "Couldn't determine the cluster size of the target image, "
> >>>                "which has no backing file");
> >>> -        error_append_hint(errp,
> >>> +        error_append_hint(&local_err,
> >>>                "Aborting, since this may create an unusable destination image\n");
> >>> +        error_propagate(errp, local_err);
> >>>            return ret;
> >>>        } else if (ret < 0 && target->backing) {
> >>>            /* Not fatal; just trudge on ahead. */
> >>
> >>
> >> Pain.. Do we need these hints, if they are so painful?
> >>
> > 
> > I agree that the one above doesn't qualify as a useful hint.
> > It just tells that QEMU is giving up and gives no indication
> > to the user on how to avoid the issue. It should probably be
> > dropped.
> > 
> >> At least for cases like this, we can create helper function
> >>
> >> error_setg_errno_hint(..., error, hint)
> > 
> > Not very useful if hint has to be forged separately with
> > g_sprintf(), and we can't have such a thing as:
> > 
> > error_setg_errno_hint(errp, err_fmt, ..., hint_fmt, ...)
> > 
> >>
> >> But what could be done when we call function, which may or may not set errp?
> >>
> >> ret = f(errp);
> >> if (ret) {
> >>      error_append_hint(errp, hint);
> >> }
> >>
> > 
> > Same problem. If errp is &error_fatal and f() does errno_setg(errp), it
> > ends up calling exit().
> > 
> >> Hmmm..
> >>
> >> Can it look like
> >>
> >> ret = f(..., hint_helper(errp, hint))
> >>
> >> ?
> >>
> > 
> > Nope, hint_helper() will get called before f() and things are worse.
> > If errp is NULL then error_append_hint() does nothing and if it is
> > &error_fatal then it aborts.
> > 
> >> I can't imagine how to do it, as someone should remove hint from error_abort object on
> >> success path..
> >>
> >> But seems, the following is possible, which seems better for me than local-error approach:
> >>
> >> error_push_hint(errp, hint);
> >> ret = f(.., errp);
> >> error_pop_hint(errp);
> >>
> > 
> > Matter of taste... also, it looks awkward to come up with a hint
> > before knowing what happened. I mean the appropriate hint could
> > depend on the value returned by f() and/or errno for example.
> > 
> >> ===
> >>
> >> Continue thinking on this:
> >>
> >> It may look like just
> >> ret = f(..., set_hint(errp, hint));
> >>
> >> or (just to split long line):
> >> set_hint(errp, hint);
> >> ret = f(..., errp);
> >>
> >> if in each function with errp does error_push_hint(errp) on start and error_pop_hint(errp) on exit,
> >> which may be just one call at function start of macro, which will call error_push_hint(errp) and
> >> define local variable by g_auto, with cleanup which will call error_pop_hint(errp) on function
> >> exit..
> >>
> >> Or, may be, more direct way to set cleanup for function exists?
> >>
> >> ===
> >>
> >> Also, we can implement some code generation, to generate for functions with errp argument
> >> wrappers with additional hint parameter, and just use these wrappers..
> >>
> >> ===
> >>
> >> If nobody likes any of my suggestions, then ignore them. I understand that this series fixes
> >> real issue and much effort has already been spent. May be one day I'll try to rewrite it...
> >>
> > 
> > For the reason exposed above, I don't think it makes sense to
> > build the hint before calling a function that calls error_setg().
> > I'm afraid we're stuck with local_err... it is then up to the
> > people to make it as less painful as possible.
> > 
> 
> Hmm. so, seems that in general we need local_err..
> 
> Then may be, may can make automated propagation?
> 
> It will look like
> 
> g_auto(ErrorPropagation) _error_prop = (ErrorPropagation){
>    .errp = errp,
>    .local_err = NULL,
> }
> 
> errp = &_error_prop.local_err;
> 
> and this thing may be fully covered into macro,
> to look like this at function start (to be honest it should exactly after all
> local variable definitions):
> 
> MAKE_ERRP_SAFE(_error_prop, errp);
> 
> 

Maybe you can send an RFC patch that converts a handful of
local_err users to g_auto() ?

