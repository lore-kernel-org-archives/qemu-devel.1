Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5DBC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DAA9216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAA9216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjQZq-00051a-Ox
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 11:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36686)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjQQv-0003UP-6k
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjQQs-0007fj-7Z
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:47:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hjQQj-0006y3-El; Fri, 05 Jul 2019 11:47:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA9EC59441;
 Fri,  5 Jul 2019 15:47:19 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A73BF1001B27;
 Fri,  5 Jul 2019 15:47:17 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 17:46:38 +0200
Message-Id: <20190705154639.16591-9-philmd@redhat.com>
In-Reply-To: <20190705154639.16591-1-philmd@redhat.com>
References: <20190705154639.16591-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 05 Jul 2019 15:47:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 8/9] hw/block/pflash_cfi01: Replace DPRINTF
 by qemu_log_mask(GUEST_ERROR)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index ba00e52923..ab72af22a7 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -283,7 +283,9 @@ static uint32_t pflash_read(PFlashCFI01 *pfl, hwaddr =
offset,
     switch (pfl->cmd) {
     default:
         /* This should never happen : reset state & treat it as a read *=
/
-        DPRINTF("%s: unknown command state: %x\n", __func__, pfl->cmd);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid state, "
+                      "wcycle %d cmd 0x02%x\n",
+                      __func__, pfl->wcycle, pfl->cmd);
         pfl->wcycle =3D 0;
         pfl->cmd =3D 0xff;
         /* fall through to read code */
@@ -630,7 +632,9 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
         break;
     default:
         /* Should never happen */
-        DPRINTF("%s: invalid write state\n",  __func__);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid state, "
+                      "wcycle %d cmd (0x02%x -> value 0x02%x)\n",
+                      __func__, pfl->wcycle, pfl->cmd, value);
         goto mode_read_array;
     }
     return;
--=20
2.20.1


