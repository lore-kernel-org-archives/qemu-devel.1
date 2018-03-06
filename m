Received: from eggs.gnu.org ([2001:4830:134:3::10]:47917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVH-0004kV-Co
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVE-00068y-59
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:39 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVD-00068V-Ur
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:36 -0500
Received: by mail-wm0-x244.google.com with SMTP id s206so17984031wme.0
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:35 -0800 (PST)
Received: from 640k.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	l38sm25652538wrc.96.2018.03.06.05.19.33 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 06 Mar 2018 05:19:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:18:57 +0100
Message-Id: <1520342370-123606-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/34] g364fb: fix DirtyBitmapSnapshot leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/g364fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 819f8be..3d75394 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -207,6 +207,7 @@ done:
     if (xmax || ymax) {
         dpy_gfx_update(s->con, xmin, ymin, xmax - xmin + 1, ymax - ymin + 1);
     }
+    g_free(snap);
 }
 
 static void g364fb_draw_blank(G364State *s)
-- 
1.8.3.1
