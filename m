Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531BAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 23:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5BC20706
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 23:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn4TRCUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5BC20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kALRl-0006Yh-9a
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 19:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kALR4-00066D-4t
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 18:59:30 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:45093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kALR2-0006Uy-Hj
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 18:59:29 -0400
Received: by mail-pg1-x52c.google.com with SMTP id 67so2303650pgd.12
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 15:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xSa+lKrzpAxZpfbmVv/lwbN7oH6G4GxEh8xRVQQ8Z/A=;
 b=Hn4TRCUz+vE014TGDkJVeDikBqyie3cvkGPqBSD10tKMLJsJRfuJZasVcqFRpTlLgi
 2RXBeuQfm7JdxRjlT0R6Uf0P4TZcJVirP1nQcYENK76vIaGjNTlhnZqk2vRGhXAjA1v7
 BQF3+v+n7C3wl86j3cmyGFziuuODLKo6/JcjGHCcQ+ZUJFREPwFajfJedXvgHE+ouUL6
 Pp18ZUkPdAWA4SstvJoDgXMkYNbBYz/+K3K79vJM473dIdxyJ/RsSJhiKvxrI1ObqFsC
 wKYmOiVbgDegn5QiC/LI3cjWUoKbchW+XJRKmPUH7+kzORdz2geuwlBjRkZDd1jaF9T1
 rh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xSa+lKrzpAxZpfbmVv/lwbN7oH6G4GxEh8xRVQQ8Z/A=;
 b=SD3HAK6IXd5VO5ZyFFjH2E8NzSTNObVt+NZzh8rF7vnmEugOkAYdX96W5BPt8YIkUS
 XyJbTpI8FDuKmuIPXU1wuI4TxnD7Z062WysRiMgu1unJLpwOLdPBgrhVATeuTB8QAoqb
 BsMEcrvXF3wzA9dA503u3S5n6BpaHqU/WrG5vJPUxGX1lCaJiFV9EEkQcgYiovJws1TP
 tLH75fruD462P0fCd5hM9LKQl9FbjWNDgepd7STzQh0H6fhGSnhfm3K2cNofcJHbyGo0
 nC3LHqzGwyvubue14j0cRUhQdKCtfIayX2BBBMR3XTT2DmApPpRO/q1+czQQLryGMPtz
 wwJw==
X-Gm-Message-State: AOAM532NL2y5upsD6XhtgP9pz5hSHX5WJYFoE1I1FGKEThy/UICGolgL
 gSp1QEfVE1i+hc/iGT29aeqc9iyeO1YnAw==
X-Google-Smtp-Source: ABdhPJzO8eBPbJWv4/VfW2yXXeQ3XFjiGuhqZLTebgnbP+OkvSbPtOlpbnzPOr/8taXAbVtuaXiWrQ==
X-Received: by 2002:a62:78cb:: with SMTP id t194mr5570627pfc.171.1598309965775; 
 Mon, 24 Aug 2020 15:59:25 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id gk19sm2027866pjb.2.2020.08.24.15.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 15:59:24 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] SIMPLE_PATH_RE should match the full path token. Maybe
 also apply to others such as STRING_RE and TOPLEVEL_RE, not for sure
Date: Tue, 25 Aug 2020 06:59:02 +0800
Message-Id: <20200824225903.1623-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x52c.google.com
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
Cc: pbonzini@redhat.com, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

---
 scripts/ninjatool.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/ninjatool.py b/scripts/ninjatool.py
index cc77d51aa8..6ca8be6f10 100755
--- a/scripts/ninjatool.py
+++ b/scripts/ninjatool.py
@@ -55,7 +55,7 @@ else:
 
 PATH_RE = r"[^$\s:|]+|\$[$ :]|\$[a-zA-Z0-9_-]+|\$\{[a-zA-Z0-9_.-]+\}"
 
-SIMPLE_PATH_RE = re.compile(r"[^$\s:|]+")
+SIMPLE_PATH_RE = re.compile(r"^[^$\s:|]+$")
 IDENT_RE = re.compile(r"[a-zA-Z0-9_.-]+$")
 STRING_RE = re.compile(r"(" + PATH_RE + r"|[\s:|])(?:\r?\n)?|.")
 TOPLEVEL_RE = re.compile(r"([=:#]|\|\|?|^ +|(?:" + PATH_RE + r")+)\s*|.")
-- 
2.27.0.windows.1


