Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EEDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8D522257
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhjWcUCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8D522257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTZk-0000JH-No
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUTXU-0007o5-4V
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kUTXO-0008Fs-5b
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603107671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rL4LkJrvxpzmkHLXsU0YL91P/ux/ccPkrguJPrDhEYQ=;
 b=LhjWcUCB/a9l26sIUf6LyWwcO1UZMlA16XiINmbTpFRwF9t4DlFaqziiFW9acpz+RKFkdq
 bZRHKAQq05ekTOTRKIuyX0JRyWD71O95ZQH31z5k3Z/2WLOlGjqsnEciU+ad1I/tnyoAlJ
 qLwWJgCYafRSqM3XXEdOy0pyayhOFnY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-goqw4IasNvCnH4WwkPyGnQ-1; Mon, 19 Oct 2020 07:41:09 -0400
X-MC-Unique: goqw4IasNvCnH4WwkPyGnQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECD5C846376
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 11:41:08 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B70355C1A3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 11:41:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] do not use colons in test names
Date: Mon, 19 Oct 2020 07:41:07 -0400
Message-Id: <20201019114108.1779369-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Starting with meson 0.56, colons are used to separate the subproject name
from the test name.  Use dash or slash depending on what looks nicer.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/fp/meson.build    | 4 ++--
 tests/qtest/meson.build | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/fp/meson.build b/tests/fp/meson.build
index 24739ad421..514e345bf5 100644
--- a/tests/fp/meson.build
+++ b/tests/fp/meson.build
@@ -603,7 +603,7 @@ fptest_rounding_args = ['-r', 'all']
 # FIXME: i32_to_extF80 (broken), i64_to_extF80 (broken)
 #        extF80_roundToInt (broken)
 foreach k, v : softfloat_conv_tests
-  test('fp-test:' + k, fptest,
+  test('fp-test-' + k, fptest,
        args: fptest_args + fptest_rounding_args + v.split(),
        suite: ['softfloat', 'softfloat-conv'])
 endforeach
@@ -612,7 +612,7 @@ endforeach
 #        extF80_{mulAdd} (missing)
 foreach k, v : softfloat_tests
   extF80_broken = ['lt_quiet', 'rem'].contains(k)
-  test('fp-test:' + k, fptest,
+  test('fp-test-' + k, fptest,
        args: fptest_args + fptest_rounding_args +
              ['f16_' + k, 'f32_' + k, 'f64_' + k, 'f128_' + k] +
              (extF80_broken ? [] : ['extF80_' + k]),
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 3987f96086..c2822d9de7 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -250,7 +250,7 @@ foreach dir : target_dirs
       }
     endif
     # FIXME: missing dependency on the emulator binary and qemu-img
-    test('qtest-@0@: @1@'.format(target_base, test),
+    test('qtest-@0@/@1@'.format(target_base, test),
          qtest_executables[test],
          depends: [test_deps, qtest_emulator],
          env: qtest_env,
-- 
2.26.2


