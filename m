Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B6AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BD7F2078A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9F7Z4aN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD7F2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFmD-0008Ll-VO
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSFky-0007OF-Iv; Tue, 13 Oct 2020 04:34:04 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:32973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSFku-0004YJ-Pa; Tue, 13 Oct 2020 04:34:04 -0400
Received: by mail-pg1-x544.google.com with SMTP id l18so7986811pgg.0;
 Tue, 13 Oct 2020 01:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BqS9I9bPkkKtvHXhww60g40rR5uN9bhvhUw/qFG9oNk=;
 b=A9F7Z4aNfMLLOUZs7jSOtHfRKOCXT7JVDkNLnQjuaoujyff3dstjFSIDarzADzHvby
 +8Kyju7Dp9KByNk2YLtKXjLoJWTHDDTpaVIU9qP/PGGa98ASrxHisHUySRnm5b3mBL1B
 9ZbDt4cNmCJcWf+e+DVKRNow0yxABceZpDO+2lurAdTb8T1qEE6JzUGy4fJdQKftQ5jQ
 AjhkY4Jx1B3J+1w+ld1ZwLH0hpYZ2xMJ1Y6lnKkbHZqT7GLsw3cUeWQmzAgXOvByFz4m
 czsWuiKsd/Qu+SPpRrTHKJJpMUsdqaHXIcHfx103ci6Etx2A4a+pvg0g6nVwJuDwixFK
 gMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BqS9I9bPkkKtvHXhww60g40rR5uN9bhvhUw/qFG9oNk=;
 b=jQw4vz5/O9VHDWOyuUxE72FK+XMjI71t7uSubrU7N70Edi6IWXJns+rQ4noCAMmgBZ
 k83inIy9B8K85rGwZnO7O8MtAPxpxSu1zeHFAJ2EPFHOZLYJa+HLgaRUsSC1E4fbljpO
 Qbfqi1m1mvDYgYT40YBuZ9tZstgYt2Jn/Sf4MwsIYQVfmO36ISWZRCtZEX0jtxr6x+PR
 4vXrUnzmJXO0LQWA3xCUEBrfw2Dw6aMurZ53XKYC+AgDxigoIaxMPDp8IqXxFtj+CAD/
 Tb8OY3xZFzFtNpZF/fLBfAMUmdJkavA0FfewFH2ELo2fuq45mba/yBHEOAYzgXf+D4a7
 5Sxw==
X-Gm-Message-State: AOAM5313mxU+a+Z17CkBgl8MazuSfFxvoRoOn6CIIZHzIqPsxxbrFdpO
 N1X5UH9qsS1D08ywtMt+AvM=
X-Google-Smtp-Source: ABdhPJzTIUsC8/cya+uXnZLTppWdMkOx57r4OX2kJ+9Bv6dZv/SYtdgtj6m+R1deKfbN7rf/ES0ENA==
X-Received: by 2002:a62:1844:0:b029:152:80d3:8647 with SMTP id
 65-20020a6218440000b029015280d38647mr26805603pfy.18.1602578038991; 
 Tue, 13 Oct 2020 01:33:58 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id t13sm22497886pfc.1.2020.10.13.01.33.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Oct 2020 01:33:58 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [RESEND PATCH v2] hw/intc: Move sifive_plic.h to the include directory
Date: Tue, 13 Oct 2020 16:33:53 +0800
Message-Id: <1602578033-68384-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Since sifive_plic.h is used by hw/intc/sifive_plic.c,
it has to be in the public include directory. Move it.

Fixes: 84fcf3c15111 ("hw/riscv: Move sifive_plic model to hw/intc")
Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

---

Changes in v2:
- reword the commit message as Philippe suggested

 {hw => include/hw}/intc/sifive_plic.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {hw => include/hw}/intc/sifive_plic.h (100%)

diff --git a/hw/intc/sifive_plic.h b/include/hw/intc/sifive_plic.h
similarity index 100%
rename from hw/intc/sifive_plic.h
rename to include/hw/intc/sifive_plic.h
-- 
2.7.4


