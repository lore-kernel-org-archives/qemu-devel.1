Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7C1C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 22:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5AE4208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 22:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQNVB1E4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AE4208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGUs0-0002sN-QA
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 18:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGUqx-0001XD-P5
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 18:15:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22371
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kGUqw-0002Yc-3d
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 18:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599776137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qXS3/olQEWE6olehVY6G/wq941xe6izMFWQeRubt6Cg=;
 b=eQNVB1E4IzFPdlO6j4VVu6YK7u0TwrKvTyhqMytcu2CBD8/K6wJ3ufxR043mcc6Da1uMSO
 y7N681BZ7sJr4WBnlOKBiqOeWYaprZnxZCz0u1d1sMCanPEHlVu2AUccFfZaZS03+FHV1w
 OEtjFW4hej2xtiW95k5qBeF4yTS75Io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-Tchw8kHqORabR0tVmEbyZg-1; Thu, 10 Sep 2020 18:15:35 -0400
X-MC-Unique: Tchw8kHqORabR0tVmEbyZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4348D1084C83;
 Thu, 10 Sep 2020 22:15:34 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C13675121;
 Thu, 10 Sep 2020 22:15:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/9] qom: Reformat section titles using Sphinx syntax
Date: Thu, 10 Sep 2020 18:15:22 -0400
Message-Id: <20200910221526.10041-6-ehabkost@redhat.com>
In-Reply-To: <20200910221526.10041-1-ehabkost@redhat.com>
References: <20200910221526.10041-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 18:15:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qom/object.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index d2eecdf872..da9ecb310f 100644
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


