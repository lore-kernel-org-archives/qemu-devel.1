Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420ADC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 837232168B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6JnnsLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837232168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzeL-0002nV-DA
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVz1E-0007cP-7L
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVz1B-0001m9-Ao
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603467011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7MebyAj8ZV2lkF1PPn8N5figXVf0BbskoRjvhz9AzA=;
 b=A6JnnsLzLSKi6z+iW61g6vs83H1Gp0h2pj0lBD9BVFVPk9TehNIPqsutSftUW4D4MtXyiV
 PtzZqs4/MmSeqdIbp3UjkVMrTFYZb9gHeDHWCAoxBQCoosrSTx0ijd07NqWHag1OUUX2R2
 yi5ZmIdolG2UOzbPqE7LV4e6qzNGuug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-b_XUee3lMyiptKs4y8wB0A-1; Fri, 23 Oct 2020 11:30:06 -0400
X-MC-Unique: b_XUee3lMyiptKs4y8wB0A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D667807331
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 15:30:05 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-189.ams2.redhat.com
 [10.36.113.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 274CB5B4BC;
 Fri, 23 Oct 2020 15:30:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH 3/7] make all links be relative to the root
Date: Fri, 23 Oct 2020 16:29:53 +0100
Message-Id: <20201023152957.488974-4-berrange@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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

This enables the site to be hosted at URLs with different base
directories. This is useful when viewing the site after being
published as GitLab CI artifacts.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 _includes/assets.html        | 28 ++++++++++++++--------------
 _includes/copyright.html     |  2 +-
 _includes/footer.html        | 12 ++++++------
 _includes/nav.html           | 12 ++++++------
 _includes/relative_root.html | 12 ++++++++++++
 _includes/sidebar.html       |  6 +++---
 _layouts/archive.html        |  4 ++--
 _layouts/blog.html           |  3 ++-
 _layouts/home.html           |  1 +
 _layouts/page.html           |  1 +
 blog/index.html              |  4 ++--
 index.html                   |  4 ++--
 12 files changed, 52 insertions(+), 37 deletions(-)
 create mode 100644 _includes/relative_root.html

diff --git a/_includes/assets.html b/_includes/assets.html
index 826a50f..411a1ac 100644
--- a/_includes/assets.html
+++ b/_includes/assets.html
@@ -4,23 +4,23 @@
 	<meta name="viewport" content="width=device-width">
 	<link href='https://fonts.googleapis.com/css?family=Roboto+Mono:300,400%7cRoboto:300,400,500' rel='stylesheet' type='text/css'>
 
-	<link rel="apple-touch-icon" sizes="180x180" href="/assets/favicons/apple-touch-icon.png">
-	<link rel="icon" type="image/png" sizes="32x32" href="/assets/favicons/favicon-32x32.png">
-	<link rel="icon" type="image/png" sizes="16x16" href="/assets/favicons/favicon-16x16.png">
-	<link rel="manifest" href="/assets/favicons/manifest.json">
-	<link rel="mask-icon" href="/assets/favicons/safari-pinned-tab.svg" color="#5bbad5">
-	<meta name="msapplication-config" content="/assets/favicons/browserconfig.xml">
+	<link rel="apple-touch-icon" sizes="180x180" href="{{ relative_root }}/assets/favicons/apple-touch-icon.png">
+	<link rel="icon" type="image/png" sizes="32x32" href="{{ relative_root }}/assets/favicons/favicon-32x32.png">
+	<link rel="icon" type="image/png" sizes="16x16" href="{{ relative_root }}/assets/favicons/favicon-16x16.png">
+	<link rel="manifest" href="{{ relative_root }}/assets/favicons/manifest.json">
+	<link rel="mask-icon" href="{{ relative_root }}/assets/favicons/safari-pinned-tab.svg" color="#5bbad5">
+	<meta name="msapplication-config" content="{{ relative_root }}/assets/favicons/browserconfig.xml">
 	<meta name="theme-color" content="#ffffff">
 
-	<link rel="stylesheet" href="/assets/css/normalize.css" />
+	<link rel="stylesheet" href="{{ relative_root }}/assets/css/normalize.css" />
 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css" />
-	<link rel="stylesheet" href="/assets/css/skel-noscript.css" />
-	<link rel="stylesheet" href="/assets/css/style.css" />
-	<link rel="stylesheet" href="/assets/css/style-mobile.css" media="(max-width:699px)"/>
-	<link rel="stylesheet" href="/assets/css/style-desktop.css" media="(min-width:700px)" />
-	<link rel="alternate" title="QEMU Blog (Atom feed)" href="/feed.xml" type="application/atom+xml" />
+	<link rel="stylesheet" href="{{ relative_root }}/assets/css/skel-noscript.css" />
+	<link rel="stylesheet" href="{{ relative_root }}/assets/css/style.css" />
+	<link rel="stylesheet" href="{{ relative_root }}/assets/css/style-mobile.css" media="(max-width:699px)"/>
+	<link rel="stylesheet" href="{{ relative_root }}/assets/css/style-desktop.css" media="(min-width:700px)" />
+	<link rel="alternate" title="QEMU Blog (Atom feed)" href="{{ relative_root }}/feed.xml" type="application/atom+xml" />
 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
 	{% if page.colorbox %}
-	<script src="/assets/js/jquery.colorbox.js"></script>
-	<link rel="stylesheet" href="/assets/css/colorbox.css" />
+	<script src="{{ relative_root }}/assets/js/jquery.colorbox.js"></script>
+	<link rel="stylesheet" href="{{ relative_root }}/assets/css/colorbox.css" />
 	{% endif %}
diff --git a/_includes/copyright.html b/_includes/copyright.html
index 3e6e6a3..cdcd98f 100644
--- a/_includes/copyright.html
+++ b/_includes/copyright.html
@@ -2,7 +2,7 @@
 	<div id="copyright-inner">
 	  <div class="container">
 	    This site is made available under the terms of
-	    <a href="/license.html">a number of licenses</a>.
+	    <a href="{{ relative_root }}/license.html">a number of licenses</a>.
 	  </div>
 	</div>
 </div>
diff --git a/_includes/footer.html b/_includes/footer.html
index c8f1042..b614795 100644
--- a/_includes/footer.html
+++ b/_includes/footer.html
@@ -1,20 +1,20 @@
 <div id="footer">
 	<div id="footer-inner">
 		<ul class="style">
-			<li><a href="/">Home</a></li>
-			<li><a href="/download">Download</a></li>
-			<li><a href="/conservancy/">Conservancy / Committee</a></li>
+			<li><a href="{{ relative_root }}/">Home</a></li>
+			<li><a href="{{ relative_root }}/download">Download</a></li>
+			<li><a href="{{ relative_root }}/conservancy/">Conservancy / Committee</a></li>
 			<li><a href="http://qemu-advent-calendar.org">QEMU advent calendar</a></li>
 		</ul>
 		<ul class="style">
-			<li><a href="/contribute">Contribute</a></li>
-			<li><a href="/contribute/report-a-bug">Reporting a bug</a></li>
+			<li><a href="{{ relative_root }}/contribute">Contribute</a></li>
+			<li><a href="{{ relative_root }}/contribute/report-a-bug">Reporting a bug</a></li>
 			<li><a href="https://wiki.qemu.org/Documentation/GettingStartedDevelopers">New contributors</a></li>
 			<li><a href="https://wiki.qemu.org/Contribute/SubmitAPatch">Submitting a patch</a></li>
 			<li><a href="https://wiki.qemu.org/Contribute/FAQ">Contributor FAQ</a></li>
 		</ul>
 		<ul class="style">
-			<li><a href="/documentation">Documentation</a></li>
+			<li><a href="{{ relative_root }}/documentation">Documentation</a></li>
 			<li><a href="https://www.qemu.org/docs/master/">Main docs</a></li>
 			<li><a href="https://wiki.qemu.org/Category:Developer_documentation">Developer docs</a></li>
 			<li><a href="https://wiki.qemu.org/">Wiki</a></li>
diff --git a/_includes/nav.html b/_includes/nav.html
index 0c81e24..58b6c5a 100644
--- a/_includes/nav.html
+++ b/_includes/nav.html
@@ -2,12 +2,12 @@
 	<nav id="nav">
 		<ul>
 			{% assign current = page.url | downcase | split: '/' %}
-			<li class='{% if page.url == '/' %}not-desktop {%endif %}home'><a href="/">Home</a>
-			</li><li {% if current[1] == 'download' %}class='current'{% endif %}><a href="/download">Download</a>
-			</li><li {% if current[1] == 'support' %}class='current'{% endif %}><a href="/support">Support</a>
-			</li><li {% if current[1] == 'contribute' %}class='current'{% endif %}><a href="/contribute">Contribute</a>
-			</li><li {% if current[1] == 'documentation' %}class='current'{% endif %}><a href="/documentation">Documentation</a>
-			</li><li {% if current[1] == 'blog' %}class='current'{% endif %}><a href="/blog">Blog</a></li>
+			<li class='{% if page.url == '/' %}not-desktop {%endif %}home'><a href="{{ relative_root }}/">Home</a>
+			</li><li {% if current[1] == 'download' %}class='current'{% endif %}><a href="{{ relative_root }}/download">Download</a>
+			</li><li {% if current[1] == 'support' %}class='current'{% endif %}><a href="{{ relative_root }}/support">Support</a>
+			</li><li {% if current[1] == 'contribute' %}class='current'{% endif %}><a href="{{ relative_root }}/contribute">Contribute</a>
+			</li><li {% if current[1] == 'documentation' %}class='current'{% endif %}><a href="{{ relative_root }}/documentation">Documentation</a>
+			</li><li {% if current[1] == 'blog' %}class='current'{% endif %}><a href="{{ relative_root }}/blog">Blog</a></li>
 		</ul>
 	</nav>
 
diff --git a/_includes/relative_root.html b/_includes/relative_root.html
new file mode 100644
index 0000000..87c30e2
--- /dev/null
+++ b/_includes/relative_root.html
@@ -0,0 +1,12 @@
+{% assign relative_root = '' %}
+{% assign tempDepth = page.url | append: 'hackish-solution' | split: '/' | size | minus: 2 %}
+{% for i in (1..tempDepth) %}
+  {% if forloop.last %}
+    {% assign relative_root = relative_root | append: ".." %}
+  {% else %}
+    {% assign relative_root = relative_root | append: "../" %}
+  {% endif %}
+{% endfor %}
+{% if relative_root == '' %}
+    {% assign relative_root = '.' %}
+{% endif %}
diff --git a/_includes/sidebar.html b/_includes/sidebar.html
index 0dc3538..f0cec2a 100644
--- a/_includes/sidebar.html
+++ b/_includes/sidebar.html
@@ -9,7 +9,7 @@
 		<ul class="style">
 		{% for post in site.posts offset: 0 limit: 2 %}
 			<li>
-				<a href="{{ site.prefix }}{{ post.url }}">{{ post.title }}</a><br/>
+				<a href="{{ relative_root }}{{ post.url }}">{{ post.title }}</a><br/>
 				<span class="posted">{{ post.date | date_to_string }}</span>
 			</li>
 		{% endfor %}
@@ -31,12 +31,12 @@
 		{% assign thisurl = post.date | date: "%Y/%m" %}
 		{% assign thisdate = post.date | date: "%B %Y" %}
 		{% if thisurl != prevurl and prevurl != "" %}
-		<li><a href="/blog/{{ prevurl }}/">{{ prevdate }} ({{ counter }})</a></li>
+		<li><a href="{{ relative_root }}/blog/{{ prevurl }}/">{{ prevdate }} ({{ counter }})</a></li>
 		{% assign counter = 0 %}
 		{% endif %}
 		{% assign counter = counter | plus: 1 %}
 		{% endfor %}
-		<li><a href="/blog/{{ thisurl }}/">{{ thisdate }} ({{ counter }})</a></li>
+		<li><a href="{{ relative_root }}/blog/{{ thisurl }}/">{{ thisdate }} ({{ counter }})</a></li>
 		</ul>
 	</section>
 </div>
diff --git a/_layouts/archive.html b/_layouts/archive.html
index 4e67749..a0be7b8 100644
--- a/_layouts/archive.html
+++ b/_layouts/archive.html
@@ -9,13 +9,13 @@ layout: blog
 		{% for post in page.posts %}
 		<article>
 			<header>
-				<h2><a href="{{ site.prefix }}{{ post.url }}">{{ post.title }}</a></h2>
+				<h2><a href="../../..{{ post.url }}">{{ post.title }}</a></h2>
 				<div class="posted">{{ post.date | date_to_string }}{%
 				if post.last_modified_at %} (Updated {{ post.last_modified_at | date_to_string }}) {%
 				endif %}{% if post.author %} &mdash; by {{ post.author }}{% endif %}</div>
 			</header>
 		{{ post.excerpt }}
-		<a href="{{ site.prefix }}{{ post.url }}" class="button button-style1">Read More</a>
+		<a href="../../..{{ post.url }}" class="button button-style1">Read More</a>
 		</article>
 		{% endfor %}
 	</section>
diff --git a/_layouts/blog.html b/_layouts/blog.html
index 2dfb9c8..b300636 100644
--- a/_layouts/blog.html
+++ b/_layouts/blog.html
@@ -3,7 +3,8 @@
 Linear by TEMPLATED
 templated.co @templatedco
 Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
--->
+  -->
+{% include relative_root.html %}
 <html>
 <head>
 	<title>{{ page.title }} - {{ site.title }}</title>
diff --git a/_layouts/home.html b/_layouts/home.html
index b96e391..d94c9b0 100644
--- a/_layouts/home.html
+++ b/_layouts/home.html
@@ -4,6 +4,7 @@ Linear by TEMPLATED
 templated.co @templatedco
 Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
 -->
+{% include relative_root.html %}
 <html>
 <head>
 	<title>{{ site.title }}</title>
diff --git a/_layouts/page.html b/_layouts/page.html
index 110ca97..d650054 100644
--- a/_layouts/page.html
+++ b/_layouts/page.html
@@ -4,6 +4,7 @@ Linear by TEMPLATED
 templated.co @templatedco
 Released for free under the Creative Commons Attribution 3.0 license (templated.co/license)
 -->
+{% include relative_root.html %}
 <html>
 <head>
 	<title>{{ page.title }} - {{ site.title }}</title>
diff --git a/blog/index.html b/blog/index.html
index 313b994..c7ceb0a 100644
--- a/blog/index.html
+++ b/blog/index.html
@@ -8,7 +8,7 @@ layout: blog
 	<div class="row">
 		<section>
 			<header>
-				<h1><a href="{{ site.prefix }}{{ post.url }}">{{ post.title }}</a></h1>
+				<h1><a href="{{ relative_root }}{{ post.url }}">{{ post.title }}</a></h1>
 				<div class="posted">{{ post.date | date_to_string }}{%
 				if post.last_modified_at %} (Updated {{ post.last_modified_at | date_to_string }}) {%
 				endif %}{% if post.author %} &mdash; by {{ post.author }}{% endif %}</div>
@@ -22,7 +22,7 @@ layout: blog
 				</ul>
 			{% else %}
 				{{ post.excerpt }}
-				<a href="{{ site.prefix }}{{ post.url }}" class="button button-style1">Read More</a>
+				<a href="{{ relative_root }}{{ post.url }}" class="button button-style1">Read More</a>
 			{% endif %}
 		</section>
 	</div>
diff --git a/index.html b/index.html
index 4c65101..ca2f7e9 100644
--- a/index.html
+++ b/index.html
@@ -38,7 +38,7 @@ colorbox: True
 			{% include screenshot.html offset=3 limit=10 %}
 			</section>
 
-<script src="/assets/js/object-fit.js"></script>
+<script src="{{ relative_root }}/assets/js/object-fit.js"></script>
 <script>
 window.hasColorBox = false;
 $(window).on("load resize", function() {
@@ -62,7 +62,7 @@ $('.colorbox').on("click.random-namespace", function() {
 
 		</div>
 		<hr>
-		<p>QEMU is a member of <a href="/conservancy/">Software Freedom Conservancy</a>.</p>
+		<p>QEMU is a member of <a href="{{ relative_root }}/conservancy/">Software Freedom Conservancy</a>.</p>
 	</div>
 </div>
 
-- 
2.26.2


