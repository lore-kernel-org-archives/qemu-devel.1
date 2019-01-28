Received: from eggs.gnu.org ([209.51.188.92]:47570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1goFd7-0007h6-Fr
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1goFd6-0003Os-6L
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:49 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:51038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1goFd5-0003MW-RJ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:43:48 -0500
Received: by mail-wm1-x32a.google.com with SMTP id n190so15822070wmd.0
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:43:40 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Mon, 28 Jan 2019 23:43:23 +0100
Message-Id: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 00/14] Audio patches (was: Audio 5.1 patches)
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

Hi,

Here's an updated version of my audio patches. Due to the size of the patch
series, I broke it down to smaller parts, this is the first part.  This series
adds an -audiodev command line parameter instead of the old environment variable
based config.

Changes from v3:

* fixed formatting issues reported by issues by checkpatch.pl, except in patch
  2 "audio: use qapi AudioFormat instead of audfmt_e", since it's a search and
  replace patch

Regards,
Zoltan

Kővágó, Zoltán (14):
  qapi: qapi for audio backends
  audio: use qapi AudioFormat instead of audfmt_e
  audio: -audiodev command line option: documentation
  audio: -audiodev command line option basic implementation
  alsaaudio: port to -audiodev config
  coreaudio: port to -audiodev config
  dsoundaudio: port to -audiodev config
  noaudio: port to -audiodev config
  ossaudio: port to -audiodev config
  paaudio: port to -audiodev config
  sdlaudio: port to -audiodev config
  spiceaudio: port to -audiodev config
  wavaudio: port to -audiodev config
  audio: -audiodev command line option: cleanup

 Makefile.objs             |   6 +-
 qapi/audio.json           | 233 +++++++++++
 qapi/qapi-schema.json     |   1 +
 audio/audio.h             |  30 +-
 audio/audio_int.h         |  33 +-
 audio/audio_template.h    |  13 +-
 audio/dsound_template.h   |   6 +-
 audio/alsaaudio.c         | 383 ++++++-----------
 audio/audio.c             | 845 ++++++++++++--------------------------
 audio/audio_legacy.c      | 549 +++++++++++++++++++++++++
 audio/audio_win_int.c     |  18 +-
 audio/coreaudio.c         |  50 +--
 audio/dsoundaudio.c       |  61 +--
 audio/noaudio.c           |   3 +-
 audio/ossaudio.c          | 197 ++++-----
 audio/paaudio.c           | 121 +++---
 audio/sdlaudio.c          |  50 +--
 audio/spiceaudio.c        |  11 +-
 audio/wavaudio.c          |  75 +---
 audio/wavcapture.c        |   2 +-
 hw/arm/omap2.c            |   2 +-
 hw/audio/ac97.c           |   2 +-
 hw/audio/adlib.c          |   2 +-
 hw/audio/cs4231a.c        |   6 +-
 hw/audio/es1370.c         |   4 +-
 hw/audio/gus.c            |   2 +-
 hw/audio/hda-codec.c      |  18 +-
 hw/audio/lm4549.c         |   6 +-
 hw/audio/milkymist-ac97.c |   2 +-
 hw/audio/pcspk.c          |   2 +-
 hw/audio/sb16.c           |  14 +-
 hw/audio/wm8750.c         |   6 +-
 hw/display/xlnx_dp.c      |   2 +-
 hw/input/tsc210x.c        |   2 +-
 hw/usb/dev-audio.c        |   2 +-
 ui/vnc.c                  |  26 +-
 vl.c                      |   7 +-
 audio/Makefile.objs       |   2 +-
 qemu-options.hx           | 222 +++++++++-
 39 files changed, 1715 insertions(+), 1301 deletions(-)
 create mode 100644 qapi/audio.json
 create mode 100644 audio/audio_legacy.c

-- 
2.20.1
