Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DD8C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D04A2171F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D04A2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42409 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSq9x-0002jR-Ei
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 17:49:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSq4Z-0007NR-RW
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSq4Y-000061-Og
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:43:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hSq4W-0008Ve-Gp; Mon, 20 May 2019 17:43:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4558A20276;
	Mon, 20 May 2019 21:43:51 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-28.brq.redhat.com [10.40.204.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 219EF1001E6C;
	Mon, 20 May 2019 21:43:45 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 23:43:38 +0200
Message-Id: <20190520214342.13709-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 20 May 2019 21:43:51 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/4] arm: exynos4: Add dma support for smdkc210
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Another intent to salvage previous work from Guenter Roeck:
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06302.html

Since v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06674.=
html
- rebased
- QOM'ify the SoC code

Since v2: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06459.=
html
- rename init -> create
- create controllers in SoC rather than the board (Peter Maydell)
- add Linux dtsi in commit message

Since v1: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06335.=
html
- Do not factor out pl330_init, which resulted in buggy v1, see:
  https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06448.html

Guenter Roeck (1):
  hw/arm/exynos4210: Add DMA support for the Exynos4210

Philippe Mathieu-Daud=C3=A9 (3):
  hw/arm/exynos4: Remove unuseful debug code
  hw/arm/exynos4: Use the IEC binary prefix definitions
  hw/arm/exynos4210: QOM'ify the Exynos4210 SoC

 hw/arm/exynos4210.c         | 52 ++++++++++++++++++++++++++++++++++---
 hw/arm/exynos4_boards.c     | 38 +++++++--------------------
 include/hw/arm/exynos4210.h |  9 +++++--
 3 files changed, 65 insertions(+), 34 deletions(-)

--=20
2.20.1


