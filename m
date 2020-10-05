Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F804C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 21:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE77208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 21:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIafn13e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE77208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPXz6-0001bq-KJ
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 17:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXkm-0000Ae-BV
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 17:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXki-0007UP-UR
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 17:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601932235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oOBeLpeIEpL/TxoU2ObY2AqnifWcBURZsaekTSVcawE=;
 b=JIafn13eB8SW3hYeUlsTCN1OleHiIpTT41hOupGkALUjfNCjIe63wz7xsDUtBzQ79C1SIa
 I/64XuiTOZ8duqCMDLcq7enhZHrU2klG//xbPoKRIzQok+Lp5E1ACFnIZ5fxTylys4Bnup
 Tmne1Cr6BAsTXHwQr5udeih9dSAsIpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-SKSFeW3kPC2_uK7b5ns2RA-1; Mon, 05 Oct 2020 17:10:33 -0400
X-MC-Unique: SKSFeW3kPC2_uK7b5ns2RA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34CBC873114;
 Mon,  5 Oct 2020 21:10:32 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9F0378807;
 Mon,  5 Oct 2020 21:10:31 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 15/21] docs/devel/qom: Remove usage of <code>
Date: Mon,  5 Oct 2020 17:09:54 -0400
Message-Id: <20201005211000.710404-16-ehabkost@redhat.com>
In-Reply-To: <20201005211000.710404-1-ehabkost@redhat.com>
References: <20201005211000.710404-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

<code> is not valid reST syntax.

Function @argument references don't need additional markup, so
just remove <code></code>.

Constants were changed to use reST ``code`` syntax

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20201003025424.199291-6-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index de121d8d8e8..e80092f349a 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1256,7 +1256,7 @@ char *object_property_get_str(Object *obj, const char *name,
  * Writes an object's canonical path to a property.
  *
  * If the link property was created with
- * <code>OBJ_PROP_LINK_STRONG</code> bit, the old target object is
+ * %OBJ_PROP_LINK_STRONG bit, the old target object is
  * unreferenced, and a reference is added to the new target object.
  *
  * Returns: %true on success, %false on failure.
@@ -1603,16 +1603,16 @@ void object_property_allow_set_link(const Object *obj, const char *name,
  *
  * Links form the graph in the object model.
  *
- * The <code>@check()</code> callback is invoked when
+ * The @check() callback is invoked when
  * object_property_set_link() is called and can raise an error to prevent the
- * link being set.  If <code>@check</code> is NULL, the property is read-only
+ * link being set.  If @check is NULL, the property is read-only
  * and cannot be set.
  *
  * Ownership of the pointer that @child points to is transferred to the
- * link property.  The reference count for <code>*@child</code> is
+ * link property.  The reference count for *@child is
  * managed by the property from after the function returns till the
  * property is deleted with object_property_del().  If the
- * <code>@flags</code> <code>OBJ_PROP_LINK_STRONG</code> bit is set,
+ * @flags %OBJ_PROP_LINK_STRONG bit is set,
  * the reference count is decremented when the property is deleted or
  * modified.
  *
@@ -1823,7 +1823,7 @@ ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
  * Add an alias for a property on an object.  This function will add a property
  * of the same type as the forwarded property.
  *
- * The caller must ensure that <code>@target_obj</code> stays alive as long as
+ * The caller must ensure that @target_obj stays alive as long as
  * this property exists.  In the case of a child object or an alias on the same
  * object this will be the case.  For aliases to other objects the caller is
  * responsible for taking a reference.
-- 
2.26.2


