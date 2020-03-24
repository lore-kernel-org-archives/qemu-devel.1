Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9018AC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8A62076E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 19:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC7Vkw0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8A62076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGpfk-0004x6-Fh
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 15:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jGpeO-0003i3-8F
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jGpeN-00036W-11
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:55:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43042)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jGpeM-00035z-Tb
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 15:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585079746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oilTP3uWJ7zHXpKqEgMgvLZ955N7WVuR8EFGNNwEC3Q=;
 b=PC7Vkw0SMOX6SG8WVy/X1TJ26vGjlQWbvU62Vgd90HRHWCwYlLjwe7F9lFip8gxDX/ez36
 nem7++CMcZoPvD/hoZr4L5d/hDdG4OshlQ59kpaM8jxWeyp109o5/dbFx05R7vSTEChHHx
 mPrWG9jP+lEb50OScck6tqfNAx0/Pag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-cAvZ2DPJOoGoQmGHACl9HA-1; Tue, 24 Mar 2020 15:55:40 -0400
X-MC-Unique: cAvZ2DPJOoGoQmGHACl9HA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77224107B27F;
 Tue, 24 Mar 2020 19:55:36 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B100171FF;
 Tue, 24 Mar 2020 19:55:24 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 0/2] Ide patches
Date: Tue, 24 Mar 2020 15:55:21 -0400
Message-Id: <20200324195523.19779-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 736cf607e40674776d752acc201f565723e86045=
:

  Update version for v5.0.0-rc0 release (2020-03-24 17:50:00 +0000)

are available in the Git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to 51058b3b3bcbe62506cf191fca1c0d679bb80f2b:

  hw/ide/sii3112: Use qdev gpio rather than qemu_allocate_irqs() (2020-03-2=
4 15:52:16 -0400)

----------------------------------------------------------------
Pull request: IDE

Admittedly the first one is not a crisis fix; but I think it's low-risk to
include for rc1.

The second one is yours, and will shush coverity.

----------------------------------------------------------------

Peter Maydell (1):
  hw/ide/sii3112: Use qdev gpio rather than qemu_allocate_irqs()

Sven Schnelle (1):
  fdc/i8257: implement verify transfer mode

 include/hw/isa/isa.h |  1 -
 hw/block/fdc.c       | 61 +++++++++++++-------------------------------
 hw/dma/i8257.c       | 20 ++++++++++-----
 hw/ide/sii3112.c     |  8 +++---
 4 files changed, 35 insertions(+), 55 deletions(-)

--=20
2.21.1


