Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC228C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A0A217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A0A217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58792 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUFCm-0007G8-Fl
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 14:46:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFBU-0006SV-2J
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFBS-0005hr-H3
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:44:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hUFBS-0005h2-8P
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:44:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 897033DE10;
	Fri, 24 May 2019 18:44:49 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E08AE7D917;
	Fri, 24 May 2019 18:44:48 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Fri, 24 May 2019 15:44:30 -0300
Message-Id: <20190524184447.16678-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Fri, 24 May 2019 18:44:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 00/17] Machine Core queue, 2019-05-24
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a7b21f6762a2d6ec08106d8a7ccb1182991452=
3f:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-p=
ull-request' into staging (2019-05-24 12:47:49 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 23d1f360f3de1d968d98ba605bd3b718f5309e6f:

  hw/intc/nvic: Use object_initialize_child for correct reference countin=
g (2019-05-24 15:29:02 -0300)

----------------------------------------------------------------
Machine Core queue, 2019-05-24

* Display more helpful message when an object type is missing
  (Philippe Mathieu-Daud=C3=A9)
* Use object_initialize_child for correct reference counting
  (Philippe Mathieu-Daud=C3=A9)

----------------------------------------------------------------

Queue for Machine Core patches


Philippe Mathieu-Daud=C3=A9 (17):
  qom/object: Display more helpful message when an object type is
    missing
  hw/ppc/pnv: Use object_initialize_child for correct reference counting
  hw/misc/macio: Use object_initialize_child for correct ref. counting
  hw/virtio: Use object_initialize_child for correct reference counting
  hw/arm/bcm2835: Use TYPE_PL011 instead of hardcoded string
  hw/arm/bcm2835: Use object_initialize() on PL011State
  hw/arm/bcm2835: Use object_initialize_child for correct ref. counting
  hw/arm/aspeed: Use object_initialize_child for correct ref. counting
  hw/arm: Use object_initialize_child for correct reference counting
  hw/mips: Use object_initialize() on MIPSCPSState
  hw/mips: Use object_initialize_child for correct reference counting
  hw/microblaze/zynqmp: Move the IPI state into the PMUSoC state
  hw/microblaze/zynqmp: Let the SoC manage the IPI devices
  hw/microblaze/zynqmp: Use object_initialize_child for correct ref.
    counting
  hw/microblaze/zynqmp: Use object_initialize_child for correct ref.
    counting
  hw/arm/mps2: Use object_initialize_child for correct reference
    counting
  hw/intc/nvic: Use object_initialize_child for correct reference
    counting

 include/hw/arm/bcm2835_peripherals.h |  3 +-
 hw/arm/aspeed.c                      |  6 +--
 hw/arm/aspeed_soc.c                  | 50 +++++++++--------------
 hw/arm/bcm2835_peripherals.c         | 61 +++++++++++-----------------
 hw/arm/digic.c                       | 17 +++-----
 hw/arm/imx25_pdk.c                   |  5 +--
 hw/arm/kzm.c                         |  5 +--
 hw/arm/mps2-tz.c                     |  8 ++--
 hw/arm/mps2.c                        |  8 ++--
 hw/arm/raspi.c                       |  7 ++--
 hw/arm/sabrelite.c                   |  5 +--
 hw/arm/xlnx-zcu102.c                 |  5 +--
 hw/arm/xlnx-zynqmp.c                 |  8 ++--
 hw/intc/armv7m_nvic.c                |  6 +--
 hw/microblaze/xlnx-zynqmp-pmu.c      | 45 ++++++++++----------
 hw/mips/boston.c                     | 25 ++++++------
 hw/mips/cps.c                        | 20 ++++-----
 hw/mips/mips_malta.c                 | 17 ++++----
 hw/misc/macio/macio.c                |  8 ++--
 hw/ppc/pnv.c                         | 12 ++----
 hw/virtio/virtio.c                   |  5 +--
 qom/object.c                         |  7 +++-
 22 files changed, 146 insertions(+), 187 deletions(-)

--=20
2.18.0.rc1.1.g3f1ff2140


