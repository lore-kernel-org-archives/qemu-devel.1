Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243BAC468BD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3014208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3014208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51058 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZEoS-0000kR-5O
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34402)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kraxel@redhat.com>) id 1hZEm0-0007NC-Q7
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1hZElz-00051G-Ro
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:19:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50078)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hZElz-0004uW-Ks
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:19:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4A2A030832F4
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 13:19:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-25.ams2.redhat.com
 [10.36.117.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 627196092E;
 Fri,  7 Jun 2019 13:19:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EE3F716E1A; Fri,  7 Jun 2019 15:19:01 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 15:18:56 +0200
Message-Id: <20190607131901.20107-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 07 Jun 2019 13:19:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/5] Ui 20190607 patches
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 0d74f3b4277a7ecb0ccb80c865797d11f8e466=
f5:

  Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-=
request' into staging (2019-06-06 14:09:14 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/ui-20190607-pull-request

for you to fetch changes up to 15ee0d9bc10b3de677ff6cd78b6dc9d5a7d40603:

  egl-helpers: add modifier support to egl_dmabuf_import_texture() (2019-=
06-07 11:52:35 +0200)

----------------------------------------------------------------
curses: 32bit build fix.
egl: dmabuf modifier support.

----------------------------------------------------------------

Gerd Hoffmann (4):
  console: add dmabuf modifier field.
  vfio/display: set dmabuf modifier field
  egl-helpers: add modifier support to egl_get_fd_for_texture().
  egl-helpers: add modifier support to egl_dmabuf_import_texture()

Max Reitz (1):
  ui/curses: Fix build with -m32

 include/ui/console.h     |  1 +
 include/ui/egl-helpers.h |  3 ++-
 hw/vfio/display.c        |  1 +
 ui/curses.c              |  8 ++++----
 ui/egl-helpers.c         | 39 ++++++++++++++++++++++++++++-----------
 ui/spice-display.c       |  7 ++++---
 6 files changed, 40 insertions(+), 19 deletions(-)

--=20
2.18.1


