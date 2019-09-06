Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B089BC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 11:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A3D206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 11:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A3D206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6C5j-0007f4-NX
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 07:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i6C4z-0007GS-LX
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i6C4y-0001DQ-9t
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:07:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i6C4y-0001Cz-4p
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:07:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C1D3307D844;
 Fri,  6 Sep 2019 11:06:58 +0000 (UTC)
Received: from thuth.com (ovpn-116-159.ams2.redhat.com [10.36.116.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCBD15C1D4;
 Fri,  6 Sep 2019 11:06:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  6 Sep 2019 13:06:49 +0200
Message-Id: <20190906110649.9561-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 06 Sep 2019 11:06:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [qemu-web RFC PATCH] Update to Jekyll 4.0
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
Cc: alex.bennee@linaro.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

- Update versions in Gemfile
- "has_key?" has to be renamed to "key?" in category_archive_plugin.rb
- Add .jekyll-cache to .gitignore file

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitignore                          |  1 +
 Gemfile                             | 15 +++------------
 _plugins/category_archive_plugin.rb |  2 +-
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/.gitignore b/.gitignore
index c744144..3b93b88 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,3 +2,4 @@
 /Gemfile.lock
 /vendor
 /.bundle
+/.jekyll-cache
diff --git a/Gemfile b/Gemfile
index b01dff9..200f2c4 100644
--- a/Gemfile
+++ b/Gemfile
@@ -9,10 +9,10 @@ ruby RUBY_VERSION
 #
 # This will help ensure the proper Jekyll version is running.
 # Happy Jekylling!
-gem "jekyll", "3.3.0"
+gem "jekyll", "4.0.0"
 
 # This is the default theme for new Jekyll sites. You may change this to anything you like.
-gem "minima", "~> 2.0"
+gem "minima", "~> 2.5"
 
 # If you want to use GitHub Pages, remove the "gem "jekyll"" above and
 # uncomment the line below. To upgrade, run `bundle update github-pages`.
@@ -20,14 +20,5 @@ gem "minima", "~> 2.0"
 
 # If you have any plugins, put them here!
 group :jekyll_plugins do
-   gem "jekyll-feed", "~> 0.6"
+   gem "jekyll-feed", "~> 0.12"
 end
-
-
-# for RHEL7
-gem 'public_suffix', "< 3.0"
-gem 'jekyll-watch', '= 1.5.0'
-gem 'listen', '< 3.1'
-gem 'ruby_dep', '< 1.4'
-gem 'json'
-gem 'json_pure'
diff --git a/_plugins/category_archive_plugin.rb b/_plugins/category_archive_plugin.rb
index c2d8b29..5f26aad 100644
--- a/_plugins/category_archive_plugin.rb
+++ b/_plugins/category_archive_plugin.rb
@@ -50,7 +50,7 @@ module Jekyll
 
     def render(context)
       # If the category is a variable in the current context, expand it
-      if context.has_key?(@category)
+      if context.key?(@category)
 	      category = context[@category]
       else
 	      category = @category
-- 
2.18.1


