Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA6BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23745207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 14:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tSRnqd5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23745207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jop3U-00076L-De
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 10:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jop26-0004SE-3m; Fri, 26 Jun 2020 10:08:46 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:40959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <devnexen@gmail.com>)
 id 1jop23-0006uI-Kg; Fri, 26 Jun 2020 10:08:45 -0400
Received: by mail-ej1-x641.google.com with SMTP id o18so5060352eje.7;
 Fri, 26 Jun 2020 07:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=x+ueAwuuCoBhWE4SweeoDogBc0rLsINh3QqIieHvwp4=;
 b=tSRnqd5FrXVkzdHxwGzuPG08sESnn9N1UQMAnnJrx0xVWvUEUtuvWdKzFNV0kAuL/A
 e4IJgaaCZHS2CDYNSOMAllYqDzdycqF26di6xlK9VCC72UEFKzBmYckDThXGVXnxW2T9
 ugqkR4sCPbdw9FMQCoQdg1d7H3kq5ueBED6F7tDdA+hTPB7uJLkiZQzG9yf8YB9yj3/W
 I6fwNmSzCsCnvJ80j6TrbRqK9Pa2uTcdzcVOrRugGFRL3g96vi/EwCQpEhm2s76XP/Mn
 ms/kcmhxzC1tzCmte0jp8C0miPktWUzyAWfnNfpzf0ECoymrJycW9QE/+MxGWEsI+q61
 eu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=x+ueAwuuCoBhWE4SweeoDogBc0rLsINh3QqIieHvwp4=;
 b=BleRcaL32NGgAMd6WsUXERPt4o6HwrjCeX7hxeMYgZeEKxsuIvy5I2l6dLtqr5X5eu
 QWYJSnf5mrzDIPFjrmIrT2yrdXNJXLDXNT7utNhyHv0dMlHMciVzE1/7/BVMxWV130UX
 owOvJ9MnbjDI5G2dTlwZojpUhwx6BcJByWnoownQGqGvMpd5hgcsTVbgjvPzEjVcR6jo
 +XsFAQKmlgmW0a5IoVA74hxQrrYBa4MA0hSzGUL1C8sA1PmTd4aRFe5/xAMd854DxQr4
 aYG07vi+H25mPhVzaI1RLkuYpCLJUSIMCbrrBmcqMfvOx/5umzxI6zv3obLWh8MJw6qj
 MCpw==
X-Gm-Message-State: AOAM531zrMPEHG+G2fLZQtUHWDX8T9161ul+CMz2z7BxJVDFFEM+LQTP
 GvRyl5R5PWWeuYNF5CYEUDg3Ee6AfrVJ+Bt3Z6saCLaHv/8w9w==
X-Google-Smtp-Source: ABdhPJx3UefOIgdCDCrSNHjvqtdL4IboBoGlOOmE3IrmwhdGsRzEIUl0wpU0FhdDl99ftYdtcDmNuMabtgC2Hn2x4oY=
X-Received: by 2002:a17:907:100a:: with SMTP id
 ox10mr2606516ejb.351.1593180521641; 
 Fri, 26 Jun 2020 07:08:41 -0700 (PDT)
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 15:08:31 +0100
Message-ID: <CA+XhMqx3R8iH=CauJQuFo6DhU6LSFV8_2vEo4h2jLYrnDNkX5Q@mail.gmail.com>
Subject: [PATCH 3/3] syscall skipped for haiku used only in qemu_signalfd
 anyway
To: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=devnexen@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From a548479cab82200d9df33a70f24aeebb00eb70ad Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 26 Jun 2020 13:58:34 +0000
Subject: [PATCH 3/3] syscall skipped for haiku used only in qemu_signalfd
 anyway

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 util/compatfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/compatfd.c b/util/compatfd.c
index c296f55d14..ee47dd8089 100644
--- a/util/compatfd.c
+++ b/util/compatfd.c
@@ -16,7 +16,9 @@
 #include "qemu/osdep.h"
 #include "qemu/thread.h"

+#if defined(CONFIG_SIGNALFD)
 #include <sys/syscall.h>
+#endif

 struct sigfd_compat_info
 {
-- 
2.26.0

