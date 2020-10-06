Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC23C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 22:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66252208C7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 22:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpxqLW9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66252208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPvNw-0005Ra-C8
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 18:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPv9w-0006yi-8o
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 18:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPv9o-0006Qo-C8
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 18:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602022202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33Q2Vi1AhdpNi+URew9hE9hNBXhtoc0//Oh0Xh/8tIo=;
 b=MpxqLW9Z67jsUNVKSwIO/Kj4mES9PWeg59OGOu46bB2PgAKxSb3X4K49xvGONMtvPsI4/i
 31bQgM7HvotTtEn1P26SG9nTIsKeFOD1QKzGWJe/UDiO7XE4LbKF/CnT0pB4OzJ9CdR4Wn
 Cp3jpbyAT6WbmrD6y0njynwdD+jTUvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-8c4qQTj4OVyUknBhmVpIaQ-1; Tue, 06 Oct 2020 18:09:59 -0400
X-MC-Unique: 8c4qQTj4OVyUknBhmVpIaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A008B18829D4;
 Tue,  6 Oct 2020 22:09:58 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62C3E6EF47;
 Tue,  6 Oct 2020 22:09:58 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 18/21] qom: Explicitly tag doc comments for typedefs and structs
Date: Tue,  6 Oct 2020 18:09:27 -0400
Message-Id: <20201006220930.908275-19-ehabkost@redhat.com>
In-Reply-To: <20201006220930.908275-1-ehabkost@redhat.com>
References: <20201006220930.908275-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
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

If we explicitly indicate we are documenting a typedef or a
struct, we'll be able to remove the $decl_type='type name' hack
from kernel-doc.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20201003024123.193840-4-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index e80092f349..d378f13a11 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -31,7 +31,7 @@ typedef struct InterfaceInfo InterfaceInfo;
 typedef struct ObjectProperty ObjectProperty;
 
 /**
- * ObjectPropertyAccessor:
+ * typedef ObjectPropertyAccessor:
  * @obj: the object that owns the property
  * @v: the visitor that contains the property data
  * @name: the name of the property
@@ -47,7 +47,7 @@ typedef void (ObjectPropertyAccessor)(Object *obj,
                                       Error **errp);
 
 /**
- * ObjectPropertyResolve:
+ * typedef ObjectPropertyResolve:
  * @obj: the object that owns the property
  * @opaque: the opaque registered with the property
  * @part: the name of the property
@@ -66,7 +66,7 @@ typedef Object *(ObjectPropertyResolve)(Object *obj,
                                         const char *part);
 
 /**
- * ObjectPropertyRelease:
+ * typedef ObjectPropertyRelease:
  * @obj: the object that owns the property
  * @name: the name of the property
  * @opaque: the opaque registered with the property
@@ -78,7 +78,7 @@ typedef void (ObjectPropertyRelease)(Object *obj,
                                      void *opaque);
 
 /**
- * ObjectPropertyInit:
+ * typedef ObjectPropertyInit:
  * @obj: the object that owns the property
  * @prop: the property to set
  *
@@ -101,7 +101,7 @@ struct ObjectProperty
 };
 
 /**
- * ObjectUnparent:
+ * typedef ObjectUnparent:
  * @obj: the object that is being removed from the composition tree
  *
  * Called when an object is being removed from the QOM composition tree.
@@ -110,7 +110,7 @@ struct ObjectProperty
 typedef void (ObjectUnparent)(Object *obj);
 
 /**
- * ObjectFree:
+ * typedef ObjectFree:
  * @obj: the object being freed
  *
  * Called when an object's last reference is removed.
@@ -120,7 +120,7 @@ typedef void (ObjectFree)(void *obj);
 #define OBJECT_CLASS_CAST_CACHE 4
 
 /**
- * ObjectClass:
+ * struct ObjectClass:
  *
  * The base for all classes.  The only thing that #ObjectClass contains is an
  * integer type handle.
@@ -140,7 +140,7 @@ struct ObjectClass
 };
 
 /**
- * Object:
+ * struct Object:
  *
  * The base for all objects.  The first member of this object is a pointer to
  * a #ObjectClass.  Since C guarantees that the first member of a structure
@@ -370,7 +370,7 @@ struct Object
                                 true, { NULL })
 
 /**
- * TypeInfo:
+ * struct TypeInfo:
  * @name: The name of the type.
  * @parent: The name of the parent type.
  * @instance_size: The size of the object (derivative of #Object).  If
@@ -496,7 +496,7 @@ struct TypeInfo
     OBJECT_CLASS_CHECK(class, object_get_class(OBJECT(obj)), name)
 
 /**
- * InterfaceInfo:
+ * struct InterfaceInfo:
  * @type: The name of the interface.
  *
  * The information associated with an interface.
@@ -506,7 +506,7 @@ struct InterfaceInfo {
 };
 
 /**
- * InterfaceClass:
+ * struct InterfaceClass:
  * @parent_class: the base class
  *
  * The class for all interfaces.  Subclasses of this class should only add
-- 
2.26.2


