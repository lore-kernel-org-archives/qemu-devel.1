Received: from eggs.gnu.org ([2001:4830:134:3::10]:44134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTYmg-00024k-LN
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTYmf-0002li-Pu
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:47:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTYmf-0002lC-KO
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:47:05 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B80B1C04B30E
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 18:47:05 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 17 Jan 2017 16:46:37 -0200
Message-Id: <20170117184638.25809-3-ehabkost@redhat.com>
In-Reply-To: <20170117184638.25809-1-ehabkost@redhat.com>
References: <20170117184638.25809-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] audio: Rename audio_init() to
 soundhw_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

To make it consistent with the remaining soundhw.c functions and
avoid confusion with the audio_init() function in audio/audio.c,
rename audio_init() to soundhw_init().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/audio/audio.h | 2 +-
 hw/audio/soundhw.c       | 2 +-
 vl.c                     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/audio/audio.h b/include/hw/audio/audio.h
index 259bb2cf96..119f7d78d5 100644
--- a/include/hw/audio/audio.h
+++ b/include/hw/audio/audio.h
@@ -7,7 +7,7 @@ void isa_register_soundhw(const char *name, const char *descr,
 void pci_register_soundhw(const char *name, const char *descr,
                           int (*init_pci)(PCIBus *bus));
 
-void audio_init(void);
+void soundhw_init(void);
 void select_soundhw(const char *optarg);
 
 #endif
diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index 3411fe1f90..2178a5c8ef 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -127,7 +127,7 @@ void select_soundhw(const char *optarg)
     }
 }
 
-void audio_init(void)
+void soundhw_init(void)
 {
     struct soundhw *c;
     ISABus *isa_bus =
diff --git a/vl.c b/vl.c
index cb610873bc..a5bf85ebec 100644
--- a/vl.c
+++ b/vl.c
@@ -4546,7 +4546,7 @@ int main(int argc, char **argv, char **envp)
 
     realtime_init();
 
-    audio_init();
+    soundhw_init();
 
     cpu_synchronize_all_post_init();
 
-- 
2.11.0.259.g40922b1
