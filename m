Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCC7C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 21:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE3E208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 21:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKbPINPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE3E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPXyT-0000py-Ag
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 17:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXkp-0000EP-5a
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 17:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXkj-0007UY-92
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 17:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601932236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrGBXwYPvVUK3Z/wlHGaca4o9hAswgl9cl/WwDh4d1E=;
 b=HKbPINPDOLrhwS0CY83kPFbvSOi6NG0lB728rJz3YKo9tX1MadKDxO42f5rAmrwKtoNRqO
 WGxmrT3ptgPqJm5YQJTMGRDhOX+3Ug3vmmzMT4UT9odFG2q7fegKtCRj2k3tUnTP7Sv9JO
 FLgOsaQK41lrVmci9T78R9tosWvbsdE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-JDsxe8qwMRKxmgx5NgpD0w-1; Mon, 05 Oct 2020 17:10:34 -0400
X-MC-Unique: JDsxe8qwMRKxmgx5NgpD0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42F7D18A8223;
 Mon,  5 Oct 2020 21:10:33 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0936B78807;
 Mon,  5 Oct 2020 21:10:32 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 16/21] docs/devel/qom: Avoid long lines
Date: Mon,  5 Oct 2020 17:09:55 -0400
Message-Id: <20201005211000.710404-17-ehabkost@redhat.com>
In-Reply-To: <20201005211000.710404-1-ehabkost@redhat.com>
References: <20201005211000.710404-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Long code lines don't look good in the rendered documents, make
them shorter.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20201003025424.199291-7-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/devel/qom.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 0c610e20d62..42d0dc4f4da 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -284,7 +284,8 @@ in the header file:
 .. code-block:: c
    :caption: Declaring a simple type
 
-   OBJECT_DECLARE_SIMPLE_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
+   OBJECT_DECLARE_SIMPLE_TYPE(MyDevice, my_device,
+                              MY_DEVICE, DEVICE)
 
 This is equivalent to the following:
 
@@ -360,7 +361,8 @@ This accepts an array of interface type names.
 
    OBJECT_DEFINE_TYPE_WITH_INTERFACES(MyDevice, my_device,
                                       MY_DEVICE, DEVICE,
-                                      { TYPE_USER_CREATABLE }, { NULL })
+                                      { TYPE_USER_CREATABLE },
+                                      { NULL })
 
 If the type is not intended to be instantiated, then then
 the OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
@@ -368,7 +370,8 @@ the OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
 .. code-block:: c
    :caption: Defining a simple abstract type
 
-   OBJECT_DEFINE_ABSTRACT_TYPE(MyDevice, my_device, MY_DEVICE, DEVICE)
+   OBJECT_DEFINE_ABSTRACT_TYPE(MyDevice, my_device,
+                               MY_DEVICE, DEVICE)
 
 
 
-- 
2.26.2


