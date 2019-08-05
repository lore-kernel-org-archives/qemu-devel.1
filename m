Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12373C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D161D20651
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmLjBTZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D161D20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufZj-0006Up-59
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58401)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPc-0000Nr-U0
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPb-0002sm-Sl
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:40 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPb-0002rc-N9; Mon, 05 Aug 2019 12:00:39 -0400
Received: by mail-pf1-x444.google.com with SMTP id u14so39891751pfn.2;
 Mon, 05 Aug 2019 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=3wJXWQ4rYrs4QifmuLTPSjf8nx5Jdl28hrkDefUABYs=;
 b=jmLjBTZQ3+JJm2EYCK+LVoog+gYFbeMu/zRnUVncwCZtgtCvicuWNU7ylp2QyIViod
 4YhUURCpJRMmY8CqqRXsrQvhfZIVgKXdkl+IVtf/32xYwruOsBg0vSA0DNCT5NqN7KhA
 l+pVQa/dnwO5VFW3hvaxc+CpDsYFhuwIko6Br+XhyQO/Fx/QJeEwsw/SywYT01abP1DT
 AFF128l7uvZx5WC8JkawtUm2GHQsoF/6b+p+DKZKQOVXpa0y8iRU6LpAhFwdXdbi0kB8
 K4Rb/O/FPQmr3E/CnFuVKQ5Qt0lPliKF1FqKILv9nPQyQjA4H2CJHuUCb3154xiMz+aB
 2Ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=3wJXWQ4rYrs4QifmuLTPSjf8nx5Jdl28hrkDefUABYs=;
 b=otoZ1CthojBUxVazBsoZUqohKqpEQo478U4qFUcKAY1Gcp6rNG9ZAKvhWcOdoLcwTt
 X3OErgBUthTptS52X4r6iHeXcezF58rd4T3HsICgkLI8SwDafvKB6ujzEM3TDtj1+R8J
 1+qDnd/VxB9jMibiOqx+7qBYAZmkU2Yj70G0jxfLn05SYSvZm30HNbopREhjWbpAc3Pk
 RAkceD5SwNdZNn1PpARUCT1q46tcb2UsFAGzJjR1zxZOcFdyeaNVicpi3jHI1K9OvOZX
 IwTMWpP9JjSMNkgYAOFoevVhw1BHMys9fotrHZOBNhpp3RwljetlnW6WYTUjSRZ6O0BA
 1gQg==
X-Gm-Message-State: APjAAAVdzvsfwfJf7SmkB1AoqQ3aXfkp/VRk8skGA/etnUEI1WaK7/n0
 Aj8Yfv0tB7zf8fOe1J1P8SY=
X-Google-Smtp-Source: APXvYqwpsaopFxMhvQZbgHUsQ0wY20Q5+xQnWkOyujLR2jFqc4XNG++bBQZgVmOQdol7h4MDS+IZFQ==
X-Received: by 2002:aa7:8b11:: with SMTP id f17mr73792043pfd.19.1565020838921; 
 Mon, 05 Aug 2019 09:00:38 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.37
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:38 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:05 -0700
Message-Id: <1565020823-24223-11-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 10/28] riscv: sifive_u: Remove the unnecessary
 include of prci header
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

sifive_u machine does not use PRCI as of today. Remove the prci
header inclusion.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 hw/riscv/sifive_u.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9f05e09..dfcb525 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -40,7 +40,6 @@
 #include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_uart.h"
-#include "hw/riscv/sifive_prci.h"
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
 #include "chardev/char.h"
-- 
2.7.4


