Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45480C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 08:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A25206D7
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 08:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lACgLsIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A25206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk1lh-0007Tp-93
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 04:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jk1kj-0006cp-3D; Sat, 13 Jun 2020 04:43:01 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52551 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jk1kf-0004oa-Gx; Sat, 13 Jun 2020 04:43:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49kWLq40Brz9sRk; Sat, 13 Jun 2020 18:42:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1592037763;
 bh=7A5zhZ34PMBBU1KT8WiSgrrzwOfqKBgA6+HOBew7+PY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lACgLsItUSRpHC8AAzVLOgqF3tW2MEwn85r/IEikawXHu9ZE6zYjvel3pzn7Qi1pF
 sCJMndZAvw9xSZ/3hcI3xXPbuxsB+8ceMcAI15X9buyIGBgnADu6/Qe0d/CMUarqyN
 H0tvQE9D1qAntnocRJOfXvz2imZvOuo4M5SLJaKA=
Date: Sat, 13 Jun 2020 17:12:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 2/4] error: auto propagated local_err
Message-ID: <20200613071259.GD5861@umbus.fritz.box>
References: <159188280345.70166.14940592691021389043.stgit@bahia.lan>
 <159188281846.70166.15436662596881222119.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Content-Disposition: inline
In-Reply-To: <159188281846.70166.15436662596881222119.stgit@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 04:42:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 03:40:18PM +0200, Greg Kurz wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Introduce a new ERRP_AUTO_PROPAGATE macro, to be used at start of
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
> Reviewed-by: Paul Durrant <paul@xen.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>

I don't feel terribly qualified to comment on this generic change to
the errors mechanism.  I can take it through my tree if necessary, but
I'd want an ack from Markus.

> ---
>  include/qapi/error.h |  205 ++++++++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 173 insertions(+), 32 deletions(-)
>=20
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index ad5b6e896ded..30140d9bfea9 100644
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
> @@ -47,28 +49,91 @@
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
> + * A function may use the error system to return errors. In this case, t=
he
> + * function defines an Error **errp parameter, by convention the last on=
e (with
> + * exceptions for functions using ... or va_list).
>   *
> - * Avoid
> - *     error_propagate(errp, err);
> - *     error_prepend(errp, "Could not frobnicate '%s': ", name);
> - * because this fails to prepend when @errp is &error_fatal.
> + * The caller may then pass in the following errp values:
>   *
> - * Create a new error and pass it to the caller:
> + * 1. &error_abort
> + *    Any error will result in abort().
> + * 2. &error_fatal
> + *    Any error will result in exit() with a non-zero status.
> + * 3. NULL
> + *    No error reporting through errp parameter.
> + * 4. The address of a NULL-initialized Error *err
> + *    Any error will populate errp with an error object.
> + *
> + * The following rules then implement the correct semantics desired by t=
he
> + * caller.
> + *
> + * Create a new error to pass to the caller:
>   *     error_setg(errp, "situation normal, all fouled up");
>   *
> - * Call a function and receive an error from it:
> + * Calling another errp-based function:
> + *     f(..., errp);
> + *
> + * =3D=3D Checking success of subcall =3D=3D
> + *
> + * If a function returns a value indicating an error in addition to sett=
ing
> + * errp (which is recommended), then you don't need any additional code,=
 just
> + * do:
> + *
> + *     int ret =3D f(..., errp);
> + *     if (ret < 0) {
> + *         ... handle error ...
> + *         return ret;
> + *     }
> + *
> + * If a function returns nothing (not recommended for new code), the onl=
y way
> + * to check success is by consulting errp; doing this safely requires th=
e use
> + * of the ERRP_AUTO_PROPAGATE macro, like this:
> + *
> + *     int our_func(..., Error **errp) {
> + *         ERRP_AUTO_PROPAGATE();
> + *         ...
> + *         subcall(..., errp);
> + *         if (*errp) {
> + *             ...
> + *             return -EINVAL;
> + *         }
> + *         ...
> + *     }
> + *
> + * ERRP_AUTO_PROPAGATE takes care of wrapping the original errp as neede=
d, so
> + * that the rest of the function can directly use errp (including
> + * dereferencing), where any errors will then be propagated on to the or=
iginal
> + * errp when leaving the function.
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
> + * Note that older code that did not use ERRP_AUTO_PROPAGATE would inste=
ad need
> + * a local Error * variable and the use of error_propagate() to properly=
 handle
> + * all possible caller values of errp. Now this is DEPRECATED* (see belo=
w).
> + *
> + * Note that any function that wants to modify an error object, such as =
by
> + * calling error_append_hint or error_prepend, must use ERRP_AUTO_PROPAG=
ATE, in
> + * order for a caller's use of &error_fatal to see the additional inform=
ation.
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
> @@ -78,26 +143,6 @@
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
> @@ -114,6 +159,61 @@
>   *         handle the error...
>   *     }
>   * because this may pass a non-null err to bar().
> + *
> + * DEPRECATED*
> + *
> + * The following pattern of receiving, checking, and then forwarding an =
error
> + * to the caller by hand is now deprecated:
> + *
> + *     Error *err =3D NULL;
> + *     foo(arg, &err);
> + *     if (err) {
> + *         handle the error...
> + *         error_propagate(errp, err);
> + *     }
> + *
> + * Instead, use ERRP_AUTO_PROPAGATE macro.
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
> @@ -322,6 +422,47 @@ void error_set_internal(Error **errp,
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
> + * This macro exists to assist with proper error handling in a function =
which
> + * uses an Error **errp parameter.  It must be used as the first line of=
 a
> + * function which modifies an error (with error_prepend, error_append_hi=
nt, or
> + * similar) or which wants to dereference *errp.  It is still safe (but
> + * useless) to use in other functions.
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
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7kfHsACgkQbDjKyiDZ
s5JmBxAA2zojVl/gxknEsK7qNpkNWdthEsVzUdf8UN1dQh/lny9cq1+NRClVUQIS
wAq+tzGVDlVsKT5i85CCp3CzfE7LdFqFDpHLEyBwU1BH7KQhiOkSqP1OvxCmDit4
8Xq6999K2wTT6Eqm34Ns4SMWlJ0f1r99ZHuiEdhuzY56oCBA9UPESlPuJAtgfUC6
E6w+Z0gGW3fybkqZa4cqZuNMTk+tKswoV8RYCF2nmCyFH2zE4kwN48dkRMpeCFGL
mUYhB08ZqnJO8KXZTx1haDRK+RBwKTqkPz5vdeYCXE1y7NbOYGKR05EYQWBpK7+H
vivzT8Czl3juRObwle+OX2wiAGnWUruouEbQpha5mYp+3Aowm7+3O4xfT/vDp/Kl
eHbTpldL5nxsgCkD+OcpQTSe05OltoUxEna/xCPrpCGlqVebvCWOxndsEei1pxxm
j2Ma9Bvnsoj2xXu0pw8Km5aytCTS1y3B4BxbmBgyk2LkTqSQnjsxdHpCs+GGo43s
imhg/zz0OGZwxiCtQImYE0Ppp2SFs4fXrefxIyRrHtG6BJbppQVmiCn3NKFGENft
TPZBaM49o/AxkVVxMHHQS5Gy0MsE+WrH7AaJqdFf0dCfizAHAi26gYyRzuNcsLrT
zf2St8sRXaPhK7W/NXpTpsjheRMaoR7fqNqSsCf1tiTES6HaCj4=
=nKAu
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--

