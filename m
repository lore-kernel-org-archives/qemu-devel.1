Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B185C433EC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1D821D95
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 07:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fL3DQWsW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1D821D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0KJx-0007U7-5r
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 03:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0KHi-0003IJ-GN
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:44:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36947
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0KHg-0003wi-MY
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 03:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595922263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=3eCj8CWGnPptx6Rz6AUlBJxMLhIGrhP5vlbK1bDhqsY=;
 b=fL3DQWsWFy3OmsbeGRSq0+9ON7DfWEx9sPYP/11w0TLyrnEHh1XYuvogrYdpuoGhOoyFXT
 ja3kCo4NhR4ioVZlUwTdJjQ31wpskPhg9OHTwWom1Dyp1hL1D/REX4CwLxRoktU1nAR9Sm
 eBUZiHcyEa/icOsobJbmd5JFxaAlwdk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-54CGncvgMEeq7WBH_BESyA-1; Tue, 28 Jul 2020 03:44:20 -0400
X-MC-Unique: 54CGncvgMEeq7WBH_BESyA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CC0180183C;
 Tue, 28 Jul 2020 07:44:19 +0000 (UTC)
Received: from thuth.com (ovpn-112-161.ams2.redhat.com [10.36.112.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D2D25F1EA;
 Tue, 28 Jul 2020 07:44:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 4/4] cirrus.yml: Update the macOS jobs to Catalina
Date: Tue, 28 Jul 2020 09:44:05 +0200
Message-Id: <20200728074405.13118-5-thuth@redhat.com>
In-Reply-To: <20200728074405.13118-1-thuth@redhat.com>
References: <20200728074405.13118-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 00:06:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When looking at the CI jobs on cirrus-ci.com, it seems like the mojave-based
images have been decomissioned a while ago already, since apparently all our
jobs get automatically upgraded to catalina. So let's update our YML script
accordingly to avoid confusion.

Reviewed-by: Ed Maste <emaste@freebsd.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .cirrus.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.cirrus.yml b/.cirrus.yml
index 86a059c12f..0742aaf8a3 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -18,7 +18,7 @@ freebsd_12_task:
 
 macos_task:
   osx_instance:
-    image: mojave-base
+    image: catalina-base
   install_script:
     - brew install pkg-config python gnu-sed glib pixman make sdl2 bash
   script:
@@ -33,7 +33,7 @@ macos_task:
 macos_xcode_task:
   osx_instance:
     # this is an alias for the latest Xcode
-    image: mojave-xcode
+    image: catalina-xcode
   install_script:
     - brew install pkg-config gnu-sed glib pixman make sdl2 bash
   script:
-- 
2.18.1


