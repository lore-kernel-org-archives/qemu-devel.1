Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EB3C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 13:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8ACA23B8B
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 13:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utnx94dq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8ACA23B8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmdd3-0001ra-V7
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 09:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmdbl-0000K9-FT
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 09:32:33 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:42393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jmdbj-0003HF-Rv
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 09:32:33 -0400
Received: by mail-ed1-x541.google.com with SMTP id x93so9937147ede.9
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2020 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZI4rFIHyx7d9nC2CjEQDYphQq+Kuoo8/ZRfXYMg/rE0=;
 b=utnx94dqw6i07bvL1xXWZoqV0f6M7uIhIs/xuer4ax4Ii/VB73F6S8o0hUVmtxwza9
 ihyIoasFsmwUKfbhzezpbDHDrMDVwzFzOoyDFFM86Uupp79Zwqo0llTAx0cgDc6URC6O
 g1B1UVa5iLuFiKg5fUf43zCC2EywHPMEz+p87QpepZ5cKP1X0XNso/sPGaPgOpq5gR0F
 FJX4Jc5cJhIHbNsrmVBdgV8Ee+d/9z/5ouFOfMMATZsLfRyHXkRsuWnzC3xVGeu47nC9
 AJuhAW9c5SRiBH8OBUSmSnE0Ewf65CSBPfC4MFA7qYQPn3nE6LkoSVdCO7hckb4UmyNY
 s7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZI4rFIHyx7d9nC2CjEQDYphQq+Kuoo8/ZRfXYMg/rE0=;
 b=dTXBo5TSB8z3Z3D4lya64ZPoOvnlZoh0kf7tc6CKcIKJy/5MGanAqtNdU17jViHMK+
 6OxfecqgUE+xGQ6W8asyglor1bbSxNWOKKfqZmsNQOfu9pJZVBx9u9kzhvo309MAl9ke
 UOvUypxGtAfkwrOPIdLiSibWZ0J3v8jsiFW92EMA/5V8NIYlOPonY/JqJsfMqLmt/lGI
 PueomFQDMqcW8arLbnVJ5NssxL2seQoox/YU1Ifnw7r0wu5mP2Mfser2+A8UB/yeJbBq
 Te+lomHmUth4O9zCQLUMEnei6sK6Fvu79tO0UWreAE+5byZHvsj0es9sTWvFvAzCix09
 3Q9Q==
X-Gm-Message-State: AOAM5326MkfY6nrNu1keQPmC/7bU+lzD0H/fII2/v5aJuqU31ljy+DcS
 3Ej4l1gITIuO90fJ3vI2dX0q3Gmn
X-Google-Smtp-Source: ABdhPJwwEsSmhbN4798K9lWF/xXaJ1w/ZEYBnchdut+lSnaQ2CzT6d1D+qjhficAuSCcNiylF5zuoQ==
X-Received: by 2002:a50:b022:: with SMTP id i31mr8255631edd.301.1592659950296; 
 Sat, 20 Jun 2020 06:32:30 -0700 (PDT)
Received: from localhost.localdomain (net252-38-245-109.mbb.telenor.rs.
 [109.245.38.252])
 by smtp.gmail.com with ESMTPSA id bd19sm7453202edb.2.2020.06.20.06.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 06:32:29 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] checkpatch: Change occurences of 'kernel' to 'qemu' in
 user messages
Date: Sat, 20 Jun 2020 15:32:07 +0200
Message-Id: <20200620133207.26849-3-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200620133207.26849-1-aleksandar.qemu.devel@gmail.com>
References: <20200620133207.26849-1-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 stefanha@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is odd that we inform user that, for example, his current working
directory is not kernel root, when, in face, we mean qemu root.

Replace that and few other similar odd user messages.

Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c760c5a4a9..f46c18e413 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -49,7 +49,7 @@ Version: $V
 
 Options:
   -q, --quiet                quiet
-  --no-tree                  run without a kernel tree
+  --no-tree                  run without a qemu tree
   --no-signoff               do not check for 'Signed-off-by' line
   --patch                    treat FILE as patchfile
   --branch                   treat args as GIT revision list
@@ -57,7 +57,7 @@ Options:
   --terse                    one line per report
   -f, --file                 treat FILE as regular source file
   --strict                   fail if only warnings are found
-  --root=PATH                PATH to the kernel tree root
+  --root=PATH                PATH to the qemu tree root
   --no-summary               suppress the per-file summary
   --mailback                 only produce a report in case of warnings/errors
   --summary-file             include the filename in summary
@@ -203,7 +203,7 @@ if ($tree) {
 	}
 
 	if (!defined $root) {
-		print "Must be run from the top-level dir. of a kernel tree\n";
+		print "Must be run from the top-level dir. of a qemu tree\n";
 		exit(2);
 	}
 }
-- 
2.20.1


