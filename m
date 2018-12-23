Received: from eggs.gnu.org ([208.118.235.92]:52012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjh-0007Jd-E9
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dirty.ice.hu@gmail.com>) id 1gbAjg-0001Mg-7G
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:33 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
	id 1gbAjg-0001F7-07
	for qemu-devel@nongnu.org; Sun, 23 Dec 2018 15:52:32 -0500
Received: by mail-wr1-x441.google.com with SMTP id u4so10091513wrp.3
	for <qemu-devel@nongnu.org>; Sun, 23 Dec 2018 12:52:31 -0800 (PST)
From: "=?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?="
	<dirty.ice.hu@gmail.com>
Date: Sun, 23 Dec 2018 21:51:36 +0100
Message-Id: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/52] Audio 5.1 patches
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

I've updated my audio patchset to the current git master. Other than that not
much happened since my last update [1], fixed a few small problems that I
noticed while rebasing my patches.

Please review.

[1]: https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg02451.html

Kővágó, Zoltán (52):
  qapi: support alternates in OptsVisitor
  qapi: support nested structs in OptsVisitor
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
  audio: reduce glob_audio_state usage
  audio: basic support for multi backend audio
  audio: add audiodev properties to frontends
  audio: audiodev= parameters no longer optional when -audiodev present
  paaudio: do not move stream when sink/source name is specified
  paaudio: properly disconnect streams in fini_*
  audio: remove audio_MIN, audio_MAX
  audio: do not run each backend in audio_run
  paaudio: fix playback glitches
  audio: remove read and write pcm_ops
  audio: use size_t where makes sense
  audio: api for mixeng code free backends
  alsaaudio: port to the new audio backend api
  coreaudio: port to the new audio backend api
  dsoundaudio: port to the new audio backend api
  noaudio: port to the new audio backend api
  ossaudio: port to the new audio backend api
  paaudio: port to the new audio backend api
  sdlaudio: port to the new audio backend api
  spiceaudio: port to the new audio backend api
  wavaudio: port to the new audio backend api
  audio: remove remains of the old backend api
  audio: unify input and output mixeng buffer management
  audio: remove hw->samples, buffer_size_in/out pcm_ops
  audio: common rate control code for timer based outputs
  audio: split ctl_* functions into enable_* and volume_*
  audio: add mixeng option (documentation)
  audio: make mixeng optional
  paaudio: get/put_buffer functions
  audio: support more than two channels in volume setting
  audio: replace shift in audio_pcm_info with bytes_per_frame
  audio: basic support for multichannel audio
  paaudio: channel-map option
  usb-audio: do not count on avail bytes actually available
  usb-audio: support more than two channels of audio
  usbaudio: change playback counters to 64 bit

 Makefile.objs                           |    6 +-
 audio/Makefile.objs                     |    3 +-
 audio/alsaaudio.c                       |  755 ++++-------
 audio/audio.c                           | 1561 ++++++++++++-----------
 audio/audio.h                           |   78 +-
 audio/audio_int.h                       |  131 +-
 audio/audio_legacy.c                    |  342 +++++
 audio/audio_pt_int.c                    |  174 ---
 audio/audio_pt_int.h                    |   22 -
 audio/audio_template.h                  |  112 +-
 audio/audio_win_int.c                   |   18 +-
 audio/coreaudio.c                       |  198 ++-
 audio/dsound_template.h                 |   63 +-
 audio/dsoundaudio.c                     |  449 ++-----
 audio/mixeng.h                          |   11 +-
 audio/noaudio.c                         |   98 +-
 audio/ossaudio.c                        |  594 ++++-----
 audio/paaudio.c                         |  881 ++++++-------
 audio/rate_template.h                   |    2 +-
 audio/sdlaudio.c                        |  218 ++--
 audio/spiceaudio.c                      |  286 ++---
 audio/wavaudio.c                        |  158 +--
 audio/wavcapture.c                      |    8 +-
 configure                               |    5 -
 hmp-commands.hx                         |   11 +-
 hw/acpi/core.c                          |    2 +-
 hw/arm/omap2.c                          |    2 +-
 hw/audio/ac97.c                         |   13 +-
 hw/audio/adlib.c                        |    7 +-
 hw/audio/cs4231a.c                      |   11 +-
 hw/audio/es1370.c                       |   17 +-
 hw/audio/gus.c                          |    9 +-
 hw/audio/hda-codec.c                    |   35 +-
 hw/audio/lm4549.c                       |    6 +-
 hw/audio/milkymist-ac97.c               |   16 +-
 hw/audio/pcspk.c                        |    5 +-
 hw/audio/pl041.c                        |    1 +
 hw/audio/sb16.c                         |   17 +-
 hw/audio/wm8750.c                       |   14 +-
 hw/core/qdev-properties-system.c        |   57 +
 hw/display/xlnx_dp.c                    |    2 +-
 hw/input/tsc210x.c                      |    2 +-
 hw/usb/dev-audio.c                      |  460 ++++++-
 include/hw/qdev-properties.h            |    3 +
 include/qapi/opts-visitor.h             |    9 +-
 include/sysemu/replay.h                 |    4 +-
 monitor.c                               |   12 +-
 net/net.c                               |    2 +-
 numa.c                                  |    2 +-
 qapi/audio.json                         |  261 ++++
 qapi/opts-visitor.c                     |  145 ++-
 qapi/qapi-schema.json                   |    1 +
 qemu-options.hx                         |  242 +++-
 qom/object_interfaces.c                 |    2 +-
 replay/replay-audio.c                   |   16 +-
 tests/qapi-schema/qapi-schema-test.json |    9 +-
 tests/qapi-schema/qapi-schema-test.out  |    4 +
 tests/test-opts-visitor.c               |   43 +-
 ui/vnc.c                                |   41 +-
 ui/vnc.h                                |    2 +
 vl.c                                    |   11 +-
 61 files changed, 3921 insertions(+), 3748 deletions(-)
 create mode 100644 audio/audio_legacy.c
 delete mode 100644 audio/audio_pt_int.c
 delete mode 100644 audio/audio_pt_int.h
 create mode 100644 qapi/audio.json

-- 
2.20.1
