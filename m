Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38EAC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:47:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA9021741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 07:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVkNx32S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA9021741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izyMe-00078j-RL
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 02:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1izyKz-0005Vg-7P
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1izyKy-00039S-8p
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43726
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1izyKy-00038N-4h
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 02:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581061563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=59TAC3S1FEf3jc/eV8YSNogD+HKf06+eZdt4s4zSlgI=;
 b=IVkNx32SJs79/lEfAip8E9Z6xdio7772hjoEKz3VQhjdMlXI4u9Oyrauzxq5UcXscxPJcW
 rrFCCZnIzkFvEp68abWVMnVgc4B+1ou2v8xjUTkkUaZ/4wGzSs7lrHZ3ujjqZ9pB6+j2Qv
 spLCPFc8XBLR+ZD3kbfdM9cpljTgOd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-_cykhlA-NNeNFvUaguGmdA-1; Fri, 07 Feb 2020 02:46:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4818C8010FE
 for <qemu-devel@nongnu.org>; Fri,  7 Feb 2020 07:46:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com
 [10.36.116.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9912789A7A;
 Fri,  7 Feb 2020 07:45:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C890C9D14; Fri,  7 Feb 2020 08:45:57 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] Audio 20200207 patches
Date: Fri,  7 Feb 2020 08:45:45 +0100
Message-Id: <20200207074557.26073-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: _cykhlA-NNeNFvUaguGmdA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 928173659d6e5dc368284f73f90ea1d129e1f57d=
:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200=
130' into staging (2020-01-30 16:19:04 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/audio-20200207-pull-request

for you to fetch changes up to ed2a4a794184df3dbd5ee4cc06e86fe220663faf:

  audio: proper support for float samples in mixeng (2020-02-06 14:35:57 +0=
100)

----------------------------------------------------------------
audio: bugfixes, mostly audio backend rewrite fallout

----------------------------------------------------------------

Gerd Hoffmann (1):
  audio/oss: fix buffer pos calculation

K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n (2):
  audio/dsound: fix invalid parameters error
  audio: proper support for float samples in mixeng

Volker R=C3=BCmelin (9):
  audio: fix audio_generic_write
  audio: fix audio_generic_read
  paaudio: remove unused variables
  audio: prevent SIGSEGV in AUD_get_buffer_size_out
  audio: fix bug 1858488
  ossaudio: prevent SIGSEGV in oss_enable_out
  ossaudio: disable poll mode can't be reached
  audio: audio_generic_get_buffer_in should honor *size
  coreaudio: fix coreaudio playback

 audio/audio_int.h       |   7 +-
 audio/audio_template.h  |  40 +++++++----
 audio/dsound_template.h |   1 +
 audio/mixeng.h          |   5 ++
 audio/alsaaudio.c       |  18 +++++
 audio/audio.c           | 145 ++++++++++++++++++++++------------------
 audio/coreaudio.c       |  34 +++-------
 audio/dsoundaudio.c     |  27 ++++++--
 audio/mixeng.c          |  70 +++++++++++++++++++
 audio/noaudio.c         |   1 +
 audio/ossaudio.c        |  28 +++++---
 audio/paaudio.c         |  15 +++--
 audio/sdlaudio.c        |  35 +++++++++-
 audio/wavaudio.c        |   1 +
 qapi/audio.json         |   2 +-
 15 files changed, 302 insertions(+), 127 deletions(-)

--=20
2.18.1


