Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B905C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A82A20679
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFdp0Jqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A82A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUYk9-0001tO-7w
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:10:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iUYfH-0004PA-4h
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iUYfG-0007Ka-21
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:05:11 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:51440)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iUYfF-0007K7-Rq
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:05:09 -0500
Received: by mail-wm1-x335.google.com with SMTP id q70so3828772wme.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 08:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O+7oqTj35SxpOp+OUToP9NWOXc7v9VZvqQg34DnV5Ds=;
 b=OFdp0JqiIAONYGeN+hkG6JSO0zYB6BSrVhvq09qzUANFF/EE17xkUS7THVsOWvCi0S
 u5ThIenbyRXW1VpaCOItFgB4j+mNk2Vaio/Bb2N+hjG4SdxCgb9iDuz9ARCRnhrEJna6
 RdANw84dWoBaTNy3+Alyr4lRAfHLfVxKZBJMXAb10IJyxXVYlOQZrHxaJHXTDuITvwKT
 eZnDsMd3ZdpHZQB9lWinBOspeLSCORUSwHmxoHZPPthD/Dc7T7flqElvsfYRa5iio/LW
 nWYIdL7JxbE4eNHQp8xNbuZ9/YbEyZFddJAMGBVQ8lJwXiMZ8C2bMZrzySeACYDAKLiu
 7s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=O+7oqTj35SxpOp+OUToP9NWOXc7v9VZvqQg34DnV5Ds=;
 b=JHsOvf5wfCiN+eEGISsMaqyQf/SdnN60XdKp+6gxQ8Wdh3Iq4Jbj7JsZr3fpuLkind
 60KeCoNohXnqT8Gr8BkH7SvvkqY5N2dTe4nePBI6EMe1iMVvNVeVmEB2fUVUrR/gKbDq
 asUDqReHS7ZIUVk76l3NGsidBw50SyfiMVp8TdHqlNsABbPUd5LkMLOPwrno1foq7RPL
 9mwrOBbnfaT+IlXiiww25t2mp5y9Xwn1CiNK6R5EgrL/9RXnhbhf/7p+1cRHMOYFdAnV
 IV27B4N7b+wx0beVSXAkA57dG9z3HUkXsQIRv3PkDvx8J89NoCrZ6GyNqpbxnmjlOp4x
 v/EA==
X-Gm-Message-State: APjAAAWGvoBpc6MjnroKam7J9yw0uL4wWLWTEBrKUA2BDPlmIOZ+/Ccp
 TgY5mYZM2BW71q74+rFy3FdRiGxfqMU=
X-Google-Smtp-Source: APXvYqwrFiH475fyasK7r7vWWq82Dw43WtuYuphWVqvJx8Y9nz1lC+jwRGsHgRTqdSmFazHdGprq7A==
X-Received: by 2002:a7b:c776:: with SMTP id x22mr4478483wmk.144.1573574708500; 
 Tue, 12 Nov 2019 08:05:08 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id v6sm16175841wrt.13.2019.11.12.08.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 08:05:07 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 3/3] target/microblaze: Plug temp leak around eval_cond_jmp()
Date: Tue, 12 Nov 2019 17:04:49 +0100
Message-Id: <20191112160449.29212-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112160449.29212-1-edgar.iglesias@gmail.com>
References: <20191112160449.29212-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Plug temp leak around eval_cond_jmp().

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 7b4b66a622..bdc7d5326a 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1681,7 +1681,10 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
                 dc->tb_flags &= ~D_FLAG;
                 /* If it is a direct jump, try direct chaining.  */
                 if (dc->jmp == JMP_INDIRECT) {
-                    eval_cond_jmp(dc, env_btarget, tcg_const_i64(dc->pc));
+                    TCGv_i64 tmp_pc = tcg_const_i64(dc->pc);
+                    eval_cond_jmp(dc, env_btarget, tmp_pc);
+                    tcg_temp_free_i64(tmp_pc);
+
                     dc->is_jmp = DISAS_JUMP;
                 } else if (dc->jmp == JMP_DIRECT) {
                     t_sync_flags(dc);
-- 
2.20.1


