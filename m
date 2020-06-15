Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48591C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 06:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7722067B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 06:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7722067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkiqr-0000dO-Bz
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 02:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jkips-0008C8-K7
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 02:43:12 -0400
Received: from 13.mo7.mail-out.ovh.net ([87.98.150.175]:54658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jkipp-0005ie-Sv
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 02:43:12 -0400
Received: from player698.ha.ovh.net (unknown [10.110.208.183])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 2C6DE16CDCA
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 08:43:06 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player698.ha.ovh.net (Postfix) with ESMTPSA id 291E91354FF62;
 Mon, 15 Jun 2020 06:42:58 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R0060d7fbe82-49c2-4592-abc9-d34496501257,F1BB0E26B38E3581C3F8E07DA172D6E56B46BED4)
 smtp.auth=groug@kaod.org
Date: Mon, 15 Jun 2020 08:42:57 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 2/4] error: auto propagated local_err
Message-ID: <20200615084257.6711e3e8@bahia.lan>
In-Reply-To: <20200613071259.GD5861@umbus.fritz.box>
References: <159188280345.70166.14940592691021389043.stgit@bahia.lan>
 <159188281846.70166.15436662596881222119.stgit@bahia.lan>
 <20200613071259.GD5861@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1Dd38kbNVxC+YNQ7Ir.XhgV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 1763722205610351078
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeijedguddufecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgefgkeduvddutdfgkeekjeelgeejffehudeuhfeltdetfedthffftdfggeeihfdvnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=87.98.150.175; envelope-from=groug@kaod.org;
 helo=13.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 02:43:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--Sig_/1Dd38kbNVxC+YNQ7Ir.XhgV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jun 2020 17:12:59 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jun 11, 2020 at 03:40:18PM +0200, Greg Kurz wrote:
> > From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >=20
> > Introduce a new ERRP_AUTO_PROPAGATE macro, to be used at start of
> > functions with an errp OUT parameter.
> >=20
> > It has three goals:
> >=20
> > 1. Fix issue with error_fatal and error_prepend/error_append_hint: user
> > can't see this additional information, because exit() happens in
> > error_setg earlier than information is added. [Reported by Greg Kurz]
> >=20
> > 2. Fix issue with error_abort and error_propagate: when we wrap
> > error_abort by local_err+error_propagate, the resulting coredump will
> > refer to error_propagate and not to the place where error happened.
> > (the macro itself doesn't fix the issue, but it allows us to [3.] drop
> > the local_err+error_propagate pattern, which will definitely fix the
> > issue) [Reported by Kevin Wolf]
> >=20
> > 3. Drop local_err+error_propagate pattern, which is used to workaround
> > void functions with errp parameter, when caller wants to know resulting
> > status. (Note: actually these functions could be merely updated to
> > return int error code).
> >=20
> > To achieve these goals, later patches will add invocations
> > of this macro at the start of functions with either use
> > error_prepend/error_append_hint (solving 1) or which use
> > local_err+error_propagate to check errors, switching those
> > functions to use *errp instead (solving 2 and 3).
> >=20
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > Reviewed-by: Paul Durrant <paul@xen.org>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>=20
> I don't feel terribly qualified to comment on this generic change to
> the errors mechanism.  I can take it through my tree if necessary, but
> I'd want an ack from Markus.
>=20

Markus answered in another mail that there's still some more work to do
before we start using the ERRP_AUTO_PROPAGATE macro. A suivre...

> > ---
> >  include/qapi/error.h |  205 ++++++++++++++++++++++++++++++++++++++++++=
--------
> >  1 file changed, 173 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/include/qapi/error.h b/include/qapi/error.h
> > index ad5b6e896ded..30140d9bfea9 100644
> > --- a/include/qapi/error.h
> > +++ b/include/qapi/error.h
> > @@ -15,6 +15,8 @@
> >  /*
> >   * Error reporting system loosely patterned after Glib's GError.
> >   *
> > + * =3D Deal with Error object =3D
> > + *
> >   * Create an error:
> >   *     error_setg(&err, "situation normal, all fouled up");
> >   *
> > @@ -47,28 +49,91 @@
> >   * reporting it (primarily useful in testsuites):
> >   *     error_free_or_abort(&err);
> >   *
> > - * Pass an existing error to the caller:
> > - *     error_propagate(errp, err);
> > - * where Error **errp is a parameter, by convention the last one.
> > + * =3D Deal with Error ** function parameter =3D
> >   *
> > - * Pass an existing error to the caller with the message modified:
> > - *     error_propagate_prepend(errp, err);
> > + * A function may use the error system to return errors. In this case,=
 the
> > + * function defines an Error **errp parameter, by convention the last =
one (with
> > + * exceptions for functions using ... or va_list).
> >   *
> > - * Avoid
> > - *     error_propagate(errp, err);
> > - *     error_prepend(errp, "Could not frobnicate '%s': ", name);
> > - * because this fails to prepend when @errp is &error_fatal.
> > + * The caller may then pass in the following errp values:
> >   *
> > - * Create a new error and pass it to the caller:
> > + * 1. &error_abort
> > + *    Any error will result in abort().
> > + * 2. &error_fatal
> > + *    Any error will result in exit() with a non-zero status.
> > + * 3. NULL
> > + *    No error reporting through errp parameter.
> > + * 4. The address of a NULL-initialized Error *err
> > + *    Any error will populate errp with an error object.
> > + *
> > + * The following rules then implement the correct semantics desired by=
 the
> > + * caller.
> > + *
> > + * Create a new error to pass to the caller:
> >   *     error_setg(errp, "situation normal, all fouled up");
> >   *
> > - * Call a function and receive an error from it:
> > + * Calling another errp-based function:
> > + *     f(..., errp);
> > + *
> > + * =3D=3D Checking success of subcall =3D=3D
> > + *
> > + * If a function returns a value indicating an error in addition to se=
tting
> > + * errp (which is recommended), then you don't need any additional cod=
e, just
> > + * do:
> > + *
> > + *     int ret =3D f(..., errp);
> > + *     if (ret < 0) {
> > + *         ... handle error ...
> > + *         return ret;
> > + *     }
> > + *
> > + * If a function returns nothing (not recommended for new code), the o=
nly way
> > + * to check success is by consulting errp; doing this safely requires =
the use
> > + * of the ERRP_AUTO_PROPAGATE macro, like this:
> > + *
> > + *     int our_func(..., Error **errp) {
> > + *         ERRP_AUTO_PROPAGATE();
> > + *         ...
> > + *         subcall(..., errp);
> > + *         if (*errp) {
> > + *             ...
> > + *             return -EINVAL;
> > + *         }
> > + *         ...
> > + *     }
> > + *
> > + * ERRP_AUTO_PROPAGATE takes care of wrapping the original errp as nee=
ded, so
> > + * that the rest of the function can directly use errp (including
> > + * dereferencing), where any errors will then be propagated on to the =
original
> > + * errp when leaving the function.
> > + *
> > + * In some cases, we need to check result of subcall, but do not want =
to
> > + * propagate the Error object to our caller. In such cases we don't ne=
ed
> > + * ERRP_AUTO_PROPAGATE, but just a local Error object:
> > + *
> > + * Receive an error and not pass it:
> >   *     Error *err =3D NULL;
> > - *     foo(arg, &err);
> > + *     subcall(arg, &err);
> >   *     if (err) {
> >   *         handle the error...
> > + *         error_free(err);
> >   *     }
> >   *
> > + * Note that older code that did not use ERRP_AUTO_PROPAGATE would ins=
tead need
> > + * a local Error * variable and the use of error_propagate() to proper=
ly handle
> > + * all possible caller values of errp. Now this is DEPRECATED* (see be=
low).
> > + *
> > + * Note that any function that wants to modify an error object, such a=
s by
> > + * calling error_append_hint or error_prepend, must use ERRP_AUTO_PROP=
AGATE, in
> > + * order for a caller's use of &error_fatal to see the additional info=
rmation.
> > + *
> > + * In rare cases, we need to pass existing Error object to the caller =
by hand:
> > + *     error_propagate(errp, err);
> > + *
> > + * Pass an existing error to the caller with the message modified:
> > + *     error_propagate_prepend(errp, err);
> > + *
> > + *
> >   * Call a function ignoring errors:
> >   *     foo(arg, NULL);
> >   *
> > @@ -78,26 +143,6 @@
> >   * Call a function treating errors as fatal:
> >   *     foo(arg, &error_fatal);
> >   *
> > - * Receive an error and pass it on to the caller:
> > - *     Error *err =3D NULL;
> > - *     foo(arg, &err);
> > - *     if (err) {
> > - *         handle the error...
> > - *         error_propagate(errp, err);
> > - *     }
> > - * where Error **errp is a parameter, by convention the last one.
> > - *
> > - * Do *not* "optimize" this to
> > - *     foo(arg, errp);
> > - *     if (*errp) { // WRONG!
> > - *         handle the error...
> > - *     }
> > - * because errp may be NULL!
> > - *
> > - * But when all you do with the error is pass it on, please use
> > - *     foo(arg, errp);
> > - * for readability.
> > - *
> >   * Receive and accumulate multiple errors (first one wins):
> >   *     Error *err =3D NULL, *local_err =3D NULL;
> >   *     foo(arg, &err);
> > @@ -114,6 +159,61 @@
> >   *         handle the error...
> >   *     }
> >   * because this may pass a non-null err to bar().
> > + *
> > + * DEPRECATED*
> > + *
> > + * The following pattern of receiving, checking, and then forwarding a=
n error
> > + * to the caller by hand is now deprecated:
> > + *
> > + *     Error *err =3D NULL;
> > + *     foo(arg, &err);
> > + *     if (err) {
> > + *         handle the error...
> > + *         error_propagate(errp, err);
> > + *     }
> > + *
> > + * Instead, use ERRP_AUTO_PROPAGATE macro.
> > + *
> > + * The old pattern is deprecated because of two things:
> > + *
> > + * 1. Issue with error_abort and error_propagate: when we wrap error_a=
bort by
> > + * local_err+error_propagate, the resulting coredump will refer to
> > + * error_propagate and not to the place where error happened.
> > + *
> > + * 2. A lot of extra code of the same pattern
> > + *
> > + * How to update old code to use ERRP_AUTO_PROPAGATE?
> > + *
> > + * All you need is to add ERRP_AUTO_PROPAGATE() invocation at function=
 start,
> > + * than you may safely dereference errp to check errors and do not nee=
d any
> > + * additional local Error variables or calls to error_propagate().
> > + *
> > + * Example:
> > + *
> > + * old code
> > + *
> > + *     void fn(..., Error **errp) {
> > + *         Error *err =3D NULL;
> > + *         foo(arg, &err);
> > + *         if (err) {
> > + *             handle the error...
> > + *             error_propagate(errp, err);
> > + *             return;
> > + *         }
> > + *         ...
> > + *     }
> > + *
> > + * updated code
> > + *
> > + *     void fn(..., Error **errp) {
> > + *         ERRP_AUTO_PROPAGATE();
> > + *         foo(arg, errp);
> > + *         if (*errp) {
> > + *             handle the error...
> > + *             return;
> > + *         }
> > + *         ...
> > + *     }
> >   */
> > =20
> >  #ifndef ERROR_H
> > @@ -322,6 +422,47 @@ void error_set_internal(Error **errp,
> >                          ErrorClass err_class, const char *fmt, ...)
> >      GCC_FMT_ATTR(6, 7);
> > =20
> > +typedef struct ErrorPropagator {
> > +    Error *local_err;
> > +    Error **errp;
> > +} ErrorPropagator;
> > +
> > +static inline void error_propagator_cleanup(ErrorPropagator *prop)
> > +{
> > +    error_propagate(prop->errp, prop->local_err);
> > +}
> > +
> > +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cle=
anup);
> > +
> > +/*
> > + * ERRP_AUTO_PROPAGATE
> > + *
> > + * This macro exists to assist with proper error handling in a functio=
n which
> > + * uses an Error **errp parameter.  It must be used as the first line =
of a
> > + * function which modifies an error (with error_prepend, error_append_=
hint, or
> > + * similar) or which wants to dereference *errp.  It is still safe (but
> > + * useless) to use in other functions.
> > + *
> > + * If errp is NULL or points to error_fatal, it is rewritten to point =
to a
> > + * local Error object, which will be automatically propagated to the o=
riginal
> > + * errp on function exit (see error_propagator_cleanup).
> > + *
> > + * After invocation of this macro it is always safe to dereference errp
> > + * (as it's not NULL anymore) and to add information by error_prepend =
or
> > + * error_append_hint (as, if it was error_fatal, we swapped it with a
> > + * local_error to be propagated on cleanup).
> > + *
> > + * Note: we don't wrap the error_abort case, as we want resulting core=
dump
> > + * to point to the place where the error happened, not to error_propag=
ate.
> > + */
> > +#define ERRP_AUTO_PROPAGATE() \
> > +    g_auto(ErrorPropagator) _auto_errp_prop =3D {.errp =3D errp}; \
> > +    do { \
> > +        if (!errp || errp =3D=3D &error_fatal) { \
> > +            errp =3D &_auto_errp_prop.local_err; \
> > +        } \
> > +    } while (0)
> > +
> >  /*
> >   * Special error destination to abort on error.
> >   * See error_setg() and error_propagate() for details.
> >=20
> >=20
>=20


--Sig_/1Dd38kbNVxC+YNQ7Ir.XhgV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl7nGHEACgkQcdTV5YIv
c9auqA/+M0JHiWgPIrCKcXEbC3K+EV88yM3nOvyajcRwpB9fwE2uOOT2X2CUFfEt
CmVPuXhjEfheBYgOPm80Dg8siIgrEb8RVCQur0Bb/dBB6m8AaLLk9SoRILWetaXG
yzHRInL9yijfQ3uBkwAn2FsO58/o3ocRk3GVL4jAyqe+StupZJJmT+Mc+nwmhVlx
OI3MxUsafZ8FUNr+T6/ZcKz3K/3NLx5BMFk3NYiXhSrcPi55maUom/VuipTtTaXY
3hxfpElALXz/T2dU9vMB8RgOu2Y1pmU78GyJ//U/nQQdzADI202JwmfUMLqn134L
K4SY2WIMmCpdlFPvO1038wNK7WAMyoLgyz9QcKuecDOCLA6ULR1hL4K7NfMjHe87
F/dEvhRN0+g8cjU7m8Sr/rJCtqKuGX2sOeQ5YJWbzrflsSqcRCynW2L8JEKPt39n
KzXltchEM5l9fU5berWLUEfv8CX9FpgD0fiP1Nig1FTJWBfFuSqnJ2WUKDQsXDKP
BBzm6q61f5bFzpIJPR5t12NE4AO9ZQ5CGP8I9vanf+JekQzW40QAj76hz/tKHczW
ICUONVCkFPX0mPiqQMLtHQUEfZHlVJOeIFtyBdtuZZd8iwRvx5XxFQkX3peDhHwH
KxJ6KSnaOGmOQCAPhSxEgElBwekMcTfs8TGhafkVwPDgupXpTYo=
=iMWk
-----END PGP SIGNATURE-----

--Sig_/1Dd38kbNVxC+YNQ7Ir.XhgV--

