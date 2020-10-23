Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473CEC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CC72192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnkTbTxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CC72192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzgn-0006nZ-9N
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVz1K-0007ht-JJ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVz1G-0001p2-Eu
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603467017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ofjx9eklJguHvhd4j2ZPUixoPBImc5PsFAy+CiMpW10=;
 b=WnkTbTxH3fg6ryHKQynV7YINEiW9mRY4vwGxE8oHIm/MB/Wz3c7TJ9+KgE/0WQ2Xppgzpy
 M6kYOjbRJVOvR0MsMFJPZCZnc94lRebTR6LVMwA+H551JLgBs2hfsxoHj4xStB9EuLE5lm
 qeqJkO0RZVMUA3A/trATxlKlacYyycE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-8b9oN-laNR-F4s0kFUNPtw-1; Fri, 23 Oct 2020 11:30:11 -0400
X-MC-Unique: 8b9oN-laNR-F4s0kFUNPtw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4D068049F4
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 15:30:08 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-189.ams2.redhat.com
 [10.36.113.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66E2E5B4AC;
 Fri, 23 Oct 2020 15:30:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH 5/7] Simplify and restructure the page footer
Date: Fri, 23 Oct 2020 16:29:55 +0100
Message-Id: <20201023152957.488974-6-berrange@redhat.com>
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

The page footer currently has a large wall of links.

Many of the links duplicate what is already present in the page header
navbar. The header is styled to have a fixed position, it will always
be on screen. The footer meanwhile is often off the bottom of the
screen.

Other links from the footer are already present in the 'contribute' and
'documentation' pages, with more descriptive text.

The wiki link would be better placed in the top header where it is more
obviously visible to users.

With this change the footer is slimmed down to avoid link duplication,
leaving it primarily focused on providing links to the related external
sites.

The wiki link is moved to the header nav which has extra space after the
previous patch.

Finally the conservancy link pulled out and placed just below the footer
adjacent to the licensing link, giving it more prominence.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 _includes/copyright.html     |  8 --------
 _includes/footer.html        | 30 +++++++++---------------------
 _includes/nav.html           |  1 +
 _layouts/blog.html           |  1 -
 _layouts/home.html           |  1 -
 _layouts/page.html           |  1 -
 assets/css/style-desktop.css | 24 ++++--------------------
 assets/css/style-mobile.css  | 13 +------------
 assets/css/style.css         | 36 ++++++++++++++++++++++++++----------
 9 files changed, 41 insertions(+), 74 deletions(-)
 delete mode 100644 _includes/copyright.html

diff --git a/_includes/copyright.html b/_includes/copyright.html
deleted file mode 100644
index cdcd98f..0000000
--- a/_includes/copyright.html
+++ /dev/null
@@ -1,8 +0,0 @@
-<div id="copyright">
-	<div id="copyright-inner">
-	  <div class="container">
-	    This site is made available under the terms of
-	    <a href="{{ relative_root }}/license.html">a number of licenses</a>.
-	  </div>
-	</div>
-</div>
diff --git a/_includes/footer.html b/_includes/footer.html
index b614795..2dd247b 100644
--- a/_includes/footer.html
+++ b/_includes/footer.html
@@ -1,30 +1,18 @@
 <div id="footer">
-	<div id="footer-inner">
+	<div id="external-links">
 		<ul class="style">
-			<li><a href="{{ relative_root }}/">Home</a></li>
-			<li><a href="{{ relative_root }}/download">Download</a></li>
-			<li><a href="{{ relative_root }}/conservancy/">Conservancy / Committee</a></li>
-			<li><a href="http://qemu-advent-calendar.org">QEMU advent calendar</a></li>
-		</ul>
-		<ul class="style">
-			<li><a href="{{ relative_root }}/contribute">Contribute</a></li>
-			<li><a href="{{ relative_root }}/contribute/report-a-bug">Reporting a bug</a></li>
-			<li><a href="https://wiki.qemu.org/Documentation/GettingStartedDevelopers">New contributors</a></li>
-			<li><a href="https://wiki.qemu.org/Contribute/SubmitAPatch">Submitting a patch</a></li>
-			<li><a href="https://wiki.qemu.org/Contribute/FAQ">Contributor FAQ</a></li>
-		</ul>
-		<ul class="style">
-			<li><a href="{{ relative_root }}/documentation">Documentation</a></li>
-			<li><a href="https://www.qemu.org/docs/master/">Main docs</a></li>
-			<li><a href="https://wiki.qemu.org/Category:Developer_documentation">Developer docs</a></li>
-			<li><a href="https://wiki.qemu.org/">Wiki</a></li>
-		</ul>
-		<ul class="style">
-			<li><a href="https://planet.virt-tools.org/">virt tools planet</a></li>
+			<li><a href="http://qemu-advent-calendar.org">Advent calendar</a></li>
+			<li><a href="https://planet.virt-tools.org/">Blog planet</a></li>
 			<li><a href="https://www.linux-kvm.org/">KVM</a></li>
 			<li><a href="http://libguestfs.org/">Libguestfs</a></li>
 			<li><a href="https://libvirt.org/">Libvirt</a></li>
 			<li><a href="https://xenproject.org">Xen</a></li>
 		</ul>
 	</div>
+	<div id="conservancy">
+	  QEMU is a member of <a href="{{ relative_root }}/conservancy/">Software Freedom Conservancy</a>
+	</div>
+	<div id="licenses">
+	  <a href="{{ relative_root }}/license.html">Website licenses</a>
+	</div>
 </div>
diff --git a/_includes/nav.html b/_includes/nav.html
index c66ee92..73b39b3 100644
--- a/_includes/nav.html
+++ b/_includes/nav.html
@@ -7,6 +7,7 @@
 			</li><li {% if current[1] == 'support' %}class='current'{% endif %}><a href="{{ relative_root }}/support">Support</a>
 			</li><li {% if current[1] == 'contribute' %}class='current'{% endif %}><a href="{{ relative_root }}/contribute">Contribute</a>
 			</li><li {% if current[1] == 'documentation' %}class='current'{% endif %}><a href="{{ relative_root }}/documentation">Docs</a>
+			</li><li><a href="https://wiki.qemu.org">Wiki</a>
 			</li><li {% if current[1] == 'blog' %}class='current'{% endif %}><a href="{{ relative_root }}/blog">Blog</a></li>
 		</ul>
 	</nav>
diff --git a/_layouts/blog.html b/_layouts/blog.html
index b300636..b7fcdbf 100644
--- a/_layouts/blog.html
+++ b/_layouts/blog.html
@@ -21,7 +21,6 @@ Released for free under the Creative Commons Attribution 3.0 license (templated.
 	
 	{% include sidebar.html %}
 	{% include footer.html %}
-	{% include copyright.html %}
 
 </body>
 </html>
diff --git a/_layouts/home.html b/_layouts/home.html
index d94c9b0..f7b6931 100644
--- a/_layouts/home.html
+++ b/_layouts/home.html
@@ -18,7 +18,6 @@ Released for free under the Creative Commons Attribution 3.0 license (templated.
 	{{ content }}
 
 	{% include footer.html %}
-	{% include copyright.html %}
 
 </body>
 </html>
diff --git a/_layouts/page.html b/_layouts/page.html
index d650054..765d204 100644
--- a/_layouts/page.html
+++ b/_layouts/page.html
@@ -23,7 +23,6 @@ Released for free under the Creative Commons Attribution 3.0 license (templated.
 	</div>
 	
 	{% include footer.html %}
-	{% include copyright.html %}
 
 </body>
 </html>
diff --git a/assets/css/style-desktop.css b/assets/css/style-desktop.css
index b7e403a..d45ec15 100644
--- a/assets/css/style-desktop.css
+++ b/assets/css/style-desktop.css
@@ -101,29 +101,13 @@
 /*********************************************************************************/
 /* Footer                                                                        */
 /*********************************************************************************/
-	
-	#footer
-	{
-		padding: 1em 0em;
-	}
-	
-	#footer-inner
-	{
-		width: 95%;
-		display: table;
-		margin: auto;
-	}
 
-	#footer ul
-	{
-		width: 25%;
-		display: table-cell;
-		padding-left: 2em;
+	#licenses {
+		float: right;
 	}
 
-	#footer ul:first-child
-	{
-		padding-left: 0px;
+	#conservancy {
+		float: left;
 	}
 
 /*********************************************************************************/
diff --git a/assets/css/style-mobile.css b/assets/css/style-mobile.css
index 8910e71..652650b 100644
--- a/assets/css/style-mobile.css
+++ b/assets/css/style-mobile.css
@@ -242,7 +242,7 @@
 /* Columns                                                                       */
 /*********************************************************************************/
 
-	#main, #footer-inner, #copyright-inner
+	#main, #copyright-inner
 	{
 		margin-left: 0%;
 		width: 100%;
@@ -283,19 +283,8 @@
 	
 	#footer
 	{
-		padding: 1em;
-	}
-	
-	#footer ul
-	{
-		padding: 0.6em 0px;
-		border-top: 1px solid white;
 	}
 
-	#footer ul:first-child
-	{
-		border-top: 0px;
-	}
 	
 /*********************************************************************************/
 /* Featured                                                                      */
diff --git a/assets/css/style.css b/assets/css/style.css
index e09b383..e2fee29 100644
--- a/assets/css/style.css
+++ b/assets/css/style.css
@@ -503,24 +503,40 @@
 	{
 		position: relative;
 		clear: left;
-		background: #401200;
-		color: #FFF;
 	}
 	
 	#footer a
 	{
 		color: inherit;
 	}
-	
-	#footer ul
-	{
-		vertical-align: top;
+
+	#footer ul {
+		margin: 0em;
 	}
 
-	#footer ul, #footer ul > li
-	{
-		padding: 0;
-		margin: 0
+	#conservancy, #licenses {
+		padding: 0em;
+		padding-left: 1em;
+		padding-right: 1em;
+		font-size: smaller;
+		color: #707070;
+		margin: 0em;
+	}
+
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
+	#external-links li a {
+		padding-left: 1em;
 	}
 
 /*********************************************************************************/
-- 
2.26.2


