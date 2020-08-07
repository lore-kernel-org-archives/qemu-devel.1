Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05EFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 22:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED642177B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 22:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz3fvDBI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED642177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4Ap2-0001Hr-QR
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 18:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavlica.nikola@gmail.com>)
 id 1k4AoN-0000ro-Pr
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 18:26:03 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:46867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pavlica.nikola@gmail.com>)
 id 1k4AoL-0008KE-Ci
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 18:26:03 -0400
Received: by mail-ed1-x533.google.com with SMTP id q4so2291238edv.13
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 15:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:message-id:mime-version;
 bh=mqAuQPRcrnUHFgEnYYWZkd4A2fD82UsdV7TRq2BmLbc=;
 b=Iz3fvDBIpekxDcKIc0zhbEGmon3O2+/Vbp6BAQP/TAAxpOYoy4PaqD8Zd/Vz80kX2+
 RwEKEBDVXVx3AoSqk8oGDbpyF74Awgiihdz7F1DT+r9ge2BjBsglh/lq1CcypKRyeCke
 wziaAfbeyWW87MflA0vbGd/RF8xH4gKe4pcbI2fiuW4Kt/DFgJzEu9lNi6oib5gRpIqv
 Na0/GoNCLguNjsYDkPVmSjMKY5gsEDAm7ATNn8zeqkuJ/cTtEfIqZzyU7iWdio2Sdybl
 PJ2KQYgknHbk+3Ny9/xP28REsxJLk9l+23rOxjL73cKFe29hlnmZm6zeDNF4n0gxEPg4
 9XPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:message-id:mime-version;
 bh=mqAuQPRcrnUHFgEnYYWZkd4A2fD82UsdV7TRq2BmLbc=;
 b=RLIhkoRFifCCumgaxVyhOt977G/FJV4BXemXvN9KwlJdH+cwoe2lMu0RYTZAYZUuwy
 lyMFmjZfvUGvL5NNY67nuJTT9gEVXbc8+SU4ik48jpWri/Pj/eFwNvrdN00FX+1lSKQF
 YmmQ1tZ6Qfk8tzpkvzyddqJnT0CpXdzzq097FzQDMVfpqTCgESxgPt5FqmgEGV6du3Xu
 Fq5j1F7zYvWWFf6nydvRLt0r2iumZHh0eOHOdt3nyq6PEihT+J/beuQz1w9OsOx9Oi1h
 jPeHUjY+G2fkxKZxqii6Ii2XPJDse785IbNYAleJS6qEYqBHezmOXnpq6k7eTfgND+LJ
 z1cg==
X-Gm-Message-State: AOAM530kez7W2RmkakQhrrvrXEE6VRv4YOVJyRJoKtsf09CFRk9lii/H
 p75OZba21FCI+G5rQjaOGxEF0QYd9KQ=
X-Google-Smtp-Source: ABdhPJwEUDXjLSJI+gvtx0O9g5fsXpYGAfqYNGGpYu3a4Aflkp+H0bQj7uoQn7dBzbZOGSCGmiKmew==
X-Received: by 2002:aa7:d7d7:: with SMTP id e23mr10518638eds.347.1596839158875; 
 Fri, 07 Aug 2020 15:25:58 -0700 (PDT)
Received: from [192.168.100.70] ([213.91.86.150])
 by smtp.gmail.com with ESMTPSA id ch24sm6585892ejb.7.2020.08.07.15.25.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 15:25:58 -0700 (PDT)
Date: Sat, 08 Aug 2020 00:25:51 +0200
From: Nikola Pavlica <pavlica.nikola@gmail.com>
Subject: [PATCH] ui/gtk: Fix regression in gd_refresh_rate_milihz
To: qemu-devel <qemu-devel@nongnu.org>
Message-Id: <3ZSPEQ.MH51LARSPXFN2@gmail.com>
X-Mailer: geary/3.36.2
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="=-s39s977ux+jYy+guGmh0"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=pavlica.nikola@gmail.com; helo=mail-ed1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-s39s977ux+jYy+guGmh0
Content-Type: text/plain; charset=us-ascii; format=flowed

 From: Nikola Pavlica <pavlica.nikola@gmail.com 
<mailto:pavlica.nikola@gmail.com>>

In January (I think), I suggested a fix for the constant refresh rate 
issue in QEMU despite VMs being able to render graphics at a framerate 
much higher than that.

Here's the link to the patch in question:
<https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg01343.html>

However, I've noticed that the fix for older systems that run a older 
system of GTK fail to compile with my version of the patch. Which was 
fixed here: 
<https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg03386.html>, 
but improperly.

The issue lies if the target system (that the package is build on) has 
a higher version of GTK, let's say 3.24, it fails the #ifdef macro and 
thus does not include the changes that I've made. I've noticed this 
issue under the ArchLinux build system, which can be fixed by just 
using the included macro for checking GTK versions.

Also being that this is a regression and not a plain bugfix, is this 
mergable into stable?

Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com 
<mailto:pavlica.nikola@gmail.com>>
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1968,7 +1968,7 @@ static GtkWidget 
*gd_create_menu_machine(GtkDisplayState *s)
  */
 static int gd_refresh_rate_millihz(GtkWidget *window)
 {
-#ifdef GDK_VERSION_3_22
+#if GTK_CHECK_VERSION(3, 22, 0)
     GdkWindow *win = gtk_widget_get_window(window);

     if (win) {
-- 
2.24.1


--=-s39s977ux+jYy+guGmh0
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

<div id=3D"geary-body" dir=3D"auto"><div><div><span style=3D"white-space: p=
re-wrap;">From: Nikola Pavlica &lt;</span><a href=3D"mailto:pavlica.nikola@=
gmail.com" style=3D"white-space: pre-wrap;">pavlica.nikola@gmail.com</a><sp=
an style=3D"white-space: pre-wrap;">&gt;

In January (I think), I suggested a fix for the constant refresh rate issue=
 in QEMU despite VMs being able to render graphics at a framerate much high=
er than that.</span></div><div><span style=3D"white-space: pre-wrap;"><br><=
/span></div><div><span style=3D"white-space: pre-wrap;">Here's the link to =
the patch in question:</span></div><div><a href=3D"https://lists.nongnu.org=
/archive/html/qemu-devel/2020-01/msg01343.html">https://lists.nongnu.org/ar=
chive/html/qemu-devel/2020-01/msg01343.html</a></div><div><br></div><div><s=
pan style=3D"white-space: pre-wrap;">However, I've noticed that the fix for=
 older systems that run a older system of GTK fail to compile with my versi=
on of the patch. Which was fixed here: </span><a href=3D"https://lists.nong=
nu.org/archive/html/qemu-devel/2020-01/msg03386.html">https://lists.nongnu.=
org/archive/html/qemu-devel/2020-01/msg03386.html</a>, but improperly.</div=
><div><br></div><div>The issue lies if the target system (that the package =
is build on) has a higher version of GTK, let's say 3.24, it fails the #ifd=
ef macro and thus does not include the changes that I've made. I've noticed=
 this issue under the ArchLinux build system, which can be fixed by just us=
ing the included macro for checking GTK versions.</div><div><span style=3D"=
white-space: pre-wrap;"><br></span></div><div><span style=3D"white-space: p=
re-wrap;">Also being that this is a regression and not a plain bugfix, is t=
his mergable into stable?</span></div><div><span style=3D"white-space: pre-=
wrap;">
Signed-off-by: Nikola Pavlica &lt;</span><a href=3D"mailto:pavlica.nikola@g=
mail.com" style=3D"white-space: pre-wrap;">pavlica.nikola@gmail.com</a><spa=
n style=3D"white-space: pre-wrap;">&gt;
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1968,7 +1968,7 @@ static GtkWidget *gd_create_menu_machine(GtkDisplaySt=
ate *s)
  */
 static int gd_refresh_rate_millihz(GtkWidget *window)
 {
-#ifdef GDK_VERSION_3_22
+#if GTK_CHECK_VERSION(3, 22, 0)
     GdkWindow *win =3D gtk_widget_get_window(window);
=20
     if (win) {</span><div class=3D"geary-signature" style=3D"white-space: =
pre-wrap;"><div class=3D"geary-signature"><div>--=20
</div>2.24.1</div></div></div></div></div>
--=-s39s977ux+jYy+guGmh0--


