Received: from eggs.gnu.org ([2001:4830:134:3::10]:56776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yaroslav.isakov@gmail.com>) id 1gaSNM-0005I3-VY
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yaroslav.isakov@gmail.com>) id 1gaSNI-0005WL-2V
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:30:32 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yaroslav.isakov@gmail.com>)
	id 1gaSNH-0005VW-TC
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 16:30:28 -0500
Received: by mail-wm1-x343.google.com with SMTP id y139so6477864wmc.5
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 13:30:27 -0800 (PST)
Received: from localhost ([91.201.22.4]) by smtp.gmail.com with ESMTPSA id
	t70sm16312724wmd.36.2018.12.21.12.59.06 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 21 Dec 2018 12:59:06 -0800 (PST)
Message-Id: <cover.1545425136.git.yaroslav.isakov@gmail.com>
From: Yaroslav Isakov <yaroslav.isakov@gmail.com>
Date: Fri, 21 Dec 2018 21:45:36 +0100
Subject: [Qemu-devel] [PATCH 0/3] Allow hw/audio drivers to pass raw DB
 values to audio/ drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This patch series introduces the ability for virtual audio drivers to pass
information about guest-chosen DB values to backend audio drivers.

For now, supported virtual driver is hda-codec, and backend is pulseaudio, as
they both support DB values.

Without these patches, emulated Windows has a very short range of hearable
sound, as range in the guest is much smaller than in Pulseaudio.

Yaroslav Isakov (3):
  Allow audio driver to pass DB value to underlying drivers
  Pass raw DB values from hda-codec.c to audio driver
  If raw DB values are known, use them in paaudio

 audio/audio.c               | 15 +++++++++++++--
 audio/audio.h               |  6 ++++--
 audio/mixeng.h              |  6 ++++--
 audio/paaudio.c             |  9 +++++++--
 hw/audio/ac97.c             |  4 ++--
 hw/audio/hda-codec-common.h |  2 +-
 hw/audio/hda-codec.c        | 12 ++++++++++--
 hw/audio/lm4549.c           |  2 +-
 hw/audio/wm8750.c           | 18 ++++++++++++------
 hw/display/xlnx_dp.c        |  3 ++-
 hw/usb/dev-audio.c          |  6 ++++--
 11 files changed, 60 insertions(+), 23 deletions(-)

-- 
2.18.1
