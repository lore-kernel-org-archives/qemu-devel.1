Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE0EC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:43:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549AC22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549AC22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0MDJ-0005Xj-QR
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 04:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0MBF-0003ie-6y
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0MBD-00052s-OY
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:41:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0MBD-00052E-H7
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:41:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 855EE307D88D;
 Wed, 21 Aug 2019 08:41:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B20DA6B49A;
 Wed, 21 Aug 2019 08:41:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 661B616E1A; Wed, 21 Aug 2019 10:41:13 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 10:40:58 +0200
Message-Id: <20190821084113.1840-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 21 Aug 2019 08:41:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/15] Audio 20190821 patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 17dc57990320edaad52ac9ea808be9719c91ce=
a6:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
9-08-20' into staging (2019-08-20 14:14:20 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/audio-20190821-pull-request

for you to fetch changes up to e76ba19a1f1377314573a6df7e2d82b597aa3d0a:

  audio: fix memory leak reported by ASAN (2019-08-21 09:13:37 +0200)

----------------------------------------------------------------
audio: second batch of -audiodev support, adding support for multiple bac=
kends.

----------------------------------------------------------------

K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n (14):
  audio: reduce glob_audio_state usage
  audio: basic support for multi backend audio
  audio: add audiodev property to vnc and wav_capture
  audio: add audiodev properties to frontends
  paaudio: prepare for multiple audiodev
  audio: audiodev=3D parameters no longer optional when -audiodev present
  paaudio: do not move stream when sink/source name is specified
  paaudio: properly disconnect streams in fini_*
  audio: remove audio_MIN, audio_MAX
  audio: do not run each backend in audio_run
  paaudio: fix playback glitches
  audio: remove read and write pcm_ops
  audio: use size_t where makes sense
  audio: fix memory leak reported by ASAN

Stefan Weil (1):
  audio: Add missing fall through comments

 audio/audio.h                    |  37 ++-
 audio/audio_int.h                |  43 ++--
 audio/audio_template.h           |  62 +++--
 audio/mixeng.h                   |   9 +-
 audio/rate_template.h            |   2 +-
 include/hw/qdev-properties.h     |   3 +
 include/sysemu/replay.h          |   4 +-
 ui/vnc.h                         |   2 +
 audio/alsaaudio.c                |  49 ++--
 audio/audio.c                    | 347 ++++++++++++++-----------
 audio/coreaudio.c                |  18 +-
 audio/dsoundaudio.c              |  31 +--
 audio/noaudio.c                  |  39 +--
 audio/ossaudio.c                 |  75 +++---
 audio/paaudio.c                  | 421 ++++++++++++++++++-------------
 audio/sdlaudio.c                 |  30 +--
 audio/spiceaudio.c               |  34 +--
 audio/wavaudio.c                 |  18 +-
 audio/wavcapture.c               |   6 +-
 hw/audio/ac97.c                  |  11 +-
 hw/audio/adlib.c                 |   5 +-
 hw/audio/cs4231a.c               |   5 +-
 hw/audio/es1370.c                |  13 +-
 hw/audio/gus.c                   |   7 +-
 hw/audio/hda-codec.c             |  17 +-
 hw/audio/milkymist-ac97.c        |  14 +-
 hw/audio/pcspk.c                 |   3 +-
 hw/audio/pl041.c                 |   1 +
 hw/audio/sb16.c                  |   3 +-
 hw/audio/wm8750.c                |  10 +-
 hw/core/qdev-properties-system.c |  57 +++++
 hw/usb/dev-audio.c               |   1 +
 monitor/misc.c                   |  22 +-
 replay/replay-audio.c            |  16 +-
 replay/replay.c                  |   2 +-
 ui/vnc.c                         |  15 +-
 hmp-commands.hx                  |  11 +-
 qemu-options.hx                  |   6 +
 38 files changed, 794 insertions(+), 655 deletions(-)

--=20
2.18.1


