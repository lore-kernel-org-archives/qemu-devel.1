Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11BFC11D0B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB1520659
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCSzbLZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB1520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oEe-0007C7-PL
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <changbin.du@gmail.com>) id 1j4oE0-0006XC-Uz
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <changbin.du@gmail.com>) id 1j4oDz-00081h-SV
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:58:52 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:40539)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <changbin.du@gmail.com>)
 id 1j4oDz-00081V-N7
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:58:51 -0500
Received: by mail-pj1-x1042.google.com with SMTP id 12so1056714pjb.5
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 07:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AyYFPintjS33+cQTR0ZmIAm/DzXISFY+IXPQ/jGUov0=;
 b=iCSzbLZU0NXD4s1knvchbX2DjYOuWKjECeKLSdwCfQ6ljs2m/6scUGlm0wtxaLJeqv
 oz7axvBnR/oU4jGbv2bNZGFSdx5pTM5nSfySIapSepZR/Drirb8pYbRQFDTW/zIjdX+s
 bAUnsFjTe1dtnKWQbnZroyZU878ra5lpGvDkYO1Z7aRDJAEaSqx1lFFf2f8DzAPd80Kk
 9/x8ft4favnCbkC2aNYqZVnTklwuyPdPVwgkSZKx03ukKQfshk6sER1YDVnlVxiH8M9S
 HNUdMuPoArFr7q2zWHTwz9Gm124lRWkXeXhWsVOoi+70GhfhOkxK9b4JlJwe26Zqx4A2
 waBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AyYFPintjS33+cQTR0ZmIAm/DzXISFY+IXPQ/jGUov0=;
 b=JnHZibCemT+wueCsR9YZpY280TV87ycQ3IsDH2juWxNHQ5e5QWGCfgVT/DHtx43bdp
 oYM8p/XotJ4ZjRLXxI7z/92HvP1ROnyqc4lxitjhgv2+eMRy53KEKQSAAKmGvBMx9MIZ
 jHCEsECPe18nAsVr7Og7FLS8WEw663RU+XT4aiYaWff6w/5KGrqoGvY8CEMBGw3ASVUe
 TpRWTFYraTLW7XNogXpoZ/t3SnXqOq+1wNvjB7mnEn8s70KIe4DKgJXC0tyzjkWhXFQo
 c9amqRYRK+JgtbltVvRfMBUWWqqt+kK8IVbbIEr/LBo7wUCnGI8kA+3KNNNzpLKHVwDn
 /ZKA==
X-Gm-Message-State: APjAAAXZzIxGCBYFN/9JyPFWY9zmRElMjqSHwIJksyKd8TJMAWKmLj7Q
 bZgY7XYQsWZhNtM5GZyQNWY=
X-Google-Smtp-Source: APXvYqwiUHdvtClCc8pfTlOUYYhzcG0Y8VdLYJubPjvCeVEifLTVSlqQtFTTahh/TQ/0TMY6JFrTJg==
X-Received: by 2002:a17:902:ff07:: with SMTP id
 f7mr30807598plj.52.1582214330251; 
 Thu, 20 Feb 2020 07:58:50 -0800 (PST)
Received: from vultr.guest ([149.248.10.52])
 by smtp.gmail.com with ESMTPSA id c68sm18400pfc.156.2020.02.20.07.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 07:58:49 -0800 (PST)
From: Changbin Du <changbin.du@gmail.com>
To: alex.bennee@linaro.org,
	philmd@redhat.com
Subject: [PATCH] tcg: gdbstub: Fix single-step issue on arm target
Date: Thu, 20 Feb 2020 23:58:34 +0800
Message-Id: <20200220155834.21905-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: qemu-devel@nongnu.org, Changbin Du <changbin.du@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Recently when debugging an arm32 system on qemu, I found sometimes the
single-step command (stepi) is not working. This can be reproduced by
below steps:
 1) start qemu-system-arm -s -S .. and wait for gdb connection.
 2) start gdb and connect to qemu. In my case, gdb gets a wrong value
    (0x60) for PC.
 3) After connected, type 'stepi' and expect it will stop at next ins.

But, it has never stopped. This because:
 1) We doesn't report ‘vContSupported’ feature to gdb explicitly and gdb
    think we do not support it. In this case, gdb use a software breakpoint
    to emulate single-step.
 2) Since gdb gets a wrong initial value of PC, then gdb inserts a
    breakpoint to wrong place (PC+4).

Since we do support ‘vContSupported’ query command, so let's tell gdb that
we support it.

Before this change, gdb send below 'Z0' packet to implement single-step:
gdb_handle_packet: Z0,4,4

After this change, gdb send "vCont;s.." which is expected:
gdb_handle_packet: vCont?
put_packet: vCont;c;C;s;S
gdb_handle_packet: vCont;s:p1.1;c:p1.-1

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub.c b/gdbstub.c
index ce304ff482..adccd938e2 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2111,7 +2111,7 @@ static void handle_query_supported(GdbCmdContext *gdb_ctx, void *user_ctx)
         gdb_ctx->s->multiprocess = true;
     }
 
-    pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";multiprocess+");
+    pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";vContSupported+;multiprocess+");
     put_packet(gdb_ctx->s, gdb_ctx->str_buf);
 }
 
-- 
2.25.0


