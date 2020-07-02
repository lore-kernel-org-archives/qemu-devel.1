Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E9BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B43C520771
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JThVTWvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43C520771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1Us-0002WL-UH
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jr1TX-00087e-8C
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:50:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20147
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jr1TS-0004nB-Mb
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593705005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dx5Y7PWTvGj3BPRlRkn6NwM+uD1KfBEFLRNWsyi80bA=;
 b=JThVTWvyutZebLULS2gAgKyDGs6fziHB29UmCMrni7HEcNmy/JsjYyzZVFBnU+Qfi+um1y
 nzkGrjSi0N/b0ogIMidIK66nQZSyWBB5IEqE8C6f3Ww4vLXvlfUdNaJxWCB4i8SZ3a1vH5
 gurc0IR91DvsuiQvJt7bKS6rFRJ1zi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-UlTfaUUuM76BC1Z5t0jSsA-1; Thu, 02 Jul 2020 11:50:03 -0400
X-MC-Unique: UlTfaUUuM76BC1Z5t0jSsA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CD408015F6;
 Thu,  2 Jul 2020 15:50:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 15C877922F;
 Thu,  2 Jul 2020 15:50:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7429A11385EB; Thu,  2 Jul 2020 17:50:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/44] error: Improve examples in error.h's big comment
Date: Thu,  2 Jul 2020 17:49:17 +0200
Message-Id: <20200702155000.3455325-2-armbru@redhat.com>
In-Reply-To: <20200702155000.3455325-1-armbru@redhat.com>
References: <20200702155000.3455325-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
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
 ehabkost@redhat.com, qemu-block@nongnu.org, Greg Kurz <groug@kaod.org>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Show errp instead of &err where &err is actually unusual.  Add a
missing declaration.  Add a second error pileup example.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 include/qapi/error.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index ad5b6e896d..3e64324b7a 100644
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
+ *         error_setg(&err, ...);
+ *     }
+ *     if (cond2) {
+ *         error_setg(&err, ...); // WRONG!
+ *     }
+ * because this may pass a non-null err to error_setg().
  */
 
 #ifndef ERROR_H
-- 
2.26.2


