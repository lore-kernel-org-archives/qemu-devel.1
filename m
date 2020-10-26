Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB50C55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94C3922250
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlxLIwY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C3922250
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzco-00051L-Fb
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPO-00035H-M5
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37246)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPM-0006nV-KD
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=3+2K7QseZ31G6O6eGWPUSYWr2X8ySATmc361BMEOoFg=;
 b=YlxLIwY90rVjCOsUikMc7GCS46g48W6HRjSjSzAJJKeWKYEA9zwVpmjiOu6CzeEABXvpyf
 df9mbSBDVRt425EsksUCUKbgUfD0eBqBBosQLrRVcCFIhrO/aAwMz1feAmS5ovqM+nqy28
 FfD95OuhreQ1hjn1z2WJ7TZ1gO0nuB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-YbN6D2GmMrmp-c6tnWNT7g-1; Mon, 26 Oct 2020 06:07:15 -0400
X-MC-Unique: YbN6D2GmMrmp-c6tnWNT7g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B9C310E2184;
 Mon, 26 Oct 2020 10:07:14 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02C0F8B840;
 Mon, 26 Oct 2020 10:07:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 25/31] scripts/oss-fuzz: ignore the generic-fuzz target
Date: Mon, 26 Oct 2020 11:06:26 +0100
Message-Id: <20201026100632.212530-26-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

generic-fuzz is not a standalone fuzzer - it requires some env variables
to be set. On oss-fuzz, we set these with some predefined
generic-fuzz-{...} targets, that are thin wrappers around generic-fuzz.
Do not make a link for the generic-fuzz from the oss-fuzz build, so
oss-fuzz does not treat it as a standalone fuzzer.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20201023150746.107063-18-alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
[thuth: Reformatted one comment to stay within the 80 columns limit]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/oss-fuzz/build.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index 0ce2867732..fcae4a0c26 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -99,8 +99,14 @@ cp "./qemu-fuzz-i386" "$DEST_DIR/bin/"
 # executable name)
 for target in $(./qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
 do
-    ln  "$DEST_DIR/bin/qemu-fuzz-i386" \
-        "$DEST_DIR/qemu-fuzz-i386-target-$target"
+    # Ignore the generic-fuzz target, as it requires some environment variables
+    # to be configured. We have some generic-fuzz-{pc-q35, floppy, ...} targets
+    # that are thin wrappers around this target that set the required
+    # environment variables according to predefined configs.
+    if [ "$target" != "generic-fuzz" ]; then
+        ln  "$DEST_DIR/bin/qemu-fuzz-i386" \
+            "$DEST_DIR/qemu-fuzz-i386-target-$target"
+    fi
 done
 
 echo "Done. The fuzzers are located in $DEST_DIR"
-- 
2.18.2


