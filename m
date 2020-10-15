Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D97C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE08221D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WACCL2sM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE08221D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT4d1-0008AG-Oq
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 10:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT4Zw-0004CA-OL
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:50:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT4Zu-0001fV-T1
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602773401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aLpNJpWPYwwF01s/Lhok3fVvRwYNbm36mgvYFogFwDM=;
 b=WACCL2sMyW52pkpFGsBDbB8gqDSpopja1CmJAdHbaaGeMOE/gQTkJwTilcO2FgbBPEabYs
 8U+2bs/iK34j6XWxSQQxX6ZuTOKba9yL0pxtNw8wBzy7v9Cz1YZ7k8Yb2TO/7I5d4LZERH
 NSm46dFA2jODmI796RKA6vDQK426z4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-2qn1dOYcMbKRcrJbJgffcA-1; Thu, 15 Oct 2020 10:49:59 -0400
X-MC-Unique: 2qn1dOYcMbKRcrJbJgffcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 935F780F05B;
 Thu, 15 Oct 2020 14:49:58 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CACF610F3;
 Thu, 15 Oct 2020 14:49:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/10] keyval: Fix and clarify grammar
Date: Thu, 15 Oct 2020 16:49:43 +0200
Message-Id: <20201015144952.388043-2-kwolf@redhat.com>
In-Reply-To: <20201015144952.388043-1-kwolf@redhat.com>
References: <20201015144952.388043-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

The grammar has a few issues:

* key-fragment = / [^=,.]* /

  Prose restricts key fragments: they "must be valid QAPI names or
  consist only of decimal digits".  Technically, '' consists only of
  decimal digits.  The code rejects that.  Fix the grammar.

* val          = { / [^,]* / | ',,' }

  Use + instead of *.  Accepts the same language.

* val-no-key   = / [^=,]* /

  The code rejects an empty value.  Fix the grammar.

* Section "Additional syntax for use with an implied key" is
  confusing.  Rewrite it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20201011073505.1185335-2-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 util/keyval.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/util/keyval.c b/util/keyval.c
index 13def4af54..82d8497c71 100644
--- a/util/keyval.c
+++ b/util/keyval.c
@@ -16,8 +16,8 @@
  *   key-vals     = [ key-val { ',' key-val } [ ',' ] ]
  *   key-val      = key '=' val
  *   key          = key-fragment { '.' key-fragment }
- *   key-fragment = / [^=,.]* /
- *   val          = { / [^,]* / | ',,' }
+ *   key-fragment = / [^=,.]+ /
+ *   val          = { / [^,]+ / | ',,' }
  *
  * Semantics defined by reduction to JSON:
  *
@@ -71,12 +71,16 @@
  * Awkward.  Note that we carefully restrict alternate types to avoid
  * similar ambiguity.
  *
- * Additional syntax for use with an implied key:
+ * Alternative syntax for use with an implied key:
  *
- *   key-vals-ik  = val-no-key [ ',' key-vals ]
- *   val-no-key   = / [^=,]* /
+ *   key-vals     = [ key-val-1st { ',' key-val } [ ',' ] ]
+ *   key-val-1st  = val-no-key | key-val
+ *   val-no-key   = / [^=,]+ /
  *
- * where no-key is syntactic sugar for implied-key=val-no-key.
+ * where val-no-key is syntactic sugar for implied-key=val-no-key.
+ *
+ * Note that you can't use the sugared form when the value contains
+ * '=' or ','.
  */
 
 #include "qemu/osdep.h"
-- 
2.28.0


