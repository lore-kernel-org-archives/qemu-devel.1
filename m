Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677A8C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6791207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrCW6M5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6791207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXP2t-000482-KA
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOuX-0003R3-3a
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43022)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOuV-0006BJ-51
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603804870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orWnQ7R4iI1Db8hb2cb+ozRH61xLz6VmNQwcHyT1Uqg=;
 b=BrCW6M5HqIFf1lww1FBbIfyPP6LawV17ArmIWVviEGI4xO1dsP1nadQcy8VDeuDBOYyUE1
 Im4kuj92XS0Nb9GZ8Kj3J54bIAsITqsMtXrJBI/z/aabRPMgIbOALA4A8l2AqCffnc+G1F
 oc5yTN/FmRo0X9q69JQC971x3lf/hhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-_HdWrEyENc6i2B423z0vQg-1; Tue, 27 Oct 2020 09:21:06 -0400
X-MC-Unique: _HdWrEyENc6i2B423z0vQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2B26807342
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 13:21:05 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-115-46.ams2.redhat.com
 [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D5981992F;
 Tue, 27 Oct 2020 13:21:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH v2 10/16] Use two column layout to display
 screenshots and releases
Date: Tue, 27 Oct 2020 13:20:09 +0000
Message-Id: <20201027132015.621733-11-berrange@redhat.com>
In-Reply-To: <20201027132015.621733-1-berrange@redhat.com>
References: <20201027132015.621733-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Now that the screenshots are using a carousel, they don't consume the
full width of the page. This enables switching to a two column layout
with information about the latest release placed in one column, and
screenshots in the other. This means release information is no longer
hidden off the bottom of the page.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 assets/css/style-desktop.css | 13 +++++++++
 assets/css/style-mobile.css  | 10 -------
 assets/css/style.css         | 56 +++++++++++++++++++++++++++++++++---
 index.html                   | 33 ++++++++++++---------
 4 files changed, 85 insertions(+), 27 deletions(-)

diff --git a/assets/css/style-desktop.css b/assets/css/style-desktop.css
index b7e403a..2b25532 100644
--- a/assets/css/style-desktop.css
+++ b/assets/css/style-desktop.css
@@ -133,6 +133,8 @@
 	#featured
 	{
 		padding: 3em 0em 1em 0em;
+		width: 50%;
+		float: left;
 	}
 	
 	#featured p
@@ -153,6 +155,17 @@
 	.\31 1u img { height: 66vw; }
 	.\31 2u img { height: 72vw; }
 	
+/*********************************************************************************/
+/* Quickstart                                                                    */
+/*********************************************************************************/
+
+	#quickstart
+	{
+		padding-top: 5em;
+		width: 50%;
+		float: right;
+	}
+
 /*********************************************************************************/
 /* Horizontal menu                                                               */
 /*********************************************************************************/
diff --git a/assets/css/style-mobile.css b/assets/css/style-mobile.css
index d045d84..5dab41c 100644
--- a/assets/css/style-mobile.css
+++ b/assets/css/style-mobile.css
@@ -49,20 +49,10 @@
 			background-attachment: fixed;
 		}
 
-	#featured
-	{
-		padding-top: 250px;
-	}
-	@media (min-width:500px) {
-		body
-		{
-			background-image: url(../images/qemu_head_400_faint.png);
-		}
 		#featured
 		{
 			padding-top: 50px;
 		}
-	}
 
 	section,
 	article
diff --git a/assets/css/style.css b/assets/css/style.css
index a12a9e3..6308084 100644
--- a/assets/css/style.css
+++ b/assets/css/style.css
@@ -548,11 +548,17 @@
 	#featured
 	{
 		position: relative;
-		background: rgba(0,0,0,0.05);
 		text-align: center;
 		margin-bottom: 2em;
 	}
 	
+	#featured .container
+	{
+		max-width: 500px;
+		margin-let: auto;
+		margin-right: auto;
+	}
+
 	#featured header
 	{
 		border-bottom: 1px solid #333333;
@@ -576,9 +582,6 @@
 	#featured .screenshots .pennant
 	{
 		font-size: 4em;
-		width: 40%;
-		margin-left: auto;
-		margin-right: auto;
 	}
 
 	#featured .screenshots .pennant img
@@ -593,3 +596,48 @@
 	{
 		margin-top: 1.5em;
 	}
+
+
+/*********************************************************************************/
+/* Quickstart                                                                    */
+/*********************************************************************************/
+
+	#quickstart
+	{
+		margin: 0em;
+		padding: 3em 0em 1em 0em;
+	}
+
+	#quickstart .container
+	{
+		max-width: 500px;
+		margin-let: auto;
+		margin-right: auto;
+	}
+
+	#quickstart ul, #quickstart p
+	{
+		margin: 0em;
+		padding-left: 0.5em;
+	}
+
+	#quickstart ul > li
+	{
+		list-style: none;
+		display: block;
+		padding-bottom: 2em;
+	}
+
+	#quickstart ul > li > strong
+	{
+		list-style: none;
+		display: block;
+		font-size: 2em;
+		margin-bottom: 0.2em;
+	}
+
+	#quickstart li span
+	{
+		display: inline-block;
+		padding-left: 1.5em;
+	}
diff --git a/index.html b/index.html
index 4501811..d057a87 100644
--- a/index.html
+++ b/index.html
@@ -12,11 +12,29 @@ bxslider: True
 			<span class="tag">A generic and open source machine emulator and virtualizer</p>
 		</div>
 	</div>
-	
+
+<!-- Main -->
+<div id="quickstart">
+	<div class="container">
+		<ul>
+{% for release in site.data.releases offset: 0 limit: 1 %}
+			<li><strong>Latest release: <a
+  href="https://download.qemu.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz">{{release.branch}}.{{release.patch}}</a></strong>
+			  <span>{{release.date}} </span>
+			  <span><a href="https://download.qemu.org/qemu-{{release.branch}}.{{release.patch}}.tar.xz.sig">signature</a></span>
+			  <span><a href="https://wiki.qemu.org/ChangeLog/{{release.branch}}">changes</a></span>
+			  <br>
+			  <span><a href="{{ relative_root }}/download">Other releases</a></span>
+			</li>
+{% endfor %}
+		</ul>
+	</div>
+</div>
+
 <!-- Featured -->
 <div id="featured">
 	<div class="container">
-		<div class="row slider screenshots">
+		<div class="slider screenshots">
 			{% include screenshot.html %}
 		</div>
 
@@ -56,17 +74,6 @@ $(document).ready(function(){
 	</div>
 </div>
 
-<!-- Main -->
-	<div id="releases">
-		<header>
-			<h2>Latest releases</h2>
-		</header>
-		<div class="container">
-			{% include releases.html %}
-		</div>
-	</div>
-
-
 <script>
 	$(window).on("scroll", function() {
 		isScroll = window.scrollY < 120;
-- 
2.26.2


