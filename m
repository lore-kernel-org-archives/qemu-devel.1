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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA74C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D27E42078A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyShGAle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27E42078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFkO-0006wK-Uw
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSFhM-0004zO-A0; Tue, 13 Oct 2020 04:30:20 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:32983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kSFhK-0004Bf-EQ; Tue, 13 Oct 2020 04:30:19 -0400
Received: by mail-pj1-x1042.google.com with SMTP id p3so192175pjd.0;
 Tue, 13 Oct 2020 01:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6Sgy3rHvTN4jCcntej3MnMJNBmjZHwYNF6EFKidYoio=;
 b=IyShGAle7UWgHDPYY0p261aJjIzXUPMJqJHCfW9WhYEEiXDWg7IyaEg2BBvpnXKZjU
 LAGWysGlnBed5ZTuyVUCtUt7FIEc8Z4x4Xs6i3158VFVNNkYYGQ9EMZICTsF/kG7+Wbu
 w3+4+RHRzQYgns/pQE+DAQ2+z1a+jDweeXMMEMeMsJ8YEouCUNxKmDyhNbxJrnsXDI0A
 4yHnAQFPjm+nDJjTJJT2vCIUZwquLF0CJY89tYCriB909eCsrmnw7LKqgshHMZ9SEajc
 MSF4Vbz2WjjaQtFdqdWo4cz5hlc+L0OehtD4cz0/wS0YmnkcQpOuHewMyArVYtB5Kgm5
 POoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6Sgy3rHvTN4jCcntej3MnMJNBmjZHwYNF6EFKidYoio=;
 b=C6pl+Dbv+LEyQ2ftRGO+uCwdfOdX/OUrtjJi5xUH+3F9ZS3Z7lusZTcfvJGufhBPKQ
 RnxWC4ptZG4PoaIwg73sX7wIXTCQgZLhUW0d7WWqF1Z3JNmeuqpZGJuGVGjzSHURjaFY
 P/nKzsulezxpeCYua7MA9A0lzTgCj2IKo40ctRCx7ZVi4GJ2Ye98oWlCp2EMVUTbhqXA
 CccSkMjfouoBmvjTVFOakIW2oiqVmQOqirppg9DTPtuHeC0XtVJlr6SSyMN82SByoLya
 pH4owDyfQNyg/Re1mN7MsHrCJe+LCXU5sO/CzGZbzj7dkls+XlAUFVcxrVjHD2u5lxip
 mUrQ==
X-Gm-Message-State: AOAM5324k1ZdfoWAZij/oqewm2h+v37ERLdN2hKYvR/Wr7DhYMkmR/CW
 WG9Xy1I9mx/4uDeLuYsXRsk=
X-Google-Smtp-Source: ABdhPJxeuObfPx1CWxPMM4B4B2wHjST4q7H6Ow64I750jdXE8+H75yXMbce/KPHsYsyg6F1ULraORA==
X-Received: by 2002:a17:90a:bd97:: with SMTP id
 z23mr25507639pjr.191.1602577816043; 
 Tue, 13 Oct 2020 01:30:16 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id m11sm22271419pfa.69.2020.10.13.01.30.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Oct 2020 01:30:15 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
X-Google-Original-From: Bin Meng <bin.meng@windriver.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v2] hw/intc: Move sifive_plic.h to the include directory
Date: Tue, 13 Oct 2020 16:30:11 +0800
Message-Id: <1602577811-67343-1-git-send-email-bin.meng@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1042.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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


