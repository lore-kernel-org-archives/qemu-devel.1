Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90929C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B75521783
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzApEN9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B75521783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX68U-000858-WF
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63j-0001im-GH
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63i-00060c-IH
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:55 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:37504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iX63i-0005zy-Bx
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:08:54 -0500
Received: by mail-wr1-x42d.google.com with SMTP id t1so24521354wrv.4
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EjE2s4dLILThkxinnyee0kv/UUrrjl0KyE1AfYKWQZo=;
 b=XzApEN9PqChXErKLJf0sWsbQUCSOuFJNJn2yksaCeY0AivG905dNtSD1fcbmWGf5Mr
 SO3blEK5i/e8869phuDZqET76qL1+DeLb2Kwee/neOUjm/0JVCDN4lXfC+RDQeyuhE3i
 GJ0bDh4DMT+9OHoXsi6FL7cX/mal7/Z1mJHx3FTRX/5OCR6qRHypCmDCrzfLNkZdl+hF
 XeUZ6Ma3oKpoGrvO+/lJsxxgvTFOhEukYx3WlCLm+Q4hFoJruY7IU0Lh9kPAbOSHrB2w
 Ppx9Seb+3FB6o+XQWKvn167Sbyo8ExoQVq1ZAvab7D+UyCtBCHIILcvytVdQKQVAeSRE
 vaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=EjE2s4dLILThkxinnyee0kv/UUrrjl0KyE1AfYKWQZo=;
 b=V2p3UfXcrZ5gwtlvIqYblHrNaOK7ddI2idc7JbxvNtdO1bqscgZrt7Ic2KKXtA7Y2s
 RA2UJ6W8fDIio1AirXm9/kDRWHbjzAe+CeT52eawO+yzwQ3OUYyCiwqR5QG47qWxYgRk
 fkkoAHAI85rFnLkbob1HJFXr6Uqg5vvLep4rWu+D6gAiqUX+z6MA2bWyyyrCjTFxw07L
 RYurBnR3Nbumh+szjXtrBlQ1bBw+xk1b/v8jYz/LpVxgVHorWw+MdSf67e8S5NAVZb+J
 I050kU4hogvSoHrM3bd6Vofi+ZNXKU/YcUUP5yJ5IWZxzEEkN+qOivvHq+VKNxiJZQg+
 6XJA==
X-Gm-Message-State: APjAAAXynZ5xUh6z4QUkckzUz3cTdYgX2IR2BU8N+ZFGLheGLSyCEhtc
 608eA03Ls7nXn0kUfwYIn108hOgB
X-Google-Smtp-Source: APXvYqxXjmGuZg5VN/SO1JffK/bZztsyuumCrQ1iNKymUG1m37NnoABf6VzIi8tA8wPR1lHgIO5oKA==
X-Received: by 2002:a5d:522e:: with SMTP id i14mr23364679wra.27.1574179732826; 
 Tue, 19 Nov 2019 08:08:52 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n13sm3442203wmi.25.2019.11.19.08.08.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 08:08:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/12] microvm: fix memory leak in microvm_fix_kernel_cmdline
Date: Tue, 19 Nov 2019 17:08:38 +0100
Message-Id: <1574179728-35535-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
References: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Cc: Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergio Lopez <slp@redhat.com>

In microvm_fix_kernel_cmdline(), fw_cfg_modify_string() is duplicating
cmdline instead of taking ownership of it. Free it afterwards to avoid
leaking it.

Reported-by: Coverity (CID 1407218)
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Sergio Lopez <slp@redhat.com>
Message-Id: <20191112163423.91884-1-slp@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/microvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 8aacd6c..def37e6 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -331,6 +331,8 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
 
     fw_cfg_modify_i32(x86ms->fw_cfg, FW_CFG_CMDLINE_SIZE, strlen(cmdline) + 1);
     fw_cfg_modify_string(x86ms->fw_cfg, FW_CFG_CMDLINE_DATA, cmdline);
+
+    g_free(cmdline);
 }
 
 static void microvm_machine_state_init(MachineState *machine)
-- 
1.8.3.1



