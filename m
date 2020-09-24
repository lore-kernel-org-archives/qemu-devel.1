Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED67C4727D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65AC3221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esTEjMgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65AC3221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLO74-0008Sd-D1
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUS-0002nP-Bf
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNUP-0006Bx-GM
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FRpFA2P7IfC6WfO047C+ygVzFYlCMRb/VByphnkkYsQ=;
 b=esTEjMgt3so/C20LNtFxLp8H40XdqkhxiThhhHWnYKrX9mEVdRyzqc9YPAAAZ3aweEb74+
 sWKN0dERzlJj6QjxEllVO7bQbXnbJCqX8xtF7unuxSIhth2XRJKbS4HmHSZfPMpRvm2Mo6
 51ora6AGG2f0itJ1Kzv+gACfpB0cqcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337--6AYhX73M6O4BgfTPw0wgw-1; Thu, 24 Sep 2020 05:24:31 -0400
X-MC-Unique: -6AYhX73M6O4BgfTPw0wgw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21558104D3F3
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:24:30 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D74F15C1C7;
 Thu, 24 Sep 2020 09:24:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 70/92] qom: Reformat section titles using Sphinx syntax
Date: Thu, 24 Sep 2020 05:22:52 -0400
Message-Id: <20200924092314.1722645-71-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200910221526.10041-6-ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index c6e3d5d80c..5418464de4 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -120,7 +120,8 @@ typedef struct InterfaceInfo InterfaceInfo;
  *   </programlisting>
  * </example>
  *
- * # Class Initialization #
+ * Class Initialization
+ * ====================
  *
  * Before an object is initialized, the class for the object must be
  * initialized.  There is only one class object for all instance objects
@@ -193,7 +194,8 @@ typedef struct InterfaceInfo InterfaceInfo;
  *   </programlisting>
  * </example>
  *
- * # Interfaces #
+ * Interfaces
+ * ==========
  *
  * Interfaces allow a limited form of multiple inheritance.  Instances are
  * similar to normal types except for the fact that are only defined by
@@ -206,7 +208,8 @@ typedef struct InterfaceInfo InterfaceInfo;
  * an argument to a method on its corresponding SomethingIfClass, or to
  * dynamically cast it to an object that implements the interface.
  *
- * # Methods #
+ * Methods
+ * =======
  *
  * A <emphasis>method</emphasis> is a function within the namespace scope of
  * a class. It usually operates on the object instance by passing it as a
@@ -304,7 +307,8 @@ typedef struct InterfaceInfo InterfaceInfo;
  * The first example of such a QOM method was #CPUClass.reset,
  * another example is #DeviceClass.realize.
  *
- * # Standard type declaration and definition macros #
+ * Standard type declaration and definition macros
+ * ===============================================
  *
  * A lot of the code outlined above follows a standard pattern and naming
  * convention. To reduce the amount of boilerplate code that needs to be
-- 
2.26.2



