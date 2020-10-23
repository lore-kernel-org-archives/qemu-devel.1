Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38CDC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE0E2192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVthOTHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE0E2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzin-0001u7-Vq
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVz1M-0007jX-D9
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVz1K-0001sa-Kn
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603467021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8he3c9/fm4RZIZ48oFtpBP3I47PrHLYDnfqvmDMej4=;
 b=eVthOTHSSziVSdseJRNc3TJKGqG/YKj0X7pgEuV5F0AzplzeMcQCbdqwLBCAIkUp3YTRqn
 br8BKWGgEU/p9Yqm9B9buluGxJe45DtSBTPs8m+jWcs7T16osSudheVe4MfPzPDylAtPIv
 KLLqHvTzmF0VdEMl+r7zVZkzFQcnxok=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-MNOkz_CcN86ynMXOLTWRaw-1; Fri, 23 Oct 2020 11:30:19 -0400
X-MC-Unique: MNOkz_CcN86ynMXOLTWRaw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 493E4100F7BE
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 15:30:10 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-189.ams2.redhat.com
 [10.36.113.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1321F5B4BE;
 Fri, 23 Oct 2020 15:30:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH 6/7] Add link to "edit this page" for all pages
Date: Fri, 23 Oct 2020 16:29:56 +0100
Message-Id: <20201023152957.488974-7-berrange@redhat.com>
In-Reply-To: <20201023152957.488974-1-berrange@redhat.com>
References: <20201023152957.488974-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The link takes the user directly to the source markdown file in gitlab,
where they can press the "Edit" button and make changes directly in the
browser. They will be prompted to fork the project when committing the
changes if they don't already have a fork.  The result is a commit which
can be submitted for review per the contributing guidelines.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 _includes/footer.html        | 3 +++
 assets/css/style-desktop.css | 4 ++++
 assets/css/style.css         | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/_includes/footer.html b/_includes/footer.html
index 2dd247b..0a77d8e 100644
--- a/_includes/footer.html
+++ b/_includes/footer.html
@@ -1,4 +1,7 @@
 <div id="footer">
+	<div id="edit-page">
+		<a href="https://gitlab.com/qemu-project/qemu-web/-/blob/master/{{page.path}}">edit this page</a>
+	</div>
 	<div id="external-links">
 		<ul class="style">
 			<li><a href="http://qemu-advent-calendar.org">Advent calendar</a></li>
diff --git a/assets/css/style-desktop.css b/assets/css/style-desktop.css
index d45ec15..19272ad 100644
--- a/assets/css/style-desktop.css
+++ b/assets/css/style-desktop.css
@@ -102,6 +102,10 @@
 /* Footer                                                                        */
 /*********************************************************************************/
 
+	#edit-page {
+		text-align: right;
+	}
+
 	#licenses {
 		float: right;
 	}
diff --git a/assets/css/style.css b/assets/css/style.css
index e2fee29..50bbcd1 100644
--- a/assets/css/style.css
+++ b/assets/css/style.css
@@ -514,7 +514,7 @@
 		margin: 0em;
 	}
 
-	#conservancy, #licenses {
+	#conservancy, #licenses, #edit-page {
 		padding: 0em;
 		padding-left: 1em;
 		padding-right: 1em;
-- 
2.26.2


