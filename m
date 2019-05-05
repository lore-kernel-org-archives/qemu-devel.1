Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29998C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 20:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FFF208C2
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 20:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FFF208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45316 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNNQo-0003M0-95
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 16:08:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNP3-00026D-1c
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNNOz-0002oO-Vd
	for qemu-devel@nongnu.org; Sun, 05 May 2019 16:06:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hNNOx-0002Lv-Ij; Sun, 05 May 2019 16:06:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 823C830820E4;
	Sun,  5 May 2019 20:06:19 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-58.brq.redhat.com [10.40.204.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 411C060851;
	Sun,  5 May 2019 20:06:05 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-stable@nongnu.org
Date: Sun,  5 May 2019 22:05:57 +0200
Message-Id: <20190505200602.12412-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Sun, 05 May 2019 20:06:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/5] hw/block/pflash: Add DeviceReset() handlers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505200557.naic8gpR8FN40w8e21l9dwcgPaJSihuL9dxsDDxRF-s@z>

The pflash device lacks a reset() function.
When a machine is resetted, the flash might be in an
inconsistent state, leading to unexpected behavior:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713

Resolve this issue by adding a DeviceReset() handler.

Both CFI01/CFI02 devices are fixed by this series.

Regards,

Phil.

Philippe Mathieu-Daud=C3=A9 (5):
  hw/block/pflash_cfi01: Removed an unused timer
  hw/block/pflash_cfi01: Extract the pflash_reset() code
  hw/block/pflash_cfi01: Add the DeviceReset() handler
  hw/block/pflash_cfi02: Extract the pflash_reset() code
  hw/block/pflash_cfi02: Add the DeviceReset() handler

 hw/block/pflash_cfi01.c | 31 ++++++++++++-------------------
 hw/block/pflash_cfi02.c | 31 +++++++++++++++++++++----------
 2 files changed, 33 insertions(+), 29 deletions(-)

--=20
2.20.1


