Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEBCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:52:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E18220709
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 22:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHrWWtZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E18220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTC72-0007LK-2L
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 18:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTC2c-0003Bh-FK
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:48:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTC2a-0003Kb-P6
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:48:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id s9so417035wro.8
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 15:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cDFZKte6J1gmQ1RO0KbRzu5XwwyBiWwbpD2fweDsWn0=;
 b=uHrWWtZKQqXzXwkn7OL0eV6dFq5FvNmO38Hk+uIbEWOtNOYG8Io9fdepPQtXDEYoNR
 BNDStF4uEc3r49sme/ALGNRMD98S8PqxjpjdP8q27eUltKR8wzmSipO3UbnX+EBudbOD
 yvtjIa7f+do7UQt74an6eihZGckrnb3PvZJq1ilfKFIBusHd9AYa2ogII80OgPhLIy3q
 IdejQKmVqjVF0VOxB+OK+wtU/ujin+lI0u8JHQnzAPJChklFh3BaHZuffi2qYfiNLEZ6
 aF2P9Md/vHhLyNoDk+K4ZCIeHP227aWX61oyVEEZb+p7u+agYEE54nNM/T2xN3Tu0OYx
 XSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cDFZKte6J1gmQ1RO0KbRzu5XwwyBiWwbpD2fweDsWn0=;
 b=uPnf5smqK05TpN4/YZX8hNY6iYhtbQo4YlC2/ZFqjLJ7eID8DEbWgtLyzR8v7FD/an
 u5wPh19mAgoQUo+jTFuokTVjAaiCoZqvRadYFIh6hgUgqLB6Vm23Qr+VBnRzMlCCLweP
 yAXZJQah80EuXPx+FYDK+yEViC9NRpbtAiwz372x8SVd/Kyr2tn8iIZkPP9n8kYS7G3c
 yM++O2UkuexCfTUgIdIT3fib8JE8AU0ZGxXy3z6hHj6pcN20rY/We0HmDMHptqr7IWkR
 zcxFXt2wsQ+5lreKuqyojF9GCKqDnkEMBgeyGgMpI7nLq2h6VedAluKvpnmxFLjOM4gn
 xPUA==
X-Gm-Message-State: AOAM53102o1NynErN0ymiNXdjrlIzr4PEeDNBm1IqsahqLTmV88XZMAf
 OYNSizRoort5TRuQNwyFVIi5jLsmmdo=
X-Google-Smtp-Source: ABdhPJx2cwDQ8UOF8b6cTex9hA1/kT9gA+lvedbq6iyCIFjj8T1H1kTzjUGBO9b8VkQ4Sl+crSfj/g==
X-Received: by 2002:adf:d84e:: with SMTP id k14mr513938wrl.251.1602802087290; 
 Thu, 15 Oct 2020 15:48:07 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id o63sm602974wmo.2.2020.10.15.15.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 15:48:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Victor Kamensky <kamensky@cisco.com>
Subject: [RFC PATCH v2 4/4] target/mips: Allow using the 34Kf with 16/32/64
 preset TLB entries
Date: Fri, 16 Oct 2020 00:47:46 +0200
Message-Id: <20201015224746.540027-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201015224746.540027-1-f4bug@amsat.org>
References: <20201015224746.540027-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Khem Raj <raj.khem@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per "MIPS32 34K Processor Core Family Software User's Manual,
Revision 01.13" page 8 in "Joint TLB (JTLB)" section:

  "The JTLB is a fully associative TLB cache containing 16, 32,
   or 64-dual-entries mapping up to 128 virtual pages to their
   corresponding physical addresses."

Add these values to the CP0_Config1_MMU_preset array.

Example to use a 34Kf cpu with preset 64 TLB:

  $ qemu-system-mipsel -cpu 34Kf,tlb-entries=64 ...

This is helpful for developers of the Yocto Project [*]:

  Yocto Project uses qemu-system-mips 34Kf cpu model, to run 32bit
  MIPS CI loop. It was observed that in this case CI test execution
  time was almost twice longer than 64bit MIPS variant that runs
  under MIPS64R2-generic model. It was investigated and concluded
  that the difference in number of TLBs 16 in 34Kf case vs 64 in
  MIPS64R2-generic is responsible for most of CI real time execution
  difference. Because with 16 TLBs linux user-land trashes TLB more
  and it needs to execute more instructions in TLB refill handler
  calls, as result it runs much longer.

[*] https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03428.html

Buglink: https://bugzilla.yoctoproject.org/show_bug.cgi?id=13992
Reported-by: Victor Kamensky <kamensky@cisco.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/translate_init.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/translate_init.c.inc b/target/mips/translate_init.c.inc
index a426463c434..02500e696f4 100644
--- a/target/mips/translate_init.c.inc
+++ b/target/mips/translate_init.c.inc
@@ -258,6 +258,7 @@ const mips_def_t mips_defs[] =
                        (0 << CP0C1_IS) | (3 << CP0C1_IL) | (1 << CP0C1_IA) |
                        (0 << CP0C1_DS) | (3 << CP0C1_DL) | (1 << CP0C1_DA) |
                        (1 << CP0C1_CA),
+        .CP0_Config1_MMU_preset = (const unsigned[]){16, 32, 64, 0},
         .CP0_Config2 = MIPS_CONFIG2,
         .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_VInt) | (1 << CP0C3_MT) |
                        (1 << CP0C3_DSPP),
-- 
2.26.2


