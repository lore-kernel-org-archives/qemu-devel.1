Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B28C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50F52072E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 12:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHUqI9HP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50F52072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioRth-0002UB-LD
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 07:54:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ioRsC-0000qD-Ky
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ioRsB-0000oN-Jb
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51100
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ioRsB-0000mm-FJ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 07:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578315162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FBp5aqjLZFYnatMx/1MpZ3T9tDK6H8YGgSHSkfHsa6c=;
 b=FHUqI9HPG1mXEk5gAObQ5+B1DstWJon7Xn/ONfkWAucD0jvAd3yU6QeDEsR7oOMuJx+w8m
 P7NsybGSvVWft4SUEz+nTXU6Ll+WliLd9zIFglIQEM/Ss0iD7dnYbYMEf0UpLu34WKgOaO
 w+lI3zSAiyw4Pi1vCZWZQo6/MfPyPZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-WBerDlcBNLyKapRBgK4GlA-1; Mon, 06 Jan 2020 07:52:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25EA31005514
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 12:52:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com
 [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83E1F46;
 Mon,  6 Jan 2020 12:52:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 875A348E0; Mon,  6 Jan 2020 13:52:36 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] Audio 20200106 patches
Date: Mon,  6 Jan 2020 13:52:30 +0100
Message-Id: <20200106125236.24132-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: WBerDlcBNLyKapRBgK4GlA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

The following changes since commit f0dcfddecee8b860e015bb07d67cfcbdfbfd51d9=
:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' i=
nto staging (2020-01-03 17:18:08 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/audio-20200106-pull-request

for you to fetch changes up to 40ad46d3cc463fab5a23db466f77e37aff23f927:

  audio: fix integer overflow (2020-01-06 08:47:16 +0100)

----------------------------------------------------------------
audio: bugfixes.

----------------------------------------------------------------

Volker R=C3=BCmelin (6):
  hda-codec: fix playback rate control
  hda-codec: fix recording rate control
  paaudio: drop recording stream in qpa_fini_in
  paaudio: try to drain the recording stream
  paaudio: wait until the recording stream is ready
  audio: fix integer overflow

 audio/audio.c        |  2 +-
 audio/paaudio.c      | 68 +++++++++++++++++++++++++++++++-------------
 hw/audio/hda-codec.c |  8 +++---
 3 files changed, 53 insertions(+), 25 deletions(-)

--=20
2.18.1


