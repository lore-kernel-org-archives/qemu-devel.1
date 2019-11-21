Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD30EC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE2E2073F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 10:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIj6tcyn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE2E2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXjbr-00052C-NY
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 05:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iXjVl-0007BL-8Z
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iXjVk-0007VG-55
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:16:29 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52362
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iXjVk-0007Ur-1I
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 05:16:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574331387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EjAUpSJzJpegy5ge3A/puoS+rZ0LjJO7CbtLZG9YGL8=;
 b=JIj6tcyngzqriHChWkFMKj3X9aHMCAPahHQ3SYsS+22yE8n8Y8+q3SVcuMkhlYPK2LxR2S
 DqmwOrRDhmO9tp+EAUfZaU/kwb+ezZr41fBGvqK6Yzf6PDBTD6TjmyGOAav7L9WjCyElK1
 xwHIOEX+wslKrEHRGyuy3ZeeFzcsYms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-45z4v-wnNNWiqZpPQ5UvMQ-1; Thu, 21 Nov 2019 05:16:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE6EF1005509;
 Thu, 21 Nov 2019 10:16:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C8866CE50;
 Thu, 21 Nov 2019 10:16:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 830CA16E08; Thu, 21 Nov 2019 11:16:18 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Fixes 20191121 patches
Date: Thu, 21 Nov 2019 11:16:15 +0100
Message-Id: <20191121101618.29289-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 45z4v-wnNNWiqZpPQ5UvMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 39e2821077e6dcf788b7c2a9ef50970ec7995437=
:

  Update version for v4.2.0-rc2 release (2019-11-19 19:34:10 +0000)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/fixes-20191121-pull-request

for you to fetch changes up to c55c974486b0dadf97fe47e2e789d5dba9b77138:

  ui/gtk: fix gettext message's charset. (2019-11-21 09:42:30 +0100)

----------------------------------------------------------------
two audio fixes and one gtk message fix.

----------------------------------------------------------------

Sai Pavan Boddu (1):
  display: xlnx_dp: Provide sufficient bytes for silent audio channel

Volker R=C3=BCmelin (1):
  audio: fix audio recording

yanminhui (1):
  ui/gtk: fix gettext message's charset.

 audio/audio.c        | 1 +
 hw/display/xlnx_dp.c | 9 +++++++--
 ui/gtk.c             | 1 +
 po/zh_CN.po          | 2 +-
 4 files changed, 10 insertions(+), 3 deletions(-)

--=20
2.18.1


