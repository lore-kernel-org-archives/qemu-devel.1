Received: from eggs.gnu.org ([2001:4830:134:3::10]:51244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBg1B-00077S-D1
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dBg18-00024D-IB
	for qemu-devel@nongnu.org; Fri, 19 May 2017 07:24:25 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 19 May 2017 13:24:14 +0200
Message-Id: <20170519112415.19191-3-kraxel@redhat.com>
In-Reply-To: <20170519112415.19191-1-kraxel@redhat.com>
References: <20170519112415.19191-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] audio: Rename audio_init() to soundhw_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, "open list:PReP" <qemu-ppc@nongnu.org>

From: Eduardo Habkost <ehabkost@redhat.com>

To make it consistent with the remaining soundhw.c functions and
avoid confusion with the audio_init() function in audio/audio.c,
rename audio_init() to soundhw_init().

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-id: 20170508205735.23444-3-ehabkost@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/audio/audio.h | 2 +-
 hw/audio/soundhw.c       | 2 +-
 hw/ppc/prep.c            | 2 +-
 vl.c                     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

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
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 96a4813b3f..4a7d2cfbe0 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -783,7 +783,7 @@ static void ibm_40p_init(MachineState *machine)
                        &cmos_checksum);
 
     /* initialize audio subsystem */
-    audio_init();
+    soundhw_init();
 
     /* add some more devices */
     if (defaults_enabled()) {
diff --git a/vl.c b/vl.c
index 6e46889cde..8f08f422a7 100644
--- a/vl.c
+++ b/vl.c
@@ -4575,7 +4575,7 @@ int main(int argc, char **argv, char **envp)
 
     realtime_init();
 
-    audio_init();
+    soundhw_init();
 
     if (hax_enabled()) {
         hax_sync_vcpus();
-- 
2.9.3
