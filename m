Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6A1C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1947204FD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1947204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42057 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNvMP-0002hW-TI
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:22:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hNvKM-0000eD-6b
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hNvKL-00089I-5B
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:19:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>)
	id 1hNvKI-00086z-UQ; Tue, 07 May 2019 04:19:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DEC8AC08E;
	Tue,  7 May 2019 08:19:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 935EC60C4D;
	Tue,  7 May 2019 08:19:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 7905811AA3; Tue,  7 May 2019 10:19:46 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 10:19:38 +0200
Message-Id: <20190507081946.19264-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 07 May 2019 08:19:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/8] Vga 20190507 patches
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
	Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a6ae23831b05a11880b40f7d58e332c45a6b04=
f7:

  Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pull-re=
quest' into staging (2019-05-03 15:26:09 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/vga-20190507-pull-request

for you to fetch changes up to 6306cae275c7091aa4e785809d956b475bfedab4:

  i2c-ddc: move it to hw/display (2019-05-07 09:56:10 +0200)

----------------------------------------------------------------
vga: bugfixes for qxl, cirrus, ati.
vga: add "-vga help" support.
vga: move i2c-ddc to display.

----------------------------------------------------------------

BALATON Zoltan (1):
  ati-vga: Fix check for blt outside vram

Daniel P. Berrang=C3=A9 (1):
  qxl: avoid unaligned pointer reads/writes

Marc-Andr=C3=A9 Lureau (2):
  vl: constify VGAInterfaceInfo
  vl: add -vga help support

Paolo Bonzini (1):
  i2c-ddc: move it to hw/display

Philippe Mathieu-Daud=C3=A9 (2):
  hw/display/cirrus_vga: Update the documentation URL
  hw/display/cirrus_vga: Remove unused include

Prasad J Pandit (1):
  qxl: check release info object

 include/hw/{i2c =3D> display}/i2c-ddc.h |  0
 include/hw/display/xlnx_dp.h          |  2 +-
 hw/display/ati_2d.c                   | 12 +++---
 hw/display/cirrus_vga.c               | 10 +++--
 hw/{i2c =3D> display}/i2c-ddc.c         |  2 +-
 hw/display/qxl.c                      | 58 +++++++++++++--------------
 hw/display/sii9022.c                  |  2 +-
 hw/display/sm501.c                    |  2 +-
 vl.c                                  | 46 +++++++++++++++------
 hw/display/Kconfig                    |  5 +++
 hw/display/Makefile.objs              |  1 +
 hw/i2c/Kconfig                        |  5 ---
 hw/i2c/Makefile.objs                  |  1 -
 13 files changed, 84 insertions(+), 62 deletions(-)
 rename include/hw/{i2c =3D> display}/i2c-ddc.h (100%)
 rename hw/{i2c =3D> display}/i2c-ddc.c (99%)

--=20
2.18.1


