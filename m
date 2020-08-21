Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4968C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E76020732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 10:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c76hQ2qK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E76020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k94E2-00023y-PC
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 06:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Cu-0000Kb-Jx
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:23:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30896
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k94Cs-0001P2-0m
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 06:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598005413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I9hKuV+4GxIHdg4f78rZx+b5318hCEMxJMS+IR9ty5w=;
 b=c76hQ2qKt1RPxPyxhqEoD4H0gs+LBO/mDVAWIHzSPmO+Tb6UdLZe6A7udrrVeBU4POdGhO
 twSSYN0kaB4dOKunXnm9+kt2BTpRvYzwYICGjCSI61wchXdpFvcNtCjJvNPffnYjUwHKtG
 eMPIQWUa8jAOuFUaAH6j/vcvSkkgWyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-cUbZjK8eNjSIJMgz6FMDLA-1; Fri, 21 Aug 2020 06:23:31 -0400
X-MC-Unique: cUbZjK8eNjSIJMgz6FMDLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B4CB1014DF9
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:23:30 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A51619C78
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:23:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v8 001/152] oss-fuzz/build: remove LIB_FUZZING_ENGINE
Date: Fri, 21 Aug 2020 06:20:58 -0400
Message-Id: <20200821102329.29777-2-pbonzini@redhat.com>
In-Reply-To: <20200821102329.29777-1-pbonzini@redhat.com>
References: <20200821102329.29777-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:55:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

Meson build scripts will only include qemu-fuzz-TARGET rules if configured
with --enable-fuzzing, and that takes care of adding -fsanitize=fuzzer.
Therefore we can just specify the configure option and stop modifying
the CFLAGS and CONFIG_FUZZ options in the "make" invocation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/oss-fuzz/build.sh | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index a07b3022e8..52430cb620 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -20,7 +20,7 @@
 # e.g.
 # $CXX $CXXFLAGS -std=c++11 -Iinclude \
 #     /path/to/name_of_fuzzer.cc -o $OUT/name_of_fuzzer \
-#     $LIB_FUZZING_ENGINE /path/to/library.a
+#     -fsanitize=fuzzer /path/to/library.a
 
 fatal () {
     echo "Error : ${*}, exiting."
@@ -54,10 +54,6 @@ mkdir -p $OSS_FUZZ_BUILD_DIR || fatal "mkdir $OSS_FUZZ_BUILD_DIR failed"
 cd $OSS_FUZZ_BUILD_DIR || fatal "cd $OSS_FUZZ_BUILD_DIR failed"
 
 
-if [ -z ${LIB_FUZZING_ENGINE+x} ]; then
-    LIB_FUZZING_ENGINE="-fsanitize=fuzzer"
-fi
-
 if [ -z ${OUT+x} ]; then
     DEST_DIR=$(realpath "./DEST_DIR")
 else
@@ -67,14 +63,12 @@ fi
 mkdir -p "$DEST_DIR/lib/"  # Copy the shared libraries here
 
 # Build once to get the list of dynamic lib paths, and copy them over
-../configure --disable-werror --cc="$CC" --cxx="$CXX" \
+../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
     --extra-cflags="$EXTRA_CFLAGS" --target-list="i386-softmmu"
 
-if ! make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" "-j$(nproc)" \
-    i386-softmmu/fuzz; then
+if ! make "-j$(nproc)" i386-softmmu/fuzz; then
     fatal "Build failed. Please specify a compiler with fuzzing support"\
-          "using the \$CC and \$CXX environemnt variables, or specify a"\
-          "\$LIB_FUZZING_ENGINE compatible with your compiler"\
+          "using the \$CC and \$CXX environemnt variables"\
           "\nFor example: CC=clang CXX=clang++ $0"
 fi
 
@@ -87,7 +81,7 @@ rm ./i386-softmmu/qemu-fuzz-i386
 ../configure --bindir="$DEST_DIR" --datadir="$DEST_DIR/data/" --disable-werror \
     --cc="$CC" --cxx="$CXX" --extra-cflags="$EXTRA_CFLAGS" \
     --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'"
-make CONFIG_FUZZ=y CFLAGS="$LIB_FUZZING_ENGINE" "-j$(nproc)" i386-softmmu/fuzz
+make "-j$(nproc)" i386-softmmu/fuzz
 
 # Copy over the datadir
 cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
-- 
2.26.2



