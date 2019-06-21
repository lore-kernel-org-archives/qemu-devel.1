Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B4AC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:55:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3153A208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 11:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3490pY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3153A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60016 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heI8g-00045X-OR
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 07:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49230)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHl1-0000wp-99
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1heHkl-00067B-Op
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:53539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1heHkl-00066I-AJ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 07:30:47 -0400
Received: by mail-wm1-x335.google.com with SMTP id x15so5999187wmj.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 04:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H+GIX/ew7P3W1KtFZyQEoH7Aekz0PvrQKasKssVk2dE=;
 b=e3490pY53AyTGdnzLusrPW1DhvfbMRppGiwbKOfQMLHdcP3aP2llaPJI48NTDyyA8U
 CAQjvDkaHdVwqGHE4D9QXer0uV+oVVF5xCQqFnT+Oz94lt8z9oPztfV0X+YEo6tipfbH
 gzEFgw/sHb6zu+hrOh25hWbjsiS1y6ZqTZDrxcKqRmvuWM6wcCM9MstWDunn9tKvXB6W
 R5cL5g+TbEvMecGaBsOo5k+RivyeqCbPmc1QeYh92+Kopa+Emmz0+m8a7rNKQnOcrPBc
 1cvOzU2DjxOnRQx9rQv69rALlS8PuHtZqD/NXM50SkNh/I3pAAqrFPZpmYSSF1fXl81F
 MUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=H+GIX/ew7P3W1KtFZyQEoH7Aekz0PvrQKasKssVk2dE=;
 b=L1H4q8ifJkoPGIlMmEx3F/A78xdLUJrBF+MqYdQW+No4kdQHVWxXresQOpRF7se+Cf
 EEMQ0MtXaqXo8FFxvEB/0Kz8aTy0ZtDGw/79A30TKifZSKpjctzyRxbxsmrHEmJt4kCa
 Vda52Aqc1f0hMD00Z3Vwd0OnBLRVOzVNH1S8i2tXR+GsXLi0W3thMA/NMpf7eNM/py2x
 eQej/WPj9n4xt4paq7WsEEP+avvH+CHAn+44uTrfI0udImkdbcKucxRrDF2JBhj1jBa4
 Jc2OaRI1X+e/0/dg8MnMPCNfbtr8Cr5EihZtJBOXBQeHjbLDrIXQbWGx3iwL3kWScVbL
 e6uQ==
X-Gm-Message-State: APjAAAUej13A6eS2NYfHJycD6+FHKYsKA0UQd7JkAdeR7lVPOrrNVaA7
 sn3kspZmXp/5SwuID8qDjGj9tru9
X-Google-Smtp-Source: APXvYqw78QfeB8EWm76XpNXcEi9/Yq23E6X/cR6dtxqTrBJHKMJGGklY+qIcdVmAfPM7GBC0IHWgIA==
X-Received: by 2002:a05:600c:2549:: with SMTP id
 e9mr3946555wma.46.1561116646000; 
 Fri, 21 Jun 2019 04:30:46 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id r3sm2712851wrr.61.2019.06.21.04.30.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 04:30:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 21 Jun 2019 13:30:18 +0200
Message-Id: <1561116620-22245-24-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::335
Subject: [Qemu-devel] [PULL 23/25] sd: Fix out-of-bounds assertions
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
Cc: Lidong Chen <lidong.chen@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lidong Chen <lidong.chen@oracle.com>

Due to an off-by-one error, the assert statements allow an
out-of-bound array access.  This doesn't happen in practice,
but the static analyzer notices.

Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Message-Id: <6b19cb7359a10a6bedc3ea0fce22fed3ef93c102.1560806687.git.lidong.chen@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/sd/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 60500ec..917195a6 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -145,7 +145,7 @@ static const char *sd_state_name(enum SDCardStates state)
     if (state == sd_inactive_state) {
         return "inactive";
     }
-    assert(state <= ARRAY_SIZE(state_name));
+    assert(state < ARRAY_SIZE(state_name));
     return state_name[state];
 }
 
@@ -166,7 +166,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
     if (rsp == sd_r1b) {
         rsp = sd_r1;
     }
-    assert(rsp <= ARRAY_SIZE(response_name));
+    assert(rsp < ARRAY_SIZE(response_name));
     return response_name[rsp];
 }
 
-- 
1.8.3.1



