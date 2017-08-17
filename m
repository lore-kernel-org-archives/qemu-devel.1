Received: from eggs.gnu.org ([2001:4830:134:3::10]:40931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diGbj-0007n1-R0
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1diGbf-0007hk-0M
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:56:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1diGbe-0007hU-QG
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 04:56:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0D732EC6C5
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 08:56:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-17-marcandre.lureau@redhat.com>
	<87d17ur7y1.fsf@dusky.pond.sub.org>
Date: Thu, 17 Aug 2017 10:56:40 +0200
In-Reply-To: <87d17ur7y1.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 17 Aug 2017 09:04:38 +0200")
Message-ID: <87mv6yk1x3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 16/26] qapi: add conditions to VNC
 type/commands/events on the schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Gerd, can we delete the vnc_init_func() stub?  Things still compile for
me when I do.

diff --git a/include/ui/console.h b/include/ui/console.h
index 7262bef..2c3b2cd 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -484,11 +484,6 @@ static inline QemuOpts *vnc_parse(const char *str, Error **errp)
     error_setg(errp, "VNC support is disabled");
     return NULL;
 }
-static inline int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
-{
-    error_setg(errp, "VNC support is disabled");
-    return -1;
-}
 #endif
 
 /* curses.c */
