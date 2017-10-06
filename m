Received: from eggs.gnu.org ([2001:4830:134:3::10]:40569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOS-0006z4-DP
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOR-0004od-Ap
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:02 -0300
Message-Id: <20171006235023.11952-8-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 07/88] Audio: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: added audio/alsaaudio.c and audio/coreaudio.c]
---
 audio/alsaaudio.c    | 2 +-
 audio/coreaudio.c    | 2 +-
 audio/dsoundaudio.c  | 2 +-
 audio/ossaudio.c     | 2 +-
 audio/paaudio.c      | 2 +-
 audio/wavaudio.c     | 2 +-
 audio/wavcapture.c   | 2 +-
 hw/audio/intel-hda.c | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 3652a7b5fa..1a129c79e3 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -1126,7 +1126,7 @@ static ALSAConf glob_conf = {
 
 static void *alsa_audio_init (void)
 {
-    ALSAConf *conf = g_malloc(sizeof(ALSAConf));
+    ALSAConf *conf = g_new(ALSAConf, 1);
     *conf = glob_conf;
     return conf;
 }
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index c75142084f..651b390b5e 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -687,7 +687,7 @@ static CoreaudioConf glob_conf = {
 
 static void *coreaudio_audio_init (void)
 {
-    CoreaudioConf *conf = g_malloc(sizeof(CoreaudioConf));
+    CoreaudioConf *conf = g_new(CoreaudioConf, 1);
     *conf = glob_conf;
 
     return conf;
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 516846eb80..0492d9075e 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -787,7 +787,7 @@ static void *dsound_audio_init (void)
 {
     int err;
     HRESULT hr;
-    dsound *s = g_malloc0(sizeof(dsound));
+    dsound *s = g_new0(dsound, 1);
 
     s->conf = glob_conf;
     hr = CoInitialize (NULL);
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index 0edd7ea5fe..50d772011c 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -846,7 +846,7 @@ static OSSConf glob_conf = {
 
 static void *oss_audio_init (void)
 {
-    OSSConf *conf = g_malloc(sizeof(OSSConf));
+    OSSConf *conf = g_new(OSSConf, 1);
     *conf = glob_conf;
 
     if (access(conf->devpath_in, R_OK | W_OK) < 0 ||
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 65beb6f010..fc32960c25 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -814,7 +814,7 @@ static PAConf glob_conf = {
 
 static void *qpa_audio_init (void)
 {
-    paaudio *g = g_malloc(sizeof(paaudio));
+    paaudio *g = g_new(paaudio, 1);
     g->conf = glob_conf;
     g->mainloop = NULL;
     g->context = NULL;
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 341eec3121..f90a02610f 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -231,7 +231,7 @@ static WAVConf glob_conf = {
 
 static void *wav_audio_init (void)
 {
-    WAVConf *conf = g_malloc(sizeof(WAVConf));
+    WAVConf *conf = g_new(WAVConf, 1);
     *conf = glob_conf;
     return conf;
 }
diff --git a/audio/wavcapture.c b/audio/wavcapture.c
index 5863803584..a744b748a5 100644
--- a/audio/wavcapture.c
+++ b/audio/wavcapture.c
@@ -145,7 +145,7 @@ int wav_start_capture (CaptureState *s, const char *path, int freq,
     ops.capture = wav_capture;
     ops.destroy = wav_destroy;
 
-    wav = g_malloc0 (sizeof (*wav));
+    wav = g_new0(WAVState, 1);
 
     shift = bits16 + stereo;
     hdr[34] = bits16 ? 0x10 : 0x08;
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 18a50a8f83..3a2b611d41 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -470,7 +470,7 @@ static void intel_hda_parse_bdl(IntelHDAState *d, IntelHDAStream *st)
     addr = intel_hda_addr(st->bdlp_lbase, st->bdlp_ubase);
     st->bentries = st->lvi +1;
     g_free(st->bpl);
-    st->bpl = g_malloc(sizeof(bpl) * st->bentries);
+    st->bpl = g_new(bpl, st->bentries);
     for (i = 0; i < st->bentries; i++, addr += 16) {
         pci_dma_read(&d->pci, addr, buf, 16);
         st->bpl[i].addr  = le64_to_cpu(*(uint64_t *)buf);
-- 
2.14.2
