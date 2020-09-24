Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A814C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:19:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7971723600
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUk0AZ+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7971723600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOL7-00075u-Ho
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUO-0002cg-Bf
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUM-0006Bm-QC
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1yGgP/wnkoeiNvd9YE6GhujgEyLfDMjsnEUzEA74Obg=;
 b=IUk0AZ+PPhqfPe5NGUfru+OgnkUDcv2LRue31ZiR/HOJbT9v6A9A3uPrz3JU7hrjrWtQ76
 dVWIuW4B8yNztKrt2IScwyKxF+rAOSfwsVjqci2RPso3431AILiGTBhk9fXLjC392omhJs
 p8rrlG9DDWnjD9niE15/bxLRT9LJ5sQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-CBGqjGrFM8Kpb_PoZjq1Xg-1; Thu, 24 Sep 2020 05:24:28 -0400
X-MC-Unique: CBGqjGrFM8Kpb_PoZjq1Xg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 745DA871803
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:24:27 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC0FD61983;
 Thu, 24 Sep 2020 09:24:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 69/92] qom: Add kernel-doc markup to introduction doc comment
Date: Thu, 24 Sep 2020 05:22:51 -0400
Message-Id: <20200924092314.1722645-70-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

Add DOC: section keyword to introduction doc comment, so it will
be rendered by kernel-doc.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200910221526.10041-5-ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index f1e8cb5398..c6e3d5d80c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -29,9 +29,7 @@ typedef struct InterfaceInfo InterfaceInfo;
 #define TYPE_OBJECT "object"
 
 /**
- * SECTION:object.h
- * @title:Base Object Type System
- * @short_description: interfaces for creating new types and objects
+ * DOC:
  *
  * The QEMU Object Model provides a framework for registering user creatable
  * types and instantiating objects from those types.  QOM provides the following
-- 
2.26.2



