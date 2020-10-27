Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0F8C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BEF6218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUGIWqIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEF6218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXP8L-0002Bv-Fh
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOuh-0003nM-4q
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOud-0006Cp-MD
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603804879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vlo1gDebt5sCqcu700TeAqkVIrdGkZHwxRZikms0jxo=;
 b=CUGIWqItalQNhsoU0fJZUgz9CqikyeUdco+xQvq3EHYG/vtmJnhM6hOX5NQwq67QqHMvHi
 9Tigvk01qvWoDc0WdyevU/rnGgRDM46R614Eihfucq2+Nxj9CCy9zOOSytFGzCCt8iVlG6
 gwlm+b/PX9ysAD0ahnNqgAtJL74oXrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-lP0izg2aNEKNrfiwmJDJXA-1; Tue, 27 Oct 2020 09:21:15 -0400
X-MC-Unique: lP0izg2aNEKNrfiwmJDJXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5A0D18B9EC4
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 13:21:14 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-115-46.ams2.redhat.com
 [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6ACE19646;
 Tue, 27 Oct 2020 13:21:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH v2 14/16] Simplify and restructure the page footer
Date: Tue, 27 Oct 2020 13:20:13 +0000
Message-Id: <20201027132015.621733-15-berrange@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
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

Remove links from the footer than duplicate what is already present in
the header navbar or easily found from other places. The footer bar is
now simply a selection of links to related external sites, along with
the website license and SFC information.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 _includes/footer.html        | 15 +++------------
 assets/css/style-desktop.css | 21 +--------------------
 assets/css/style-mobile.css  | 22 +---------------------
 assets/css/style.css         | 24 ++++++++++++++++--------
 4 files changed, 21 insertions(+), 61 deletions(-)

diff --git a/_includes/footer.html b/_includes/footer.html
index fba5f08..5adc569 100644
--- a/_includes/footer.html
+++ b/_includes/footer.html
@@ -1,17 +1,8 @@
 <div id="footer">
-	<div id="footer-inner">
+	<div id="external-links">
 		<ul class="style">
-			<li><a href="{{ relative_root }}/">Home</a></li>
-			<li><a href="{{ relative_root }}/download">Download</a></li>
-			<li><a href="http://qemu-advent-calendar.org">QEMU advent calendar</a></li>
-		</ul>
-		<ul class="style">
-			<li><a href="{{ relative_root }}/documentation">Documentation</a></li>
-			<li><a href="https://www.qemu.org/docs/master/">Main docs</a></li>
-			<li><a href="https://wiki.qemu.org/Category:Developer_documentation">Developer docs</a></li>
-		</ul>
-		<ul class="style">
-			<li><a href="https://planet.virt-tools.org/">virt tools planet</a></li>
+			<li><a href="http://qemu-advent-calendar.org">Advent calendar</a></li>
+			<li><a href="https://planet.virt-tools.org/">Blog planet</a></li>
 			<li><a href="https://www.linux-kvm.org/">KVM</a></li>
 			<li><a href="http://libguestfs.org/">Libguestfs</a></li>
 			<li><a href="https://libvirt.org/">Libvirt</a></li>
diff --git a/assets/css/style-desktop.css b/assets/css/style-desktop.css
index 2b25532..593f090 100644
--- a/assets/css/style-desktop.css
+++ b/assets/css/style-desktop.css
@@ -104,26 +104,7 @@
 	
 	#footer
 	{
-		padding: 1em 0em;
-	}
-	
-	#footer-inner
-	{
-		width: 95%;
-		display: table;
-		margin: auto;
-	}
-
-	#footer ul
-	{
-		width: 25%;
-		display: table-cell;
-		padding-left: 2em;
-	}
-
-	#footer ul:first-child
-	{
-		padding-left: 0px;
+		clear: both;
 	}
 
 /*********************************************************************************/
diff --git a/assets/css/style-mobile.css b/assets/css/style-mobile.css
index 5dab41c..2a18870 100644
--- a/assets/css/style-mobile.css
+++ b/assets/css/style-mobile.css
@@ -232,7 +232,7 @@
 /* Columns                                                                       */
 /*********************************************************************************/
 
-	#main, #footer-inner
+	#main
 	{
 		margin-left: 0%;
 		width: 100%;
@@ -267,26 +267,6 @@
 		font-size: 1.6em;
 	}
 	
-/*********************************************************************************/
-/* Footer                                                                        */
-/*********************************************************************************/
-	
-	#footer
-	{
-		padding: 1em;
-	}
-	
-	#footer ul
-	{
-		padding: 0.6em 0px;
-		border-top: 1px solid white;
-	}
-
-	#footer ul:first-child
-	{
-		border-top: 0px;
-	}
-	
 /*********************************************************************************/
 /* Featured                                                                      */
 /*********************************************************************************/
diff --git a/assets/css/style.css b/assets/css/style.css
index a9d5b90..369b57f 100644
--- a/assets/css/style.css
+++ b/assets/css/style.css
@@ -502,9 +502,6 @@
 	#footer
 	{
 		position: relative;
-		clear: left;
-		background: #401200;
-		color: #FFF;
 	}
 	
 	#footer a
@@ -514,13 +511,24 @@
 	
 	#footer ul
 	{
-		vertical-align: top;
+		margin: 0em;
 	}
 
-	#footer ul, #footer ul > li
-	{
-		padding: 0;
-		margin: 0
+	#external-links {
+		padding: 0em;
+		padding-top: 0.3em;
+		padding-bottom: 0.3em;
+		background: #401200;
+		color: #FFF;
+		text-align: center;
+	}
+
+	#external-links li {
+		display: inline;
+	}
+
+	#external-links li a {
+		padding-left: 1em;
 	}
 
 	#licenses, #conservancy {
-- 
2.26.2


