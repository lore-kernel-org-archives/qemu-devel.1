Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A06C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 20:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D17120714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 20:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2xfttac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D17120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHvP0-0003dx-Hx
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 16:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jHvO0-000273-ER
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 16:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jHvNy-0002vZ-Ip
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 16:15:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25879)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jHvNy-0002ux-Es
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 16:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585340121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7nk1vRt2EW91yZBA0hQnUHhRbgmQUUVDNLIQJK6RVSw=;
 b=e2xfttac0hJGEsUapgsvCgbP960XquDplhY8GPWfBz1vC4JvyYnLa9e5pX7nv3cIzPQHoi
 jBV70vWd8pKGXum99/Pd2Jh+CrykNKTqX3q1ymmbjMJLHItU8/7w+XZ4TGVufhyZEQqeyz
 jfXKalFSouc5X2zIkDahYmSYMCkrsuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-8QWFtiOtMDKDQXO4XYSrVw-1; Fri, 27 Mar 2020 16:15:18 -0400
X-MC-Unique: 8QWFtiOtMDKDQXO4XYSrVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ADF98017CC;
 Fri, 27 Mar 2020 20:15:15 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-210.rdu2.redhat.com [10.10.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6356B19757;
 Fri, 27 Mar 2020 20:15:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 0/5] Ide patches
Date: Fri, 27 Mar 2020 16:14:56 -0400
Message-Id: <20200327201501.1417-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-block@nongnu.org,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit cfe68ae025f704f336d7dd3d1903ce37b445831d=
:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.0-pul=
l-request' into staging (2020-03-26 20:55:54 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to cbf4c9ac9c000f7caf1bfee031041b62d2b000c8:

  cmd646-ide: use qdev gpio rather than qemu_allocate_irqs() (2020-03-27 14=
:30:08 -0400)

----------------------------------------------------------------
Pull request

----------------------------------------------------------------

Mark Cave-Ayland (3):
  via-ide: don't use PCI level for legacy IRQs
  via-ide: use qdev gpio rather than qemu_allocate_irqs()
  cmd646-ide: use qdev gpio rather than qemu_allocate_irqs()

Peter Maydell (1):
  hw/ide/sii3112: Use qdev gpio rather than qemu_allocate_irqs()

Sven Schnelle (1):
  fdc/i8257: implement verify transfer mode

 include/hw/isa/isa.h |  1 -
 hw/block/fdc.c       | 61 +++++++++++++-------------------------------
 hw/dma/i8257.c       | 20 ++++++++++-----
 hw/ide/cmd646.c      |  9 +++----
 hw/ide/sii3112.c     |  8 +++---
 hw/ide/via.c         |  7 ++---
 6 files changed, 43 insertions(+), 63 deletions(-)

--=20
2.21.1


