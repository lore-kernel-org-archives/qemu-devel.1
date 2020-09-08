Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29C1C2BC11
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A852067C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7A9hO54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A852067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFikm-0001s9-Jo
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFigo-0002CL-G7; Tue, 08 Sep 2020 14:49:58 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:35285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFigf-0002c7-Gv; Tue, 08 Sep 2020 14:49:53 -0400
Received: by mail-pf1-x432.google.com with SMTP id o68so39955pfg.2;
 Tue, 08 Sep 2020 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nB7uQ/s9fu4x2Up4TVd+1iuCIae9I+X+vwqkrJxP6ag=;
 b=B7A9hO54DtWhVFF9yNlZJ/h1g9kt9KN92br5SvqAXO8cgkCAAUjescOFXWSq5Bp7ET
 u7P7o3cgA17F6MffubtZCf+RIP4UNyaykdYi/9x1flZHnq6iKri1p58+wdWc3rKmgfal
 fxbE3t1ikHCU5jrzxA951nkApgBHxYjxuUrGEmKettBeBEZ9/BlDAyUXhlIpEklRBzBB
 sd8/5m2WDkEBOZBVo3mhy0Fu310pokFunClTo7Ka14CvlTjEWH/Rkrz38UMgf1VXt025
 4ve19RCfUGH7xPGoM7TH4xOebJBN7PC95i40MrHNFXPbA+N0h2UAG9LNlHOPkjc6Riqb
 k3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nB7uQ/s9fu4x2Up4TVd+1iuCIae9I+X+vwqkrJxP6ag=;
 b=PB4reVk1PKxrA9xwNSltH3PR26FhSXovXT2+QrpQAsL5N82kgUkGT641fH4JXEa2us
 DoMbEWQ39+jZdJqV8gDeVtgJ4x4dbf0tLQnBC4s550F4YV8GPzDfLzEj9F+zyqvSgEZM
 sQeSd5Pj+LbaNxnJX8gjF0jp+lSEbKhvzhzRB2Ia1zU18Ek6HhtQNInMAStbBi1wVfdF
 HA96qHMrNSgsiib584nMEvjm4mEtLdTB7/lp+jfP9Z24XDVGT+cvciuwIG+cdw5YuVAN
 pDRPd0hBlR7EcirMyxxu8MEpBZjbRdjZRGXsBTAzXoyEtyA2y7aJQpHV2gB8ETNOfeWH
 nzMg==
X-Gm-Message-State: AOAM532a2Cz6Ihyc9nziocPoeCr+pHYERKTh+uErAy2KpS3MOVsK5VaM
 887LrtWEzioaVjuRSBz+rqAP6Si4dc19Nj5P
X-Google-Smtp-Source: ABdhPJxiZOiROnf68MtWLwsKseLbJ6ijF2SN+UEvMx2z+HufJx+W3MqWZr676CvTc/msMA0LrKrNzQ==
X-Received: by 2002:a65:408b:: with SMTP id t11mr90788pgp.199.1599590982763;
 Tue, 08 Sep 2020 11:49:42 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 8sm43553pjx.14.2020.09.08.11.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:49:42 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] ci: fixes msys2 build by upgrading capstone to 4.0.2
Date: Wed,  9 Sep 2020 02:49:04 +0800
Message-Id: <20200908184918.1085-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908184918.1085-1-luoyonggang@gmail.com>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x432.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 capstone  | 2 +-
 configure | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/capstone b/capstone
index 22ead3e0bf..1d23053284 160000
--- a/capstone
+++ b/capstone
@@ -1 +1 @@
-Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf
+Subproject commit 1d230532840a37ac032c6ab80128238fc930c6c1
diff --git a/configure b/configure
index 4231d56bcc..f4f8bc3756 100755
--- a/configure
+++ b/configure
@@ -5156,7 +5156,7 @@ case "$capstone" in
       LIBCAPSTONE=libcapstone.a
     fi
     capstone_libs="-Lcapstone -lcapstone"
-    capstone_cflags="-I${source_path}/capstone/include"
+    capstone_cflags="-I${source_path}/capstone/include -I${source_path}/capstone/include/capstone"
     ;;
 
   system)
-- 
2.28.0.windows.1


