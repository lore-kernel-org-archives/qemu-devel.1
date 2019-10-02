Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510C7C10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202DA21848
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8ex01ZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202DA21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFiKF-0003is-Vx
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrY-0005ju-QV
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrX-0003fC-Ql
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:28 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrX-0003en-Kr
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id n14so20461935wrw.9
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=9FxYLphVXY4uST+nxeWKafzobQ3LpK2O54/JNRyeh/U=;
 b=Q8ex01ZDvD42NilWySzXQwWTeTpDqiandsgRDwBY+TEklq8EAkWCJNFBTyM3dCwBZf
 hXi03Jv/JNBzNaSQYcCoEvHP6VxAYHs9NZjR91Xz2Znil0WUshrXMfcXFObW2CUYJHMo
 M0Vh5+pQf1PGx4PvvNrptWo0VCZp8lMIz7KLAyQFKmTGNC7INrL2wFAFdGf/3D43Mxgc
 nWyrtw42FfMFLKcZqa3bNW/Piy7sG6j6wlF7XsWASZ8Zn70vA1VGYZwUbRhxeVgUQPCV
 /1vkF6BIl+AZTY4Y9cQywEQ+M9RHYPY8BWsdw+PQ0BlqHw2jR7X+wGkrpE9MzfmioqLz
 1DYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=9FxYLphVXY4uST+nxeWKafzobQ3LpK2O54/JNRyeh/U=;
 b=gw4zWYByfBWHAwURxNW+7jdZLkgRqCxXBFSLmkOwVY7vfbKA1yHJFAVp7mkXstbhep
 gCPKsIGbh+wG9Artx+izKpay9KHGKoXOV9rwyj0q249yYcNOQfqGbImYhm89q/PLqtyz
 1La42PkIY8S5+gWXeQ8cLuQPI3ivGdRj3EHKXHL7lp1EBQM72dt8MY8o4PvT2DZ6J0CV
 vcx6BK8oTb88xrb32SNmTc26xZHpAdHIEJK9X+RAdqQ7AprtdpX9U13bTQV9y2EeVNjC
 28ncM4b1EYIBfpdvFWspYvrdUscfWXzz57YeoKd+QQ/u1PAu4wS4vV5cbs7fiZUCnFUb
 Sl2A==
X-Gm-Message-State: APjAAAWGhG48grqC8x9RYOV50cvbY/CwbFTsGQswFISOoyVtD3L5ElmI
 BNtUDaL+jeB6uOZstxPUA5AsDjei
X-Google-Smtp-Source: APXvYqy9TtJ0VViJOXweruFrA5TPOxCtFx5fakumBX2TGlfqSdCdFuhzs5D66P2z//bzzvcs5uAXKw==
X-Received: by 2002:a5d:4a52:: with SMTP id v18mr398185wrs.368.1570035146444; 
 Wed, 02 Oct 2019 09:52:26 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/30] tests/docker: only enable ubsan for test-clang
Date: Wed,  2 Oct 2019 18:51:52 +0200
Message-Id: <1570035113-56848-30-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

-fsanitize=undefined is not the same thing as --enable-sanitizers.  After
commit 47c823e ("tests/docker: add sanitizers back to clang build", 2019-09-11)
test-clang is almost duplicating the asan (test-debug) test, so
partly revert commit 47c823e5b while leaving ubsan enabled.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/test-clang | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/docker/test-clang b/tests/docker/test-clang
index db9e697..8c51ead 100755
--- a/tests/docker/test-clang
+++ b/tests/docker/test-clang
@@ -17,7 +17,9 @@ requires clang
 
 cd "$BUILD_DIR"
 
-OPTS="--cxx=clang++ --cc=clang --host-cc=clang --enable-sanitizers"
+OPTS="--cxx=clang++ --cc=clang --host-cc=clang"
+OPTS="$OPTS --extra-cflags=-fsanitize=undefined \
+    --extra-cflags=-fno-sanitize=float-divide-by-zero"
 build_qemu $OPTS
 check_qemu
 install_qemu
-- 
1.8.3.1



