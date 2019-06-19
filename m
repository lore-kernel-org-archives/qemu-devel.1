Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D85EC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677BA21874
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eA2BFhiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677BA21874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39086 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdc7J-0003dg-DO
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34998)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lukas.durfina@gmail.com>) id 1hdc1N-0006dr-Bv
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukas.durfina@gmail.com>) id 1hdc1M-0006tY-Cn
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:57:09 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51214)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukas.durfina@gmail.com>)
 id 1hdc1M-0006rz-5s
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:57:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id 207so2173356wma.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=ozeDcMYF7/Nrl2lmQXs5V+WaQacMnGyieLUIr2Ve3s8=;
 b=eA2BFhiRHPJCX8VW8RLCm5PW8TXV3ucLR07geDnROX0Kv2OGB5ouYrixD1dQIwpL14
 eP9fbi5Gce6dtZ2cnMDqFFXsNP/kcSqLPJFSMa0yDh9UGJr+Rn+gBlGbR/EQZb2HL+xh
 1C3o9gdsDl20KZnSBW/0TywIudV3hiJOp2LmgdE04p17IiiI/PEWEcZ9glAoGbvmcIrQ
 z0FPl8HoMgMZm5E98tqdPuVF7vWGf6jS09wrgq6Ns+w+NXQPi9U7WHFygWFRPVHZbugo
 5I+CjhDPyR2fv2b+Ux7goMpoy6C5091uICrlS1lZWEH4GGk40HgjmOgMX1OWjRwbMxag
 XEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ozeDcMYF7/Nrl2lmQXs5V+WaQacMnGyieLUIr2Ve3s8=;
 b=R/j/2UHZ+/KxMnj0zW9sp1SnVzTZSDo8063CCdGvV/XTYtTaRRmDRhUSg0onH2ibFh
 OJRH5QtjC9n8wEZGUmqUOCIDArId0jqQLJsyIAe4r2d4OjAEOFtis350PPi2F4CSuXlq
 8bnnYJ9z5HmgNmJQn+WrZnPjkyF+FMf5zi/wHIXWVCohq9KxyqNRO5OD0AXJ2tA3sQAL
 nquk0Uy9EjjlTsGwgtV73b3KIJyq3WQklVeYgEbNHdSdLdL/Vq9i2ldY2RYaequi402X
 Re2MgnLN5HpCa3Ti0fsjBLDNVhDeXL491LlAVNfRLj2WCIMq4sNiX0YlOTobMPWrfKZN
 FPBw==
X-Gm-Message-State: APjAAAUv5LvdVSxW7MLVWd4ishWjMevncZHGTGB/3sJw+9quCkocwlzF
 ZH/UalnhFHhvX0UMYGRs/KaUWAzi9/Q=
X-Google-Smtp-Source: APXvYqxr3WxYSC+F4IzmdEUoXxuM/MA9baAtSzz3ShdOKE2+cE+3Y8rD+L9d0y/Ix9KU+uHuBN+Mjw==
X-Received: by 2002:a1c:2c41:: with SMTP id s62mr8851120wms.8.1560956225989;
 Wed, 19 Jun 2019 07:57:05 -0700 (PDT)
Received: from tachyum-sk-server.tachyum.com ([185.110.144.102])
 by smtp.gmail.com with ESMTPSA id t12sm21986012wrw.53.2019.06.19.07.57.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 07:57:05 -0700 (PDT)
From: lukas.durfina@gmail.com
X-Google-Original-From: ldurfina@tachyum.com
To: qemu-devel@nongnu.org
Date: Wed, 19 Jun 2019 16:56:54 +0200
Message-Id: <20190619145654.118068-1-ldurfina@tachyum.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
X-Mailman-Approved-At: Wed, 19 Jun 2019 10:59:12 -0400
Subject: [Qemu-devel] [PATCH] gdbstub: print message on startup as gdbserver
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
Cc: philmd@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lukas Durfina <ldurfina@tachyum.com>

It helps to test gdb running qemu instead of a gdbserver.
It prints the same message as the gdbserver on startup.

Signed-off-by: Lukas Durfina <ldurfina@tachyum.com>
---
 gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub.c b/gdbstub.c
index 8618e34311..9ad9929968 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -3109,6 +3109,7 @@ int gdbserver_start(int port)
     gdbserver_fd = gdbserver_open(port);
     if (gdbserver_fd < 0)
         return -1;
+    printf("Listening on port %d\n", port);
     /* accept connections */
     if (!gdb_accept()) {
         close(gdbserver_fd);
-- 
2.17.1


