Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16CEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68A120775
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ias7LSNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68A120775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtI7k-0000zL-0l
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHfg-00059U-Uz
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:32:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60270
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHff-0002g3-7L
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/uOY4/SJ4gfWNyZryEqE5tEwIEyI2WF/Ib9P410Ruoo=;
 b=Ias7LSNIcesIKMr/S06tExIdUQbQo0h7qq1Q9stDJ0EqJeoBXejjo0RrGzkEtQiwIweVx/
 Q2t3P09og84Sl8G02JDKRK77V+dNcX/IGiRgIg6zkMFg/FfwAHzu36fcFOzgQ4pzIKTXUa
 6kwMF1WI0MXLVN18N33tQz2Rcocj9WY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-nU0NIt0UPiK8ZFTrTKTiTA-1; Tue, 07 Jul 2020 17:25:16 -0400
X-MC-Unique: nU0NIt0UPiK8ZFTrTKTiTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EF111005510;
 Tue,  7 Jul 2020 21:25:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 39C1079220;
 Tue,  7 Jul 2020 21:25:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BAF9C1132921; Tue,  7 Jul 2020 23:25:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/53] error: Fix examples in error.h's big comment
Date: Tue,  7 Jul 2020 23:24:11 +0200
Message-Id: <20200707212503.1495927-2-armbru@redhat.com>
In-Reply-To: <20200707212503.1495927-1-armbru@redhat.com>
References: <20200707212503.1495927-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Mark a bad example more clearly.  Fix the error_propagate_prepend()
example.  Add a missing declaration and a second error pileup example.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <20200707160613.848843-2-armbru@redhat.com>
---
 include/qapi/error.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index ad5b6e896d..e8960eaad5 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -24,7 +24,7 @@
  *                       "charm, top, bottom.\n");
  *
  * Do *not* contract this to
- *     error_setg(&err, "invalid quark\n"
+ *     error_setg(&err, "invalid quark\n" // WRONG!
  *                "Valid quarks are up, down, strange, charm, top, bottom.");
  *
  * Report an error to the current monitor if we have one, else stderr:
@@ -52,7 +52,8 @@
  * where Error **errp is a parameter, by convention the last one.
  *
  * Pass an existing error to the caller with the message modified:
- *     error_propagate_prepend(errp, err);
+ *     error_propagate_prepend(errp, err,
+ *                             "Could not frobnicate '%s': ", name);
  *
  * Avoid
  *     error_propagate(errp, err);
@@ -108,12 +109,23 @@
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


