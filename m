Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1870FC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D965A20843
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D965A20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36547 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQt6W-0002Y7-QU
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 08:33:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hQt4a-00018U-3D
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hQt4Y-0006EX-SK
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:31:52 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:39574
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hQt4Y-0006C1-MY
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:31:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 5027F81396;
	Wed, 15 May 2019 14:31:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
	by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UOv47WxQr_8i; Wed, 15 May 2019 14:31:48 +0200 (CEST)
Received: from wifi-guest-96.act-europe.fr (wifi-guest-96.act-europe.fr
	[10.10.126.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.eu.adacore.com (Postfix) with ESMTPSA id 1A2EC8138C;
	Wed, 15 May 2019 14:31:48 +0200 (CEST)
From: KONRAD Frederic <frederic.konrad@adacore.com>
To: qemu-devel@nongnu.org
Date: Wed, 15 May 2019 14:31:26 +0200
Message-Id: <1557923493-4836-1-git-send-email-frederic.konrad@adacore.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 194.98.77.210
Subject: [Qemu-devel] [PATCH v3 0/7] Leon3 patches
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk,
	chouteau@adacore.com, frederic.konrad@adacore.com,
	philmd@redhat.com, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

Those are some little fixes for the leon3 machine:
  * The first patch makes an error message more friendly when no kernel /=
 bios
    are provided.
  * The three next one remove the old-style create function as suggested =
by
    Mark.
  * The fifth part initializes the uart and the timer when no bios are
    provided.
  * The sixth part adds AHB and APB plug and play devices to allow to boo=
t
    linux.
  * The last part adds myself to the MAINTAINERS for this board.

The test images are available here: https://www.gaisler.com/anonftp/linux=
/lin
ux-2.6/images/leon-linux-4.9/leon-linux-4.9-1.0/up/

Tested with:
  qemu-system-sparc -M leon3_generic --nographic --kernel image.ram

V2 -> V3:
  * rebased.
  * added patches 1, 2, 3, 4 as suggested by Mark.
  * fixed DEVICE_NATIVE_ENDIAN to DEVICE_BIG_ENDIAN in patch 6 as suggest=
ed by
    Mark.
  * added include/hw/*/grlib* to the MAINTAINED file as suggested by Mark=
.
V1 -> V2:
  * minor fixes in the first patch suggested by Philippe.

Regards,
Fred

KONRAD Frederic (7):
  leon3: fix the error message when no bios are provided
  grlib,irqmp: get rid of the old-style create function
  grlib,gptimer: get rid of the old-style create function
  grlib,apbuart: get rid of the old-style create function
  leon3: add a little bootloader
  leon3: introduce the plug and play mechanism
  MAINTAINERS: add myself for leon3

 MAINTAINERS                         |   3 +-
 hw/char/grlib_apbuart.c             |   4 +-
 hw/intc/grlib_irqmp.c               |   3 +-
 hw/misc/Makefile.objs               |   2 +
 hw/misc/grlib_ahb_apb_pnp.c         | 269 ++++++++++++++++++++++++++++++=
++++++
 hw/sparc/leon3.c                    | 157 ++++++++++++++++++---
 hw/timer/grlib_gptimer.c            |   4 +-
 include/hw/misc/grlib_ahb_apb_pnp.h |  60 ++++++++
 include/hw/sparc/grlib.h            |  78 +----------
 9 files changed, 483 insertions(+), 97 deletions(-)
 create mode 100644 hw/misc/grlib_ahb_apb_pnp.c
 create mode 100644 include/hw/misc/grlib_ahb_apb_pnp.h

--=20
1.8.3.1


