Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A678C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E622A206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlBhawCW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E622A206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtHck-0001GD-4p
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 17:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHb1-0007LI-I7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:27:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26069
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHax-0001tz-9g
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjTg3TYDvdYubEwxieaVivSeO+RKPrnPp3dzxX5R0A8=;
 b=WlBhawCWwvrLn+fW+PwLdIGN6A8WT5r/L1mOPMNW0/EAu8EjThHPiMovBSn8olAhG9DIfW
 l5XlL+R0jqv7Pgz3t97fUc+8wZiEmF+8lpUtV0Kx9A+BRiIozYn4J5ly9JCZ0KA1+ldBJ4
 KxQSYZx5QwNucXGRnOsrYq7yMmc4EgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-EP-ACS0fOG-j34OrZwhnZw-1; Tue, 07 Jul 2020 17:25:07 -0400
X-MC-Unique: EP-ACS0fOG-j34OrZwhnZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6EDBA18FE861;
 Tue,  7 Jul 2020 21:25:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DC9B60CC0;
 Tue,  7 Jul 2020 21:25:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BEF2C1132922; Tue,  7 Jul 2020 23:25:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/53] error: Improve error.h's big comment
Date: Tue,  7 Jul 2020 23:24:12 +0200
Message-Id: <20200707212503.1495927-3-armbru@redhat.com>
In-Reply-To: <20200707212503.1495927-1-armbru@redhat.com>
References: <20200707212503.1495927-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add headlines to the big comment.

Explain examples for NULL, &error_abort and &error_fatal argument
better.

Tweak rationale for error_propagate_prepend().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200707160613.848843-3-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 include/qapi/error.h | 51 +++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index e8960eaad5..6d079c58b7 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -15,6 +15,8 @@
 /*
  * Error reporting system loosely patterned after Glib's GError.
  *
+ * = Creating errors =
+ *
  * Create an error:
  *     error_setg(&err, "situation normal, all fouled up");
  *
@@ -27,6 +29,8 @@
  *     error_setg(&err, "invalid quark\n" // WRONG!
  *                "Valid quarks are up, down, strange, charm, top, bottom.");
  *
+ * = Reporting and destroying errors =
+ *
  * Report an error to the current monitor if we have one, else stderr:
  *     error_report_err(err);
  * This frees the error object.
@@ -40,6 +44,30 @@
  *     error_free(err);
  * Note that this loses hints added with error_append_hint().
  *
+ * Call a function ignoring errors:
+ *     foo(arg, NULL);
+ * This is more concise than
+ *     Error *err = NULL;
+ *     foo(arg, &err);
+ *     error_free(err); // don't do this
+ *
+ * Call a function aborting on errors:
+ *     foo(arg, &error_abort);
+ * This is more concise and fails more nicely than
+ *     Error *err = NULL;
+ *     foo(arg, &err);
+ *     assert(!err); // don't do this
+ *
+ * Call a function treating errors as fatal:
+ *     foo(arg, &error_fatal);
+ * This is more concise than
+ *     Error *err = NULL;
+ *     foo(arg, &err);
+ *     if (err) { // don't do this
+ *         error_report_err(err);
+ *         exit(1);
+ *     }
+ *
  * Handle an error without reporting it (just for completeness):
  *     error_free(err);
  *
@@ -47,6 +75,11 @@
  * reporting it (primarily useful in testsuites):
  *     error_free_or_abort(&err);
  *
+ * = Passing errors around =
+ *
+ * Errors get passed to the caller through the conventional @errp
+ * parameter.
+ *
  * Pass an existing error to the caller:
  *     error_propagate(errp, err);
  * where Error **errp is a parameter, by convention the last one.
@@ -54,11 +87,10 @@
  * Pass an existing error to the caller with the message modified:
  *     error_propagate_prepend(errp, err,
  *                             "Could not frobnicate '%s': ", name);
- *
- * Avoid
- *     error_propagate(errp, err);
+ * This is more concise than
+ *     error_propagate(errp, err); // don't do this
  *     error_prepend(errp, "Could not frobnicate '%s': ", name);
- * because this fails to prepend when @errp is &error_fatal.
+ * and works even when @errp is &error_fatal.
  *
  * Create a new error and pass it to the caller:
  *     error_setg(errp, "situation normal, all fouled up");
@@ -70,15 +102,6 @@
  *         handle the error...
  *     }
  *
- * Call a function ignoring errors:
- *     foo(arg, NULL);
- *
- * Call a function aborting on errors:
- *     foo(arg, &error_abort);
- *
- * Call a function treating errors as fatal:
- *     foo(arg, &error_fatal);
- *
  * Receive an error and pass it on to the caller:
  *     Error *err = NULL;
  *     foo(arg, &err);
@@ -86,8 +109,6 @@
  *         handle the error...
  *         error_propagate(errp, err);
  *     }
- * where Error **errp is a parameter, by convention the last one.
- *
  * Do *not* "optimize" this to
  *     foo(arg, errp);
  *     if (*errp) { // WRONG!
-- 
2.26.2


