Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3A4C4360C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7886B214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 12:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7886B214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCk4f-0003RQ-OY
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 08:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCk0i-0001ID-N3
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCk0g-0006s4-1w
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCk0f-0006qy-Sy
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 08:33:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1332188305
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 12:33:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D77E41001938;
 Tue, 24 Sep 2019 12:33:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 382CE113865F; Tue, 24 Sep 2019 14:33:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/37] qapi: Make visit_next_list()'s comment less confusing
Date: Tue, 24 Sep 2019 14:32:58 +0200
Message-Id: <20190924123334.30645-2-armbru@redhat.com>
In-Reply-To: <20190924123334.30645-1-armbru@redhat.com>
References: <20190924123334.30645-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 24 Sep 2019 12:33:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

visit_next_list() returns non-null on success, null on failure.  The
comment's phrasing "until NULL return or error occurs" is needlessly
confusing.  Scratch the "or error occurs" part.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190802122325.16520-1-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/qapi/visitor.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 5b2ed3f202..c5b23851a1 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -364,10 +364,10 @@ void visit_start_list(Visitor *v, const char *name,=
 GenericList **list,
  * @tail must not be NULL; on the first call, @tail is the value of
  * *list after visit_start_list(), and on subsequent calls @tail must
  * be the previously returned value.  Should be called in a loop until
- * a NULL return or error occurs; for each non-NULL return, the caller
- * then calls the appropriate visit_type_*() for the element type of
- * the list, with that function's name parameter set to NULL and obj
- * set to the address of @tail->value.
+ * a NULL return; for each non-NULL return, the caller then calls the
+ * appropriate visit_type_*() for the element type of the list, with
+ * that function's name parameter set to NULL and obj set to the
+ * address of @tail->value.
  */
 GenericList *visit_next_list(Visitor *v, GenericList *tail, size_t size)=
;
=20
--=20
2.21.0


