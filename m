Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54277C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:39:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20DC1206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 19:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cg057VmO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DC1206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igwDU-0004Gf-V4
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 14:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1igwCS-0002wl-5I
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:38:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1igwCP-0001Tl-G4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:38:34 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20946
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1igwCO-0001Rj-TR
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 14:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576525111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zFR4+hHGXwqvYOgsrxkCpiDUpOVABar24qY7FUE05Lc=;
 b=cg057VmOGjPFBgIJLBwtGcHB2vbF8oB5GMmW1ire41gPn6zkifSqM+iomwGAX1SgYgh1Rc
 HvclXr2nwpbV08/QSscQR99TwEJNEub5B6ST7xVAzqQsq+sng8eQxy6ziil5vhBxoBM51E
 894gePuqJICrHKmrqtyAj7shE8pwO3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-wEd_YM0uPhuIY3tUtued2A-1; Mon, 16 Dec 2019 14:38:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36865800053;
 Mon, 16 Dec 2019 19:38:27 +0000 (UTC)
Received: from localhost (ovpn-116-90.gru2.redhat.com [10.97.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B26FD5D9C9;
 Mon, 16 Dec 2019 19:38:26 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/4] x86 queue, 2019-12-16
Date: Mon, 16 Dec 2019 16:38:21 -0300
Message-Id: <20191216193825.1794153-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: wEd_YM0uPhuIY3tUtued2A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 4148d142a8cbbce10bb77e560997ae6b482e5edf=
:

  Merge remote-tracking branch 'remotes/dgilbert/tags/pull-virtiofs-2019121=
3a' into staging (2019-12-13 15:58:54 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to 88703ce2e6bbc8cc00c90c1bb8af1f3cd964ac9c:

  i386: Use g_autofree in a few places (2019-12-13 16:32:19 -0300)

----------------------------------------------------------------
x86 queue, 2019-12-16

Feature:
* Cooperlake CPU model

Cleanups:
* Use g_autofree in a few places

----------------------------------------------------------------

Cathy Zhang (3):
  i386: Add MSR feature bit for MDS-NO
  i386: Add macro for stibp
  i386: Add new CPU model Cooperlake

Eduardo Habkost (1):
  i386: Use g_autofree in a few places

 target/i386/cpu.c | 101 +++++++++++++++++++++++++++++++++-------------
 target/i386/cpu.h |   3 ++
 2 files changed, 76 insertions(+), 28 deletions(-)

--=20
2.23.0


