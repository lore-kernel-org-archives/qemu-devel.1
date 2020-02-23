Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784DAC35671
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 13:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F992206ED
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 13:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F992206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5rNq-0005rp-DH
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 08:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1j5rIk-0000As-2e
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 08:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1j5rIi-0003xm-J0
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 08:28:06 -0500
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:45972)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1j5rIi-0003xL-AI
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 08:28:04 -0500
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail02.asahi-net.or.jp (Postfix) with ESMTPA id 9E86DE4899;
 Sun, 23 Feb 2020 22:28:03 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 51E41240092;
 Sun, 23 Feb 2020 22:28:03 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH v31 23/23] fix warning.
Date: Sun, 23 Feb 2020 22:27:50 +0900
Message-Id: <20200223132750.69480-24-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223132750.69480-1-ysato@users.sourceforge.jp>
References: <20200223132750.69480-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.14
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
Cc: richard.henderson@linaro.org, philmd@redhat.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 hw/rx/rx-virt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/rx/rx-virt.c b/hw/rx/rx-virt.c
index 6cf7936201..4ee6647728 100644
--- a/hw/rx/rx-virt.c
+++ b/hw/rx/rx-virt.c
@@ -90,8 +90,10 @@ static void rxvirt_init(MachineState *machine)
=20
     /* Load kernel and dtb */
     if (kernel_filename) {
-        /* The kernel image is loaded into
-           the latter half of the SDRAM space. */
+        /*
+          The kernel image is loaded into
+          the latter half of the SDRAM space.
+        */
         kernel_offset =3D machine->ram_size / 2;
         rx_load_image(RXCPU(first_cpu), kernel_filename,
                       SDRAM_BASE + kernel_offset, kernel_offset);
--=20
2.20.1


