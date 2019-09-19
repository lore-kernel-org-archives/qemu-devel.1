Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33D8C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAA321907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 07:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAA321907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAqas-0002wO-6Z
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 03:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iAqZC-0001Ey-5I
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iAqZ9-0004ym-RZ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:09:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iAqZ9-0004xO-Hj
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 03:09:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1807310C0517
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 07:09:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AE8D5D6B0;
 Thu, 19 Sep 2019 07:09:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6AFB617535; Thu, 19 Sep 2019 09:09:18 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 09:09:14 +0200
Message-Id: <20190919070918.16059-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 19 Sep 2019 07:09:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/4] Ui 20190919 patches
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

The following changes since commit 89ea03a7dc83ca36b670ba7f787802791fcb04=
b1:

  Merge remote-tracking branch 'remotes/huth-gitlab/tags/m68k-pull-2019-0=
9-07' into staging (2019-09-09 09:48:34 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/ui-20190919-pull-request

for you to fetch changes up to 6bf21f3d83e95bcc4ba35a7a07cc6655e8b010b0:

  vnc: fix memory leak when vnc disconnect (2019-09-17 13:45:10 +0200)

----------------------------------------------------------------
ui: add barrier client.
ui: bugfixes for vnc & egl.

----------------------------------------------------------------

Gerd Hoffmann (2):
  ui/egl: fix framebuffer reads
  vnc: fix websocket field in events

Laurent Vivier (1):
  ui: add an embedded Barrier client

Li Qiang (1):
  vnc: fix memory leak when vnc disconnect

 docs/barrier.txt         | 370 +++++++++++++++++++
 include/ui/egl-helpers.h |   2 +-
 ui/input-barrier.h       | 112 ++++++
 ui/vnc.h                 |   4 +-
 ui/egl-headless.c        |   4 +-
 ui/egl-helpers.c         |   6 +-
 ui/input-barrier.c       | 750 +++++++++++++++++++++++++++++++++++++++
 ui/vnc-enc-tight.c       | 219 ++++++------
 ui/vnc-enc-zlib.c        |  11 +-
 ui/vnc-enc-zrle.c        |  68 ++--
 ui/vnc-enc-zrle.inc.c    |   2 +-
 ui/vnc.c                 |  29 +-
 ui/Makefile.objs         |   1 +
 13 files changed, 1409 insertions(+), 169 deletions(-)
 create mode 100644 docs/barrier.txt
 create mode 100644 ui/input-barrier.h
 create mode 100644 ui/input-barrier.c

--=20
2.18.1


