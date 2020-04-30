Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFDCC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8A42082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 05:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hb6sSnHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8A42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU1vl-0005EW-1K
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 01:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n7-00057Z-GA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jU1n0-0002fN-Jr
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60928
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jU1mz-0002cB-Q4
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 01:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588224670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZacRsiQHzcgpcc27GbgCU4ripqPFecDF160ILu2GBvA=;
 b=Hb6sSnHNgCMFFfmuDZPEODO6ZkP+Upe6HoFG0iXgqeAFAoxTs89imDoJHl+Gf4zUwKyVsI
 MNNvper4625DPB1SwjS7oO50fj+j4gh9ttbFpAEkXC91g+4/hS6l/M1VptKkG2xaHjNA2q
 OpkuzwtO0ADfwgrvRB68Qo6PLIuOLcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-Iv548PfVPxeMLbteEMMCfA-1; Thu, 30 Apr 2020 01:31:08 -0400
X-MC-Unique: Iv548PfVPxeMLbteEMMCfA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFBA0800D24
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 05:31:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0D1A60638;
 Thu, 30 Apr 2020 05:31:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E3B0911358C2; Thu, 30 Apr 2020 07:31:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/20] qapi: Belatedly update visitor.h's big comment for QAPI
 modules
Date: Thu, 30 Apr 2020 07:30:50 +0200
Message-Id: <20200430053104.32204-7-armbru@redhat.com>
In-Reply-To: <20200430053104.32204-1-armbru@redhat.com>
References: <20200430053104.32204-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200424084338.26803-2-armbru@redhat.com>
---
 include/qapi/visitor.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index c5b23851a1..f8a0fc1ea9 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -58,7 +58,7 @@
  *
  * where T is FOO for scalar types, and FOO * otherwise.  The scalar
  * visitors are declared here; the remaining visitors are generated in
- * qapi-visit.h.
+ * qapi-visit-MODULE.h.
  *
  * The @name parameter of visit_type_FOO() describes the relation
  * between this QAPI value and its parent container.  When visiting
@@ -86,16 +86,16 @@
  * by manual construction.
  *
  * For the QAPI object types (structs, unions, and alternates), there
- * is an additional generated function in qapi-visit.h compatible
- * with:
+ * is an additional generated function in qapi-visit-MODULE.h
+ * compatible with:
  *
  * void visit_type_FOO_members(Visitor *v, FOO *obj, Error **errp);
  *
  * for visiting the members of a type without also allocating the QAPI
  * struct.
  *
- * Additionally, in qapi-types.h, all QAPI pointer types (structs,
- * unions, alternates, and lists) have a generated function compatible
+ * Additionally, QAPI pointer types (structs, unions, alternates, and
+ * lists) have a generated function in qapi-types-MODULE.h compatible
  * with:
  *
  * void qapi_free_FOO(FOO *obj);
--=20
2.21.1


