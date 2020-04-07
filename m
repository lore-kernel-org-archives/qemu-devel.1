Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60955C2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B97206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mtw8H/ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B97206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkSF-00049h-8V
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33100)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jLkQy-0002Gh-5t
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jLkQx-0000Yt-6s
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:22:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29231
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jLkQw-0000Xi-NL
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586251334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5SMIdwpe1aDWx6fWsI0+nxbTHrw0yyA33j9tO8bNJOA=;
 b=Mtw8H/ugifCZCnCYo6zkHwmVNLzjAZrZ62YDPRbtMX2MPci48BsP6D7DCpcIWVk1YKbw5X
 ehf6aWjyJxz5K8OGTIgfaGsgbUbI6JEzFCh/K13NNe4M4Mg6VFsZnvkYQTK3PH16m+84hD
 DOqUPBOkPvMjkFfXnHs4z/dWGnxbpeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-uSzQ3ul5PPG2Ejuhfp8pTQ-1; Tue, 07 Apr 2020 05:22:11 -0400
X-MC-Unique: uSzQ3ul5PPG2Ejuhfp8pTQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 234ED8017F4
 for <qemu-devel@nongnu.org>; Tue,  7 Apr 2020 09:22:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1960D92F83;
 Tue,  7 Apr 2020 09:22:08 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 059951750A; Tue,  7 Apr 2020 11:22:07 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Fixes 20200407 patches
Date: Tue,  7 Apr 2020 11:22:02 +0200
Message-Id: <20200407092207.6079-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

The following changes since commit 146aa0f104bb3bf88e43c4082a0bfc4bbda4fbd8=
:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' i=
nto staging (2020-04-03 15:30:11 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/fixes-20200407-pull-request

for you to fetch changes up to ac2071c3791b67fc7af78b8ceb320c01ca1b5df7:

  ati-vga: Fix checks in ati_2d_blt() to avoid crash (2020-04-07 09:25:23 +=
0200)

----------------------------------------------------------------
fixes for 5.0:
- audio: windows (dsound) fixes.
- vga: ati blitter sanity check fixes.

----------------------------------------------------------------

BALATON Zoltan (1):
  ati-vga: Fix checks in ati_2d_blt() to avoid crash

Volker R=C3=BCmelin (3):
  dsoundaudio: fix never-ending playback loop
  dsoundaudio: fix "Could not lock capture buffer" warning
  dsoundaudio: dsound_get_buffer_in should honor *size

 audio/audio.c       | 12 +++++-------
 audio/dsoundaudio.c |  9 +++++++--
 hw/display/ati_2d.c | 37 ++++++++++++++++++++++++++-----------
 3 files changed, 38 insertions(+), 20 deletions(-)

--=20
2.18.2


