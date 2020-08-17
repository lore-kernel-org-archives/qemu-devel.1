Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086B8C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A861520748
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfgAoNR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A861520748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gIe-0007dD-Rb
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGQ-0002ss-Rb
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:30 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGP-00060M-7H
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:30 -0400
Received: by mail-wr1-x443.google.com with SMTP id r4so15221890wrx.9
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=I9hKuV+4GxIHdg4f78rZx+b5318hCEMxJMS+IR9ty5w=;
 b=qfgAoNR9qrlEA0cZUTQAWbQt+Zh6MCVgGi9ZUMB1yFzcqRUa2RJ/pVgO42Y9Jd/FRE
 QfbvZov6uuLJ4z13SOdD4RTwVwID4E64RvG10SOK7KvS9cK8bdwbltdIJI+b5bTmmm5x
 FLfHUyJq64uZqO8BFnkP35cS4xhu12HmQKB1NRnMA9/XbvxlSyewZ3RMzZSp7jvlh2N7
 Hwwi5hrm7zPpnr/jAvJgyR3+KWta/5w0vZaCFt02lbEMR06MFReTKrgIydf7nDvhegpK
 ZmA8LEO+KEF2ZE/ifl1wJjYVuTX/1Aa5MmyVOv8kQBjUBci9MojO3YEbdrDrT+DRwcap
 sf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=I9hKuV+4GxIHdg4f78rZx+b5318hCEMxJMS+IR9ty5w=;
 b=ej8O/0UrdL7TkYOAvLo6rxUkEM77zA9tkWMhZzrKrU71TOmMFw9hncddKo4qofB/Mg
 OSocwAvaqMh6Hvx4JDUy1wHWAHPUXthmDWiRwolkFSMpLUgmaoIq68nDbBjhmksAArqe
 T7/gfpcQrLZ5WKJDNGQMtMh9G7OW3tmMJrb20NwuXgUkJ+48Jo6DyY1PV4kWKy9cifJX
 HjrA58d6GiTTA5s1MHRUDmMvWLuJxiiDefM2YfmOpO6qpdwmyL4lBKjzL1+A1RzN6+Wh
 5jiNTgo+YhbLcQwrl7VAWM95pRHoGzLnQFX5JHQne8R1VmVLr2vDvSLE5IDUi9xeoaqi
 1ryQ==
X-Gm-Message-State: AOAM532yJL+huWHBEUa7mCDQkY3RYz+SEhmt49n3nU9qVNX30YL0ZrcD
 oYPz5uCQyvj60jrlOlv6OrqY/ttReIk=
X-Google-Smtp-Source: ABdhPJwH1pa+jFAWIQiAGIDBAi2e6Iz/MukJOCvV24dJEgPpFK0ryYAJ5jSd6y2AGvGZwZkjAc+SWA==
X-Received: by 2002:adf:fb87:: with SMTP id a7mr16895120wrr.390.1597675046933; 
 Mon, 17 Aug 2020 07:37:26 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.26 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 001/150] oss-fuzz/build: remove LIB_FUZZING_ENGINE
Date: Mon, 17 Aug 2020 16:34:54 +0200
Message-Id: <20200817143723.343284-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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



