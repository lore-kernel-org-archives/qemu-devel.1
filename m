Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AC6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 12:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24F72083B
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 12:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U52ix8zM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24F72083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTOQh-0001T7-Ox
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 08:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTODg-0000Oh-2e
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:48:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTODc-0002nw-2d
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602848899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9z/m4ESTg5T+PETE/Wuky1JefDySUw5SrCPfc7Rt9E=;
 b=U52ix8zMLD4z+FvNjylkA87Ly3zA5fxToiuXzJ3vwQleHCi1UWSmU32SfxbfIwRakWC20X
 7iY36HOhCPHoFF15f+NiV9FncYgZ4ZiiAlZ8XSO+t7u+SfFGD/rkBF/N62n7FEReDa8thl
 HcHT0t3NGi87o5CQ9O+VAsyndcnkzUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-DqwN_q79OTa-_BU6UlihbA-1; Fri, 16 Oct 2020 07:48:17 -0400
X-MC-Unique: DqwN_q79OTa-_BU6UlihbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8988800683
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 11:48:16 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 694F97667A;
 Fri, 16 Oct 2020 11:48:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/22] tests: add missing generated sources to testqapi
Date: Fri, 16 Oct 2020 07:47:57 -0400
Message-Id: <20201016114814.1564523-6-pbonzini@redhat.com>
In-Reply-To: <20201016114814.1564523-1-pbonzini@redhat.com>
References: <20201016114814.1564523-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 03:57:19
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ninja notices them due to a different order in visiting the graph.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/include/meson.build |  8 ++++----
 tests/meson.build         | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tests/include/meson.build b/tests/include/meson.build
index fea3a6342f..9abba308fa 100644
--- a/tests/include/meson.build
+++ b/tests/include/meson.build
@@ -10,7 +10,7 @@ test_qapi_outputs_extra = [
   'test-qapi-visit-sub-module.h',
 ]
 
-test_qapi_outputs_extra = custom_target('QAPI test (include)',
-                                        output: test_qapi_outputs_extra,
-                                        input: test_qapi_files,
-                                        command: 'true')
+test_qapi_files_extra = custom_target('QAPI test (include)',
+                                      output: test_qapi_outputs_extra,
+                                      input: test_qapi_files,
+                                      command: 'true')
diff --git a/tests/meson.build b/tests/meson.build
index bf47a38c74..afeb6be689 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -56,8 +56,18 @@ test_qapi_files = custom_target('Test QAPI files',
 # perhaps change qapi_gen to replace / with _, like Meson itself does?
 subdir('include')
 
-libtestqapi = static_library('testqapi', sources: [test_qapi_files, genh, test_qapi_outputs_extra])
-testqapi = declare_dependency(link_with: libtestqapi)
+test_qapi_sources = []
+test_qapi_headers = []
+i = 0
+foreach o: test_qapi_files.to_list() + test_qapi_files_extra.to_list()
+  if o.full_path().endswith('.h')
+    test_qapi_headers += o
+  endif
+  test_qapi_sources += o
+endforeach
+
+libtestqapi = static_library('testqapi', sources: [genh, test_qapi_sources])
+testqapi = declare_dependency(link_with: libtestqapi, sources: [genh, test_qapi_headers])
 
 testblock = declare_dependency(dependencies: [block], sources: 'iothread.c')
 
-- 
2.26.2



