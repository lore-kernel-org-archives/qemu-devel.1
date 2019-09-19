Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5250CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171C221924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171C221924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtPU-0001Xx-Bk
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iAtNF-0007hz-UP
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iAtND-0000bE-BX
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:09:17 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:34371)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iAtNC-0000a8-T8
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:09:15 -0400
Received: from player759.ha.ovh.net (unknown [10.108.42.145])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 811351094B0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 12:09:12 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id 1B21AA062F2E;
 Thu, 19 Sep 2019 10:08:36 +0000 (UTC)
Date: Thu, 19 Sep 2019 12:08:34 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190919120834.0ef0470b@bahia.lan>
In-Reply-To: <4234506a-171e-bff4-3edb-8c50ed9ec722@virtuozzo.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <20190919105909.4d3456f6@bahia.lan>
 <4234506a-171e-bff4-3edb-8c50ed9ec722@virtuozzo.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6036793827346651475
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.109.80
Subject: Re: [Qemu-devel] [RFC] error: auto propagated local_err
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "codyprime@gmail.com" <codyprime@gmail.com>,
 "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 "sundeep.lkml@gmail.com" <sundeep.lkml@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 09:28:11 +0000
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> 19.09.2019 11:59, Greg Kurz wrote:
> > On Wed, 18 Sep 2019 16:02:44 +0300
> > Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> > 
> >> Hi all!
> >>
> >> Here is a proposal (three of them, actually) of auto propagation for
> >> local_err, to not call error_propagate on every exit point, when we
> >> deal with local_err.
> >>
> >> It also may help make Greg's series[1] about error_append_hint smaller.
> >>
> > 
> > This will depend on whether we reach a consensus soon enough (soft
> > freeze for 4.2 is 2019-10-29). Otherwise, I think my series should
> > be merged as is, and auto-propagation to be delayed to 4.3.
> > 
> >> See definitions and examples below.
> >>
> >> I'm cc-ing to this RFC everyone from series[1] CC list, as if we like
> >> it, the idea will touch same code (and may be more).
> >>
> > 
> > When we have a good auto-propagation mechanism available, I guess
> > this can be beneficial for most of the code, not only the places
> > where we add hints (or prepend something, see below).
> > 
> >> [1]: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03449.html
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >>   include/qapi/error.h | 102 +++++++++++++++++++++++++++++++++++++++++++
> >>   block.c              |  63 ++++++++++++--------------
> >>   block/backup.c       |   8 +++-
> >>   block/gluster.c      |   7 +++
> >>   4 files changed, 144 insertions(+), 36 deletions(-)
> >>
> >> diff --git a/include/qapi/error.h b/include/qapi/error.h
> >> index 3f95141a01..083e061014 100644
> >> --- a/include/qapi/error.h
> >> +++ b/include/qapi/error.h
> >> @@ -322,6 +322,108 @@ void error_set_internal(Error **errp,
> >>                           ErrorClass err_class, const char *fmt, ...)
> >>       GCC_FMT_ATTR(6, 7);
> >>   
> >> +typedef struct ErrorPropagator {
> >> +    Error **errp;
> >> +    Error *local_err;
> >> +} ErrorPropagator;
> >> +
> >> +static inline void error_propagator_cleanup(ErrorPropagator *prop)
> >> +{
> >> +    if (prop->local_err) {
> >> +        error_propagate(prop->errp, prop->local_err);
> > 
> > We also have error_propagate_prepend(), which is basically a variant of
> > error_prepend()+error_propagate() that can cope with &error_fatal. This
> > was introduced by Markus in commit 4b5766488fd3, for similar reasons that
> > motivated my series. It has ~30 users in the tree.
> > 
> > There's no such thing a generic cleanup function with a printf-like
> > interface, so all of these should be converted back to error_prepend()
> > if we go for auto-propagation.
> > 
> > Aside from propagation, one can sometime choose to call things like
> > error_free() or error_free_or_abort()... Auto-propagation should
> > detect that and not call error_propagate() in this case.
> 
> Hmm, for example, qmp_eject, which error_free or error_propagate..
> We can leave such cases as is, not many of them. Or introduce
> safe_errp_free(Error **errp), which will zero pointer after freeing.
> 

Maybe even turning error_free() to take an Error ** ? It looks
safe to zero out a dangling pointer. Of course the API change
would need to be propagated to all error_* functions that
explicitly call error_free().

> > 
> >> +    }
> >> +}
> >> +
> >> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cleanup);
> >> +
> >> +/*
> >> + * ErrorPropagationPair
> >> + *
> >> + * [Error *local_err, Error **errp]
> >> + *
> >> + * First element is local_err, second is original errp, which is propagation
> >> + * target. Yes, errp has a bit another type, so it should be converted.
> >> + *
> >> + * ErrorPropagationPair may be used as errp, which points to local_err,
> >> + * as it's type is compatible.
> >> + */
> >> +typedef Error *ErrorPropagationPair[2];
> >> +
> >> +static inline void error_propagation_pair_cleanup(ErrorPropagationPair *arr)
> >> +{
> >> +    Error *local_err = (*arr)[0];
> >> +    Error **errp = (Error **)(*arr)[1];
> >> +
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +    }
> >> +}
> >> +
> >> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagationPair,
> >> +                                 error_propagation_pair_cleanup);
> >> +
> >> +/*
> >> + * DEF_AUTO_ERRP
> >> + *
> >> + * Define auto_errp variable, which may be used instead of errp, and
> >> + * *auto_errp may be safely checked to be zero or not, and may be safely
> >> + * used for error_append_hint(). auto_errp is automatically propagated
> >> + * to errp at function exit.
> >> + */
> >> +#define DEF_AUTO_ERRP(auto_errp, errp) \
> >> +    g_auto(ErrorPropagationPair) (auto_errp) = {NULL, (Error *)(errp)}
> >> +
> >> +
> >> +/*
> >> + * Another variant:
> >> + *   Pros:
> >> + *     - normal structure instead of cheating with array
> >> + *     - we can directly use errp, if it's not NULL and don't point to
> >> + *       error_abort or error_fatal
> >> + *   Cons:
> >> + *     - we need to define two variables instead of one
> >> + */
> >> +typedef struct ErrorPropagationStruct {
> >> +    Error *local_err;
> >> +    Error **errp;
> >> +} ErrorPropagationStruct;
> >> +
> >> +static inline void error_propagation_struct_cleanup(ErrorPropagationStruct *prop)
> >> +{
> >> +    if (prop->local_err) {
> >> +        error_propagate(prop->errp, prop->local_err);
> >> +    }
> >> +}
> >> +
> >> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagationStruct,
> >> +                                 error_propagation_struct_cleanup);
> >> +
> >> +#define DEF_AUTO_ERRP_V2(auto_errp, errp) \
> >> +    g_auto(ErrorPropagationStruct) (__auto_errp_prop) = {.errp = (errp)}; \
> >> +    Error **auto_errp = \
> >> +        ((errp) == NULL || *(errp) == error_abort || *(errp) == error_fatal) ? \
> >> +        &__auto_errp_prop.local_err : \
> >> +        (errp);
> >> +
> >> +/*
> >> + * Third variant:
> >> + *   Pros:
> >> + *     - simpler movement for functions which don't have local_err yet
> >> + *       the only thing to do is to call one macro at function start.
> >> + *       This extremely simplifies Greg's series
> >> + *   Cons:
> >> + *     - looks like errp shadowing.. Still seems safe.
> >> + *     - must be after all definitions of local variables and before any
> >> + *       code.
> >> + *     - like v2, several statements in one open macro
> >> + */
> >> +#define MAKE_ERRP_SAFE(errp) \
> >> +g_auto(ErrorPropagationStruct) (__auto_errp_prop) = {.errp = (errp)}; \
> >> +if ((errp) == NULL || *(errp) == error_abort || *(errp) == error_fatal) { \
> >> +    (errp) = &__auto_errp_prop.local_err; \
> >> +}
> >> +
> >> +
> >>   /*
> >>    * Special error destination to abort on error.
> >>    * See error_setg() and error_propagate() for details.
> >> diff --git a/block.c b/block.c
> >> index 5944124845..5253663329 100644
> >> --- a/block.c
> >> +++ b/block.c
> >> @@ -1275,12 +1275,11 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
> >>                               const char *node_name, QDict *options,
> >>                               int open_flags, Error **errp)
> >>   {
> >> -    Error *local_err = NULL;
> >> +    DEF_AUTO_ERRP_V2(auto_errp, errp);
> >>       int i, ret;
> >>   
> >> -    bdrv_assign_node_name(bs, node_name, &local_err);
> >> -    if (local_err) {
> >> -        error_propagate(errp, local_err);
> >> +    bdrv_assign_node_name(bs, node_name, auto_errp);
> >> +    if (*auto_errp) {
> >>           return -EINVAL;
> >>       }
> >>   
> >> @@ -1290,20 +1289,21 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
> >>   
> >>       if (drv->bdrv_file_open) {
> >>           assert(!drv->bdrv_needs_filename || bs->filename[0]);
> >> -        ret = drv->bdrv_file_open(bs, options, open_flags, &local_err);
> >> +        ret = drv->bdrv_file_open(bs, options, open_flags, auto_errp);
> >>       } else if (drv->bdrv_open) {
> >> -        ret = drv->bdrv_open(bs, options, open_flags, &local_err);
> >> +        ret = drv->bdrv_open(bs, options, open_flags, auto_errp);
> >>       } else {
> >>           ret = 0;
> >>       }
> >>   
> >>       if (ret < 0) {
> >> -        if (local_err) {
> >> -            error_propagate(errp, local_err);
> >> -        } else if (bs->filename[0]) {
> >> -            error_setg_errno(errp, -ret, "Could not open '%s'", bs->filename);
> >> -        } else {
> >> -            error_setg_errno(errp, -ret, "Could not open image");
> >> +        if (!*auto_errp) {
> >> +            if (bs->filename[0]) {
> >> +                error_setg_errno(errp, -ret, "Could not open '%s'",
> >> +                                 bs->filename);
> >> +            } else {
> >> +                error_setg_errno(errp, -ret, "Could not open image");
> >> +            }
> >>           }
> >>           goto open_failed;
> >>       }
> >> @@ -1314,9 +1314,8 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
> >>           return ret;
> >>       }
> >>   
> >> -    bdrv_refresh_limits(bs, &local_err);
> >> -    if (local_err) {
> >> -        error_propagate(errp, local_err);
> >> +    bdrv_refresh_limits(bs, auto_errp);
> >> +    if (*auto_errp) {
> >>           return -EINVAL;
> >>       }
> >>   
> >> @@ -4238,17 +4237,17 @@ out:
> >>   void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
> >>                    Error **errp)
> >>   {
> >> -    Error *local_err = NULL;
> >> +    g_auto(ErrorPropagator) prop = {.errp = errp};
> >>   
> >> -    bdrv_set_backing_hd(bs_new, bs_top, &local_err);
> >> -    if (local_err) {
> >> -        error_propagate(errp, local_err);
> >> +    errp = &prop.local_err;
> >> +
> >> +    bdrv_set_backing_hd(bs_new, bs_top, errp);
> >> +    if (*errp) {
> >>           goto out;
> >>       }
> >>   
> >> -    bdrv_replace_node(bs_top, bs_new, &local_err);
> >> -    if (local_err) {
> >> -        error_propagate(errp, local_err);
> >> +    bdrv_replace_node(bs_top, bs_new, errp);
> >> +    if (*errp) {
> >>           bdrv_set_backing_hd(bs_new, NULL, &error_abort);
> >>           goto out;
> >>       }
> >> @@ -5309,9 +5308,9 @@ void bdrv_init_with_whitelist(void)
> >>   static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
> >>                                                     Error **errp)
> >>   {
> >> +    DEF_AUTO_ERRP(auto_errp, errp);
> >>       BdrvChild *child, *parent;
> >>       uint64_t perm, shared_perm;
> >> -    Error *local_err = NULL;
> >>       int ret;
> >>       BdrvDirtyBitmap *bm;
> >>   
> >> @@ -5324,9 +5323,8 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
> >>       }
> >>   
> >>       QLIST_FOREACH(child, &bs->children, next) {
> >> -        bdrv_co_invalidate_cache(child->bs, &local_err);
> >> -        if (local_err) {
> >> -            error_propagate(errp, local_err);
> >> +        bdrv_co_invalidate_cache(child->bs, auto_errp);
> >> +        if (*auto_errp) {
> >>               return;
> >>           }
> >>       }
> >> @@ -5346,19 +5344,17 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
> >>        */
> >>       bs->open_flags &= ~BDRV_O_INACTIVE;
> >>       bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
> >> -    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, &local_err);
> >> +    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, auto_errp);
> >>       if (ret < 0) {
> >>           bs->open_flags |= BDRV_O_INACTIVE;
> >> -        error_propagate(errp, local_err);
> >>           return;
> >>       }
> >>       bdrv_set_perm(bs, perm, shared_perm);
> >>   
> >>       if (bs->drv->bdrv_co_invalidate_cache) {
> >> -        bs->drv->bdrv_co_invalidate_cache(bs, &local_err);
> >> -        if (local_err) {
> >> +        bs->drv->bdrv_co_invalidate_cache(bs, auto_errp);
> >> +        if (*auto_errp) {
> >>               bs->open_flags |= BDRV_O_INACTIVE;
> >> -            error_propagate(errp, local_err);
> >>               return;
> >>           }
> >>       }
> >> @@ -5378,10 +5374,9 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
> >>   
> >>       QLIST_FOREACH(parent, &bs->parents, next_parent) {
> >>           if (parent->role->activate) {
> >> -            parent->role->activate(parent, &local_err);
> >> -            if (local_err) {
> >> +            parent->role->activate(parent, auto_errp);
> >> +            if (*auto_errp) {
> >>                   bs->open_flags |= BDRV_O_INACTIVE;
> >> -                error_propagate(errp, local_err);
> >>                   return;
> >>               }
> >>           }
> >> diff --git a/block/backup.c b/block/backup.c
> >> index 89f7f89200..462dea4fbb 100644
> >> --- a/block/backup.c
> >> +++ b/block/backup.c
> >> @@ -583,6 +583,10 @@ static const BlockJobDriver backup_job_driver = {
> >>   static int64_t backup_calculate_cluster_size(BlockDriverState *target,
> >>                                                Error **errp)
> >>   {
> >> +    /*
> >> +     * Example of using DEF_AUTO_ERRP to make error_append_hint safe
> >> +     */
> >> +    DEF_AUTO_ERRP(auto_errp, errp);
> >>       int ret;
> >>       BlockDriverInfo bdi;
> >>   
> >> @@ -602,10 +606,10 @@ static int64_t backup_calculate_cluster_size(BlockDriverState *target,
> >>                       BACKUP_CLUSTER_SIZE_DEFAULT);
> >>           return BACKUP_CLUSTER_SIZE_DEFAULT;
> >>       } else if (ret < 0 && !target->backing) {
> >> -        error_setg_errno(errp, -ret,
> >> +        error_setg_errno(auto_errp, -ret,
> >>               "Couldn't determine the cluster size of the target image, "
> >>               "which has no backing file");
> >> -        error_append_hint(errp,
> >> +        error_append_hint(auto_errp,
> >>               "Aborting, since this may create an unusable destination image\n");
> >>           return ret;
> >>       } else if (ret < 0 && target->backing) {
> >> diff --git a/block/gluster.c b/block/gluster.c
> >> index 64028b2cba..799a2dbeca 100644
> >> --- a/block/gluster.c
> >> +++ b/block/gluster.c
> >> @@ -695,6 +695,13 @@ static int qemu_gluster_parse(BlockdevOptionsGluster *gconf,
> >>                                 QDict *options, Error **errp)
> >>   {
> >>       int ret;
> >> +    /*
> >> +     * Example of using MAKE_ERRP_SAFE to make error_append_hint safe. We
> >> +     * only need to add one macro call. Note, it must be placed exactly after
> >> +     * all local variables defenition.
> >> +     */
> >> +    MAKE_ERRP_SAFE(errp);
> >> +
> >>       if (filename) {
> >>           ret = qemu_gluster_parse_uri(gconf, filename);
> >>           if (ret < 0) {
> > 
> 
> 


