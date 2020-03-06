Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4239C10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:30:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD8E2073D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD8E2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAFG-00051T-Fa
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 05:30:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jAAEL-0004Ww-Qn
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jAAEJ-00038v-Mm
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:29:21 -0500
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:42324)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jAAEJ-00033E-Gk
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:29:19 -0500
Received: from player738.ha.ovh.net (unknown [10.108.35.119])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 86E3E24640B
 for <qemu-devel@nongnu.org>; Fri,  6 Mar 2020 11:29:17 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 4B46D103D5B09;
 Fri,  6 Mar 2020 10:28:58 +0000 (UTC)
Date: Fri, 6 Mar 2020 11:28:56 +0100
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v8 01/10] error: auto propagated local_err
Message-ID: <20200306112856.2ec79faf@bahia.home>
In-Reply-To: <20200306051536.27803-2-vsementsov@virtuozzo.com>
References: <20200306051536.27803-1-vsementsov@virtuozzo.com>
 <20200306051536.27803-2-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 2737344149911279955
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudduvddgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.178.58
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, armbru@redhat.com,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  6 Mar 2020 08:15:27 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> Here is introduced ERRP_AUTO_PROPAGATE macro, to be used at start of
> functions with an errp OUT parameter.
>=20
> It has three goals:
>=20
> 1. Fix issue with error_fatal and error_prepend/error_append_hint: user
> can't see this additional information, because exit() happens in
> error_setg earlier than information is added. [Reported by Greg Kurz]
>=20
> 2. Fix issue with error_abort and error_propagate: when we wrap
> error_abort by local_err+error_propagate, the resulting coredump will
> refer to error_propagate and not to the place where error happened.
> (the macro itself doesn't fix the issue, but it allows us to [3.] drop
> the local_err+error_propagate pattern, which will definitely fix the
> issue) [Reported by Kevin Wolf]
>=20
> 3. Drop local_err+error_propagate pattern, which is used to workaround
> void functions with errp parameter, when caller wants to know resulting
> status. (Note: actually these functions could be merely updated to
> return int error code).
>=20
> To achieve these goals, later patches will add invocations
> of this macro at the start of functions with either use
> error_prepend/error_append_hint (solving 1) or which use
> local_err+error_propagate to check errors, switching those
> functions to use *errp instead (solving 2 and 3).
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20

Thanks for this impressive work Vladimir !

Reviewed-by: Greg Kurz <groug@kaod.org>

> Cc: Eric Blake <eblake@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: Paul Durrant <paul@xen.org>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> Cc: qemu-block@nongnu.org
> Cc: qemu-devel@nongnu.org
> Cc: xen-devel@lists.xenproject.org
>=20
>  include/qapi/error.h | 203 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 170 insertions(+), 33 deletions(-)
>=20
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index ad5b6e896d..bb9bcf02fb 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -15,6 +15,8 @@
>  /*
>   * Error reporting system loosely patterned after Glib's GError.
>   *
> + * =3D Deal with Error object =3D
> + *
>   * Create an error:
>   *     error_setg(&err, "situation normal, all fouled up");
>   *
> @@ -47,28 +49,88 @@
>   * reporting it (primarily useful in testsuites):
>   *     error_free_or_abort(&err);
>   *
> - * Pass an existing error to the caller:
> - *     error_propagate(errp, err);
> - * where Error **errp is a parameter, by convention the last one.
> + * =3D Deal with Error ** function parameter =3D
>   *
> - * Pass an existing error to the caller with the message modified:
> - *     error_propagate_prepend(errp, err);
> + * Function may use error system to return errors. In this case function
> + * defines Error **errp parameter, which should be the last one (except =
for
> + * functions which varidic argument list), which has the following API:
>   *
> - * Avoid
> - *     error_propagate(errp, err);
> - *     error_prepend(errp, "Could not frobnicate '%s': ", name);
> - * because this fails to prepend when @errp is &error_fatal.
> + * Caller may pass as errp:
> + * 1. &error_abort
> + *    This means abort on any error
> + * 2. &error_fatal
> + *    Exit with non-zero return code on error
> + * 3. NULL
> + *    Ignore errors
> + * 4. Another value
> + *    On error allocate error object and set errp
>   *
> - * Create a new error and pass it to the caller:
> - *     error_setg(errp, "situation normal, all fouled up");
> + * Error API functions with Error ** (like error_setg) argument supports=
 these
> + * rules, so user functions just need to use them appropriately (read be=
low).
>   *
> - * Call a function and receive an error from it:
> + * Simple pass error to the caller:
> + *     error_setg(errp, "Some error");
> + *
> + * Subcall of another errp-based function, passing the error to the call=
er
> + *     f(..., errp);
> + *
> + * =3D=3D Checking success of subcall =3D=3D
> + *
> + * If function returns error code in addition to errp (which is recommen=
ded),
> + * you don't need any additional code, just do:
> + *     int ret =3D f(..., errp);
> + *     if (ret < 0) {
> + *         ... handle error ...
> + *         return ret;
> + *     }
> + *
> + * If function returns nothing (which is not recommended API) and the on=
ly way
> + * to check success is checking errp, we must care about cases [1-3] abo=
ve. We
> + * need to use macro ERRP_AUTO_PROPAGATE (see below for details) like th=
is:
> + *
> + *     int our_func(..., Error **errp) {
> + *         ERRP_AUTO_PROPAGATE();
> + *         ...
> + *         subcall(..., errp);
> + *         if (*errp) {
> + *             ...
> + *             return -ERRNO;
> + *         }
> + *         ...
> + *     }
> + *
> + * ERRP_AUTO_PROPAGATE cares about Error ** API, wraps original errp if =
needed,
> + * so that it can be safely used (including dereferencing), and auto-pro=
pagates
> + * error to original errp on function end.
> + *
> + * In some cases, we need to check result of subcall, but do not want to
> + * propagate the Error object to our caller. In such cases we don't need
> + * ERRP_AUTO_PROPAGATE, but just a local Error object:
> + *
> + * Receive an error and not pass it:
>   *     Error *err =3D NULL;
> - *     foo(arg, &err);
> + *     subcall(arg, &err);
>   *     if (err) {
>   *         handle the error...
> + *         error_free(err);
>   *     }
>   *
> + * Note, that before ERRP_AUTO_PROPAGATE introduction the pattern above =
(with
> + * error_propagate() instead of error_free()) was used to check and pass=
 error
> + * to the caller. Now this is DEPRECATED* (see below).
> + *
> + * Note also, that if you want to use error_append_hint/error_prepend or=
 their
> + * variants, you must use ERRP_AUTO_PROPAGATE too. Otherwise, in case of
> + * error_fatal, you'll miss the chance to insert your additional informa=
tion
> + * into Error object.
> + *
> + * In rare cases, we need to pass existing Error object to the caller by=
 hand:
> + *     error_propagate(errp, err);
> + *
> + * Pass an existing error to the caller with the message modified:
> + *     error_propagate_prepend(errp, err);
> + *
> + *
>   * Call a function ignoring errors:
>   *     foo(arg, NULL);
>   *
> @@ -78,26 +140,6 @@
>   * Call a function treating errors as fatal:
>   *     foo(arg, &error_fatal);
>   *
> - * Receive an error and pass it on to the caller:
> - *     Error *err =3D NULL;
> - *     foo(arg, &err);
> - *     if (err) {
> - *         handle the error...
> - *         error_propagate(errp, err);
> - *     }
> - * where Error **errp is a parameter, by convention the last one.
> - *
> - * Do *not* "optimize" this to
> - *     foo(arg, errp);
> - *     if (*errp) { // WRONG!
> - *         handle the error...
> - *     }
> - * because errp may be NULL!
> - *
> - * But when all you do with the error is pass it on, please use
> - *     foo(arg, errp);
> - * for readability.
> - *
>   * Receive and accumulate multiple errors (first one wins):
>   *     Error *err =3D NULL, *local_err =3D NULL;
>   *     foo(arg, &err);
> @@ -114,6 +156,61 @@
>   *         handle the error...
>   *     }
>   * because this may pass a non-null err to bar().
> + *
> + * DEPRECATED*
> + *
> + * The following pattern of receiving checking and passing the caller of=
 the
> + * error by hand is deprecated now:
> + *
> + *     Error *err =3D NULL;
> + *     foo(arg, &err);
> + *     if (err) {
> + *         handle the error...
> + *         error_propagate(errp, err);
> + *     }
> + *
> + * Instead, use ERRP_AUTO_PROPAGATE macro (defined below).
> + *
> + * The old pattern is deprecated because of two things:
> + *
> + * 1. Issue with error_abort and error_propagate: when we wrap error_abo=
rt by
> + * local_err+error_propagate, the resulting coredump will refer to
> + * error_propagate and not to the place where error happened.
> + *
> + * 2. A lot of extra code of the same pattern
> + *
> + * How to update old code to use ERRP_AUTO_PROPAGATE?
> + *
> + * All you need is to add ERRP_AUTO_PROPAGATE() invocation at function s=
tart,
> + * than you may safely dereference errp to check errors and do not need =
any
> + * additional local Error variables or calls to error_propagate().
> + *
> + * Example:
> + *
> + * old code
> + *
> + *     void fn(..., Error **errp) {
> + *         Error *err =3D NULL;
> + *         foo(arg, &err);
> + *         if (err) {
> + *             handle the error...
> + *             error_propagate(errp, err);
> + *             return;
> + *         }
> + *         ...
> + *     }
> + *
> + * updated code
> + *
> + *     void fn(..., Error **errp) {
> + *         ERRP_AUTO_PROPAGATE();
> + *         foo(arg, errp);
> + *         if (*errp) {
> + *             handle the error...
> + *             return;
> + *         }
> + *         ...
> + *     }
>   */
> =20
>  #ifndef ERROR_H
> @@ -322,6 +419,46 @@ void error_set_internal(Error **errp,
>                          ErrorClass err_class, const char *fmt, ...)
>      GCC_FMT_ATTR(6, 7);
> =20
> +typedef struct ErrorPropagator {
> +    Error *local_err;
> +    Error **errp;
> +} ErrorPropagator;
> +
> +static inline void error_propagator_cleanup(ErrorPropagator *prop)
> +{
> +    error_propagate(prop->errp, prop->local_err);
> +}
> +
> +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_clean=
up);
> +
> +/*
> + * ERRP_AUTO_PROPAGATE
> + *
> + * This macro is created to be the first line of a function which use
> + * Error **errp parameter to report error. It's needed only in cases whe=
re we
> + * want to use error_prepend, error_append_hint or dereference *errp. It=
's
> + * still safe (but useless) in other cases.
> + *
> + * If errp is NULL or points to error_fatal, it is rewritten to point to=
 a
> + * local Error object, which will be automatically propagated to the ori=
ginal
> + * errp on function exit (see error_propagator_cleanup).
> + *
> + * After invocation of this macro it is always safe to dereference errp
> + * (as it's not NULL anymore) and to add information by error_prepend or
> + * error_append_hint (as, if it was error_fatal, we swapped it with a
> + * local_error to be propagated on cleanup).
> + *
> + * Note: we don't wrap the error_abort case, as we want resulting coredu=
mp
> + * to point to the place where the error happened, not to error_propagat=
e.
> + */
> +#define ERRP_AUTO_PROPAGATE() \
> +    g_auto(ErrorPropagator) _auto_errp_prop =3D {.errp =3D errp}; \
> +    do { \
> +        if (!errp || errp =3D=3D &error_fatal) { \
> +            errp =3D &_auto_errp_prop.local_err; \
> +        } \
> +    } while (0)
> +
>  /*
>   * Special error destination to abort on error.
>   * See error_setg() and error_propagate() for details.


