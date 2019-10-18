Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465CACA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1779A21925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 07:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1779A21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLMvE-00083V-Hq
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 03:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iLMtV-0006Ev-45
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iLMtT-00071r-6u
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iLMtS-00070A-3C
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 03:41:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8714D89B00C
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:41:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-43.ams2.redhat.com
 [10.36.116.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB5BC5C1B2;
 Fri, 18 Oct 2019 07:41:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0F0AF16E08; Fri, 18 Oct 2019 09:41:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] Audio 20191018 patches
Date: Fri, 18 Oct 2019 09:41:31 +0200
Message-Id: <20191018074144.24071-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Fri, 18 Oct 2019 07:41:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f22f553efffd083ff624be116726f843a39f11=
48:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20191013' into =
staging (2019-10-17 16:48:56 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/audio-20191018-pull-request

for you to fetch changes up to 0cf13e367a99dd1abefc46ec94b4c1a80c678f61:

  paaudio: fix channel order for usb-audio 5.1 and 7.1 streams (2019-10-1=
8 08:14:05 +0200)

----------------------------------------------------------------
audio: bugfixes, pa connection and stream naming.
audio: 5.1/7.1 support for alsa, pa and usb-audio.

----------------------------------------------------------------

K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n (13):
  audio: fix parameter dereference before NULL check
  audio: paaudio: fix connection and stream name
  audio: paaudio: ability to specify stream name
  audio: add mixing-engine option (documentation)
  audio: make mixeng optional
  paaudio: get/put_buffer functions
  audio: support more than two channels in volume setting
  audio: replace shift in audio_pcm_info with bytes_per_frame
  audio: basic support for multichannel audio
  usb-audio: do not count on avail bytes actually available
  usb-audio: support more than two channels of audio
  usbaudio: change playback counters to 64 bit
  paaudio: fix channel order for usb-audio 5.1 and 7.1 streams

 audio/audio.h           |  10 +
 audio/audio_int.h       |   7 +-
 audio/audio_template.h  |  31 ++-
 audio/dsound_template.h |  10 +-
 audio/alsaaudio.c       |  18 +-
 audio/audio.c           | 176 ++++++++++-----
 audio/coreaudio.c       |   4 +-
 audio/dsoundaudio.c     |   4 +-
 audio/noaudio.c         |   2 +-
 audio/ossaudio.c        |  14 +-
 audio/paaudio.c         | 162 ++++++++++++--
 audio/spiceaudio.c      |  17 +-
 audio/wavaudio.c        |   6 +-
 hw/usb/dev-audio.c      | 461 ++++++++++++++++++++++++++++++++++------
 qapi/audio.json         |  12 ++
 qemu-options.hx         |  15 ++
 16 files changed, 758 insertions(+), 191 deletions(-)

--=20
2.18.1


