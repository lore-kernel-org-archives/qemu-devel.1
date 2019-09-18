Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12550C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857F3207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857F3207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAeAA-0004nu-Ge
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iAdTo-0007ZE-JS
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 13:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iAdTl-00079O-Sd
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 13:11:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52246)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iAdTZ-00074X-Qr; Wed, 18 Sep 2019 13:10:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 57652316D791;
 Wed, 18 Sep 2019 17:10:44 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CADD5D6B2;
 Wed, 18 Sep 2019 17:10:20 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
Date: Wed, 18 Sep 2019 12:10:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918130244.24257-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 18 Sep 2019 17:10:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: fam@euphon.net, peter.maydell@linaro.org, mst@redhat.com,
 codyprime@gmail.com, mark.cave-ayland@ilande.co.uk, mdroth@linux.vnet.ibm.com,
 kraxel@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, david@redhat.com, armbru@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, marcandre.lureau@redhat.com, rth@twiddle.net,
 farman@linux.ibm.com, groug@kaod.org, dgilbert@redhat.com,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, stefanha@redhat.com,
 jsnow@redhat.com, david@gibson.dropbear.id.au, kwolf@redhat.com,
 berrange@redhat.com, cohuck@redhat.com, qemu-s390x@nongnu.org,
 sundeep.lkml@gmail.com, qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/19 8:02 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Here is a proposal (three of them, actually) of auto propagation for
> local_err, to not call error_propagate on every exit point, when we
> deal with local_err.
> 
> It also may help make Greg's series[1] about error_append_hint smaller.
> 
> See definitions and examples below.
> 
> I'm cc-ing to this RFC everyone from series[1] CC list, as if we like
> it, the idea will touch same code (and may be more).

It might have been nice to do a patch series of one proposal per patch,
rather than cramming three in one, if only to see...

> 
> [1]: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03449.html
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/qapi/error.h | 102 +++++++++++++++++++++++++++++++++++++++++++
>  block.c              |  63 ++++++++++++--------------
>  block/backup.c       |   8 +++-
>  block/gluster.c      |   7 +++
>  4 files changed, 144 insertions(+), 36 deletions(-)

...relative diffstat sizing differences between them.

Of course, adding the framework requires growth in error.h.  The real
question, then, is how many lines do we save elsewhere by getting rid of
boilerplate that is replaced by auto cleanup, and how many lines are
mechanically churned to change variable names.  And how much of that
churn can itself be automated with Coccinelle.

But I think the idea is worth pursuing!

> 
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 3f95141a01..083e061014 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -322,6 +322,108 @@ void error_set_internal(Error **errp,
>                          ErrorClass err_class, const char *fmt, ...)
>      GCC_FMT_ATTR(6, 7);
>  
> +typedef struct ErrorPropagator {
> +    Error **errp;
> +    Error *local_err;
> +} ErrorPropagator;
> +
> +static inline void error_propagator_cleanup(ErrorPropagator *prop)
> +{
> +    if (prop->local_err) {
> +        error_propagate(prop->errp, prop->local_err);
> +    }

Technically, you don't need the 'if' here, since error_propogate() works
just fine when prop->local_err is NULL.

> +}
> +
> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cleanup);
> +

Looks reasonable.

> +/*
> + * ErrorPropagationPair
> + *
> + * [Error *local_err, Error **errp]
> + *
> + * First element is local_err, second is original errp, which is propagation
> + * target. Yes, errp has a bit another type, so it should be converted.
> + *
> + * ErrorPropagationPair may be used as errp, which points to local_err,
> + * as it's type is compatible.

s/it's/its/  ("it's" is only appropriate if "it is" can be substituted)

> + */
> +typedef Error *ErrorPropagationPair[2];
> +
> +static inline void error_propagation_pair_cleanup(ErrorPropagationPair *arr)
> +{
> +    Error *local_err = (*arr)[0];
> +    Error **errp = (Error **)(*arr)[1];
> +
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +    }
> +}

I don't like the type-punning.

> +
> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagationPair,
> +                                 error_propagation_pair_cleanup);
> +
> +/*
> + * DEF_AUTO_ERRP
> + *
> + * Define auto_errp variable, which may be used instead of errp, and
> + * *auto_errp may be safely checked to be zero or not, and may be safely
> + * used for error_append_hint(). auto_errp is automatically propagated
> + * to errp at function exit.
> + */
> +#define DEF_AUTO_ERRP(auto_errp, errp) \
> +    g_auto(ErrorPropagationPair) (auto_errp) = {NULL, (Error *)(errp)}

Again, more type-punning.  Ends up declaring the equivalent of 'Error
*auto_errp[2]' which devolves to 'Error **auto_errp'.

So, using this macro requires me to pass in the name of my local
variable (which auto-propagates when it goes out of scope) and the errp
parameter.  Can we shortcut by declaring that the variable it propagates
to MUST be named 'errp' rather than having that as a parameter name
(doing so would force us to be consistent at using an Error **errp
parameter).

> +
> +
> +/*
> + * Another variant:
> + *   Pros:
> + *     - normal structure instead of cheating with array
> + *     - we can directly use errp, if it's not NULL and don't point to
> + *       error_abort or error_fatal
> + *   Cons:
> + *     - we need to define two variables instead of one
> + */
> +typedef struct ErrorPropagationStruct {
> +    Error *local_err;
> +    Error **errp;
> +} ErrorPropagationStruct;

No real difference from ErrorPropagator above.

> +
> +static inline void error_propagation_struct_cleanup(ErrorPropagationStruct *prop)
> +{
> +    if (prop->local_err) {
> +        error_propagate(prop->errp, prop->local_err);
> +    }

Another useless if.

> +}
> +
> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagationStruct,
> +                                 error_propagation_struct_cleanup);
> +
> +#define DEF_AUTO_ERRP_V2(auto_errp, errp) \
> +    g_auto(ErrorPropagationStruct) (__auto_errp_prop) = {.errp = (errp)}; \
> +    Error **auto_errp = \
> +        ((errp) == NULL || *(errp) == error_abort || *(errp) == error_fatal) ? \
> +        &__auto_errp_prop.local_err : \
> +        (errp);


Not written to take a trailing semicolon in the caller.

Less type-punning, and and tries to reuse errp where possible.

> +
> +/*
> + * Third variant:
> + *   Pros:
> + *     - simpler movement for functions which don't have local_err yet
> + *       the only thing to do is to call one macro at function start.
> + *       This extremely simplifies Greg's series
> + *   Cons:
> + *     - looks like errp shadowing.. Still seems safe.
> + *     - must be after all definitions of local variables and before any
> + *       code.

Why?  I see no reason why it can't be hoisted earlier than other
declarations, and the only reason to not sink it after earlier code that
doesn't touch errp would be our coding standards that frowns on
declaration after code.

> + *     - like v2, several statements in one open macro

Not a drawback in my mind.

> + */
> +#define MAKE_ERRP_SAFE(errp) \
> +g_auto(ErrorPropagationStruct) (__auto_errp_prop) = {.errp = (errp)}; \
> +if ((errp) == NULL || *(errp) == error_abort || *(errp) == error_fatal) { \
> +    (errp) = &__auto_errp_prop.local_err; \
> +}

Not written to take a trailing semicolon in the caller.

You could even set __auto_errp_prop unconditionally rather than trying
to reuse incoming errp (the difference being that error_propagate() gets
called more frequently).

This is actually quite cool.  And if you get rid of your insistence that
it must occur after other variable declarations, you could instead
easily automate that any function that has a parameter 'Error **errp'
then has a MAKE_ERRP_SAFE(errp); as the first line of its function body
(that becomes something that you could grep for, rather than having to
use the smarts of coccinelle).

Or if we want to enforce consistency on the parameter naming, even go with:

#define MAKE_ERRP_SAFE() \
g_auto(ErrorPropagationStruct) (__auto_errp_prop) = {.errp = errp}; \
errp = &__auto_errp_prop.local_err

> +
> +
>  /*
>   * Special error destination to abort on error.
>   * See error_setg() and error_propagate() for details.
> diff --git a/block.c b/block.c
> index 5944124845..5253663329 100644
> --- a/block.c
> +++ b/block.c

So the above was the proposed implementations (I'm leaning towards
option 3); the below is a demonstration of their use.

> @@ -1275,12 +1275,11 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
>                              const char *node_name, QDict *options,
>                              int open_flags, Error **errp)
>  {
> -    Error *local_err = NULL;
> +    DEF_AUTO_ERRP_V2(auto_errp, errp);

This is option 2. Basically, you replace any declaration of local_err to
instead use the magic macro...

>      int i, ret;
>  
> -    bdrv_assign_node_name(bs, node_name, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    bdrv_assign_node_name(bs, node_name, auto_errp);
> +    if (*auto_errp) {

then s/local_err/*auto_errp/ and delete resulting &* pairs and
error_propagate() calls in the rest of the function.  Coccinelle could
make this type of conversion easy.

>          return -EINVAL;
>      }
>  
> @@ -1290,20 +1289,21 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
>  
>      if (drv->bdrv_file_open) {
>          assert(!drv->bdrv_needs_filename || bs->filename[0]);
> -        ret = drv->bdrv_file_open(bs, options, open_flags, &local_err);
> +        ret = drv->bdrv_file_open(bs, options, open_flags, auto_errp);
>      } else if (drv->bdrv_open) {
> -        ret = drv->bdrv_open(bs, options, open_flags, &local_err);
> +        ret = drv->bdrv_open(bs, options, open_flags, auto_errp);
>      } else {
>          ret = 0;
>      }
>  
>      if (ret < 0) {
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -        } else if (bs->filename[0]) {
> -            error_setg_errno(errp, -ret, "Could not open '%s'", bs->filename);
> -        } else {
> -            error_setg_errno(errp, -ret, "Could not open image");
> +        if (!*auto_errp) {
> +            if (bs->filename[0]) {
> +                error_setg_errno(errp, -ret, "Could not open '%s'",
> +                                 bs->filename);

You reflowed the logic a bit here, but it is still worth pointing out
that you still call error_setg*(errp) as before (no changing to
auto_errp, although that would also have worked).

> +            } else {
> +                error_setg_errno(errp, -ret, "Could not open image");
> +            }
>          }
>          goto open_failed;
>      }
> @@ -1314,9 +1314,8 @@ static int bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv,
>          return ret;
>      }
>  
> -    bdrv_refresh_limits(bs, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    bdrv_refresh_limits(bs, auto_errp);
> +    if (*auto_errp) {
>          return -EINVAL;
>      }
>  
> @@ -4238,17 +4237,17 @@ out:
>  void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
>                   Error **errp)
>  {
> -    Error *local_err = NULL;
> +    g_auto(ErrorPropagator) prop = {.errp = errp};

This is option 1.  It's rather open-coded, rather than having a nice
wrapper macro.

>  
> -    bdrv_set_backing_hd(bs_new, bs_top, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    errp = &prop.local_err;

And by re-assigning errp manually,

> +
> +    bdrv_set_backing_hd(bs_new, bs_top, errp);
> +    if (*errp) {

you can now safely use it in the rest of the function without worrying
about NULL.

>          goto out;
>      }
>  
> -    bdrv_replace_node(bs_top, bs_new, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    bdrv_replace_node(bs_top, bs_new, errp);
> +    if (*errp) {
>          bdrv_set_backing_hd(bs_new, NULL, &error_abort);
>          goto out;

Not too bad (we'd probably want a coccinelle script to prove that you
don't dereference *errp without first using the magic reassignment).

>      }
> @@ -5309,9 +5308,9 @@ void bdrv_init_with_whitelist(void)
>  static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
>                                                    Error **errp)
>  {
> +    DEF_AUTO_ERRP(auto_errp, errp);

Option 1 again, but this time with a macro.

>      BdrvChild *child, *parent;
>      uint64_t perm, shared_perm;
> -    Error *local_err = NULL;
>      int ret;
>      BdrvDirtyBitmap *bm;
>  
> @@ -5324,9 +5323,8 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
>      }
>  
>      QLIST_FOREACH(child, &bs->children, next) {
> -        bdrv_co_invalidate_cache(child->bs, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> +        bdrv_co_invalidate_cache(child->bs, auto_errp);
> +        if (*auto_errp) {
>              return;
>          }
>      }
> @@ -5346,19 +5344,17 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
>       */
>      bs->open_flags &= ~BDRV_O_INACTIVE;
>      bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
> -    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, &local_err);
> +    ret = bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, auto_errp);
>      if (ret < 0) {
>          bs->open_flags |= BDRV_O_INACTIVE;
> -        error_propagate(errp, local_err);
>          return;
>      }
>      bdrv_set_perm(bs, perm, shared_perm);
>  
>      if (bs->drv->bdrv_co_invalidate_cache) {
> -        bs->drv->bdrv_co_invalidate_cache(bs, &local_err);
> -        if (local_err) {
> +        bs->drv->bdrv_co_invalidate_cache(bs, auto_errp);
> +        if (*auto_errp) {
>              bs->open_flags |= BDRV_O_INACTIVE;
> -            error_propagate(errp, local_err);
>              return;
>          }
>      }
> @@ -5378,10 +5374,9 @@ static void coroutine_fn bdrv_co_invalidate_cache(BlockDriverState *bs,
>  
>      QLIST_FOREACH(parent, &bs->parents, next_parent) {
>          if (parent->role->activate) {
> -            parent->role->activate(parent, &local_err);
> -            if (local_err) {
> +            parent->role->activate(parent, auto_errp);
> +            if (*auto_errp) {
>                  bs->open_flags |= BDRV_O_INACTIVE;
> -                error_propagate(errp, local_err);
>                  return;
>              }
>          }
> diff --git a/block/backup.c b/block/backup.c
> index 89f7f89200..462dea4fbb 100644
> --- a/block/backup.c
> +++ b/block/backup.c
> @@ -583,6 +583,10 @@ static const BlockJobDriver backup_job_driver = {
>  static int64_t backup_calculate_cluster_size(BlockDriverState *target,
>                                               Error **errp)
>  {
> +    /*
> +     * Example of using DEF_AUTO_ERRP to make error_append_hint safe
> +     */
> +    DEF_AUTO_ERRP(auto_errp, errp);

Option 1 again.  Requires renaming errp to auto_errp in the rest of the
function.

>      int ret;
>      BlockDriverInfo bdi;
>  
> @@ -602,10 +606,10 @@ static int64_t backup_calculate_cluster_size(BlockDriverState *target,
>                      BACKUP_CLUSTER_SIZE_DEFAULT);
>          return BACKUP_CLUSTER_SIZE_DEFAULT;
>      } else if (ret < 0 && !target->backing) {
> -        error_setg_errno(errp, -ret,
> +        error_setg_errno(auto_errp, -ret,
>              "Couldn't determine the cluster size of the target image, "
>              "which has no backing file");
> -        error_append_hint(errp,
> +        error_append_hint(auto_errp,
>              "Aborting, since this may create an unusable destination image\n");
>          return ret;
>      } else if (ret < 0 && target->backing) {
> diff --git a/block/gluster.c b/block/gluster.c
> index 64028b2cba..799a2dbeca 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -695,6 +695,13 @@ static int qemu_gluster_parse(BlockdevOptionsGluster *gconf,
>                                QDict *options, Error **errp)
>  {
>      int ret;
> +    /*
> +     * Example of using MAKE_ERRP_SAFE to make error_append_hint safe. We
> +     * only need to add one macro call.

Option 3.  By far my favorite, whether or not we decide to take a macro
parameter for the variable name to protect, or hard-code for consistency
that 'errp' must be in scope when it is used.

> Note, it must be placed exactly after
> +     * all local variables defenition.

definition

Why do you think this limitation is necessary?  Do you have an actual
code sequence that misbehaves if the compiler-unwind cleanup is
performed in a different order when the macro is used before other
variable declarations?

> +     */
> +    MAKE_ERRP_SAFE(errp);
> +
>      if (filename) {
>          ret = qemu_gluster_parse_uri(gconf, filename);
>          if (ret < 0) {
> 

This is sweet - you can safely use '*errp' in the rest of the function,
without having to remember a second error name - while the caller can
still pass NULL or error_abort as desired.

And I still think we can probably get Coccinelle to help make the
conversions, both of using this macro in any function that has an Error
**errp parameter, as well as getting rid of local_err declarations and
error_propagate() calls rendered redundant once this macro is used.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

