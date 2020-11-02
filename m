Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E4BC388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26062225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FfItod38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26062225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZda8-0003Ot-R5
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLv-00011m-Kr
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:43 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:50798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLr-0006bN-Jk
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:43 -0500
Received: by mail-wm1-x332.google.com with SMTP id 13so10160138wmf.0
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=bg1yVgXIhU8cNkSuYiD5wujRWcjW+EPEExJMC8FO3EU=;
 b=FfItod380r8GFhUrvfdO2oC+R5iMdRkPL0yE9ITi01miSE5Vp6X+eIuAY8NBNSVzqd
 49TzJgY1/hoGtbv64G95yJxSXzKMp97oubiV49ypDqHP0nwjgtvxzxshxGQDKFh3vxUo
 Su/xsouMu6IqytPsVCvEoJ4cSlgMGGN63LG4Kqu3Sr3MebQ3HA8w37mWEKGBPi/2HUPZ
 UO+iXfOCqSsLs5ioAnUJxXsP4CVKzGm/QsI77/MS9tbICAyRpuDoSnWW7dQ7DtS7tsQa
 plbh0ZYD1lazJi2/amU0N8R/n+EUGFtc8cT6ECV9boCZCdedhgNcyz1vyhGmyKmYVxlI
 Iw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bg1yVgXIhU8cNkSuYiD5wujRWcjW+EPEExJMC8FO3EU=;
 b=hK6hUhW7qMDBkm8ILzScXZoV83qa/JYksOlkgdu4WS96qY4Dc/pdXDjEzJpmWufmMP
 gxLVfRgfkFm/AUhaAELChha98SYMsyZBwCdEOrflftiv7XB2ut3ZwkoXAcPc3CXQE2Pn
 q/dzswL4CxnNB/0B6ntcHseHnR0jXW94rDpJEyiKQX27GDqn5T9SCYnrLbIub+P0JLe5
 6yL4id5yPlwjFbi93bfZwRBYu5SX5H3RaVAbZhAsSDlqCbpjXsI33O2yPX5nVSSm3mhp
 6StsYBlvZheQTpanW9xPOTJdrTj/YYenjNBRC/S3O0Dq1MTCq/gH8Q94HGqIAqWORDoq
 nAQw==
X-Gm-Message-State: AOAM532Nb7jhANhdv+dhnZYpYadePb+PRN9/YDaXLdkG0ul3kCaTMaZF
 ZGddOzyTDzlRCrBrhhN4nn/GAWyH17/CvA==
X-Google-Smtp-Source: ABdhPJxDRwMB8Id+0cMXa5XNiDLumNhk4YUNmFQaqgWuqdAzVPUUQa1lxfMInJqCbFWBWC2dc3kZ8A==
X-Received: by 2002:a1c:f604:: with SMTP id w4mr19088691wmc.87.1604337036503; 
 Mon, 02 Nov 2020 09:10:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/26] disas/capstone: Fix monitor disassembly of >32 bytes
Date: Mon,  2 Nov 2020 17:09:55 +0000
Message-Id: <20201102171005.30690-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

If we're using the capstone disassembler, disassembly of a run of
instructions more than 32 bytes long disassembles the wrong data for
instructions beyond the 32 byte mark:

(qemu) xp /16x 0x100
0000000000000100: 0x00000005 0x54410001 0x00000001 0x00001000
0000000000000110: 0x00000000 0x00000004 0x54410002 0x3c000000
0000000000000120: 0x00000000 0x00000004 0x54410009 0x74736574
0000000000000130: 0x00000000 0x00000000 0x00000000 0x00000000
(qemu) xp /16i 0x100
0x00000100: 00000005 andeq r0, r0, r5
0x00000104: 54410001 strbpl r0, [r1], #-1
0x00000108: 00000001 andeq r0, r0, r1
0x0000010c: 00001000 andeq r1, r0, r0
0x00000110: 00000000 andeq r0, r0, r0
0x00000114: 00000004 andeq r0, r0, r4
0x00000118: 54410002 strbpl r0, [r1], #-2
0x0000011c: 3c000000 .byte 0x00, 0x00, 0x00, 0x3c
0x00000120: 54410001 strbpl r0, [r1], #-1
0x00000124: 00000001 andeq r0, r0, r1
0x00000128: 00001000 andeq r1, r0, r0
0x0000012c: 00000000 andeq r0, r0, r0
0x00000130: 00000004 andeq r0, r0, r4
0x00000134: 54410002 strbpl r0, [r1], #-2
0x00000138: 3c000000 .byte 0x00, 0x00, 0x00, 0x3c
0x0000013c: 00000000 andeq r0, r0, r0

Here the disassembly of 0x120..0x13f is using the data that is in
0x104..0x123.

This is caused by passing the wrong value to the read_memory_func().
The intention is that at this point in the loop the 'cap_buf' buffer
already contains 'csize' bytes of data for the instruction at guest
addr 'pc', and we want to read in an extra 'tsize' bytes.  Those
extra bytes are therefore at 'pc + csize', not 'pc'.  On the first
time through the loop 'csize' happens to be zero, so the initial read
of 32 bytes into cap_buf is correct and as long as the disassembly
never needs to read more data we return the correct information.

Use the correct guest address in the call to read_memory_func().

Cc: qemu-stable@nongnu.org
Fixes: https://bugs.launchpad.net/qemu/+bug/1900779
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201022132445.25039-1-peter.maydell@linaro.org
---
 disas/capstone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/capstone.c b/disas/capstone.c
index 0a9ef9c8927..7462c0e3053 100644
--- a/disas/capstone.c
+++ b/disas/capstone.c
@@ -286,7 +286,7 @@ bool cap_disas_monitor(disassemble_info *info, uint64_t pc, int count)
 
         /* Make certain that we can make progress.  */
         assert(tsize != 0);
-        info->read_memory_func(pc, cap_buf + csize, tsize, info);
+        info->read_memory_func(pc + csize, cap_buf + csize, tsize, info);
         csize += tsize;
 
         if (cs_disasm_iter(handle, &cbuf, &csize, &pc, insn)) {
-- 
2.20.1


