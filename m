Return-Path: <SRS0=rbQy=SV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36229C282DA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 10:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01936217FA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2019 10:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01936217FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54348 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHQeN-0005L0-4j
	for qemu-devel@archiver.kernel.org; Fri, 19 Apr 2019 06:21:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hHQbR-0003BV-Qf
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 06:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hHQbQ-0002vI-Lw
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 06:18:41 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:58521
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hHQbQ-0002to-GH
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 06:18:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 9C17481392;
	Fri, 19 Apr 2019 12:18:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
	by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m5z82F7Nw0Dv; Fri, 19 Apr 2019 12:18:37 +0200 (CEST)
Received: from localhost.localdomain.localdomain
	(apoitiers-155-1-191-106.w109-220.abo.wanadoo.fr [109.220.154.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.eu.adacore.com (Postfix) with ESMTPSA id 43E678137F;
	Fri, 19 Apr 2019 12:18:37 +0200 (CEST)
From: KONRAD Frederic <frederic.konrad@adacore.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 12:18:09 +0200
Message-Id: <1555669092-10351-1-git-send-email-frederic.konrad@adacore.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
Subject: [Qemu-devel] [PATCH V1 0/3] Leon3 patches
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190419101809.sHCPYUkFvaEtisRzicaLF_Cty8GAedipAo3n6AhIyRw@z>

Hi all,

Those are some little fixes for the leon3 machine:
  * The first part has already been submitted before and has been reworked
    to follow Philippe's advice see:
      <1519898536-19027-1-git-send-email-frederic.konrad@adacore.com>
      "grlib_apbuart: always enable tx and rx"
  * The second part adds AHB and APB plug and play devices to allow to boot
    linux.
  * The third part adds myself to the MAINTAINERS for this board.

The test images are available here: https://www.gaisler.com/anonftp/linux/lin
ux-2.6/images/leon-linux-4.9/leon-linux-4.9-1.0/up/

Tested with:
  qemu-system-sparc -M leon3_generic --nographic --kernel image.ram

Regards,
Fred

KONRAD Frederic (3):
  leon3: add a little bootloader
  leon3: introduce the plug and play mecanism
  MAINTAINERS: add myself for leon3

 MAINTAINERS                         |   1 +
 hw/misc/Makefile.objs               |   2 +
 hw/misc/grlib_ahb_apb_pnp.c         | 269 ++++++++++++++++++++++++++++++++++++
 hw/sparc/leon3.c                    | 110 +++++++++++++--
 include/hw/misc/grlib_ahb_apb_pnp.h |  60 ++++++++
 include/hw/sparc/grlib.h            |  35 +++--
 6 files changed, 451 insertions(+), 26 deletions(-)
 create mode 100644 hw/misc/grlib_ahb_apb_pnp.c
 create mode 100644 include/hw/misc/grlib_ahb_apb_pnp.h

-- 
1.8.3.1


