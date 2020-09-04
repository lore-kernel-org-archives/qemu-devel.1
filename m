Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E351C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:04:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BAB620791
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAB620791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEARf-0000nA-7Z
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6y-0001DX-Ik
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51598
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kEA6u-0005J0-O1
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 07:42:32 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-_AfdZF4fNN2Q5Z1dcW_YNg-1; Fri, 04 Sep 2020 07:42:26 -0400
X-MC-Unique: _AfdZF4fNN2Q5Z1dcW_YNg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 496271084D9F;
 Fri,  4 Sep 2020 11:41:47 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0930310013C4;
 Fri,  4 Sep 2020 11:41:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 42/46] oss-fuzz: fix rpath
Date: Fri,  4 Sep 2020 07:41:18 -0400
Message-Id: <20200904114122.31307-43-pbonzini@redhat.com>
In-Reply-To: <20200904114122.31307-1-pbonzini@redhat.com>
References: <20200904114122.31307-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

Prior to this change,
readelf -d build/out/qemu/qemu-fuzz-i386-target-virtio-net-slirp
...
0x000000000000000f (RPATH)  Library rpath: ['$$ORIGIN/lib':$ORIGIN/migration:$ORIGIN/]

As of 1a4db552d8 ("ninjatool: quote dollars in variables"), we don't
need to manually double the dollars. Also, remove the single-quotes as
they are copied into the rpath.

After this change:
0x000000000000000f (RPATH)  Library rpath: [$ORIGIN/lib:$ORIGIN/migration:$ORIGIN/]

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200902142657.112879-3-alxndr@bu.edu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/oss-fuzz/build.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index f0b7442c96..d16207eb67 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -81,7 +81,7 @@ rm qemu-fuzz-i386
 # Build a second time to build the final binary with correct rpath
 ../configure --disable-werror --cc="$CC" --cxx="$CXX" --enable-fuzzing \
     --prefix="$DEST_DIR" --bindir="$DEST_DIR" --datadir="$DEST_DIR/data/" \
-    --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="-Wl,-rpath,'\$\$ORIGIN/lib'" \
+    --extra-cflags="$EXTRA_CFLAGS" --extra-ldflags="-Wl,-rpath,\$ORIGIN/lib" \
     --target-list="i386-softmmu"
 make "-j$(nproc)" qemu-fuzz-i386 V=1
 
-- 
2.26.2



