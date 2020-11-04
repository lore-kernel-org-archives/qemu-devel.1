Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97017C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDDD2072E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8HqeZqJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDDD2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKMF-0008HT-2n
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:05:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIh-00039E-BG
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIU-000625-TJ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604502122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYUhquvtGZWEyt/D5O2VVHS6S+Wd9m2Cfct82xQV++A=;
 b=Y8HqeZqJnStkwbDhHuNjxAvbQ1a0TN65AQ5/pNgeEp9jTGUX5cbyfbUddm5IbSYn6ndGqn
 0wJiOxt+w0jglkSxTuR0fWtp13pwVUYSwof8Y1ljHIOt6mLTU26J5AbuNB6dSPW5rTZ1Zn
 OfWA23rtjlbR4HJYM360seaUqu12CVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-NvtGDayXOTCWPGNtdPg8sA-1; Wed, 04 Nov 2020 10:01:57 -0500
X-MC-Unique: NvtGDayXOTCWPGNtdPg8sA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A9BD1016CE1;
 Wed,  4 Nov 2020 15:01:56 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C86B100750D;
 Wed,  4 Nov 2020 15:01:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/20] scripts/oss-fuzz: rename bin/qemu-fuzz-i386
Date: Wed,  4 Nov 2020 10:01:37 -0500
Message-Id: <20201104150153.541326-5-pbonzini@redhat.com>
In-Reply-To: <20201104150153.541326-1-pbonzini@redhat.com>
References: <20201104150153.541326-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

OSS-Fuzz changed the way it scans for fuzzers in $DEST_DIR. The new code
also scans subdirectories for fuzzers. This means that OSS-Fuzz is
considering bin/qemu-fuzz-i386 as an independent fuzzer (it is not - it
requires a --fuzz-target argument). This has led to coverage-build
failures and false crash reports. To work around this, we take advantage
of OSS-Fuzz' filename extension check - OSS-Fuzz will not run anything
that has an extension that is not ".exe":
https://github.com/google/oss-fuzz/blob/master/infra/utils.py#L115

Reported-by: OSS-Fuzz (Issue 26725)
Reported-by: OSS-Fuzz (Issue 26679)
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20201101212245.185819-1-alxndr@bu.edu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/oss-fuzz/build.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
index fcae4a0c26..3b1c82b63d 100755
--- a/scripts/oss-fuzz/build.sh
+++ b/scripts/oss-fuzz/build.sh
@@ -91,7 +91,7 @@ make "-j$(nproc)" qemu-fuzz-i386 V=1
 # Copy over the datadir
 cp  -r ../pc-bios/ "$DEST_DIR/pc-bios"
 
-cp "./qemu-fuzz-i386" "$DEST_DIR/bin/"
+cp "./qemu-fuzz-i386" "$DEST_DIR/bin/qemu-fuzz-i386.base"
 
 # Run the fuzzer with no arguments, to print the help-string and get the list
 # of available fuzz-targets. Copy over the qemu-fuzz-i386, naming it according
@@ -104,7 +104,7 @@ do
     # that are thin wrappers around this target that set the required
     # environment variables according to predefined configs.
     if [ "$target" != "generic-fuzz" ]; then
-        ln  "$DEST_DIR/bin/qemu-fuzz-i386" \
+        ln  "$DEST_DIR/bin/qemu-fuzz-i386.base" \
             "$DEST_DIR/qemu-fuzz-i386-target-$target"
     fi
 done
-- 
2.26.2



