Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAAFC433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA3B2137B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA3B2137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD73d-0006bC-39
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zG-0005FU-FA; Tue, 01 Sep 2020 10:10:14 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:49511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zD-0003kv-Ck; Tue, 01 Sep 2020 10:10:14 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MyseA-1kYbuO0Vko-00vzY7; Tue, 01 Sep 2020 16:10:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 13/44] stubs/cmos: Use correct include
Date: Tue,  1 Sep 2020 16:09:23 +0200
Message-Id: <20200901140954.889743-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dS20v3gw2u2mvJ4hZkS/ZTB7063+qvvt1jXg6HhuBk2JPnF3+RB
 8sjbueW+jPeuKyTAVWgpNloTrtJ1ocBy7hKQjczZt44JafwLl/l8pLoXu/cseaa8N0SGZAF
 K6naJDOMnj3Pb/4CmOZsslC+UYKt/Tc2224O/bOa3kK7khbd7jlZF4IEIyfwYW2I7AVr0MY
 Y1zoE/w5/j/9iFUWv1zyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wYgD4GoZcuU=:9zM3pFHSZ7J6EkcLFwQnQj
 NlL1BiPLP8tBj3m2QYeh8tnr+tmiBoJvt456nmBnojNOcJsA8PSZ7voTk7ohvC/hRWcAyg2sK
 OnKwzVHmkXQHqUOChdbRHU8D4IOdEYZInhyRj4bFqoM/MtSE91gICtfUHIrqA9wIsVho1RcpT
 WitmRXET3IVDQAXptC+LXi9jXH/tcqGTHM24QzJmKrRyBFB8JhGYKhpz+jhM2rgOipkSwaI5m
 iCAq+4ZwCKe3eA7qbFVLsFUJq9dSEZeVFk3r+VugwnLM3pxyyt3Y5kvTyJ7eW/xZ2fR8k43R7
 vAbT7h2ESHWn5hRZ8Zop1wOEmWuK0oihOP+Eon/4tSpKkukkzh7y39pgltN0XJSwaqkDfVJAs
 Irt78zkeu+zNW7Y14950Zp3ErzyfUeahy2SqFhKQgNBg2/78IgXsFneEgxmBS5lWKYNKtsI0I
 /5yynxqxq4aEF8lQMd8zuVWtW+JCIvWwk0yTcG9m/2eGrdNzCMcts13DQYY3JSUhghtMd0xVz
 iWbw/+8h+b/V5nh5pflFLHrS3yhxEPQX57RgbCBDM3wWamaa8T2F7/vZ4bOrF4Xf4D17kIN/X
 08VdC7T069L8NJY9p6n0pLHsLsjc1FPnATEHL5B+slS7E7WSuK24ijNYogoy5Hxo7ssFcGhR9
 PvrX4KPpv7AEqj5pNGHEBITAzcv2dZJWag3xzfrxhqSj31tfHuOYSLoTHXoFfWFFnUq3YyJ5i
 TLrOULmHxtTjb51goLrSOzdvo+e+MHy7c+z9LKmZ0e8+t1T5cnhXAsNDaCz2yFRQ/CnvGBsml
 JvtbiwqU2S3wjVFFYrcJ3+JOmn5mxSU0R43dCpq85zeksCy40HNhoXirUmXhK75WIGGMtbl
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, John Snow <jsnow@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

cmos_get_fd_drive_type() is declared in "hw/block/fdc.h".
This currently works because "hw/i386/pc.h" happens to
include it. Simplify including the correct header.

Fixes: 2055dbc1c9 ("acpi: move aml builder code for floppy device")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-Id: <20200724084315.1606-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 stubs/cmos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/stubs/cmos.c b/stubs/cmos.c
index 416cbe4055ff..3fdbae2c69e8 100644
--- a/stubs/cmos.c
+++ b/stubs/cmos.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "hw/i386/pc.h"
+#include "hw/block/fdc.h"
 
 int cmos_get_fd_drive_type(FloppyDriveType fd0)
 {
-- 
2.26.2


