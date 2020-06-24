Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373E0C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023722082F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiK7Wbjs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023722082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8WJ-0005FB-7m
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 12:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8V7-0002fm-FM
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:43:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23235
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8V4-00053W-Ss
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593017029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vwaMCDVCOEqedQg67jOLGOu9cO5xJvTXXQ4rtBOA3bk=;
 b=LiK7WbjsFB89t50395I5YmNQUmli6KCDMJe6+W9i10nZpbMcA7L+Cio0ybdzx5mgbUbMU4
 EfMfaA4WH6IZ7e4wTXf5q3FmsYY3Yb2vGQKb41Fgu+4A6LhfA0UKoIRrW+YoT4GGE/JENk
 9nU+tZC+VZkcLlpwjDLzD+8wIJKSnwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-29kwUgoSMQWLy_hR3_ne4g-1; Wed, 24 Jun 2020 12:43:47 -0400
X-MC-Unique: 29kwUgoSMQWLy_hR3_ne4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A23B3804008;
 Wed, 24 Jun 2020 16:43:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AE495D9D3;
 Wed, 24 Jun 2020 16:43:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D6897113846D; Wed, 24 Jun 2020 18:43:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/46] error: Improve examples in error.h's big comment
Date: Wed, 24 Jun 2020 18:42:59 +0200
Message-Id: <20200624164344.3778251-2-armbru@redhat.com>
In-Reply-To: <20200624164344.3778251-1-armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Show errp instead of &err where &err is actually unusual.  Add a
missing declaration.  Add a second error pileup example.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/error.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index ad5b6e896d..1a5ea25e12 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -16,15 +16,15 @@
  * Error reporting system loosely patterned after Glib's GError.
  *
  * Create an error:
- *     error_setg(&err, "situation normal, all fouled up");
+ *     error_setg(errp, "situation normal, all fouled up");
  *
  * Create an error and add additional explanation:
- *     error_setg(&err, "invalid quark");
- *     error_append_hint(&err, "Valid quarks are up, down, strange, "
+ *     error_setg(errp, "invalid quark");
+ *     error_append_hint(errp, "Valid quarks are up, down, strange, "
  *                       "charm, top, bottom.\n");
  *
  * Do *not* contract this to
- *     error_setg(&err, "invalid quark\n"
+ *     error_setg(errp, "invalid quark\n" // WRONG!
  *                "Valid quarks are up, down, strange, charm, top, bottom.");
  *
  * Report an error to the current monitor if we have one, else stderr:
@@ -108,12 +108,23 @@
  *     }
  *
  * Do *not* "optimize" this to
+ *     Error *err = NULL;
  *     foo(arg, &err);
  *     bar(arg, &err); // WRONG!
  *     if (err) {
  *         handle the error...
  *     }
  * because this may pass a non-null err to bar().
+ *
+ * Likewise, do *not*
+ *     Error *err = NULL;
+ *     if (cond1) {
+ *         error_setg(err, ...);
+ *     }
+ *     if (cond2) {
+ *         error_setg(err, ...); // WRONG!
+ *     }
+ * because this may pass a non-null err to error_setg().
  */
 
 #ifndef ERROR_H
-- 
2.26.2


