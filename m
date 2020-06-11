Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4B1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:57:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F04207ED
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIn2ro1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F04207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTKO-0001dM-Ae
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 15:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8i-0007ii-8Q
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58498
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT8f-0000ye-R6
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEfu+WKuLGTbcmW54phLurwiymXP59SyP07hImE7S0M=;
 b=WIn2ro1FvI5zpEXkpJBHRtUIm4mUteFpVlXGHCV7nj4+V1UtSqvdtSzigavCTgtcaPJgkB
 7u8UEfbnV7gUus2IzapNmd2MVu25ZlXAyxPfkiWyUTUucilC1IK7YjMtJW8X40Vv3n7BrU
 pgjBvUu0LgWZLQ3AhhxXkc95WO76Qfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-WNYUUgg-OfCTuxpns4ZYZg-1; Thu, 11 Jun 2020 15:44:54 -0400
X-MC-Unique: WNYUUgg-OfCTuxpns4ZYZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8003584638E;
 Thu, 11 Jun 2020 19:44:53 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27AFC5EE0E;
 Thu, 11 Jun 2020 19:44:53 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 005/115] run-coverity-scan: add --no-update-tools option
Date: Thu, 11 Jun 2020 15:42:59 -0400
Message-Id: <20200611194449.31468-6-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide a quick way to skip building the container while we figure out how
to get caching right.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/coverity-scan/run-coverity-scan | 37 +++++++++++++++----------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
index e926623b3b..bc9e12670b 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -33,6 +33,7 @@
 #   --docker-engine : specify the container engine to use (docker/podman/auto);
 #                     implies --docker
 #   --update-tools-only : update the cached copy of the tools, but don't run them
+#   --no-update-tools : do not update the cached copy of the tools
 #   --tokenfile : file to read Coverity token from
 #   --version ver : specify version being analyzed (default: ask git)
 #   --description desc : specify description of this version (default: ask git)
@@ -130,7 +131,7 @@ update_coverity_tools () {
 
 # Check user-provided environment variables and arguments
 DRYRUN=no
-UPDATE_ONLY=no
+UPDATE=yes
 DOCKER=no
 
 while [ "$#" -ge 1 ]; do
@@ -139,9 +140,13 @@ while [ "$#" -ge 1 ]; do
             shift
             DRYRUN=yes
             ;;
+        --no-update-tools)
+            shift
+            UPDATE=no
+            ;;
         --update-tools-only)
             shift
-            UPDATE_ONLY=yes
+            UPDATE=only
             ;;
         --version)
             shift
@@ -245,12 +250,12 @@ fi
 PROJNAME=QEMU
 TARBALL=cov-int.tar.xz
 
-if [ "$UPDATE_ONLY" = yes ] && [ "$DOCKER" = yes ]; then
+if [ "$UPDATE" = only ] && [ "$DOCKER" = yes ]; then
     echo "Combining --docker and --update-only is not supported"
     exit 1
 fi
 
-if [ "$UPDATE_ONLY" = yes ]; then
+if [ "$UPDATE" = only ]; then
     # Just do the tools update; we don't need to check whether
     # we are in a source tree or have upload rights for this,
     # so do it before some of the command line and source tree checks.
@@ -293,7 +298,6 @@ fi
 
 # Run ourselves inside docker if that's what the user wants
 if [ "$DOCKER" = yes ]; then
-    # build docker container including the coverity-scan tools
     # Put the Coverity token into a temporary file that only
     # we have read access to, and then pass it to docker build
     # using a volume.  A volume is enough for the token not to
@@ -308,14 +312,17 @@ if [ "$DOCKER" = yes ]; then
     echo "Created temporary directory $SECRETDIR"
     SECRET="$SECRETDIR/token"
     echo "$COVERITY_TOKEN" > "$SECRET"
-    echo "Building docker container..."
-    # TODO: This re-downloads the tools every time, rather than
-    # caching and reusing the image produced with the downloaded tools.
-    # Not sure why.
-    tests/docker/docker.py --engine ${DOCKER_ENGINE} build \
-                   -t coverity-scanner -f scripts/coverity-scan/coverity-scan.docker \
-                   -v "$SECRETDIR:/work" \
-                   --extra-files scripts/coverity-scan/run-coverity-scan
+    if [ "$UPDATE" != no ]; then
+        # build docker container including the coverity-scan tools
+        echo "Building docker container..."
+        # TODO: This re-downloads the tools every time, rather than
+        # caching and reusing the image produced with the downloaded tools.
+        # Not sure why.
+        tests/docker/docker.py --engine ${DOCKER_ENGINE} build \
+                       -t coverity-scanner -f scripts/coverity-scan/coverity-scan.docker \
+                       -v "$SECRETDIR:/work" \
+                       --extra-files scripts/coverity-scan/run-coverity-scan
+    fi
     echo "Archiving sources to be analyzed..."
     ./scripts/archive-source.sh "$SECRETDIR/qemu-sources.tgz"
     if [ "$DRYRUN" = yes ]; then
@@ -350,7 +357,9 @@ fi
 
 check_upload_permissions
 
-update_coverity_tools
+if [ "$UPDATE" != no ]; then
+    update_coverity_tools
+fi
 
 TOOLBIN="$(cd "$COVERITY_TOOL_BASE" && echo $PWD/coverity_tool/cov-analysis-*/bin)"
 
-- 
2.26.2



