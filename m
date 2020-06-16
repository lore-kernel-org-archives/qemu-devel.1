Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02492C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DB32074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 09:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZfg81Cy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DB32074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl7WA-0005Jj-VQ
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 05:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jl7QR-0006rW-Tz
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:58:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23460
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jl7QQ-0002EI-6A
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592297913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yf9bcWcOt1wtgkfpnUND5IWaNOodbWud8g0oiDPKNS8=;
 b=NZfg81CyClbZIALJY1H4nGjtonm5kdGKvWW3g2N9PrzYoFM+ssu2kshAbr3t17qSFs3Ql5
 Brq7uSuDHPSGoFRyPQpWVdSLz9yhYFa9kURd1RMuq+V6YX2fW6MrqThMl6sdnENkZUqnE+
 5GRMWAwEoaJWrTAd9XCwJ7P4J9m9lew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-UikDMSUbOR-EOBUN6o-NJQ-1; Tue, 16 Jun 2020 04:58:28 -0400
X-MC-Unique: UikDMSUbOR-EOBUN6o-NJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D8B31009454;
 Tue, 16 Jun 2020 08:58:27 +0000 (UTC)
Received: from thuth.com (ovpn-114-128.ams2.redhat.com [10.36.114.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2311B768DC;
 Tue, 16 Jun 2020 08:58:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 7/7] configure: Let SLOF be initialized by
 ./scripts/git-submodule.sh
Date: Tue, 16 Jun 2020 10:58:13 +0200
Message-Id: <20200616085813.29296-8-thuth@redhat.com>
In-Reply-To: <20200616085813.29296-1-thuth@redhat.com>
References: <20200616085813.29296-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The git-submodule.sh script is called by make and initialize the
submodules listed in the GIT_SUBMODULES variable generated by
./configure.

SLOF is required for building the s390-ccw firmware on s390x, since
it is using the libnet code from SLOF for network booting.

Add it to the GIT_SUBMODULES when building the s390-ccw firmware.

Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200615074919.12552-1-f4bug@amsat.org>
[thuth: Tweaked the commit message a little bit]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .travis.yml | 1 -
 configure   | 5 +++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 22de1eeea1..74158f741b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -496,7 +496,6 @@ jobs:
         - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},s390x-linux-user"
         - UNRELIABLE=true
       script:
-        - ( cd ${SRC_DIR} ; git submodule update --init roms/SLOF )
         - BUILD_RC=0 && make -j${JOBS} || BUILD_RC=$?
         - |
           if [ "$BUILD_RC" -eq 0 ] ; then
diff --git a/configure b/configure
index bb7fd12612..927e4a3d06 100755
--- a/configure
+++ b/configure
@@ -6533,6 +6533,11 @@ if test "$cpu" = "s390x" ; then
   write_c_skeleton
   if compile_prog "-march=z900" ""; then
     roms="$roms s390-ccw"
+    # SLOF is required for building the s390-ccw firmware on s390x,
+    # since it is using the libnet code from SLOF for network booting.
+    if test -e "${source_path}/.git" ; then
+      git_submodules="${git_submodules} roms/SLOF"
+    fi
   fi
 fi
 
-- 
2.18.1


