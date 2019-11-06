Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C35C47E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 07:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3290F206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 07:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPm5DLjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3290F206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSFRX-0007gA-GG
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 02:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iSFPV-00063O-Qj
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 02:07:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iSFPT-0006Gd-TL
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 02:07:21 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52219
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iSFPT-0006GT-Pv
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 02:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573024039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePN88b0QkOKd74gcPuLwNtjXKxdkX8YmnSFh4CTvwJg=;
 b=PPm5DLjVTIGcPIPuavFUYcR4DqVH/ZTm54dCculTSfri5RlNlyIY8xVOOG6OjUF/EaDrJE
 dAmwDE71nIkBySpK8S53i1EwyLX/LVZNFsaHZNtjdae6dioq+a71aa8JMPiDBjUOTX/063
 eBkVv52gam6BTWPcxQCrmolNodBJOo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-8o_EZZSKOnm-qFjmdpNg2w-1; Wed, 06 Nov 2019 02:07:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 054211005500;
 Wed,  6 Nov 2019 07:07:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-69.ams2.redhat.com
 [10.36.116.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D49905D713;
 Wed,  6 Nov 2019 07:07:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7D2EE9D23; Wed,  6 Nov 2019 08:07:12 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/1] qemu-options: Rework the help text of the '-display' option
Date: Wed,  6 Nov 2019 08:07:12 +0100
Message-Id: <20191106070712.2679-2-kraxel@redhat.com>
In-Reply-To: <20191106070712.2679-1-kraxel@redhat.com>
References: <20191106070712.2679-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 8o_EZZSKOnm-qFjmdpNg2w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <huth@tuxfamily.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <huth@tuxfamily.org>

Improve the help text of the "-display" option:

- Only print the options that we have enabled in the binary
  (similar to what we do for other options like -netdev already)

- The "frame=3Don|off" from "-display sdl" has been removed in commit
  09bd7ba9f5f7 ("Remove deprecated -no-frame option"), so we should
  not show this in the help text anymore

- The "-display egl-headless" line was missing a "\n" at the end

- Indent the default display text in a nicer way

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20191023120129.13721-1-huth@tuxfamily.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qemu-options.hx | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 1fc2470e2fd4..637597d0d95e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1546,26 +1546,38 @@ STEXI
 ETEXI
=20
 DEF("display", HAS_ARG, QEMU_OPTION_display,
+#if defined(CONFIG_SPICE)
     "-display spice-app[,gl=3Don|off]\n"
-    "-display sdl[,frame=3Don|off][,alt_grab=3Don|off][,ctrl_grab=3Don|off=
]\n"
+#endif
+#if defined(CONFIG_SDL)
+    "-display sdl[,alt_grab=3Don|off][,ctrl_grab=3Don|off]\n"
     "            [,window_close=3Don|off][,gl=3Don|core|es|off]\n"
+#endif
+#if defined(CONFIG_GTK)
     "-display gtk[,grab_on_hover=3Don|off][,gl=3Don|off]|\n"
+#endif
+#if defined(CONFIG_VNC)
     "-display vnc=3D<display>[,<optargs>]\n"
+#endif
+#if defined(CONFIG_CURSES)
     "-display curses[,charset=3D<encoding>]\n"
+#endif
+#if defined(CONFIG_OPENGL)
+    "-display egl-headless[,rendernode=3D<file>]\n"
+#endif
     "-display none\n"
-    "-display egl-headless[,rendernode=3D<file>]"
-    "                select display type\n"
-    "The default display is equivalent to\n"
+    "                select display backend type\n"
+    "                The default display is equivalent to\n               =
 "
 #if defined(CONFIG_GTK)
-            "\t\"-display gtk\"\n"
+            "\"-display gtk\"\n"
 #elif defined(CONFIG_SDL)
-            "\t\"-display sdl\"\n"
+            "\"-display sdl\"\n"
 #elif defined(CONFIG_COCOA)
-            "\t\"-display cocoa\"\n"
+            "\"-display cocoa\"\n"
 #elif defined(CONFIG_VNC)
-            "\t\"-vnc localhost:0,to=3D99,id=3Ddefault\"\n"
+            "\"-vnc localhost:0,to=3D99,id=3Ddefault\"\n"
 #else
-            "\t\"-display none\"\n"
+            "\"-display none\"\n"
 #endif
     , QEMU_ARCH_ALL)
 STEXI
--=20
2.18.1


