Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5235DC43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A14552076D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 13:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJ+sck6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A14552076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kShG4-0007Hl-EX
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 09:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kShEa-0005uy-Oy
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kShEW-0000bf-S6
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 09:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602683664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nyXlG61ofguEsUwQVhnQMBDJF6A4CqiTQdIuGm+a+mw=;
 b=YJ+sck6t4f61zYyTs6O8AKmq6kr4GSMLfGk3mLT4psOevPeZq/ErP8lsAU4LPfnCYdX4Y9
 pC4FMDhsl9QhXxF7Pplh/FCW9frV6AKVtxObIezoYIdPJoRJv4ZmWQucvGvUf9wG1FRUF4
 rHpwRfNh6RqCdOpsl5hoxq8IxpP2mjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-hDYz5-tCM66T-DztsUadzQ-1; Wed, 14 Oct 2020 09:54:21 -0400
X-MC-Unique: hDYz5-tCM66T-DztsUadzQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 526E41084D6A;
 Wed, 14 Oct 2020 13:54:20 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D158760C15;
 Wed, 14 Oct 2020 13:54:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] tests: add missing generated sources to testqapi
Date: Wed, 14 Oct 2020 09:54:12 -0400
Message-Id: <20201014135416.1290679-4-pbonzini@redhat.com>
In-Reply-To: <20201014135416.1290679-1-pbonzini@redhat.com>
References: <20201014135416.1290679-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: berrange@redhat.com, alex.bennee@linaro.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ninja notices them due to a different order in visiting the graph.

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



