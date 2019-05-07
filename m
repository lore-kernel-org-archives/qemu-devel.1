Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586BBC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D2CE20578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2CE20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47120 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO0RS-0006JS-EV
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 09:47:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hO0Pe-00050F-L1
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hO0Pd-000762-Do
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:45:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hO0PW-0006wz-Nf; Tue, 07 May 2019 09:45:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8809301BE66;
	Tue,  7 May 2019 13:45:33 +0000 (UTC)
Received: from thuth.com (ovpn-116-130.ams2.redhat.com [10.36.116.130])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1AA0747341;
	Tue,  7 May 2019 13:45:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue,  7 May 2019 15:45:20 +0200
Message-Id: <20190507134521.31044-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 07 May 2019 13:45:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 00/28] Kconfig for Arm machines
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
Cc: jsnow@redhat.com, qemu-arm@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04=
f7:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-re=
quest' into staging (2019-05-03 15:26:09 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-07

for you to fetch changes up to 69f879e9fefab9aaf24893fe4ce23e07756d703c:

  hw/arm: Remove hard-enablement of the remaining PCI devices (2019-05-07=
 15:01:47 +0200)

----------------------------------------------------------------
Kconfig settings for the Arm machines
(v2: Fix the dependency of q35 to AHCI_ICH9 in the second patch)
----------------------------------------------------------------

Thomas Huth (28):
      hw/pci/pci-stub: Add msi_enabled() and msi_notify() to the pci stub=
s
      hw/ide/ahci: Add a Kconfig switch for the AHCI-ICH9 device
      hw/arm: Express dependencies of the exynos machines with Kconfig
      hw/arm: Express dependencies of the highbank machines with Kconfig
      hw/arm: Express dependencies of integratorcp with Kconfig
      hw/arm: Express dependencies of the fsl-imx31 machine with Kconfig
      hw/arm: Express dependencies of musicpal with Kconfig
      hw/arm: Express dependencies of the OMAP machines with Kconfig
      hw/arm: Express dependencies of stellaris with Kconfig
      hw/arm: Express dependencies of realview, versatile and vexpress wi=
th Kconfig
      hw/arm: Express dependencies of the PXA2xx machines with Kconfig
      hw/arm: Express dependencies of xilinx-zynq with Kconfig
      hw/arm: Express dependencies of collie with Kconfig
      hw/arm: Express dependencies of the aspeed boards with Kconfig
      hw/arm: Express dependencies of the virt machine with Kconfig
      hw/arm: Express dependencies of netduino / stm32f2xx with Kconfig
      hw/arm: Express dependencies of allwinner / cubieboard with Kconfig
      hw/arm: Express dependencies of the MPS2 boards with Kconfig
      hw/arm: Express dependencies of the raspi machines with Kconfig
      hw/arm: Express dependencies of canon-a1100 with Kconfig
      hw/arm: Express dependencies of sabrelite with Kconfig
      hw/arm: Express dependencies of the MSF2 / EMCRAFT_SF2 machine with=
 Kconfig
      hw/arm: Express dependencies of the remaining IMX boards with Kconf=
ig
      hw/arm: Express dependencies of the microbit / nrf51 machine with K=
config
      hw/arm: Express dependencies of the ZynqMP zcu102 machine with Kcon=
fig
      hw/arm: Express dependencies of the xlnx-versal-virt machine with K=
config
      hw/arm: Express dependencies of the musca machines with Kconfig
      hw/arm: Remove hard-enablement of the remaining PCI devices

 default-configs/aarch64-softmmu.mak |   5 -
 default-configs/arm-softmmu.mak     | 179 ++++----------------
 hw/arm/Kconfig                      | 317 ++++++++++++++++++++++++++++++=
+++++-
 hw/arm/Makefile.objs                |  25 ++-
 hw/display/Kconfig                  |   3 +
 hw/i2c/Kconfig                      |   2 +-
 hw/i386/Kconfig                     |   2 +-
 hw/ide/Kconfig                      |   6 +-
 hw/ide/Makefile.objs                |   2 +-
 hw/misc/Kconfig                     |   2 +
 hw/pci/pci-stub.c                   |  11 ++
 11 files changed, 384 insertions(+), 170 deletions(-)

