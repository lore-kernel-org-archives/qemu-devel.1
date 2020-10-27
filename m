Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC925C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D71C207E8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awvRFEmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D71C207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXP2b-0003RA-VH
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOuL-0002zT-2W
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:21:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOuI-00068o-Vv
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603804858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FE3MiVgbc/oAXJWaDzBE7fcs+ceEd5HE58Enc9rAni0=;
 b=awvRFEmcD6QaI/XzlPlRWqyXIYaGFBQR1+G4miDAZtz1PivaY0mpCTIhU7iM88653agF01
 qpgWCQGL+fGQFEmGq0NNDkgQZ5SgDhNe2FASD9XahCWT6b2PUT2OK0mssfkWfyp5z2Tzpn
 +Jg3kEWfXUJNvtBy6LFvX7cBQmVsWmU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-8qn29bpVMleNgrJjDohOaA-1; Tue, 27 Oct 2020 09:20:55 -0400
X-MC-Unique: 8qn29bpVMleNgrJjDohOaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95E851084D78
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 13:20:54 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-115-46.ams2.redhat.com
 [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9116B19648;
 Tue, 27 Oct 2020 13:20:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH v2 08/16] Simplify copyright and integrate into footer
Date: Tue, 27 Oct 2020 13:20:07 +0000
Message-Id: <20201027132015.621733-9-berrange@redhat.com>
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

The copyright information is at the base of the page so logically part of
the page footer structure.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 _includes/copyright.html    |  8 --------
 _includes/footer.html       |  3 +++
 _layouts/blog.html          |  1 -
 _layouts/home.html          |  1 -
 _layouts/page.html          |  1 -
 assets/css/style-mobile.css |  2 +-
 assets/css/style.css        | 29 ++++++++++++-----------------
 7 files changed, 16 insertions(+), 29 deletions(-)
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
index b614795..6e1b247 100644
--- a/_includes/footer.html
+++ b/_includes/footer.html
@@ -27,4 +27,7 @@
 			<li><a href="https://xenproject.org">Xen</a></li>
 		</ul>
 	</div>
+	<div id="licenses">
+		<a href="{{ relative_root }}/license.html">Website licenses</a>
+	</div>
 </div>
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
diff --git a/assets/css/style-mobile.css b/assets/css/style-mobile.css
index 8910e71..d045d84 100644
--- a/assets/css/style-mobile.css
+++ b/assets/css/style-mobile.css
@@ -242,7 +242,7 @@
 /* Columns                                                                       */
 /*********************************************************************************/
 
-	#main, #footer-inner, #copyright-inner
+	#main, #footer-inner
 	{
 		margin-left: 0%;
 		width: 100%;
diff --git a/assets/css/style.css b/assets/css/style.css
index 855217b..c9452e3 100644
--- a/assets/css/style.css
+++ b/assets/css/style.css
@@ -428,7 +428,7 @@
 /* Columns                                                                       */
 /*********************************************************************************/
 
-	#main, #copyright-inner
+	#main
 	{
 		margin-left: 16.667%;
 		width: 66.667%;
@@ -523,23 +523,18 @@
 		margin: 0
 	}
 
-/*********************************************************************************/
-/* Copyright                                                                     */
-/*********************************************************************************/
-	
-	#copyright
-	{
-		clear: left;
-		border-top: 1px solid #aaaaaa;
-		position: relative;
-		color: #aaaaaa;
-		background: #ffffff;
-		padding: 1em 0em;
+	#licenses {
+		padding: 0em;
+		padding-left: 1em;
+		padding-right: 1em;
+		font-size: smaller;
+		color: #401200;
+		background: #fff;
+		margin: 1em;
 	}
-	
-	#copyright a
-	{
-		color: inherit;
+
+	#licenses {
+		float: right;
 	}
 	
 /*********************************************************************************/
-- 
2.26.2


