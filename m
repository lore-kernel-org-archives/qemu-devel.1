Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF3DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F6C207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0Sf7nXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F6C207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3x9-0007AU-13
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3fA-0001aj-L2
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40416
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f3-0003Wj-5R
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+zKMySlk4YZIJ/O1n57ROOJ5c8QQPrDl/sS9HNk9hw=;
 b=g0Sf7nXa0HZ10Jr2KYlqAAnbbwJ68Lj+RRdTsfHttGfGyDa5TQyWLxZLEXIbg66Vt40r7H
 LuG2EWZX36hzCNu9S4V4zrWwFVn5X7aN5TC3vw4t47RcJlVvjjSuDxXSJg/7LoMeV7AWJH
 3wOqA+AxVEM+n2pYLo//y2oOBP6YLqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-mPjkXBFQNCuVgoI_BbJUsw-1; Tue, 19 May 2020 10:56:01 -0400
X-MC-Unique: mPjkXBFQNCuVgoI_BbJUsw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDE7E1855A03
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:56:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCCF66442A;
 Tue, 19 May 2020 14:56:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 68C09113522E; Tue, 19 May 2020 16:55:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 49/55] sysbus: sysbus_init_child_obj() is now unused, drop
Date: Tue, 19 May 2020 16:55:45 +0200
Message-Id: <20200519145551.22836-50-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/sysbus.h | 17 -----------------
 hw/core/sysbus.c    |  8 --------
 2 files changed, 25 deletions(-)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 606095ba35..da9f85c58c 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -93,23 +93,6 @@ MemoryRegion *sysbus_address_space(SysBusDevice *dev);
 bool sysbus_realize(SysBusDevice *dev, Error **errp);
 bool sysbus_realize_and_unref(SysBusDevice *dev, Error **errp);
 
-/**
- * sysbus_init_child_obj:
- * @parent: The parent object
- * @childname: Used as name of the "child<>" property in the parent
- * @child: A pointer to the memory to be used for the object.
- * @childsize: The maximum size available at @child for the object.
- * @childtype: The name of the type of the object to instantiate.
- *
- * This function will initialize an object and attach it to the main system
- * bus. The memory for the object should have already been allocated. The
- * object will then be added as child to the given parent. The returned object
- * has a reference count of 1 (for the "child<...>" property from the parent),
- * so the object will be finalized automatically when the parent gets removed.
- */
-void sysbus_init_child_obj(Object *parent, const char *childname, void *child,
-                           size_t childsize, const char *childtype);
-
 /* Call func for every dynamically created sysbus device in the system */
 void foreach_dynamic_sysbus_device(FindSysbusDeviceFunc *func, void *opaque);
 
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 1220298e8f..70239b7e7d 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -355,14 +355,6 @@ BusState *sysbus_get_default(void)
     return main_system_bus;
 }
 
-void sysbus_init_child_obj(Object *parent, const char *childname, void *child,
-                           size_t childsize, const char *childtype)
-{
-    object_initialize_child_with_props(parent, childname, child, childsize,
-                                       childtype, &error_abort, NULL);
-    qdev_set_parent_bus(DEVICE(child), sysbus_get_default());
-}
-
 static void sysbus_register_types(void)
 {
     type_register_static(&system_bus_info);
-- 
2.21.1


