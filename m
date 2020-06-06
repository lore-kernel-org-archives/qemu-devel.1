Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B34FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65F59206A2
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F59206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYh9-0007en-Ic
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYfd-00062Y-GX
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:15:33 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYfZ-0007Zp-W7
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:15:33 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mk0FS-1jErg11vJo-00kMKw; Sat, 06 Jun 2020 15:15:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/19] linux-user: return target error codes for socket()
 and prctl()
Date: Sat,  6 Jun 2020 15:15:00 +0200
Message-Id: <20200606131517.1250346-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131517.1250346-1-laurent@vivier.eu>
References: <20200606131517.1250346-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vSvE8yzZQ+/jhlqHLs9KtejW7Ampq8TfsPaedVkwpuOrylfQ2ER
 rGdcECFpZX6PonpreSaje50d1d2A4WTu8o92o4Lv8XRKFe4RQxhoQXxUJ7rdJlhX92IhQ3b
 l6I6BUtyuZGpSx8jPQvdd6IjKoRY2H+4qdF74hHTvm/4X2ckTfAQfLpQRaaQnHADkFCvkPZ
 vo7x4MpBUxCS3WwG9xO8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TdF/lp0OqK0=:0m599vtsLyEnGmlf618jMb
 bbdk49pW54bCL1VCs4H8GreIAMn3jBPesYGSRMTWcIhoS530hlQEJ+IZcoodKFDXu2DygsEGv
 bMGeErVTADBvxkkjyP2cOebaod75iv/eWHJpNkPlntpZFd6MyZ++WucQeEQKO2WrOwpL1CEx3
 kseDFIXOJbZ2E0k4Qh4EI7dYHdSJUdYa5H9nxgSgWjnZKZvQ1FWwklvzNUOdqpvyhX5uP/Gri
 3RHOt4nNfphToquST5KXSE0Sf+5QviTEPHPaAuQmQsUsrBwFWyaVqRBchAW4OfVPL6YdgoXWh
 +ZLb5R6EV0t90Y8WiheVx5mBqs/7Pi81PdmqQkOsHvg8PUFBv59iqo0DLkb08+enQfU1qOBWf
 9mOYzt403yqdZ59QuyBEjFqZqF9VkOg0vlTXMBWgTI28b6SMN6xxXkObFh48zUt0pY6BSqJLe
 okBuYPg7pUceo92UPpyIDDCKv7+Mmom2l848pbxfzYrdlI2PvcjvKmyxhXOCEGNxdbW3c6SZz
 gligXTXOxn6XnvPtquUEdjH5FuUF4T0rOlndDZEoPMjqe1rmkhrJZHLjVYkr8qweHwwalXjrK
 tPjeaONamBwIM+km3HnhfY4hTg1gs84SDXvJFsEAux+Iz7jWxgpYTp4duL6GZfWaTxd1dRvWr
 6iwSfX0sdmNFbYcI1DNTQPHttitDXw7qb7H/TupCW2+v2qVJjjmWpsdJ5whhWFSw2DQGaRM7g
 fSaA+af2bicQ0jDHm7YXjVdkoTbMIl02uTvocQHx5UFIUzNJ9/tFjKwNxxDmUR01rQAzZYE9o
 mRt78/clmgol9kMg2KN4P1YiuS6Ah8h+aXso2pN+9R/1uId9AFmMcFiOHOoLsh22fb4ZaCQ
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:15:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Helge Deller <deller@gmx.de>

Return target error codes instead of host error codes.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Message-Id: <20200424220033.GA28140@ls3530.fritz.box>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e89b815ce983..fd5c4f1d73e6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2987,7 +2987,7 @@ static abi_long do_socket(int domain, int type, int protocol)
 #endif
          protocol == NETLINK_KOBJECT_UEVENT ||
          protocol == NETLINK_AUDIT)) {
-        return -EPFNOSUPPORT;
+        return -TARGET_EPFNOSUPPORT;
     }
 
     if (domain == AF_PACKET ||
@@ -5856,7 +5856,7 @@ static abi_long do_get_thread_area(CPUX86State *env, abi_ulong ptr)
 
 abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 {
-    return -ENOSYS;
+    return -TARGET_ENOSYS;
 }
 #else
 abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
-- 
2.26.2


