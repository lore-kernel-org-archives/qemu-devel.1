Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47C6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 17:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89E7F2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 17:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E7F2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj4Ne-0000bY-I6
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 13:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jj4M4-0007CY-BN
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 13:17:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60839
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jj4M3-0000I0-5G
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 13:17:36 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-P1ew-mauN26CKyzRCOha7g-1; Wed, 10 Jun 2020 13:17:30 -0400
X-MC-Unique: P1ew-mauN26CKyzRCOha7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F4ED461;
 Wed, 10 Jun 2020 17:17:29 +0000 (UTC)
Received: from bahia.lan (ovpn-114-202.ams2.redhat.com [10.36.114.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3BC21002393;
 Wed, 10 Jun 2020 17:17:27 +0000 (UTC)
Subject: [PATCH 1/3] error: auto propagated local_err
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 10 Jun 2020 19:17:26 +0200
Message-ID: <159180944686.29090.6706368074192153633.stgit@bahia.lan>
In-Reply-To: <159180935807.29090.16079635439548762534.stgit@bahia.lan>
References: <159180935807.29090.16079635439548762534.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 12:37:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=_AUTOLEARN
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Introduce a new ERRP_AUTO_PROPAGATE macro, to be used at start of
functions with an errp OUT parameter.

It has three goals:

1. Fix issue with error_fatal and error_prepend/error_append_hint: user
can't see this additional information, because exit() happens in
error_setg earlier than information is added. [Reported by Greg Kurz]

2. Fix issue with error_abort and error_propagate: when we wrap
error_abort by local_err+error_propagate, the resulting coredump will
refer to error_propagate and not to the place where error happened.
(the macro itself doesn't fix the issue, but it allows us to [3.] drop
the local_err+error_propagate pattern, which will definitely fix the
issue) [Reported by Kevin Wolf]

3. Drop local_err+error_propagate pattern, which is used to workaround
void functions with errp parameter, when caller wants to know resulting
status. (Note: actually these functions could be merely updated to
return int error code).

To achieve these goals, later patches will add invocations
of this macro at the start of functions with either use
error_prepend/error_append_hint (solving 1) or which use
local_err+error_propagate to check errors, switching those
functions to use *errp instead (solving 2 and 3).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 include/qapi/error.h |  205 ++++++++++++++++++++++++++++++++++++++++++----=
----
 1 file changed, 173 insertions(+), 32 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index ad5b6e896ded..30140d9bfea9 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -15,6 +15,8 @@
 /*
  * Error reporting system loosely patterned after Glib's GError.
  *
+ * =3D Deal with Error object =3D
+ *
  * Create an error:
  *     error_setg(&err, "situation normal, all fouled up");
  *
@@ -47,28 +49,91 @@
  * reporting it (primarily useful in testsuites):
  *     error_free_or_abort(&err);
  *
- * Pass an existing error to the caller:
- *     error_propagate(errp, err);
- * where Error **errp is a parameter, by convention the last one.
+ * =3D Deal with Error ** function parameter =3D
  *
- * Pass an existing error to the caller with the message modified:
- *     error_propagate_prepend(errp, err);
+ * A function may use the error system to return errors. In this case, the
+ * function defines an Error **errp parameter, by convention the last one =
(with
+ * exceptions for functions using ... or va_list).
  *
- * Avoid
- *     error_propagate(errp, err);
- *     error_prepend(errp, "Could not frobnicate '%s': ", name);
- * because this fails to prepend when @errp is &error_fatal.
+ * The caller may then pass in the following errp values:
  *
- * Create a new error and pass it to the caller:
+ * 1. &error_abort
+ *    Any error will result in abort().
+ * 2. &error_fatal
+ *    Any error will result in exit() with a non-zero status.
+ * 3. NULL
+ *    No error reporting through errp parameter.
+ * 4. The address of a NULL-initialized Error *err
+ *    Any error will populate errp with an error object.
+ *
+ * The following rules then implement the correct semantics desired by the
+ * caller.
+ *
+ * Create a new error to pass to the caller:
  *     error_setg(errp, "situation normal, all fouled up");
  *
- * Call a function and receive an error from it:
+ * Calling another errp-based function:
+ *     f(..., errp);
+ *
+ * =3D=3D Checking success of subcall =3D=3D
+ *
+ * If a function returns a value indicating an error in addition to settin=
g
+ * errp (which is recommended), then you don't need any additional code, j=
ust
+ * do:
+ *
+ *     int ret =3D f(..., errp);
+ *     if (ret < 0) {
+ *         ... handle error ...
+ *         return ret;
+ *     }
+ *
+ * If a function returns nothing (not recommended for new code), the only =
way
+ * to check success is by consulting errp; doing this safely requires the =
use
+ * of the ERRP_AUTO_PROPAGATE macro, like this:
+ *
+ *     int our_func(..., Error **errp) {
+ *         ERRP_AUTO_PROPAGATE();
+ *         ...
+ *         subcall(..., errp);
+ *         if (*errp) {
+ *             ...
+ *             return -EINVAL;
+ *         }
+ *         ...
+ *     }
+ *
+ * ERRP_AUTO_PROPAGATE takes care of wrapping the original errp as needed,=
 so
+ * that the rest of the function can directly use errp (including
+ * dereferencing), where any errors will then be propagated on to the orig=
inal
+ * errp when leaving the function.
+ *
+ * In some cases, we need to check result of subcall, but do not want to
+ * propagate the Error object to our caller. In such cases we don't need
+ * ERRP_AUTO_PROPAGATE, but just a local Error object:
+ *
+ * Receive an error and not pass it:
  *     Error *err =3D NULL;
- *     foo(arg, &err);
+ *     subcall(arg, &err);
  *     if (err) {
  *         handle the error...
+ *         error_free(err);
  *     }
  *
+ * Note that older code that did not use ERRP_AUTO_PROPAGATE would instead=
 need
+ * a local Error * variable and the use of error_propagate() to properly h=
andle
+ * all possible caller values of errp. Now this is DEPRECATED* (see below)=
.
+ *
+ * Note that any function that wants to modify an error object, such as by
+ * calling error_append_hint or error_prepend, must use ERRP_AUTO_PROPAGAT=
E, in
+ * order for a caller's use of &error_fatal to see the additional informat=
ion.
+ *
+ * In rare cases, we need to pass existing Error object to the caller by h=
and:
+ *     error_propagate(errp, err);
+ *
+ * Pass an existing error to the caller with the message modified:
+ *     error_propagate_prepend(errp, err);
+ *
+ *
  * Call a function ignoring errors:
  *     foo(arg, NULL);
  *
@@ -78,26 +143,6 @@
  * Call a function treating errors as fatal:
  *     foo(arg, &error_fatal);
  *
- * Receive an error and pass it on to the caller:
- *     Error *err =3D NULL;
- *     foo(arg, &err);
- *     if (err) {
- *         handle the error...
- *         error_propagate(errp, err);
- *     }
- * where Error **errp is a parameter, by convention the last one.
- *
- * Do *not* "optimize" this to
- *     foo(arg, errp);
- *     if (*errp) { // WRONG!
- *         handle the error...
- *     }
- * because errp may be NULL!
- *
- * But when all you do with the error is pass it on, please use
- *     foo(arg, errp);
- * for readability.
- *
  * Receive and accumulate multiple errors (first one wins):
  *     Error *err =3D NULL, *local_err =3D NULL;
  *     foo(arg, &err);
@@ -114,6 +159,61 @@
  *         handle the error...
  *     }
  * because this may pass a non-null err to bar().
+ *
+ * DEPRECATED*
+ *
+ * The following pattern of receiving, checking, and then forwarding an er=
ror
+ * to the caller by hand is now deprecated:
+ *
+ *     Error *err =3D NULL;
+ *     foo(arg, &err);
+ *     if (err) {
+ *         handle the error...
+ *         error_propagate(errp, err);
+ *     }
+ *
+ * Instead, use ERRP_AUTO_PROPAGATE macro.
+ *
+ * The old pattern is deprecated because of two things:
+ *
+ * 1. Issue with error_abort and error_propagate: when we wrap error_abort=
 by
+ * local_err+error_propagate, the resulting coredump will refer to
+ * error_propagate and not to the place where error happened.
+ *
+ * 2. A lot of extra code of the same pattern
+ *
+ * How to update old code to use ERRP_AUTO_PROPAGATE?
+ *
+ * All you need is to add ERRP_AUTO_PROPAGATE() invocation at function sta=
rt,
+ * than you may safely dereference errp to check errors and do not need an=
y
+ * additional local Error variables or calls to error_propagate().
+ *
+ * Example:
+ *
+ * old code
+ *
+ *     void fn(..., Error **errp) {
+ *         Error *err =3D NULL;
+ *         foo(arg, &err);
+ *         if (err) {
+ *             handle the error...
+ *             error_propagate(errp, err);
+ *             return;
+ *         }
+ *         ...
+ *     }
+ *
+ * updated code
+ *
+ *     void fn(..., Error **errp) {
+ *         ERRP_AUTO_PROPAGATE();
+ *         foo(arg, errp);
+ *         if (*errp) {
+ *             handle the error...
+ *             return;
+ *         }
+ *         ...
+ *     }
  */
=20
 #ifndef ERROR_H
@@ -322,6 +422,47 @@ void error_set_internal(Error **errp,
                         ErrorClass err_class, const char *fmt, ...)
     GCC_FMT_ATTR(6, 7);
=20
+typedef struct ErrorPropagator {
+    Error *local_err;
+    Error **errp;
+} ErrorPropagator;
+
+static inline void error_propagator_cleanup(ErrorPropagator *prop)
+{
+    error_propagate(prop->errp, prop->local_err);
+}
+
+G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cleanup=
);
+
+/*
+ * ERRP_AUTO_PROPAGATE
+ *
+ * This macro exists to assist with proper error handling in a function wh=
ich
+ * uses an Error **errp parameter.  It must be used as the first line of a
+ * function which modifies an error (with error_prepend, error_append_hint=
, or
+ * similar) or which wants to dereference *errp.  It is still safe (but
+ * useless) to use in other functions.
+ *
+ * If errp is NULL or points to error_fatal, it is rewritten to point to a
+ * local Error object, which will be automatically propagated to the origi=
nal
+ * errp on function exit (see error_propagator_cleanup).
+ *
+ * After invocation of this macro it is always safe to dereference errp
+ * (as it's not NULL anymore) and to add information by error_prepend or
+ * error_append_hint (as, if it was error_fatal, we swapped it with a
+ * local_error to be propagated on cleanup).
+ *
+ * Note: we don't wrap the error_abort case, as we want resulting coredump
+ * to point to the place where the error happened, not to error_propagate.
+ */
+#define ERRP_AUTO_PROPAGATE() \
+    g_auto(ErrorPropagator) _auto_errp_prop =3D {.errp =3D errp}; \
+    do { \
+        if (!errp || errp =3D=3D &error_fatal) { \
+            errp =3D &_auto_errp_prop.local_err; \
+        } \
+    } while (0)
+
 /*
  * Special error destination to abort on error.
  * See error_setg() and error_propagate() for details.



