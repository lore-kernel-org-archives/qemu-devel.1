Return-Path: <SRS0=Ju6v=UI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C64C2BCA1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 11:01:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853FC2083D
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 11:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLozLhUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853FC2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34878 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZvZN-0005SS-3t
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 07:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50647)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hZvQo-0003xD-91
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 06:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lucienmp.qemu@gmail.com>) id 1hZvQl-0001HJ-1X
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 06:52:10 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1hZvQf-00019b-8Y
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 06:52:04 -0400
Received: by mail-pl1-x642.google.com with SMTP id g9so2508376plm.6
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2019 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :user-agent; bh=A7XFk/cRaCDQvL+Mi/+bJBxTQNAdsRFYEqO98UFpvSs=;
 b=KLozLhUAw9YmoHiqbSNXPXSkW6/0lS5nNjBRBXeCzOJZsUsa5nhfM2V/gILSkZnR5T
 8WPVkW6/tjdKmHiEN7rxxlXo02MNQ2GSzfSwBVFw5N+uINdWKFR6xxx6sdv6rCPjOG4K
 E90HwWiaffaLulkwHe7e7f2raGdh8+JY+MXJfN33fskhJP2OEh1nKvnRnj5yZdZAf98l
 olGvUMc9k8qU8oOG5qnH9qN/nuuIevju2lLkMEV/71Vx1ZmrMlb9SIR64EqQpsxX2b1U
 3acS9YL+f9lwVb564nlq1RSw96M5IJMmlIPpRhHJEkpT2RLefdQk75kjHX4d5b3OtKLl
 3Dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=A7XFk/cRaCDQvL+Mi/+bJBxTQNAdsRFYEqO98UFpvSs=;
 b=YRtuTw8UduRzH2tpO+mitBMq193QfnF9dW3RFnZyholarewBgneszOcCJmiUatOaGI
 E4Z5VkDB/coUAqjz8yeCTzmLdOAwwjUJbf4iWTt3Cxepqsle0w7i8ruENG6GzARHQk6O
 U5G8tuvrPeEgbuuiN4yMmKkOE7WNL8jJR6xlfs6h3H3nVi8EuIy0AMG3QpZUCDMbNhzn
 8suYk84nBGKaVBHnaYe3KeWM+HIEcrJnNEtsb1ucMyNfgFB9ndP6BYvr4zwr0oA1plqT
 qqWP6mR7GO8e0qlMf14O13qGiNqX7ke75Wd3Wrv0FZ0/6aFigctytLu3OBZ7MGdLDFl0
 TSFg==
X-Gm-Message-State: APjAAAUSHvmBMX74oMkE/cCecKco9f1FmqbWvkdutdFV2nh1AZjnA/58
 MMMTM/SMunqYfN3g4bfj/bgLadm9
X-Google-Smtp-Source: APXvYqy6BnelalA9VBTXAhxwZbOb2bSMSZhhrjWa3IihL2x8ND0oKi5H4wCtfXtqV/MCo0kvIlWwZg==
X-Received: by 2002:a17:902:4381:: with SMTP id
 j1mr64175495pld.286.1560077518046; 
 Sun, 09 Jun 2019 03:51:58 -0700 (PDT)
Received: from localhost.localdomain (i60-43-49-30.s30.a048.ap.plala.or.jp.
 [60.43.49.30])
 by smtp.gmail.com with ESMTPSA id j14sm7232634pfe.10.2019.06.09.03.51.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 09 Jun 2019 03:51:57 -0700 (PDT)
Date: Sun, 9 Jun 2019 19:51:54 +0900
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Message-ID: <20190609105154.GA16755@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v3] The m68k gdbstub SR reg request doesnt
 include Condition-Codes
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

The register request via gdbstub would return the SR part
which contains the Trace/Master/IRQ state flags, but
would be missing the CR (Condition Register) state bits.

This fix adds this support by merging them in the m68k
specific gdbstub handler m68k_cpu_gdb_read_register for SR register.

Signed-off-by: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
---

Notes:
    v1->v2
       - removed my superfluous braces
       - slightly amended the commit message
    
    v2->v3
       - removed my incorrect use of code block in a switch

 target/m68k/gdbstub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
index fd2bb46c42..6e7f3b8980 100644
--- a/target/m68k/gdbstub.c
+++ b/target/m68k/gdbstub.c
@@ -36,7 +36,8 @@ int m68k_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
     } else {
         switch (n) {
         case 16:
-            return gdb_get_reg32(mem_buf, env->sr);
+            /* SR is made of SR+CCR, CCR is many 1bit flags so uses helper */
+            return gdb_get_reg32(mem_buf, env->sr | cpu_m68k_get_ccr(env));
         case 17:
             return gdb_get_reg32(mem_buf, env->pc);
         }
-- 
2.21.0



