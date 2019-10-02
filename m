Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE0AC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB182054F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaeSiMzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB182054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFiBp-0003y0-LW
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrJ-0005NX-Mc
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFhrI-0003MC-RA
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:13 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFhrI-0003LS-LJ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 12:52:12 -0400
Received: by mail-wm1-x342.google.com with SMTP id 7so7980621wme.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 09:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=ctHqzmF5TD8AB7smZxOhtvuEQnZ1yozHJ+9MqxlkUs0=;
 b=OaeSiMzqglA9jbgYLidNul4LVSa+ezpPObr8nrH34VlW53Diilqgig/XNy6vcsgDA6
 oGJf20POMjWhJVe4uAb5+B9b8p7Vy63jxgiugiRjcjtUIBm/9fItTAU4azemxY9J+mGo
 5iCP4aeA/XpbnLlIZpohBnX3dxH7TsO6lKxHhnPwQU1u8uVsh/Bh2JmorttXlaOXDaox
 d8Oha6ipz545+cRUukq/KwaiAqzflI0BqjIdn//5KU+yGScQ7aLHIF4jeDEHO9rdHvoC
 3AN0kgPn41lSUUGr03A1FgIgvbQZvGHiKcDXHJ9TK/KKhxotkgNUYKmTMFL29bsKbeRb
 kjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=ctHqzmF5TD8AB7smZxOhtvuEQnZ1yozHJ+9MqxlkUs0=;
 b=lB4IKQBppHEQd5pq2QL8gnlnRJ0ey55WXzpCKbiQbl8dnd4H0RrL7hKLtq7PoQ9MMr
 /LhL7A/6ygmHLWgjTd5lpWm23EWraDlbJBUYTcN/yb2YBUvNF/wCpWDKJSC1N6jKqUPu
 nN2mK5nOWlTKhjD8tVUvZ+8sJVPFkZymVoRQlDkTIaBXqqYjva2TUnMjf0gakioe8X/6
 yF2UjqHQYXgfDacy5WsmVud0GhaWe015IAP54uCimYS1YcdsNrV/Y7svSrWLSZRN/2lt
 LwtNnZNKWlGmIw3g4sNVY6Mf6h9gzaMWmFZURthz712mQDB1zkDbxRZAZ9sZNRPp54FE
 19JQ==
X-Gm-Message-State: APjAAAUHYPqViwzzsuYD1MKfHYMO7eNSuIvuztbrIrn/eIHJmKBGvE1F
 uEBSSos8FOYgGirU9Eq2U90xzk6i
X-Google-Smtp-Source: APXvYqxRaGm2dI0X4OgyKUrl9NdufBR2pkadAxmrTrHFFn1gWKsTHjrDLxjd+UjCS3PiosMexeaYmw==
X-Received: by 2002:a05:600c:2057:: with SMTP id
 p23mr3558370wmg.17.1570035131366; 
 Wed, 02 Oct 2019 09:52:11 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g4sm27303990wrw.9.2019.10.02.09.52.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 02 Oct 2019 09:52:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/30] mcf5208: fix leak from qemu_allocate_irqs
Date: Wed,  2 Oct 2019 18:51:39 +0200
Message-Id: <1570035113-56848-17-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

The array returned by qemu_allocate_irqs is malloced, free it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/m68k/mcf5208.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 012710d..60c5802 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -273,6 +273,8 @@ static void mcf5208evb_init(MachineState *machine)
                      0xfc030000, pic + 36);
     }
 
+    g_free(pic);
+
     /*  0xfc000000 SCM.  */
     /*  0xfc004000 XBS.  */
     /*  0xfc008000 FlexBus CS.  */
-- 
1.8.3.1



