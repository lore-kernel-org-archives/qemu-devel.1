Received: from eggs.gnu.org ([2001:4830:134:3::10]:57497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et7Dj-0002jc-SE
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1et7Di-0000Gr-IH
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:41:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53732 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1et7Di-0000Fd-Eg
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:41:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2BD64040856
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 07:40:58 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Mar 2018 08:40:46 +0100
Message-Id: <20180306074053.22856-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 0/7] audio: modularize
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

Add audio driver (host backend) registry.  Add audio module support.
Enable module builds for alsa, oss, pulse and sdl.

Gerd Hoffmann (7):
  audio: add driver registry
  audio: add module loading support
  build: enable audio modules
  audio/alsa: build as module
  audio/oss: build as module
  audio/pulseaudio: build as module
  audio/sdl: build as module

 configure             |  7 ++++-
 Makefile              |  4 +++
 Makefile.objs         |  1 +
 audio/audio_int.h     | 14 ++++-----
 include/qemu/module.h |  1 +
 audio/alsaaudio.c     |  8 ++++-
 audio/audio.c         | 83 +++++++++++++++++++++++++++++++++++----------------
 audio/coreaudio.c     |  8 ++++-
 audio/dsoundaudio.c   |  8 ++++-
 audio/noaudio.c       |  8 ++++-
 audio/ossaudio.c      |  8 ++++-
 audio/paaudio.c       |  8 ++++-
 audio/sdlaudio.c      |  8 ++++-
 audio/spiceaudio.c    |  8 ++++-
 audio/wavaudio.c      |  8 ++++-
 audio/Makefile.objs   | 30 +++++++++++++------
 scripts/create_config |  2 +-
 17 files changed, 159 insertions(+), 55 deletions(-)

-- 
2.9.3
