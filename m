Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B16C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B1F20759
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 13:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKwtnP+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B1F20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOzJ-0007wv-CS
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 09:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOty-0002CP-76
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39560)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kXOtr-0005vh-St
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603804830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o63+6hvnnXYKsH6QMcQA4bQDIw7EUOK8XxSaw1Ksdls=;
 b=RKwtnP+pqZVT1Yw/wk13YapdrpeqSQ3ucH+3fwTCLPgi3IcqwbJxHyU78lVtM9C+NFMjno
 686KnzCPd8EnID91EFd7kTK5+uQkCjrZgc/6B9qPpgY35ExlKAn46Kk7UFtLS5GyMKsSR8
 2mG/rrmGk3Mq1GayYj4hx4duGOdT6UM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-A1sFwvRoOaK_azrt5kmPmQ-1; Tue, 27 Oct 2020 09:20:21 -0400
X-MC-Unique: A1sFwvRoOaK_azrt5kmPmQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 817CB8064D9
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 13:20:20 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-115-46.ams2.redhat.com
 [10.36.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E59B4196FD;
 Tue, 27 Oct 2020 13:20:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [qemu-web PATCH v2 01/16] Convert files to UNIX line endings
Date: Tue, 27 Oct 2020 13:20:00 +0000
Message-Id: <20201027132015.621733-2-berrange@redhat.com>
In-Reply-To: <20201027132015.621733-1-berrange@redhat.com>
References: <20201027132015.621733-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 assets/css/style-desktop.css |  586 ++++++++---------
 assets/css/style-mobile.css  |  750 ++++++++++-----------
 assets/css/style.css         | 1184 +++++++++++++++++-----------------
 index.html                   |  178 ++---
 4 files changed, 1349 insertions(+), 1349 deletions(-)

diff --git a/assets/css/style-desktop.css b/assets/css/style-desktop.css
index b6c5aa1..ce58fe2 100644
--- a/assets/css/style-desktop.css
+++ b/assets/css/style-desktop.css
@@ -1,295 +1,295 @@
-/*=0D
-=09Linear by TEMPLATED=0D
-    templated.co @templatedco=0D
-    Released for free under the Creative Commons Attribution 3.0 license (=
templated.co/license)=0D
-*/=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Grid                                                                   =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-@import url(cells.css);=0D
-=0D
-=09.row > * {=0D
-=09=09padding-left: 50px;=0D
-=09}=09=0D
-=09.row > *:first-child {=0D
-=09=09padding-left: 0px;=0D
-=09}=0D
-=09.row + .row {=0D
-=09=09padding-top: 50px;=0D
-=09}=09=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Basic                                                                  =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09.only-mobile, .not-desktop=0D
-=09{=0D
-=09=09display: none !important;=0D
-=09}=0D
-=0D
-=09body=0D
-=09{=0D
-=09=09/* 90% transparent */=0D
-=09=09background: url(../images/qemu_head_200.png) no-repeat fixed 2em 80p=
x;=0D
+/*
+=09Linear by TEMPLATED
+    templated.co @templatedco
+    Released for free under the Creative Commons Attribution 3.0 license (=
templated.co/license)
+*/
+
+/*************************************************************************=
********/
+/* Grid                                                                   =
       */
+/*************************************************************************=
********/
+
+@import url(cells.css);
+
+=09.row > * {
+=09=09padding-left: 50px;
+=09}=09
+=09.row > *:first-child {
+=09=09padding-left: 0px;
+=09}
+=09.row + .row {
+=09=09padding-top: 50px;
+=09}=09
+
+/*************************************************************************=
********/
+/* Basic                                                                  =
       */
+/*************************************************************************=
********/
+
+=09.only-mobile, .not-desktop
+=09{
+=09=09display: none !important;
+=09}
+
+=09body
+=09{
+=09=09/* 90% transparent */
+=09=09background: url(../images/qemu_head_200.png) no-repeat fixed 2em 80p=
x;
 =09=09background-color: #FFF;
-=09}=0D
-=0D
-=09body.homepage=0D
-=09{=0D
-=09=09/* 90% transparent */=0D
-=09=09background: url(../images/qemu_head_400_faint.png) no-repeat fixed c=
enter 60%;=0D
+=09}
+
+=09body.homepage
+=09{
+=09=09/* 90% transparent */
+=09=09background: url(../images/qemu_head_400_faint.png) no-repeat fixed c=
enter 60%;
 =09=09background-color: #FFF;
-=09}=0D
-=0D
-=09body,input,textarea,select=0D
-=09{=0D
-=09}=0D
-=0D
-=09.homepage h1=0D
-=09{=0D
-=09=09font-size: 7em;=0D
-=09=09letter-spacing: -0.05em;=0D
-=09}=0D
-=0D
-=09.homepage h2=0D
-=09{=0D
-=09=09font-size: 2.2em;=0D
-=09}=0D
-=0D
-=09h1=0D
-=09{=0D
-=09=09font-size: 3em;=0D
-=09}=0D
-=0D
-=09header=0D
-=09{=0D
-=09=09margin-bottom: 2em;=0D
-=09}=0D
-=09=0D
-=09=09header .byline=0D
-=09=09{=0D
-=09=09=09font-size: 1.7em;=0D
-=09=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Header                                                                 =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09#header=0D
-=09{=0D
-=09=09padding: 5em 0 2em 0;=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Main                                                                   =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09#main,#sidebar {=0D
-=09=09margin-top: 5em;=0D
-=09}=0D
-=0D
-=09#sidebar h1=0D
-=09{=0D
-=09=09font-size: 2.4em;=0D
-=09=09letter-spacing: 0em;=0D
-=09=09line-height: 1.2em;=0D
-=09=09margin-top: -0.2em;=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Footer                                                                 =
       */=0D
-/*************************************************************************=
********/=0D
-=09=0D
-=09#footer=0D
-=09{=0D
-=09=09padding: 1em 0em;=0D
-=09}=0D
-=09=0D
-=09#footer-inner=0D
-=09{=0D
-=09=09width: 95%;=0D
-=09=09display: table;=0D
-=09=09margin: auto;=0D
-=09}=0D
-=0D
-=09#footer ul=0D
-=09{=0D
-=09=09width: 25%;=0D
-=09=09display: table-cell;=0D
-=09=09padding-left: 2em;=0D
-=09}=0D
-=0D
-=09#footer ul:first-child=0D
-=09{=0D
-=09=09padding-left: 0px;=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Featured                                                               =
       */=0D
-/*************************************************************************=
********/=0D
-=09=0D
-=09#featured=0D
-=09{=0D
-=09=09padding: 3em 0em 1em 0em;=0D
-=09}=0D
-=09=0D
-=09#featured p=0D
-=09{=0D
-=09=09line-height: 1.5em;=0D
-=09=09font-size: 1.2em;=0D
-=09}=0D
-=09=0D
-=09.\31 u img { height:  6vw; }=0D
-=09.\32 u img { height: 12vw; }=0D
-=09.\33 u img { height: 18vw; }=0D
-=09.\34 u img { height: 24vw; }=0D
-=09.\36 u img { height: 36vw; }=0D
-=09.\37 u img { height: 42vw; }=0D
-=09.\38 u img { height: 48vw; }=0D
-=09.\39 u img { height: 54vw; }=0D
-=09.\31 0u img { height: 60vw; }=0D
-=09.\31 1u img { height: 66vw; }=0D
-=09.\31 2u img { height: 72vw; }=0D
-=09=0D
-/*************************************************************************=
********/=0D
-/* Horizontal menu                                                        =
       */=0D
-/*************************************************************************=
********/=0D
-=09.horiz-menu > ul=0D
-=09{=0D
-=09=09width: 100%;=0D
-=09=09margin: 0;=0D
-=09=09padding: 0;=0D
-=09=09display: table;=0D
-=09=09border-collapse: collapse;=0D
-=09}=0D
-=09.horiz-menu > ul > li=0D
-=09{=0D
-=09=09width: 25%;=0D
-=09=09border: 1px solid #000000;=0D
-=09=09display: table-cell;=0D
-=09=09color: #F03B11;=0D
-=09}=0D
-=09.horiz-menu > ul > li:hover=0D
-=09{=0D
-=09=09background: #FCECD4;=0D
-=09=09color: #802400;=0D
-=09}=0D
-=0D
-=09.horiz-menu > ul > li > a=0D
-=09{=0D
-=09=09display: block;=0D
-=09=09padding: 1em;=0D
-=09=09border-bottom: 5px transparent;=0D
-=09=09white-space: nowrap;=0D
-=09=09color: inherit;=0D
-=09}=0D
-=09.horiz-menu > ul > li > a:hover=0D
-=09{=0D
-=09=09text-decoration: none;=0D
-=09}=0D
-=09.horiz-menu > ul > li.active > a=0D
-=09{=0D
-=09=09border-bottom: 5px #F03B11 solid;=0D
-=09}=0D
-=0D
-=09.horiz-menu > ul > li.active > a:hover=0D
-=09{=0D
-=09=09border-bottom: 5px #802400 solid;=0D
-=09}=0D
-=0D
-=09.horiz-menu > article=0D
-=09{=0D
-=09=09padding-top: 1em;=0D
-=09=09margin: 0;=0D
-=09=09display: none;=0D
-=09}=0D
-=0D
-=09.horiz-menu > article.active=0D
-=09{=0D
-=09=09display: block;=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Nav                                                                    =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09#titleBar=0D
-=09{=0D
-=09=09display: none !important;=0D
-=09}=0D
-=0D
-=09#nav=0D
-=09{=0D
-=09=09display: block !important;=0D
-=09=09z-index: 2;=0D
-=09=09position: fixed;=0D
-=09=09background: #802400;=0D
-=09=09background: -webkit-linear-gradient(top, #802400 0%,#800800 100%);=
=0D
-=09=09background: linear-gradient(to bottom, #802400 0%,#800800 100%);=0D
-=09=09left: 0;=0D
-=09=09top: 0;=0D
-=09=09width: 100%;=0D
-=09}=0D
-=09=09=0D
-=09=09#nav > ul=0D
-=09=09{=0D
-=09=09=09text-align: right;=0D
-=09=09=09margin: 0;=0D
-=09=09}=0D
-=0D
-=09=09#nav > ul > li=0D
-=09=09{=0D
-=09=09=09display: inline-block;=0D
-=09=09=09margin: 0;=0D
-=09=09=09padding: 0.5em 2em 0.5em 0em;=0D
-=09=09=09color: #FFF;=0D
-=09=09=09letter-spacing: 0.06em;=0D
-=09=09=09text-transform: uppercase;=0D
-=09=09=09font-size: 1.1em;=0D
-=09=09}=0D
-=0D
-=09=09#nav a=0D
-=09=09{=0D
-=09=09=09text-decoration: none;=0D
-=09=09=09color: inherit;=0D
-=09=09}=0D
-=0D
-=09=09#nav > ul > li > a,=0D
-=09=09#nav > ul > li > span=0D
-=09=09{=0D
-=09=09=09display: inline-block;=0D
-=09=09=09padding: 3px 0.5em 3px 0.5em;=0D
-=09=09}=0D
-=0D
-=09=09#nav > ul > li:hover > a,=0D
-=09=09#nav > ul > li:hover > span=0D
-=09=09{=0D
-=09=09=09border-bottom: 3px solid #F0A833;=0D
-=09=09=09padding-bottom: 0px;=0D
-=09=09}=0D
-=0D
-=09=09#nav li.current a=0D
-=09=09{=0D
-=09=09=09font-weight: 500;=0D
-=09=09}=0D
-=0D
-/*=0D
-=09=09#nav > ul > li.home=0D
-=09=09{=0D
-=09=09=09display: block;=0D
-=09=09=09float: left;=0D
-=09=09}=0D
-*/=0D
-=0D
-=09=09#nav > ul > li > ul=0D
-=09=09{=0D
-=09=09=09display: none;=0D
-=09=09}=0D
-=0D
-=0D
-/* Colorbox customization */=0D
-=0D
-=09body #cboxTitle { height: 50px; bottom: 24px; color: #000000; text-alig=
n: left; }=0D
-=09body #cboxMiddleLeft, body #cboxMiddleRight, body #cboxContent { paddin=
g-bottom: 50px; box-sizing: content-box; }=0D
+=09}
+
+=09body,input,textarea,select
+=09{
+=09}
+
+=09.homepage h1
+=09{
+=09=09font-size: 7em;
+=09=09letter-spacing: -0.05em;
+=09}
+
+=09.homepage h2
+=09{
+=09=09font-size: 2.2em;
+=09}
+
+=09h1
+=09{
+=09=09font-size: 3em;
+=09}
+
+=09header
+=09{
+=09=09margin-bottom: 2em;
+=09}
+=09
+=09=09header .byline
+=09=09{
+=09=09=09font-size: 1.7em;
+=09=09}
+
+/*************************************************************************=
********/
+/* Header                                                                 =
       */
+/*************************************************************************=
********/
+
+=09#header
+=09{
+=09=09padding: 5em 0 2em 0;
+=09}
+
+/*************************************************************************=
********/
+/* Main                                                                   =
       */
+/*************************************************************************=
********/
+
+=09#main,#sidebar {
+=09=09margin-top: 5em;
+=09}
+
+=09#sidebar h1
+=09{
+=09=09font-size: 2.4em;
+=09=09letter-spacing: 0em;
+=09=09line-height: 1.2em;
+=09=09margin-top: -0.2em;
+=09}
+
+/*************************************************************************=
********/
+/* Footer                                                                 =
       */
+/*************************************************************************=
********/
+=09
+=09#footer
+=09{
+=09=09padding: 1em 0em;
+=09}
+=09
+=09#footer-inner
+=09{
+=09=09width: 95%;
+=09=09display: table;
+=09=09margin: auto;
+=09}
+
+=09#footer ul
+=09{
+=09=09width: 25%;
+=09=09display: table-cell;
+=09=09padding-left: 2em;
+=09}
+
+=09#footer ul:first-child
+=09{
+=09=09padding-left: 0px;
+=09}
+
+/*************************************************************************=
********/
+/* Featured                                                               =
       */
+/*************************************************************************=
********/
+=09
+=09#featured
+=09{
+=09=09padding: 3em 0em 1em 0em;
+=09}
+=09
+=09#featured p
+=09{
+=09=09line-height: 1.5em;
+=09=09font-size: 1.2em;
+=09}
+=09
+=09.\31 u img { height:  6vw; }
+=09.\32 u img { height: 12vw; }
+=09.\33 u img { height: 18vw; }
+=09.\34 u img { height: 24vw; }
+=09.\36 u img { height: 36vw; }
+=09.\37 u img { height: 42vw; }
+=09.\38 u img { height: 48vw; }
+=09.\39 u img { height: 54vw; }
+=09.\31 0u img { height: 60vw; }
+=09.\31 1u img { height: 66vw; }
+=09.\31 2u img { height: 72vw; }
+=09
+/*************************************************************************=
********/
+/* Horizontal menu                                                        =
       */
+/*************************************************************************=
********/
+=09.horiz-menu > ul
+=09{
+=09=09width: 100%;
+=09=09margin: 0;
+=09=09padding: 0;
+=09=09display: table;
+=09=09border-collapse: collapse;
+=09}
+=09.horiz-menu > ul > li
+=09{
+=09=09width: 25%;
+=09=09border: 1px solid #000000;
+=09=09display: table-cell;
+=09=09color: #F03B11;
+=09}
+=09.horiz-menu > ul > li:hover
+=09{
+=09=09background: #FCECD4;
+=09=09color: #802400;
+=09}
+
+=09.horiz-menu > ul > li > a
+=09{
+=09=09display: block;
+=09=09padding: 1em;
+=09=09border-bottom: 5px transparent;
+=09=09white-space: nowrap;
+=09=09color: inherit;
+=09}
+=09.horiz-menu > ul > li > a:hover
+=09{
+=09=09text-decoration: none;
+=09}
+=09.horiz-menu > ul > li.active > a
+=09{
+=09=09border-bottom: 5px #F03B11 solid;
+=09}
+
+=09.horiz-menu > ul > li.active > a:hover
+=09{
+=09=09border-bottom: 5px #802400 solid;
+=09}
+
+=09.horiz-menu > article
+=09{
+=09=09padding-top: 1em;
+=09=09margin: 0;
+=09=09display: none;
+=09}
+
+=09.horiz-menu > article.active
+=09{
+=09=09display: block;
+=09}
+
+/*************************************************************************=
********/
+/* Nav                                                                    =
       */
+/*************************************************************************=
********/
+
+=09#titleBar
+=09{
+=09=09display: none !important;
+=09}
+
+=09#nav
+=09{
+=09=09display: block !important;
+=09=09z-index: 2;
+=09=09position: fixed;
+=09=09background: #802400;
+=09=09background: -webkit-linear-gradient(top, #802400 0%,#800800 100%);
+=09=09background: linear-gradient(to bottom, #802400 0%,#800800 100%);
+=09=09left: 0;
+=09=09top: 0;
+=09=09width: 100%;
+=09}
+=09=09
+=09=09#nav > ul
+=09=09{
+=09=09=09text-align: right;
+=09=09=09margin: 0;
+=09=09}
+
+=09=09#nav > ul > li
+=09=09{
+=09=09=09display: inline-block;
+=09=09=09margin: 0;
+=09=09=09padding: 0.5em 2em 0.5em 0em;
+=09=09=09color: #FFF;
+=09=09=09letter-spacing: 0.06em;
+=09=09=09text-transform: uppercase;
+=09=09=09font-size: 1.1em;
+=09=09}
+
+=09=09#nav a
+=09=09{
+=09=09=09text-decoration: none;
+=09=09=09color: inherit;
+=09=09}
+
+=09=09#nav > ul > li > a,
+=09=09#nav > ul > li > span
+=09=09{
+=09=09=09display: inline-block;
+=09=09=09padding: 3px 0.5em 3px 0.5em;
+=09=09}
+
+=09=09#nav > ul > li:hover > a,
+=09=09#nav > ul > li:hover > span
+=09=09{
+=09=09=09border-bottom: 3px solid #F0A833;
+=09=09=09padding-bottom: 0px;
+=09=09}
+
+=09=09#nav li.current a
+=09=09{
+=09=09=09font-weight: 500;
+=09=09}
+
+/*
+=09=09#nav > ul > li.home
+=09=09{
+=09=09=09display: block;
+=09=09=09float: left;
+=09=09}
+*/
+
+=09=09#nav > ul > li > ul
+=09=09{
+=09=09=09display: none;
+=09=09}
+
+
+/* Colorbox customization */
+
+=09body #cboxTitle { height: 50px; bottom: 24px; color: #000000; text-alig=
n: left; }
+=09body #cboxMiddleLeft, body #cboxMiddleRight, body #cboxContent { paddin=
g-bottom: 50px; box-sizing: content-box; }
diff --git a/assets/css/style-mobile.css b/assets/css/style-mobile.css
index 9f2f033..8910e71 100644
--- a/assets/css/style-mobile.css
+++ b/assets/css/style-mobile.css
@@ -1,375 +1,375 @@
-/*=0D
-=09Linear by TEMPLATED=0D
-    templated.co @templatedco=0D
-    Released for free under the Creative Commons Attribution 3.0 license (=
templated.co/license)=0D
-*/=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Grid                                                                   =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09.row > * {=0D
-=09=09padding: 15px 0 0 0;=0D
-=09=09float: none;=0D
-=09=09margin-left: auto !important;=0D
-=09=09margin-right: auto !important;=0D
-=09}=09=0D
-=09.row + .row > * {=0D
-=09=09padding-top: 15px;=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Basic                                                                  =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09.only-desktop, .not-mobile=0D
-=09{=0D
-=09=09display: none !important;=0D
-=09}=0D
-=0D
-=09body,input,textarea,select=0D
-=09{=0D
-=09=09line-height: 1.5em;=0D
-=09=09font-size: 10.5pt;=0D
-=09=09letter-spacing: 0;=0D
-=09}=0D
-=0D
-=09body=0D
-=09{=0D
-=09=09background: url(../images/qemu_head_200_faint.png) no-repeat fixed c=
enter center;=0D
-=09}=0D
-=09=09body.homepage=0D
-=09=09{=0D
-=09=09=09background-position: center 200px;=0D
-=09=09=09background-attachment: scroll;=0D
-=09=09}=0D
-=09=09body.fixed=0D
-=09=09{=0D
-=09=09=09background-position: center 80px;=0D
-=09=09=09background-attachment: fixed;=0D
-=09=09}=0D
-=0D
-=09#featured=0D
-=09{=0D
-=09=09padding-top: 250px;=0D
-=09}=0D
-=09@media (min-width:500px) {=0D
-=09=09body=0D
-=09=09{=0D
-=09=09=09background-image: url(../images/qemu_head_400_faint.png);=0D
-=09=09}=0D
-=09=09#featured=0D
-=09=09{=0D
-=09=09=09padding-top: 50px;=0D
-=09=09}=0D
-=09}=0D
-=0D
-=09section,=0D
-=09article=0D
-=09{=0D
-=09=09clear: both;=0D
-=09=09margin: 2em 0 2em 0;=0D
-=09}=0D
-=0D
-=09.container=0D
-=09{=0D
-=09=09padding: 0em 1em;=0D
-=09}=0D
-=0D
-=09header=0D
-=09{=0D
-=09=09margin-bottom: 1.6em;=0D
-=09}=0D
-=09=0D
-=09=09header .byline=0D
-=09=09{=0D
-=09=09=09font-size: 1.2em;=0D
-=09=09}=0D
-=0D
-=09.button=0D
-=09{=0D
-=09=09display: block;=0D
-=09=09width: 100%;=0D
-=09=09text-align: center;=0D
-=09}=0D
-=0D
-=09.homepage h1=0D
-=09{=0D
-=09=09font-size: 3em;=0D
-=09=09padding-top: 0.6em;=0D
-=09}=0D
-=0D
-=09h1, .homepage h2=0D
-=09{=0D
-=09=09font-size: 2em;=0D
-=09}=0D
-=0D
-=09h2, .homepage h3=0D
-=09{=0D
-=09=09font-size: 1.6em;=0D
-=09}=0D
-=0D
-=09h3, h4, h5, h6=0D
-=09{=0D
-=09=09font-size: 1.5em;=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* UI                                                                     =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09#titleBar=0D
-=09{=0D
-=09=09width: 100%;=0D
-=09=09background: #161616;=0D
-=09=09height: 44px;=0D
-=09=09overflow: hidden;=0D
-=09=09position: fixed;=0D
-=09=09margin-top: -44px;=0D
-=09=09z-index: 2;=0D
-=09}=0D
-=0D
-=09=09body.js {=0D
-=09=09=09padding-top: 44px;=0D
-=09=09}=0D
-=0D
-=09=09#titleBar .title=0D
-=09=09{=0D
-=09=09=09color: #fff;=0D
-=09=09=09text-align: center;=0D
-=09=09=09line-height: 44px;=0D
-=09=09=09font-weight: 300;=0D
-=09=09=09text-decoration: none;=0D
-=09=09=09display: block;=0D
-=09=09=09position: absolute;=0D
-=09=09=09left: 0;=0D
-=09=09=09top: 0;=0D
-=09=09=09width: 100%;=0D
-=09=09=09z-index: 1;=0D
-=09=09}=0D
-=09=09=0D
-=09=09button[aria-controls=3D"nav"]=0D
-=09=09{=0D
-=09=09=09float: left;=0D
-=09=09=09position: relative;=0D
-=09=09=09left: 0;=0D
-=09=09=09top: 0;=0D
-=09=09=09width: 80px;=0D
-=09=09=09height: 44px;=0D
-=09=09=09cursor: pointer;=0D
-=09=09=09z-index: 2;=0D
-=09=09=09background: transparent;=0D
-=09=09=09border: 0px;=0D
-=09=09=09color: #808080;=0D
-=09=09}=0D
-=0D
-=09=09=09button[aria-controls=3D"nav"] > span.fa=0D
-=09=09=09{=0D
-=09=09=09=09width: 20px;=0D
-=09=09=09=09height: 12px;=0D
-=09=09=09=09position: absolute;=0D
-=09=09=09=09left: 12px;=0D
-=09=09=09=09top: 10px;=0D
-=09=09=09}=0D
-=0D
-=09=09=09button[aria-controls=3D"nav"]:active=0D
-=09=09=09{=0D
-=09=09=09=09color: #c0c0c0;=0D
-=09=09=09}=0D
-=09#nav=0D
-=09{=0D
-=09=09padding: 0em;=0D
-=09=09background: #1f1f1f;=0D
-=09}=0D
-=0D
-=09=09#titleBar + #nav {=0D
-=09=09=09position: fixed;=0D
-=09=09=09margin-left: -80%;=0D
-=09=09=09width: 80%;=0D
-=09=09=09height: 100%;=0D
-=09=09=09z-index: 2;=0D
-=09=09=09left: 0;=0D
-=09=09=09top: 0;=0D
-=09=09}=0D
-=0D
-=09=09#nav > ul=20=0D
-=09=09{=0D
-=09=09=09margin: 0em;=0D
-=09=09=09padding: 0.3em;=0D
-=09=09}=0D
-=0D
-=09=09#nav > ul > li=0D
-=09=09{=0D
-=09=09=09border-top: 1px solid white;=0D
-=09=09=09margin: 0;=0D
-=09=09=09padding: 0.3em;=0D
-=09=09=09color: #ffffff;=0D
-=09=09}=0D
-=0D
-=09=09#nav > ul > li:first-child=0D
-=09=09{=0D
-=09=09=09border-top: 0px;=0D
-=09=09}=0D
-=09=0D
-=09=09#nav > ul > li > a,=0D
-=09=09#nav > ul > li > span=0D
-=09=09{=0D
-=09=09=09display: block;=0D
-=09=09=09padding: 0 1em 0 1em;=0D
-=09=09=09letter-spacing: 1px;=0D
-=09=09=09color: inherit;=0D
-=09=09=09text-align: left;=0D
-=09=09}=0D
-=09=09=0D
-/*************************************************************************=
********/=0D
-/* Header                                                                 =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09#header {=0D
-=09=09height: 9em;=0D
-=09}=0D
-=0D
-=09#header h1 {=0D
-=09=09margin-bottom: 0.2em;=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Logo                                                                   =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Columns                                                                =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09#main, #footer-inner, #copyright-inner=0D
-=09{=0D
-=09=09margin-left: 0%;=0D
-=09=09width: 100%;=0D
-=09}=0D
-=0D
-=09#sidebar=0D
-=09{=0D
-=09=09margin-left: 0%;=0D
-=09=09width: 100%;=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Main                                                                   =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09#main=0D
-=09{=0D
-=09=09padding: 2em 0em 1em 0em;=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Sidebar                                                                =
       */=0D
-/*************************************************************************=
********/=0D
-=09=0D
-=09#sidebar=0D
-=09{=0D
-=09=09clear: left;=0D
-=09}=0D
-=0D
-=09#sidebar h1=0D
-=09{=0D
-=09=09font-size: 1.6em;=0D
-=09}=0D
-=09=0D
-/*************************************************************************=
********/=0D
-/* Footer                                                                 =
       */=0D
-/*************************************************************************=
********/=0D
-=09=0D
-=09#footer=0D
-=09{=0D
-=09=09padding: 1em;=0D
-=09}=0D
-=09=0D
-=09#footer ul=0D
-=09{=0D
-=09=09padding: 0.6em 0px;=0D
-=09=09border-top: 1px solid white;=0D
-=09}=0D
-=0D
-=09#footer ul:first-child=0D
-=09{=0D
-=09=09border-top: 0px;=0D
-=09}=0D
-=09=0D
-/*************************************************************************=
********/=0D
-/* Featured                                                               =
       */=0D
-/*************************************************************************=
********/=0D
-=09=0D
-=09#featured=0D
-=09{=0D
-=09=09padding-bottom: 3em;=0D
-=09}=0D
-=0D
-=09#featured h3=0D
-=09{=0D
-=09=09padding: 0.5em 0em;=0D
-=09=09font-size: 1.4em;=0D
-=09=09margin: 0em;=0D
-=09}=0D
-=09#featured h3+p=0D
-=09{=0D
-=09=09margin-top: 0em;=0D
-=09}=0D
-=0D
-=09#featured .pennant a=0D
-=09{=0D
-=09=09cursor: inherit;=0D
-=09}=0D
-=0D
-=09#featured .pennant img=0D
-=09{=0D
-=09=09object-position: bottom;=0D
-=09=09background-position: bottom; /* for IE polyfill */=0D
-=09}=0D
-=09@media (orientation: landscape) {=0D
-=09=09#featured .pennant img=0D
-=09=09{=0D
-=09=09=09height: 70vh;=0D
-=09=09}=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Welcome                                                                =
       */=0D
-/*************************************************************************=
********/=0D
-=09=0D
-=09#welcome=0D
-=09{=0D
-=09=09padding: 4em 0em 3em 0em;=0D
-=09}=0D
-=09=0D
-/*************************************************************************=
********/=0D
-/* Horizontal menu                                                        =
       */=0D
-/*************************************************************************=
********/=0D
-=09.horiz-menu > ul=0D
-=09{=0D
-=09=09display: none !important;=0D
-=09}=0D
-=09.horiz-menu > article=0D
-=09{=0D
-=09=09display: block !important;=0D
-=09=09border: 1px solid #000000;=0D
-=09=09padding: 1em;=0D
-=09=09margin-bottom: 1em;=0D
-=09}=0D
-=09.horiz-menu > article > header=0D
-=09{=0D
-=09=09display: block !important;=0D
-=09}=0D
-=09.horiz-menu pre=0D
-=09{=0D
-=09=09border: 0px;=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Releases                                                               =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09#releases ul > li {=0D
-=09=09width: 48%;=0D
-=09}=0D
+/*
+=09Linear by TEMPLATED
+    templated.co @templatedco
+    Released for free under the Creative Commons Attribution 3.0 license (=
templated.co/license)
+*/
+
+/*************************************************************************=
********/
+/* Grid                                                                   =
       */
+/*************************************************************************=
********/
+
+=09.row > * {
+=09=09padding: 15px 0 0 0;
+=09=09float: none;
+=09=09margin-left: auto !important;
+=09=09margin-right: auto !important;
+=09}=09
+=09.row + .row > * {
+=09=09padding-top: 15px;
+=09}
+
+/*************************************************************************=
********/
+/* Basic                                                                  =
       */
+/*************************************************************************=
********/
+
+=09.only-desktop, .not-mobile
+=09{
+=09=09display: none !important;
+=09}
+
+=09body,input,textarea,select
+=09{
+=09=09line-height: 1.5em;
+=09=09font-size: 10.5pt;
+=09=09letter-spacing: 0;
+=09}
+
+=09body
+=09{
+=09=09background: url(../images/qemu_head_200_faint.png) no-repeat fixed c=
enter center;
+=09}
+=09=09body.homepage
+=09=09{
+=09=09=09background-position: center 200px;
+=09=09=09background-attachment: scroll;
+=09=09}
+=09=09body.fixed
+=09=09{
+=09=09=09background-position: center 80px;
+=09=09=09background-attachment: fixed;
+=09=09}
+
+=09#featured
+=09{
+=09=09padding-top: 250px;
+=09}
+=09@media (min-width:500px) {
+=09=09body
+=09=09{
+=09=09=09background-image: url(../images/qemu_head_400_faint.png);
+=09=09}
+=09=09#featured
+=09=09{
+=09=09=09padding-top: 50px;
+=09=09}
+=09}
+
+=09section,
+=09article
+=09{
+=09=09clear: both;
+=09=09margin: 2em 0 2em 0;
+=09}
+
+=09.container
+=09{
+=09=09padding: 0em 1em;
+=09}
+
+=09header
+=09{
+=09=09margin-bottom: 1.6em;
+=09}
+=09
+=09=09header .byline
+=09=09{
+=09=09=09font-size: 1.2em;
+=09=09}
+
+=09.button
+=09{
+=09=09display: block;
+=09=09width: 100%;
+=09=09text-align: center;
+=09}
+
+=09.homepage h1
+=09{
+=09=09font-size: 3em;
+=09=09padding-top: 0.6em;
+=09}
+
+=09h1, .homepage h2
+=09{
+=09=09font-size: 2em;
+=09}
+
+=09h2, .homepage h3
+=09{
+=09=09font-size: 1.6em;
+=09}
+
+=09h3, h4, h5, h6
+=09{
+=09=09font-size: 1.5em;
+=09}
+
+/*************************************************************************=
********/
+/* UI                                                                     =
       */
+/*************************************************************************=
********/
+
+=09#titleBar
+=09{
+=09=09width: 100%;
+=09=09background: #161616;
+=09=09height: 44px;
+=09=09overflow: hidden;
+=09=09position: fixed;
+=09=09margin-top: -44px;
+=09=09z-index: 2;
+=09}
+
+=09=09body.js {
+=09=09=09padding-top: 44px;
+=09=09}
+
+=09=09#titleBar .title
+=09=09{
+=09=09=09color: #fff;
+=09=09=09text-align: center;
+=09=09=09line-height: 44px;
+=09=09=09font-weight: 300;
+=09=09=09text-decoration: none;
+=09=09=09display: block;
+=09=09=09position: absolute;
+=09=09=09left: 0;
+=09=09=09top: 0;
+=09=09=09width: 100%;
+=09=09=09z-index: 1;
+=09=09}
+=09=09
+=09=09button[aria-controls=3D"nav"]
+=09=09{
+=09=09=09float: left;
+=09=09=09position: relative;
+=09=09=09left: 0;
+=09=09=09top: 0;
+=09=09=09width: 80px;
+=09=09=09height: 44px;
+=09=09=09cursor: pointer;
+=09=09=09z-index: 2;
+=09=09=09background: transparent;
+=09=09=09border: 0px;
+=09=09=09color: #808080;
+=09=09}
+
+=09=09=09button[aria-controls=3D"nav"] > span.fa
+=09=09=09{
+=09=09=09=09width: 20px;
+=09=09=09=09height: 12px;
+=09=09=09=09position: absolute;
+=09=09=09=09left: 12px;
+=09=09=09=09top: 10px;
+=09=09=09}
+
+=09=09=09button[aria-controls=3D"nav"]:active
+=09=09=09{
+=09=09=09=09color: #c0c0c0;
+=09=09=09}
+=09#nav
+=09{
+=09=09padding: 0em;
+=09=09background: #1f1f1f;
+=09}
+
+=09=09#titleBar + #nav {
+=09=09=09position: fixed;
+=09=09=09margin-left: -80%;
+=09=09=09width: 80%;
+=09=09=09height: 100%;
+=09=09=09z-index: 2;
+=09=09=09left: 0;
+=09=09=09top: 0;
+=09=09}
+
+=09=09#nav > ul=20
+=09=09{
+=09=09=09margin: 0em;
+=09=09=09padding: 0.3em;
+=09=09}
+
+=09=09#nav > ul > li
+=09=09{
+=09=09=09border-top: 1px solid white;
+=09=09=09margin: 0;
+=09=09=09padding: 0.3em;
+=09=09=09color: #ffffff;
+=09=09}
+
+=09=09#nav > ul > li:first-child
+=09=09{
+=09=09=09border-top: 0px;
+=09=09}
+=09
+=09=09#nav > ul > li > a,
+=09=09#nav > ul > li > span
+=09=09{
+=09=09=09display: block;
+=09=09=09padding: 0 1em 0 1em;
+=09=09=09letter-spacing: 1px;
+=09=09=09color: inherit;
+=09=09=09text-align: left;
+=09=09}
+=09=09
+/*************************************************************************=
********/
+/* Header                                                                 =
       */
+/*************************************************************************=
********/
+
+=09#header {
+=09=09height: 9em;
+=09}
+
+=09#header h1 {
+=09=09margin-bottom: 0.2em;
+=09}
+
+/*************************************************************************=
********/
+/* Logo                                                                   =
       */
+/*************************************************************************=
********/
+
+
+/*************************************************************************=
********/
+/* Columns                                                                =
       */
+/*************************************************************************=
********/
+
+=09#main, #footer-inner, #copyright-inner
+=09{
+=09=09margin-left: 0%;
+=09=09width: 100%;
+=09}
+
+=09#sidebar
+=09{
+=09=09margin-left: 0%;
+=09=09width: 100%;
+=09}
+
+/*************************************************************************=
********/
+/* Main                                                                   =
       */
+/*************************************************************************=
********/
+
+=09#main
+=09{
+=09=09padding: 2em 0em 1em 0em;
+=09}
+
+/*************************************************************************=
********/
+/* Sidebar                                                                =
       */
+/*************************************************************************=
********/
+=09
+=09#sidebar
+=09{
+=09=09clear: left;
+=09}
+
+=09#sidebar h1
+=09{
+=09=09font-size: 1.6em;
+=09}
+=09
+/*************************************************************************=
********/
+/* Footer                                                                 =
       */
+/*************************************************************************=
********/
+=09
+=09#footer
+=09{
+=09=09padding: 1em;
+=09}
+=09
+=09#footer ul
+=09{
+=09=09padding: 0.6em 0px;
+=09=09border-top: 1px solid white;
+=09}
+
+=09#footer ul:first-child
+=09{
+=09=09border-top: 0px;
+=09}
+=09
+/*************************************************************************=
********/
+/* Featured                                                               =
       */
+/*************************************************************************=
********/
+=09
+=09#featured
+=09{
+=09=09padding-bottom: 3em;
+=09}
+
+=09#featured h3
+=09{
+=09=09padding: 0.5em 0em;
+=09=09font-size: 1.4em;
+=09=09margin: 0em;
+=09}
+=09#featured h3+p
+=09{
+=09=09margin-top: 0em;
+=09}
+
+=09#featured .pennant a
+=09{
+=09=09cursor: inherit;
+=09}
+
+=09#featured .pennant img
+=09{
+=09=09object-position: bottom;
+=09=09background-position: bottom; /* for IE polyfill */
+=09}
+=09@media (orientation: landscape) {
+=09=09#featured .pennant img
+=09=09{
+=09=09=09height: 70vh;
+=09=09}
+=09}
+
+/*************************************************************************=
********/
+/* Welcome                                                                =
       */
+/*************************************************************************=
********/
+=09
+=09#welcome
+=09{
+=09=09padding: 4em 0em 3em 0em;
+=09}
+=09
+/*************************************************************************=
********/
+/* Horizontal menu                                                        =
       */
+/*************************************************************************=
********/
+=09.horiz-menu > ul
+=09{
+=09=09display: none !important;
+=09}
+=09.horiz-menu > article
+=09{
+=09=09display: block !important;
+=09=09border: 1px solid #000000;
+=09=09padding: 1em;
+=09=09margin-bottom: 1em;
+=09}
+=09.horiz-menu > article > header
+=09{
+=09=09display: block !important;
+=09}
+=09.horiz-menu pre
+=09{
+=09=09border: 0px;
+=09}
+
+/*************************************************************************=
********/
+/* Releases                                                               =
       */
+/*************************************************************************=
********/
+
+=09#releases ul > li {
+=09=09width: 48%;
+=09}
diff --git a/assets/css/style.css b/assets/css/style.css
index b828887..e09b383 100644
--- a/assets/css/style.css
+++ b/assets/css/style.css
@@ -1,592 +1,592 @@
-@charset 'UTF-8';=0D
-/*=0D
-=09Linear by TEMPLATED=0D
-    templated.co @templatedco=0D
-    Released for free under the Creative Commons Attribution 3.0 license (=
templated.co/license)=0D
-*/=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Basic                                                                  =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09body=0D
-=09{=0D
-=09=09margin: 0;=0D
-=09=09padding: 0;=0D
-=09=09background: #ffffff;=0D
-=09}=0D
-=0D
-=09body,input,textarea,select=0D
-=09{=0D
-=09=09font-family: 'Roboto', sans-serif;=0D
-=09=09font-size: 11pt;=0D
-=09=09font-weight: 300;=0D
-=09=09line-height: 1.75em;=0D
-=09=09color: #000000;=0D
-=09}=0D
-=0D
-=09strong,b,a=0D
-=09{=0D
-=09=09font-weight: 400;=0D
-=09}=0D
-=09strong a,b a=0D
-=09{=0D
-=09=09font-weight: 500;=0D
-=09}=0D
-=09h1,.homepage h2=0D
-=09{=0D
-=09=09font-weight: 300;=0D
-=09=09color: black;=0D
-=09}=0D
-=09h2,h3,h4,h5,h6=0D
-=09{=0D
-=09=09font-weight: 400;=0D
-=09=09color: #802400;=0D
-=09}=0D
-=09=0D
-=09pre,code,samp,tt=0D
-=09{=0D
-=09=09font-family: 'Roboto Mono', monospace;=0D
-=09}=0D
-=09pre,code=0D
-=09{=0D
-=09=09background: rgba(0,0,0,0.05);=0D
-=09}=0D
-=0D
-=09.homepage h1 {=0D
-=09=09margin: 0;=0D
-=09}=0D
-=0D
-=09=09h1, .homepage h2=0D
-=09=09{=0D
-=09=09=09letter-spacing: -0.025em;=0D
-=09=09=09line-height: 1.025em;=0D
-=09=09=09margin-top: -0.125em;=0D
-=09=09}=0D
-=0D
-=09=09h2, .homepage h3=0D
-=09=09{=0D
-=09=09=09font-size: 2em;=0D
-=09=09}=0D
-=09=0D
-=09=09h1 a, h2 a, h3 a, h4 a, h5 a, h6 a=0D
-=09=09{=0D
-=09=09=09color: inherit;=0D
-=09=09=09font-weight: inherit;=0D
-=09=09}=0D
-=09=0D
-=09=09h1 a:hover, h2 a:hover, h3 a:hover, h4 a:hover, h5 a:hover, h6 a:hov=
er=0D
-=09=09{=0D
-=09=09=09text-decoration: none;=0D
-=09=09}=0D
-=09=09=0D
-=09pre=0D
-=09{=0D
-               padding: 1em;=0D
-               border: 1px #000000 solid;=0D
-=09=09max-width: 100%;=0D
-=09=09overflow-x: auto;=0D
-=09}=0D
-=0D
-=09a=0D
-=09{=0D
-=09=09text-decoration: none;=0D
-=09=09color: #F03B11;=0D
-=09}=0D
-=09=0D
-=09a:hover=0D
-=09{=0D
-=09=09text-decoration: underline;=0D
-=09}=0D
-=0D
-=09sub=0D
-=09{=0D
-=09=09position: relative;=0D
-=09=09top: 0.5em;=0D
-=09=09font-size: 0.8em;=0D
-=09}=0D
-=09=0D
-=09sup=0D
-=09{=0D
-=09=09position: relative;=0D
-=09=09top: -0.5em;=0D
-=09=09font-size: 0.8em;=0D
-=09}=0D
-=09=0D
-=09hr=0D
-=09{=0D
-=09=09border: 0;=0D
-=09=09border-top: solid 1px #333;=0D
-=09=09margin: 2em 0 2em 0;=0D
-=09=09padding: 0;=0D
-=09}=0D
-=09=0D
-=09blockquote=0D
-=09{=0D
-=09=09border-left: solid 0.5em #333;=0D
-=09=09padding: 1em 0 1em 2em;=0D
-=09=09font-style: italic;=0D
-=09}=0D
-=09=0D
-=09p, ul, ol, dl, table=0D
-=09{=0D
-=09=09margin-bottom: 1em;=0D
-=09}=0D
-=0D
-=09header=0D
-=09{=0D
-=09=09margin-bottom: 1em;=0D
-=09}=0D
-=09=0D
-=09=09header h1, header h2, header h3, header h4, header h5, header h6=0D
-=09=09{=0D
-=09=09=09margin-bottom: 0em;=0D
-=09=09}=0D
-=0D
-=09=09header .byline=0D
-=09=09{=0D
-=09=09=09display: block;=0D
-=09=09=09margin: 1.5em 0 0 0;=0D
-=09=09=09padding: 0 0 0.5em 0;=0D
-=09=09}=0D
-=09=09=0D
-=09=09.posted {=0D
-=09=09=09letter-spacing: 1px;=0D
-=09=09=09text-transform: uppercase;=0D
-=09=09=09font-size: 80%;=0D
-=09=09=09color: #999999;=0D
-=09=09}=0D
-=0D
-=09footer=0D
-=09{=0D
-=09=09margin-top: 1em;=0D
-=09}=0D
-=0D
-=09.clear=0D
-=09{=0D
-=09=09clear: both;=0D
-=09}=0D
-=0D
-=09.pennant=0D
-=09{=0D
-=09=09color: #999999;=0D
-=09}=0D
-=0D
-=09/* Sections/Articles */=0D
-=09=0D
-=09=09section,=0D
-=09=09article=0D
-=09=09{=0D
-=09=09=09margin-bottom: 3em;=0D
-=09=09}=0D
-=09=09=0D
-=09=09section > :last-child,=0D
-=09=09article > :last-child=0D
-=09=09{=0D
-=09=09=09margin-bottom: 0;=0D
-=09=09}=0D
-=0D
-=09=09section:last-child,=0D
-=09=09article:last-child=0D
-=09=09{=0D
-=09=09=09margin-bottom: 0;=0D
-=09=09}=0D
-=0D
-=09=09.row > section,=0D
-=09=09.row > article=0D
-=09=09{=0D
-=09=09=09margin-bottom: 0;=0D
-=09=09}=0D
-=0D
-=09/* Images */=0D
-=0D
-=09=09img {=0D
-=09=09=09max-width: 100%;=0D
-=09=09}=0D
-=0D
-=09=09.image=0D
-=09=09{=0D
-=09=09=09display: inline-block;=0D
-=09=09}=0D
-=09=09=0D
-=09=09=09.image img=0D
-=09=09=09{=0D
-=09=09=09=09display: block;=0D
-=09=09=09=09width: 100%;=0D
-=09=09=09}=0D
-=0D
-=09=09=09.image.featured=0D
-=09=09=09{=0D
-=09=09=09=09display: block;=0D
-=09=09=09=09width: 100%;=0D
-=09=09=09=09margin: 0 0 2em 0;=0D
-=09=09=09}=0D
-=09=09=09=0D
-=09=09=09.image.full=0D
-=09=09=09{=0D
-=09=09=09=09display: block;=0D
-=09=09=09=09width: 100%;=0D
-=09=09=09=09margin-bottom: 2em;=0D
-=09=09=09}=0D
-=09=09=09=0D
-=09=09=09.image.left=0D
-=09=09=09{=0D
-=09=09=09=09float: left;=0D
-=09=09=09=09margin: 0 2em 2em 0;=0D
-=09=09=09}=0D
-=09=09=09=0D
-=09=09=09.image.centered=0D
-=09=09=09{=0D
-=09=09=09=09display: block;=0D
-=09=09=09=09margin: 0 0 2em 0;=0D
-=09=09=09}=0D
-=0D
-=09=09=09=09.image.centered img=0D
-=09=09=09=09{=0D
-=09=09=09=09=09margin: 0 auto;=0D
-=09=09=09=09=09width: auto;=0D
-=09=09=09=09}=0D
-=0D
-=09/* Lists */=0D
-=0D
-=09=09ul.style=0D
-=09=09{=0D
-=09=09=09margin-bottom: 0em;=0D
-=09=09=09padding: 0;=0D
-=09=09}=0D
-=09=09=0D
-=09=09ul.style li {=0D
-=09=09=09margin: 0;=0D
-=09=09=09padding: 0em 0em 1.5em 0em;=0D
-=09=09=09list-style: none;=0D
-=09=09}=0D
-=09=09=0D
-=09=09ul.category=0D
-=09=09{=0D
-=09=09=09margin: 0;=0D
-=09=09=09padding: 0;=0D
-=09=09=09letter-spacing: 1px;=0D
-=09=09=09text-transform: uppercase;=0D
-=09=09=09font-size: 80%;=0D
-=09=09=09color: #999999;=0D
-=09=09}=0D
-=0D
-=09=09ul.category li {=0D
-=09=09=09display: inline;=0D
-=09=09=09margin: 0;=0D
-=09=09=09padding: 0;=0D
-=09=09=09list-style: none;=0D
-=09=09=09padding-right: 1em;=0D
-=09=09}=0D
-=09=09ul.category li::before {=0D
-=09=09=09padding-right: 0.3em;=0D
-=09=09}=0D
-=0D
-=0D
-=09/* Buttons */=0D
-=09=09=0D
-=09.button=0D
-=09{=0D
-=09=09position: relative;=0D
-=09=09display: inline-block;=0D
-=09=09background: #F03B11;=0D
-=09=09padding: 0.8em 2em;=0D
-=09=09font-size: 1.2em;=0D
-=09=09color: #FFF;=0D
-=09=09-moz-transition: color 0.35s ease-in-out, background-color 0.35s eas=
e-in-out;=0D
-=09=09-webkit-transition: color 0.35s ease-in-out, background-color 0.35s =
ease-in-out;=0D
-=09=09-o-transition: color 0.35s ease-in-out, background-color 0.35s ease-=
in-out;=0D
-=09=09-ms-transition: color 0.35s ease-in-out, background-color 0.35s ease=
-in-out;=0D
-=09=09transition: color 0.35s ease-in-out, background-color 0.35s ease-in-=
out;=0D
-=09=09text-align: center;=0D
-=09=09border-radius: 0.25em;=0D
-=09}=0D
-=0D
-=09.button:hover=0D
-=09{=0D
-=09=09background: #F01111;=0D
-=09=09text-decoration: none;=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Icons                                                                  =
       */=0D
-/* Powered by Font Awesome by Dave Gandy | http://fontawesome.io          =
       */=0D
-/* Licensed under the SIL OFL 1.1 (font), MIT (CSS)                       =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09.fa=0D
-=09{=0D
-=09=09text-decoration: none;=0D
-=09}=0D
-=0D
-=09=09.fa.solo=0D
-=09=09{=0D
-=09=09}=0D
-=09=09=0D
-=09=09=09.fa.solo span=0D
-=09=09=09{=0D
-=09=09=09=09display: none;=0D
-=09=09=09}=0D
-=0D
-=09=09.fa:before=0D
-=09=09{=0D
-=09=09=09display:inline-block;=0D
-=09=09=09font-family: FontAwesome;=0D
-=09=09=09font-size: 1.25em;=0D
-=09=09=09text-decoration: none;=0D
-=09=09=09font-style: normal;=0D
-=09=09=09font-weight: normal;=0D
-=09=09=09line-height: 1;=0D
-=09=09=09-webkit-font-smoothing:antialiased;=0D
-=09=09=09-moz-osx-font-smoothing:grayscale;=0D
-=09=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Social Icon Styles                                                     =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09ul.contact=0D
-=09{=0D
-=09=09padding: 1.5em 0 0 0;=0D
-=09=09list-style: none;=0D
-=09=09cursor: default;=0D
-=09}=0D
-=09=0D
-=09ul.contact li=0D
-=09{=0D
-=09=09display: inline-block;=0D
-=09=09margin: 0 1em;=0D
-=09}=0D
-=09=0D
-=09ul.contact li span=0D
-=09{=0D
-=09=09display: none;=0D
-=09=09margin: 0;=0D
-=09=09padding: 0;=0D
-=09}=0D
-=09=0D
-=09ul.contact li a=0D
-=09{=0D
-=09=09color: inherit;=0D
-=09=09font-size: 1.75em;=0D
-=09=09display: inline-block;=0D
-=09=09-moz-transition: color 0.35s ease-in-out, background-color 0.35s eas=
e-in-out;=0D
-=09=09-webkit-transition: color 0.35s ease-in-out, background-color 0.35s =
ease-in-out;=0D
-=09=09-o-transition: color 0.35s ease-in-out, background-color 0.35s ease-=
in-out;=0D
-=09=09-ms-transition: color 0.35s ease-in-out, background-color 0.35s ease=
-in-out;=0D
-=09=09transition: color 0.35s ease-in-out, background-color 0.35s ease-in-=
out;=0D
-=09}=0D
-=09=0D
-=09ul.contact li a:hover=0D
-=09{=0D
-=09=09color: #fff;=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Header                                                                 =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09#header=0D
-=09{=0D
-=09=09position: relative;=0D
-=09=09background: #f03b11;=0D
-=09=09background: -webkit-linear-gradient(top, #f03b11 0%,#f01139 100%);=
=0D
-=09=09background: linear-gradient(to bottom, #f03b11 0%,#f01139 100%);=0D
-=09=09background-size: cover;=0D
-=09=09text-align: center;=0D
-=09}=0D
-=09=0D
-=09=09#header:after=0D
-=09=09{=0D
-=09=09=09content: '';=0D
-=09=09=09position: relative;=0D
-=09=09=09width: 0;=0D
-=09=09=09height: 6em;=0D
-=09=09=09left: 0;=0D
-=09=09=09top: 0;=0D
-=09=09=09float: left;=0D
-=09=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Logo                                                                   =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09=09#header h1=0D
-=09=09{=0D
-=09=09=09color: #FFF;=0D
-=09=09=09text-decoration: none;=0D
-=09=09=09font-weight: 300;=0D
-=09=09=09line-height: 1em;=0D
-=09=09}=0D
-=09=09#header .tag=0D
-=09=09{=0D
-=09=09=09font-size: 1.4em;=0D
-=09=09=09color: #FFF;=0D
-=09=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Columns                                                                =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09#main, #copyright-inner=0D
-=09{=0D
-=09=09margin-left: 16.667%;=0D
-=09=09width: 66.667%;=0D
-=09}=0D
-=0D
-=09#sidebar=0D
-=09{=0D
-=09=09width: 16.667%;=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Main                                                                   =
       */=0D
-/*************************************************************************=
********/=0D
-=0D
-=09#main=0D
-=09{=0D
-=09=09clear: left;=0D
-=09}=0D
-=0D
-=09#main, #sidebar=0D
-=09{=0D
-=09=09position: relative;=0D
-=09=09float: left;=0D
-=09=09padding-bottom: 3em;=0D
-=09}=0D
-=09=0D
-=09.homepage header, .homepage p=0D
-=09{=0D
-=09=09text-align: center;=0D
-=09}=0D
-=09=0D
-=09#sidebar header=0D
-=09{=0D
-=09=09margin-bottom: 0.50em;=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Releases                                                               =
       */=0D
-/*************************************************************************=
********/=0D
-=09#releases=0D
-=09{=0D
-=09=09margin: 2em 0em;=0D
-=09=09text-align: center;=0D
-=09}=0D
-=0D
-=09#releases ul, #releases p=0D
-=09{=0D
-=09=09margin: 0em;=0D
-=09}=0D
-=09=0D
-=09#releases ul > li=0D
-=09{=0D
-=09=09list-style: none;=0D
-=09=09display: inline-block;=0D
-=09=09width: 40%;=0D
-=09=09margin: 1em 0em;=0D
-=09}=0D
-=0D
-=09#releases ul > li > strong=0D
-=09{=0D
-=09=09list-style: none;=0D
-=09=09display: block;=0D
-=09=09font-size: 3em;=0D
-=09=09margin-bottom: 0.2em;=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Footer                                                                 =
       */=0D
-/*************************************************************************=
********/=0D
-=09=0D
-=09#footer=0D
-=09{=0D
-=09=09position: relative;=0D
-=09=09clear: left;=0D
-=09=09background: #401200;=0D
-=09=09color: #FFF;=0D
-=09}=0D
-=09=0D
-=09#footer a=0D
-=09{=0D
-=09=09color: inherit;=0D
-=09}=0D
-=09=0D
-=09#footer ul=0D
-=09{=0D
-=09=09vertical-align: top;=0D
-=09}=0D
-=0D
-=09#footer ul, #footer ul > li=0D
-=09{=0D
-=09=09padding: 0;=0D
-=09=09margin: 0=0D
-=09}=0D
-=0D
-/*************************************************************************=
********/=0D
-/* Copyright                                                              =
       */=0D
-/*************************************************************************=
********/=0D
-=09=0D
-=09#copyright=0D
-=09{=0D
-=09=09clear: left;=0D
-=09=09border-top: 1px solid #aaaaaa;=0D
-=09=09position: relative;=0D
-=09=09color: #aaaaaa;=0D
-=09=09background: #ffffff;=0D
-=09=09padding: 1em 0em;=0D
-=09}=0D
-=09=0D
-=09#copyright a=0D
-=09{=0D
-=09=09color: inherit;=0D
-=09}=0D
-=09=0D
-/*************************************************************************=
********/=0D
-/* Featured                                                               =
       */=0D
-/*************************************************************************=
********/=0D
-=09=0D
-=09#featured=0D
-=09{=0D
-=09=09position: relative;=0D
-=09=09background: rgba(0,0,0,0.05);=0D
-=09=09text-align: center;=0D
-=09=09margin-bottom: 2em;=0D
-=09}=0D
-=09=0D
-=09#featured header=0D
-=09{=0D
-=09=09border-bottom: 1px solid #333333;=0D
-=09}=0D
-=09#featured h2=0D
-=09{=0D
-=09=09margin-bottom: 0em;=0D
-=09}=0D
-=0D
-=09#featured h3=0D
-=09{=0D
-=09=09padding: 1.5em 0em;=0D
-=09=09font-size: 1.6em;=0D
-=09=09display: block;=0D
-=09=09font-weight: 300;=0D
-=09=09height: 2em;=0D
-=09=09margin: 0em 0em 1em 0em;=0D
-=09}=0D
-=0D
-=09#featured .pennant=0D
-=09{=0D
-=09=09font-size: 4em;=0D
-=09}=0D
-=0D
-=09#featured .pennant img=0D
-=09{=0D
-=09=09width: 100%;=0D
-=09=09object-fit: contain;=0D
-=09=09background-size: contain; /* for IE polyfill */=0D
-=09=09background-repeat: no-repeat; /* for IE polyfill */=0D
-=09}=0D
-=0D
-=09#featured .button=0D
-=09{=0D
-=09=09margin-top: 1.5em;=0D
-=09}=0D
+@charset 'UTF-8';
+/*
+=09Linear by TEMPLATED
+    templated.co @templatedco
+    Released for free under the Creative Commons Attribution 3.0 license (=
templated.co/license)
+*/
+
+/*************************************************************************=
********/
+/* Basic                                                                  =
       */
+/*************************************************************************=
********/
+
+=09body
+=09{
+=09=09margin: 0;
+=09=09padding: 0;
+=09=09background: #ffffff;
+=09}
+
+=09body,input,textarea,select
+=09{
+=09=09font-family: 'Roboto', sans-serif;
+=09=09font-size: 11pt;
+=09=09font-weight: 300;
+=09=09line-height: 1.75em;
+=09=09color: #000000;
+=09}
+
+=09strong,b,a
+=09{
+=09=09font-weight: 400;
+=09}
+=09strong a,b a
+=09{
+=09=09font-weight: 500;
+=09}
+=09h1,.homepage h2
+=09{
+=09=09font-weight: 300;
+=09=09color: black;
+=09}
+=09h2,h3,h4,h5,h6
+=09{
+=09=09font-weight: 400;
+=09=09color: #802400;
+=09}
+=09
+=09pre,code,samp,tt
+=09{
+=09=09font-family: 'Roboto Mono', monospace;
+=09}
+=09pre,code
+=09{
+=09=09background: rgba(0,0,0,0.05);
+=09}
+
+=09.homepage h1 {
+=09=09margin: 0;
+=09}
+
+=09=09h1, .homepage h2
+=09=09{
+=09=09=09letter-spacing: -0.025em;
+=09=09=09line-height: 1.025em;
+=09=09=09margin-top: -0.125em;
+=09=09}
+
+=09=09h2, .homepage h3
+=09=09{
+=09=09=09font-size: 2em;
+=09=09}
+=09
+=09=09h1 a, h2 a, h3 a, h4 a, h5 a, h6 a
+=09=09{
+=09=09=09color: inherit;
+=09=09=09font-weight: inherit;
+=09=09}
+=09
+=09=09h1 a:hover, h2 a:hover, h3 a:hover, h4 a:hover, h5 a:hover, h6 a:hov=
er
+=09=09{
+=09=09=09text-decoration: none;
+=09=09}
+=09=09
+=09pre
+=09{
+               padding: 1em;
+               border: 1px #000000 solid;
+=09=09max-width: 100%;
+=09=09overflow-x: auto;
+=09}
+
+=09a
+=09{
+=09=09text-decoration: none;
+=09=09color: #F03B11;
+=09}
+=09
+=09a:hover
+=09{
+=09=09text-decoration: underline;
+=09}
+
+=09sub
+=09{
+=09=09position: relative;
+=09=09top: 0.5em;
+=09=09font-size: 0.8em;
+=09}
+=09
+=09sup
+=09{
+=09=09position: relative;
+=09=09top: -0.5em;
+=09=09font-size: 0.8em;
+=09}
+=09
+=09hr
+=09{
+=09=09border: 0;
+=09=09border-top: solid 1px #333;
+=09=09margin: 2em 0 2em 0;
+=09=09padding: 0;
+=09}
+=09
+=09blockquote
+=09{
+=09=09border-left: solid 0.5em #333;
+=09=09padding: 1em 0 1em 2em;
+=09=09font-style: italic;
+=09}
+=09
+=09p, ul, ol, dl, table
+=09{
+=09=09margin-bottom: 1em;
+=09}
+
+=09header
+=09{
+=09=09margin-bottom: 1em;
+=09}
+=09
+=09=09header h1, header h2, header h3, header h4, header h5, header h6
+=09=09{
+=09=09=09margin-bottom: 0em;
+=09=09}
+
+=09=09header .byline
+=09=09{
+=09=09=09display: block;
+=09=09=09margin: 1.5em 0 0 0;
+=09=09=09padding: 0 0 0.5em 0;
+=09=09}
+=09=09
+=09=09.posted {
+=09=09=09letter-spacing: 1px;
+=09=09=09text-transform: uppercase;
+=09=09=09font-size: 80%;
+=09=09=09color: #999999;
+=09=09}
+
+=09footer
+=09{
+=09=09margin-top: 1em;
+=09}
+
+=09.clear
+=09{
+=09=09clear: both;
+=09}
+
+=09.pennant
+=09{
+=09=09color: #999999;
+=09}
+
+=09/* Sections/Articles */
+=09
+=09=09section,
+=09=09article
+=09=09{
+=09=09=09margin-bottom: 3em;
+=09=09}
+=09=09
+=09=09section > :last-child,
+=09=09article > :last-child
+=09=09{
+=09=09=09margin-bottom: 0;
+=09=09}
+
+=09=09section:last-child,
+=09=09article:last-child
+=09=09{
+=09=09=09margin-bottom: 0;
+=09=09}
+
+=09=09.row > section,
+=09=09.row > article
+=09=09{
+=09=09=09margin-bottom: 0;
+=09=09}
+
+=09/* Images */
+
+=09=09img {
+=09=09=09max-width: 100%;
+=09=09}
+
+=09=09.image
+=09=09{
+=09=09=09display: inline-block;
+=09=09}
+=09=09
+=09=09=09.image img
+=09=09=09{
+=09=09=09=09display: block;
+=09=09=09=09width: 100%;
+=09=09=09}
+
+=09=09=09.image.featured
+=09=09=09{
+=09=09=09=09display: block;
+=09=09=09=09width: 100%;
+=09=09=09=09margin: 0 0 2em 0;
+=09=09=09}
+=09=09=09
+=09=09=09.image.full
+=09=09=09{
+=09=09=09=09display: block;
+=09=09=09=09width: 100%;
+=09=09=09=09margin-bottom: 2em;
+=09=09=09}
+=09=09=09
+=09=09=09.image.left
+=09=09=09{
+=09=09=09=09float: left;
+=09=09=09=09margin: 0 2em 2em 0;
+=09=09=09}
+=09=09=09
+=09=09=09.image.centered
+=09=09=09{
+=09=09=09=09display: block;
+=09=09=09=09margin: 0 0 2em 0;
+=09=09=09}
+
+=09=09=09=09.image.centered img
+=09=09=09=09{
+=09=09=09=09=09margin: 0 auto;
+=09=09=09=09=09width: auto;
+=09=09=09=09}
+
+=09/* Lists */
+
+=09=09ul.style
+=09=09{
+=09=09=09margin-bottom: 0em;
+=09=09=09padding: 0;
+=09=09}
+=09=09
+=09=09ul.style li {
+=09=09=09margin: 0;
+=09=09=09padding: 0em 0em 1.5em 0em;
+=09=09=09list-style: none;
+=09=09}
+=09=09
+=09=09ul.category
+=09=09{
+=09=09=09margin: 0;
+=09=09=09padding: 0;
+=09=09=09letter-spacing: 1px;
+=09=09=09text-transform: uppercase;
+=09=09=09font-size: 80%;
+=09=09=09color: #999999;
+=09=09}
+
+=09=09ul.category li {
+=09=09=09display: inline;
+=09=09=09margin: 0;
+=09=09=09padding: 0;
+=09=09=09list-style: none;
+=09=09=09padding-right: 1em;
+=09=09}
+=09=09ul.category li::before {
+=09=09=09padding-right: 0.3em;
+=09=09}
+
+
+=09/* Buttons */
+=09=09
+=09.button
+=09{
+=09=09position: relative;
+=09=09display: inline-block;
+=09=09background: #F03B11;
+=09=09padding: 0.8em 2em;
+=09=09font-size: 1.2em;
+=09=09color: #FFF;
+=09=09-moz-transition: color 0.35s ease-in-out, background-color 0.35s eas=
e-in-out;
+=09=09-webkit-transition: color 0.35s ease-in-out, background-color 0.35s =
ease-in-out;
+=09=09-o-transition: color 0.35s ease-in-out, background-color 0.35s ease-=
in-out;
+=09=09-ms-transition: color 0.35s ease-in-out, background-color 0.35s ease=
-in-out;
+=09=09transition: color 0.35s ease-in-out, background-color 0.35s ease-in-=
out;
+=09=09text-align: center;
+=09=09border-radius: 0.25em;
+=09}
+
+=09.button:hover
+=09{
+=09=09background: #F01111;
+=09=09text-decoration: none;
+=09}
+
+/*************************************************************************=
********/
+/* Icons                                                                  =
       */
+/* Powered by Font Awesome by Dave Gandy | http://fontawesome.io          =
       */
+/* Licensed under the SIL OFL 1.1 (font), MIT (CSS)                       =
       */
+/*************************************************************************=
********/
+
+=09.fa
+=09{
+=09=09text-decoration: none;
+=09}
+
+=09=09.fa.solo
+=09=09{
+=09=09}
+=09=09
+=09=09=09.fa.solo span
+=09=09=09{
+=09=09=09=09display: none;
+=09=09=09}
+
+=09=09.fa:before
+=09=09{
+=09=09=09display:inline-block;
+=09=09=09font-family: FontAwesome;
+=09=09=09font-size: 1.25em;
+=09=09=09text-decoration: none;
+=09=09=09font-style: normal;
+=09=09=09font-weight: normal;
+=09=09=09line-height: 1;
+=09=09=09-webkit-font-smoothing:antialiased;
+=09=09=09-moz-osx-font-smoothing:grayscale;
+=09=09}
+
+/*************************************************************************=
********/
+/* Social Icon Styles                                                     =
       */
+/*************************************************************************=
********/
+
+=09ul.contact
+=09{
+=09=09padding: 1.5em 0 0 0;
+=09=09list-style: none;
+=09=09cursor: default;
+=09}
+=09
+=09ul.contact li
+=09{
+=09=09display: inline-block;
+=09=09margin: 0 1em;
+=09}
+=09
+=09ul.contact li span
+=09{
+=09=09display: none;
+=09=09margin: 0;
+=09=09padding: 0;
+=09}
+=09
+=09ul.contact li a
+=09{
+=09=09color: inherit;
+=09=09font-size: 1.75em;
+=09=09display: inline-block;
+=09=09-moz-transition: color 0.35s ease-in-out, background-color 0.35s eas=
e-in-out;
+=09=09-webkit-transition: color 0.35s ease-in-out, background-color 0.35s =
ease-in-out;
+=09=09-o-transition: color 0.35s ease-in-out, background-color 0.35s ease-=
in-out;
+=09=09-ms-transition: color 0.35s ease-in-out, background-color 0.35s ease=
-in-out;
+=09=09transition: color 0.35s ease-in-out, background-color 0.35s ease-in-=
out;
+=09}
+=09
+=09ul.contact li a:hover
+=09{
+=09=09color: #fff;
+=09}
+
+/*************************************************************************=
********/
+/* Header                                                                 =
       */
+/*************************************************************************=
********/
+
+=09#header
+=09{
+=09=09position: relative;
+=09=09background: #f03b11;
+=09=09background: -webkit-linear-gradient(top, #f03b11 0%,#f01139 100%);
+=09=09background: linear-gradient(to bottom, #f03b11 0%,#f01139 100%);
+=09=09background-size: cover;
+=09=09text-align: center;
+=09}
+=09
+=09=09#header:after
+=09=09{
+=09=09=09content: '';
+=09=09=09position: relative;
+=09=09=09width: 0;
+=09=09=09height: 6em;
+=09=09=09left: 0;
+=09=09=09top: 0;
+=09=09=09float: left;
+=09=09}
+
+/*************************************************************************=
********/
+/* Logo                                                                   =
       */
+/*************************************************************************=
********/
+
+=09=09#header h1
+=09=09{
+=09=09=09color: #FFF;
+=09=09=09text-decoration: none;
+=09=09=09font-weight: 300;
+=09=09=09line-height: 1em;
+=09=09}
+=09=09#header .tag
+=09=09{
+=09=09=09font-size: 1.4em;
+=09=09=09color: #FFF;
+=09=09}
+
+/*************************************************************************=
********/
+/* Columns                                                                =
       */
+/*************************************************************************=
********/
+
+=09#main, #copyright-inner
+=09{
+=09=09margin-left: 16.667%;
+=09=09width: 66.667%;
+=09}
+
+=09#sidebar
+=09{
+=09=09width: 16.667%;
+=09}
+
+/*************************************************************************=
********/
+/* Main                                                                   =
       */
+/*************************************************************************=
********/
+
+=09#main
+=09{
+=09=09clear: left;
+=09}
+
+=09#main, #sidebar
+=09{
+=09=09position: relative;
+=09=09float: left;
+=09=09padding-bottom: 3em;
+=09}
+=09
+=09.homepage header, .homepage p
+=09{
+=09=09text-align: center;
+=09}
+=09
+=09#sidebar header
+=09{
+=09=09margin-bottom: 0.50em;
+=09}
+
+/*************************************************************************=
********/
+/* Releases                                                               =
       */
+/*************************************************************************=
********/
+=09#releases
+=09{
+=09=09margin: 2em 0em;
+=09=09text-align: center;
+=09}
+
+=09#releases ul, #releases p
+=09{
+=09=09margin: 0em;
+=09}
+=09
+=09#releases ul > li
+=09{
+=09=09list-style: none;
+=09=09display: inline-block;
+=09=09width: 40%;
+=09=09margin: 1em 0em;
+=09}
+
+=09#releases ul > li > strong
+=09{
+=09=09list-style: none;
+=09=09display: block;
+=09=09font-size: 3em;
+=09=09margin-bottom: 0.2em;
+=09}
+
+/*************************************************************************=
********/
+/* Footer                                                                 =
       */
+/*************************************************************************=
********/
+=09
+=09#footer
+=09{
+=09=09position: relative;
+=09=09clear: left;
+=09=09background: #401200;
+=09=09color: #FFF;
+=09}
+=09
+=09#footer a
+=09{
+=09=09color: inherit;
+=09}
+=09
+=09#footer ul
+=09{
+=09=09vertical-align: top;
+=09}
+
+=09#footer ul, #footer ul > li
+=09{
+=09=09padding: 0;
+=09=09margin: 0
+=09}
+
+/*************************************************************************=
********/
+/* Copyright                                                              =
       */
+/*************************************************************************=
********/
+=09
+=09#copyright
+=09{
+=09=09clear: left;
+=09=09border-top: 1px solid #aaaaaa;
+=09=09position: relative;
+=09=09color: #aaaaaa;
+=09=09background: #ffffff;
+=09=09padding: 1em 0em;
+=09}
+=09
+=09#copyright a
+=09{
+=09=09color: inherit;
+=09}
+=09
+/*************************************************************************=
********/
+/* Featured                                                               =
       */
+/*************************************************************************=
********/
+=09
+=09#featured
+=09{
+=09=09position: relative;
+=09=09background: rgba(0,0,0,0.05);
+=09=09text-align: center;
+=09=09margin-bottom: 2em;
+=09}
+=09
+=09#featured header
+=09{
+=09=09border-bottom: 1px solid #333333;
+=09}
+=09#featured h2
+=09{
+=09=09margin-bottom: 0em;
+=09}
+
+=09#featured h3
+=09{
+=09=09padding: 1.5em 0em;
+=09=09font-size: 1.6em;
+=09=09display: block;
+=09=09font-weight: 300;
+=09=09height: 2em;
+=09=09margin: 0em 0em 1em 0em;
+=09}
+
+=09#featured .pennant
+=09{
+=09=09font-size: 4em;
+=09}
+
+=09#featured .pennant img
+=09{
+=09=09width: 100%;
+=09=09object-fit: contain;
+=09=09background-size: contain; /* for IE polyfill */
+=09=09background-repeat: no-repeat; /* for IE polyfill */
+=09}
+
+=09#featured .button
+=09{
+=09=09margin-top: 1.5em;
+=09}
diff --git a/index.html b/index.html
index 1de3fe3..4c65101 100644
--- a/index.html
+++ b/index.html
@@ -1,89 +1,89 @@
----=0D
-title: QEMU=0D
-layout: home=0D
-colorbox: True=0D
----=0D
-=09<!-- Header -->=0D
-=09<div id=3D"header">=0D
-=09=09<div class=3D"container">=0D
-=09=09=09<h1>QEMU</h1>=0D
-=09=09=09<span class=3D"tag">the FAST! processor emulator</span>=0D
-=09=09</div>=0D
-=09</div>=0D
-=09=0D
-<!-- Featured -->=0D
-<div id=3D"featured">=0D
-=09<div class=3D"container">=0D
-=09=09<header>=0D
-=09=09=09<h2>What is QEMU?</h2>=0D
-=09=09=09<p>QEMU is a generic and open source machine emulator and virtual=
izer.</p>=0D
-=09=09</header>=0D
-=09=09<div class=3D"row">=0D
-=09=09=09<section class=3D"4u">=0D
-=09=09=09=09<div class=3D"pennant">{% include screenshot.html offset=3D0 l=
imit=3D1 %}</div>=0D
-=09=09=09=09<h3>Full-system<br class=3D"only-desktop"> emulation</h3>=0D
-=09=09=09=09<p>Run operating systems for any machine, on any supported arc=
hitecture</p>=0D
-=09=09=09</section>=0D
-=09=09=09<section class=3D"4u">=0D
-=09=09=09=09<div class=3D"pennant">{% include screenshot.html offset=3D1 l=
imit=3D1 %}</div>=0D
-=09=09=09=09<h3>User-mode<br class=3D"only-desktop"> emulation</h3>=0D
-=09=09=09=09<p>Run programs for another Linux/BSD target, on any supported=
 architecture</p>=0D
-=09=09=09</section>=0D
-=09=09=09<section class=3D"4u">=0D
-=09=09=09=09<div class=3D"pennant">{% include screenshot.html offset=3D2 l=
imit=3D1 %}</div>=0D
-=09=09=09=09<h3>Virtualization</h3>=0D
-=09=09=09=09<p>Run KVM and Xen virtual machines with near native performan=
ce</p>=0D
-=09=09=09</section>=0D
-=09=09=09<section style=3D"display: none;">=0D
-=09=09=09{% include screenshot.html offset=3D3 limit=3D10 %}=0D
-=09=09=09</section>=0D
-=0D
-<script src=3D"/assets/js/object-fit.js"></script>=0D
-<script>=0D
-window.hasColorBox =3D false;=0D
-$(window).on("load resize", function() {=0D
-    isMobile =3D window.innerWidth < 700;=0D
-    if (isMobile && window.hasColorBox) {=0D
-        window.hasColorBox =3D false;=0D
-        $.colorbox.remove();=0D
-    } else if (!isMobile && !window.hasColorBox) {=0D
-=09window.hasColorBox =3D true;=0D
-=09$('.colorbox').colorbox({=0D
-            'rel': '.colorbox',=0D
-            'title': function() { return $(this).attr("data-title"); }=0D
-        });=0D
-    }=0D
-});=0D
-// make links to images inactive, except through the colorbox=0D
-$('.colorbox').on("click.random-namespace", function() {=0D
-    return window.hasColorBox;=0D
-})=0D
-</script>=0D
-=0D
-=09=09</div>=0D
-=09=09<hr>=0D
-=09=09<p>QEMU is a member of <a href=3D"/conservancy/">Software Freedom Co=
nservancy</a>.</p>=0D
-=09</div>=0D
-</div>=0D
-=0D
-<!-- Main -->=0D
-=09<div id=3D"releases">=0D
-=09=09<header>=0D
-=09=09=09<h2>Latest releases</h2>=0D
-=09=09</header>=0D
-=09=09<div class=3D"container">=0D
-=09=09=09{% include releases.html %}=0D
-=09=09</div>=0D
-=09</div>=0D
-=0D
-=0D
-<script>=0D
-=09$(window).on("scroll", function() {=0D
-=09=09isScroll =3D window.scrollY < 120;=0D
-=09=09jqBody =3D $('body');=0D
-=09=09if (isScroll && jqBody.hasClass('fixed'))=0D
-=09=09=09jqBody.removeClass('fixed')=0D
-=09=09else if (!isScroll && !jqBody.hasClass('fixed'))=0D
-=09=09=09jqBody.addClass('fixed')=0D
-       });=0D
-       </script>=0D
+---
+title: QEMU
+layout: home
+colorbox: True
+---
+=09<!-- Header -->
+=09<div id=3D"header">
+=09=09<div class=3D"container">
+=09=09=09<h1>QEMU</h1>
+=09=09=09<span class=3D"tag">the FAST! processor emulator</span>
+=09=09</div>
+=09</div>
+=09
+<!-- Featured -->
+<div id=3D"featured">
+=09<div class=3D"container">
+=09=09<header>
+=09=09=09<h2>What is QEMU?</h2>
+=09=09=09<p>QEMU is a generic and open source machine emulator and virtual=
izer.</p>
+=09=09</header>
+=09=09<div class=3D"row">
+=09=09=09<section class=3D"4u">
+=09=09=09=09<div class=3D"pennant">{% include screenshot.html offset=3D0 l=
imit=3D1 %}</div>
+=09=09=09=09<h3>Full-system<br class=3D"only-desktop"> emulation</h3>
+=09=09=09=09<p>Run operating systems for any machine, on any supported arc=
hitecture</p>
+=09=09=09</section>
+=09=09=09<section class=3D"4u">
+=09=09=09=09<div class=3D"pennant">{% include screenshot.html offset=3D1 l=
imit=3D1 %}</div>
+=09=09=09=09<h3>User-mode<br class=3D"only-desktop"> emulation</h3>
+=09=09=09=09<p>Run programs for another Linux/BSD target, on any supported=
 architecture</p>
+=09=09=09</section>
+=09=09=09<section class=3D"4u">
+=09=09=09=09<div class=3D"pennant">{% include screenshot.html offset=3D2 l=
imit=3D1 %}</div>
+=09=09=09=09<h3>Virtualization</h3>
+=09=09=09=09<p>Run KVM and Xen virtual machines with near native performan=
ce</p>
+=09=09=09</section>
+=09=09=09<section style=3D"display: none;">
+=09=09=09{% include screenshot.html offset=3D3 limit=3D10 %}
+=09=09=09</section>
+
+<script src=3D"/assets/js/object-fit.js"></script>
+<script>
+window.hasColorBox =3D false;
+$(window).on("load resize", function() {
+    isMobile =3D window.innerWidth < 700;
+    if (isMobile && window.hasColorBox) {
+        window.hasColorBox =3D false;
+        $.colorbox.remove();
+    } else if (!isMobile && !window.hasColorBox) {
+=09window.hasColorBox =3D true;
+=09$('.colorbox').colorbox({
+            'rel': '.colorbox',
+            'title': function() { return $(this).attr("data-title"); }
+        });
+    }
+});
+// make links to images inactive, except through the colorbox
+$('.colorbox').on("click.random-namespace", function() {
+    return window.hasColorBox;
+})
+</script>
+
+=09=09</div>
+=09=09<hr>
+=09=09<p>QEMU is a member of <a href=3D"/conservancy/">Software Freedom Co=
nservancy</a>.</p>
+=09</div>
+</div>
+
+<!-- Main -->
+=09<div id=3D"releases">
+=09=09<header>
+=09=09=09<h2>Latest releases</h2>
+=09=09</header>
+=09=09<div class=3D"container">
+=09=09=09{% include releases.html %}
+=09=09</div>
+=09</div>
+
+
+<script>
+=09$(window).on("scroll", function() {
+=09=09isScroll =3D window.scrollY < 120;
+=09=09jqBody =3D $('body');
+=09=09if (isScroll && jqBody.hasClass('fixed'))
+=09=09=09jqBody.removeClass('fixed')
+=09=09else if (!isScroll && !jqBody.hasClass('fixed'))
+=09=09=09jqBody.addClass('fixed')
+       });
+       </script>
--=20
2.26.2


