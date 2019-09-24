Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4612C4320D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1E62146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 06:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1E62146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCeDD-0005Oi-Su
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 02:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59140)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iCeB5-0003Z5-Oh
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iCeB3-0000pX-0l
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:19:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iCeB2-0000pC-Rf
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 02:19:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3CCE0C057E9A
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:19:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6EE2C600C8;
 Tue, 24 Sep 2019 06:19:52 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7FD8D17535; Tue, 24 Sep 2019 08:19:51 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] Audio 20190924 patches
Date: Tue, 24 Sep 2019 08:19:35 +0200
Message-Id: <20190924061951.27916-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 24 Sep 2019 06:19:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4300b7c2cd9f3f273804e8cca325842ccb93b1=
ad:

  Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-requ=
est' into staging (2019-09-20 17:28:43 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/audio-20190924-pull-request

for you to fetch changes up to 571a8c522e0095239598347ac0add93337c1e0bf:

  audio: split ctl_* functions into enable_* and volume_* (2019-09-23 12:=
28:47 +0200)

----------------------------------------------------------------
audio: documentation fixes.
audio: new backend api (first part of the surround sound patch series).

----------------------------------------------------------------

K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n (14):
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
  audio: common rate control code for timer based outputs
  audio: split ctl_* functions into enable_* and volume_*

Stefan Hajnoczi (2):
  audio: fix buffer-length typo in documentation
  audio: fix ALSA period-length typo in documentation

 configure               |   5 -
 audio/audio_int.h       |  76 ++++--
 audio/audio_pt_int.h    |  22 --
 audio/audio_template.h  |  21 +-
 audio/dsound_template.h |  47 ++--
 audio/alsaaudio.c       | 370 +++++++++--------------------
 audio/audio.c           | 383 +++++++++++++++++++++++-------
 audio/audio_pt_int.c    | 173 --------------
 audio/coreaudio.c       | 143 ++++++------
 audio/dsoundaudio.c     | 379 ++++++++----------------------
 audio/noaudio.c         |  76 +++---
 audio/ossaudio.c        | 364 +++++++++++------------------
 audio/paaudio.c         | 499 ++++++++--------------------------------
 audio/sdlaudio.c        | 104 ++++-----
 audio/spiceaudio.c      | 257 +++++++--------------
 audio/wavaudio.c        |  76 ++----
 audio/Makefile.objs     |   1 -
 qemu-options.hx         |   8 +-
 18 files changed, 1083 insertions(+), 1921 deletions(-)
 delete mode 100644 audio/audio_pt_int.h
 delete mode 100644 audio/audio_pt_int.c

--=20
2.18.1


