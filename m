Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A449BC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B0D23A45
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B0D23A45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyta-0001Qz-6Q
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1hzys3-0007vw-SA
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hzys1-0004Oh-Pf
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:47:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hzys1-0004OQ-KO
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:47:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FDB8317529B;
 Tue, 20 Aug 2019 07:47:56 +0000 (UTC)
Received: from thuth.com (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56403100195C;
 Tue, 20 Aug 2019 07:47:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 09:47:41 +0200
Message-Id: <20190820074749.25208-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 20 Aug 2019 07:47:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/8] Improvements for the Kconfig switches and
 Makefiles
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit 50d69ee0d82378c7c21f482492dacfe0916b48=
63:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-softfloat-heade=
rs-190819-1' into staging (2019-08-19 15:58:01 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-08-20

for you to fetch changes up to f874d7293589ab42bf5da0c03c9048e5d11c292f:

  hw/core: Add a config switch for the generic loader device (2019-08-20 =
09:11:17 +0200)

----------------------------------------------------------------
* Improvements for the Kconfig switches and Makefiles
----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (3):
      hw/Kconfig: Move the generic XLNX_ZYNQMP to the root hw/Kconfig
      hw/intc: Only build the xlnx-iomod-intc device for the MicroBlaze P=
MU
      hw/dma: Do not build the xlnx_dpdma device for the MicroBlaze machi=
nes

Thomas Huth (5):
      hw/core: Add a config switch for the "register" device
      hw/core: Add a config switch for the "or-irq" device
      hw/core: Add a config switch for the "split-irq" device
      hw/misc: Add a config switch for the "unimplemented" device
      hw/core: Add a config switch for the generic loader device

 hw/Kconfig            |  4 ++++
 hw/arm/Kconfig        | 17 +++++++++++++++++
 hw/core/Kconfig       | 13 +++++++++++++
 hw/core/Makefile.objs |  8 ++++----
 hw/dma/Kconfig        |  1 +
 hw/dma/Makefile.objs  |  1 -
 hw/intc/Makefile.objs |  2 +-
 hw/microblaze/Kconfig |  1 +
 hw/misc/Kconfig       |  3 +++
 hw/misc/Makefile.objs |  2 +-
 hw/pci-host/Kconfig   |  3 ++-
 hw/sparc64/Kconfig    |  1 +
 hw/timer/Kconfig      |  3 ---
 13 files changed, 48 insertions(+), 11 deletions(-)

