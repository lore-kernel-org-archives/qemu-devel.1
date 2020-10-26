Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF22C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 415BA22242
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2WUgqQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415BA22242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2xm-0008Sz-C5
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2uV-0005dC-5v
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX2uS-0001kZ-OF
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603720295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=coKSwh4fjQ6X/TbCrHi9+z7SCn+lHpMXhr4LMvtL/a8=;
 b=A2WUgqQnCnKdfxTFMHslVtwrhyDRvKwud7y+J+Y79X9a9jI8ZoOJqOAB0OmfZTNcW6QHTP
 neFCn97pjT3gs7gS675H/IU8DPiV7dTu8LRg3QB1ivfCOjG7LXofUDALzx5yHXJDCifJLR
 Vn9gCHSZ0ol6rVRrfSO0o1j+Iu0S9nk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-1u5LrO1zNzGQgCEwxOf9yg-1; Mon, 26 Oct 2020 09:51:33 -0400
X-MC-Unique: 1u5LrO1zNzGQgCEwxOf9yg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04394EC1C9
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:51:33 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDC4B6EF78
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:51:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/17] do not use colons in test names
Date: Mon, 26 Oct 2020 09:51:17 -0400
Message-Id: <20201026135131.3006712-4-pbonzini@redhat.com>
In-Reply-To: <20201026135131.3006712-1-pbonzini@redhat.com>
References: <20201026135131.3006712-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
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
 tests/fp/meson.build    | 6 +++---
 tests/qtest/meson.build | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/fp/meson.build b/tests/fp/meson.build
index 24739ad421..3d4fb00f9d 100644
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
@@ -612,13 +612,13 @@ endforeach
 #        extF80_{mulAdd} (missing)
 foreach k, v : softfloat_tests
   extF80_broken = ['lt_quiet', 'rem'].contains(k)
-  test('fp-test:' + k, fptest,
+  test('fp-test-' + k, fptest,
        args: fptest_args + fptest_rounding_args +
              ['f16_' + k, 'f32_' + k, 'f64_' + k, 'f128_' + k] +
              (extF80_broken ? [] : ['extF80_' + k]),
        suite: ['softfloat', 'softfloat-' + v])
 endforeach
-test('fp-test:mulAdd', fptest,
+test('fp-test-mulAdd', fptest,
      # no fptest_rounding_args
      args: fptest_args +
            ['f16_mulAdd', 'f32_mulAdd', 'f64_mulAdd', 'f128_mulAdd'],
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 28d4068718..4e0d9e24aa 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -251,7 +251,7 @@ foreach dir : target_dirs
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



