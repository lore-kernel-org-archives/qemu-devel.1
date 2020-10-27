Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6933C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E7821556
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFmyoeMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E7821556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXP6a-00005O-CZ
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOuV-0003NI-Bm
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:21:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54611)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOuS-0006B3-Rv
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603804867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1zAGCokWrzrKTUilQC+YE1X1d3U1voMrenw7SRbmX7U=;
 b=EFmyoeMTg1VWawZo51aaWJGP/XOLwKdOVc4FP+JA/XEVq+esu2iL4oP6JwrrsMH5BLiYLJ
 jKvtVKIhcVOM81LJ4no/Zw6VgfLZRxcAIAWqTdk++IcZbc+9ky2o99AxQ7vKy3CmSIv3JI
 CLyNWOlIwhAgzdxMLWTG32dFQ2xI+nI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-RGRnJWyXMEqNdbEBKEz49w-1; Tue, 27 Oct 2020 09:21:05 -0400
X-MC-Unique: RGRnJWyXMEqNdbEBKEz49w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E8831084D8B
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 13:21:04 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-115-46.ams2.redhat.com
 [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E22C919647;
 Tue, 27 Oct 2020 13:20:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH v2 09/16] Put a full SFC membership blurb in footer
 of every page
Date: Tue, 27 Oct 2020 13:20:08 +0000
Message-Id: <20201027132015.621733-10-berrange@redhat.com>
In-Reply-To: <20201027132015.621733-1-berrange@redhat.com>
References: <20201027132015.621733-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 _includes/footer.html | 4 +++-
 assets/css/style.css  | 6 +++++-
 index.html            | 3 ---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/_includes/footer.html b/_includes/footer.html
index 6e1b247..411ff55 100644
--- a/_includes/footer.html
+++ b/_includes/footer.html
@@ -3,7 +3,6 @@
 		<ul class="style">
 			<li><a href="{{ relative_root }}/">Home</a></li>
 			<li><a href="{{ relative_root }}/download">Download</a></li>
-			<li><a href="{{ relative_root }}/conservancy/">Conservancy / Committee</a></li>
 			<li><a href="http://qemu-advent-calendar.org">QEMU advent calendar</a></li>
 		</ul>
 		<ul class="style">
@@ -27,6 +26,9 @@
 			<li><a href="https://xenproject.org">Xen</a></li>
 		</ul>
 	</div>
+	<div id="conservancy">
+		QEMU is a member of <a href="{{ relative_root }}/conservancy/">Software Freedom Conservancy</a>
+	</div>
 	<div id="licenses">
 		<a href="{{ relative_root }}/license.html">Website licenses</a>
 	</div>
diff --git a/assets/css/style.css b/assets/css/style.css
index c9452e3..a12a9e3 100644
--- a/assets/css/style.css
+++ b/assets/css/style.css
@@ -523,7 +523,7 @@
 		margin: 0
 	}
 
-	#licenses {
+	#licenses, #conservancy {
 		padding: 0em;
 		padding-left: 1em;
 		padding-right: 1em;
@@ -536,6 +536,10 @@
 	#licenses {
 		float: right;
 	}
+
+	#conservancy {
+		float: left;
+	}
 	
 /*********************************************************************************/
 /* Featured                                                                      */
diff --git a/index.html b/index.html
index 4f01fe9..4501811 100644
--- a/index.html
+++ b/index.html
@@ -53,9 +53,6 @@ $(document).ready(function(){
     });
 });
 </script>
-
-		<hr>
-		<p>QEMU is a member of <a href="{{ relative_root }}/conservancy/">Software Freedom Conservancy</a>.</p>
 	</div>
 </div>
 
-- 
2.26.2


