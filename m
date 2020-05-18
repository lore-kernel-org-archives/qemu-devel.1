Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546EBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A46A205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQE2lzbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A46A205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jabEx-0006nl-9r
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 04:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jabDA-0004Hh-Tn
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:33:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46481
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jabDA-0005vE-3K
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589790803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=xgGz94sVb4d0ezexUgevgjLRHz035twUg3/hSMAyx78=;
 b=VQE2lzbcM4ZZh8/7OOGt5WBEhSiI73jfOcjcQp23iBGDfg2umiyj5fdoIji3Y4bAxxaPhp
 5oA6Hpdgjx+bjhapzzksHdV5O/QytRL7LmOos5KUgGnxKKWd/enC0RlNUzwmVyVTOFOOWN
 OqlvlUhRV3VcKHV3Y7rWK385JdNl6nE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-whazOjatMZK3x6JjO7oCSw-1; Mon, 18 May 2020 04:33:21 -0400
X-MC-Unique: whazOjatMZK3x6JjO7oCSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6B86800D24;
 Mon, 18 May 2020 08:33:20 +0000 (UTC)
Received: from thuth.com (ovpn-112-182.ams2.redhat.com [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC99E64453;
 Mon, 18 May 2020 08:33:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] travis.yml: Use clang++ in the Clang tests
Date: Mon, 18 May 2020 10:33:16 +0200
Message-Id: <20200518083316.25065-2-thuth@redhat.com>
In-Reply-To: <20200518083316.25065-1-thuth@redhat.com>
References: <20200518083316.25065-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:51:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our configure script does not look for clang++ automatically, so we
should use --cxx=clang++ to make sure that we test our C++ code with
Clang, too. And while we're at it, also use --host-cc=clang here
to avoid that we use the normal "cc" as host C compiler.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 1ec8a7b465..564be50a3c 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -205,14 +205,15 @@ jobs:
     # Test with Clang for compile portability (Travis uses clang-5.0)
     - name: "Clang (user)"
       env:
-        - CONFIG="--disable-system"
+        - CONFIG="--disable-system --host-cc=clang --cxx=clang++"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
       compiler: clang
 
 
     - name: "Clang (main-softmmu)"
       env:
-        - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS} "
+        - CONFIG="--target-list=${MAIN_SOFTMMU_TARGETS}
+                  --host-cc=clang --cxx=clang++"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-sanitize"
       compiler: clang
       before_script:
@@ -222,7 +223,8 @@ jobs:
 
     - name: "Clang (other-softmmu)"
       env:
-        - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}"
+        - CONFIG="--disable-user --target-list-exclude=${MAIN_SOFTMMU_TARGETS}
+                  --host-cc=clang --cxx=clang++"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-clang-default"
       compiler: clang
 
-- 
2.18.1


