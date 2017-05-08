Received: from eggs.gnu.org ([2001:4830:134:3::10]:37781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7p5E-0007XL-UG
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:16:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d7p5E-0002nI-3f
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:16:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d7p5D-0002n7-U2
	for qemu-devel@nongnu.org; Mon, 08 May 2017 16:16:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBEF94E4D8
	for <qemu-devel@nongnu.org>; Mon,  8 May 2017 20:16:38 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  8 May 2017 17:16:27 -0300
Message-Id: <20170508201628.32502-3-ehabkost@redhat.com>
In-Reply-To: <20170508201628.32502-1-ehabkost@redhat.com>
References: <20170508201628.32502-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] audio: Rename audio_init() to
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
Changes v1 -> v2:
* Rebase to latest qemu.git master
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
index 5e96b73c81..29565da93d 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -129,7 +129,7 @@ void select_soundhw(const char *optarg)
     }
 }
 
-void audio_init(void)
+void soundhw_init(void)
 {
     struct soundhw *c;
     ISABus *isa_bus = (ISABus *) object_resolve_path_type("", TYPE_ISA_BUS, NULL);
diff --git a/vl.c b/vl.c
index a2400e1ab6..42fd66ac0d 100644
--- a/vl.c
+++ b/vl.c
@@ -4569,7 +4569,7 @@ int main(int argc, char **argv, char **envp)
 
     realtime_init();
 
-    audio_init();
+    soundhw_init();
 
     if (hax_enabled()) {
         hax_sync_vcpus();
-- 
2.11.0.259.g40922b1
