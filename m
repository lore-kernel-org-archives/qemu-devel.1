Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD4BC388F2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F91022267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 11:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGzQkmoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F91022267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVYXt-0000Y3-0k
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 07:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kVYWy-00006Z-GO
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:13:16 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pankaj.gupta.linux@gmail.com>)
 id 1kVYWw-0002yE-Tl
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 07:13:16 -0400
Received: by mail-wm1-x343.google.com with SMTP id c194so1589611wme.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pb6qXfswAyIe78cm/lxQ83tNAzspanJ4KKxjthIvFR4=;
 b=TGzQkmoy2GEwpuK3BB5CpFoWBRJqY69BwtXyHxoaq+9wpp/qN71aIkujcC5EoIXU/Z
 1VkjIw0IOt3qA6gtjhTubZYhcUZl57ZNp/hNstnNpRsakKjcs4gZZEcSXdS5AthkbNrl
 6tQ9JJxUx+898Yz8jaZZVjgvaoDzlTz2z7oakQBIdjPdX8moUFRVNVmyKgqj/90zJPP+
 khlouCAyqvDbJjxldlDySlJnUFcIBswZHgSWiinUfj5UxO3xy3OHnd3/ThNLITP9ItJo
 v/iia5GH5rytBL83ayjvXrg9e1LEIam0znSFmgCY7SxjlhHeQ+HoudTI/4YmGWk+pYcw
 henw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pb6qXfswAyIe78cm/lxQ83tNAzspanJ4KKxjthIvFR4=;
 b=q76yLkQRb90h+CFrybZrLMMrG2O2S1PABr+e8+pHDNw6oIrTZrjhcEHqFAdJMFc5QN
 J0ZsF6xQetSIrUquDwSEAa49+go7Tx4N9SKNI1+p069reGvsNk69d/MJC0eaoPSS0R8I
 rR8q9jMj2j4DjM9hxxSrWypn9ZxAwnnfigw4JjifCem7bkogeatG+Cr9s8S1utmhn3o1
 1suj3Hl3wa7RSbesuGugHLhje/yI6QY+670JOvdXSnOyQIAZiTvP4tljVcZKy9aTfmMt
 t1M92IZppJmmyH5ZsoJkZxiETkNhV1yvMi8jmFrgynjppeN76+jtuYvSkW43/gAtMDxc
 q2mg==
X-Gm-Message-State: AOAM530DyeXfu15k+M0TDAJ9GMA7697IHa4u8jwgmb1v4i/VebAtgoda
 PhiuXFrPln0V81uweLg84k8BZjMc+X0=
X-Google-Smtp-Source: ABdhPJxRfEGFqOPD/YYwn22Mx3t9nRenk6iZtKQv3KMSkaBnwUXkUItsI5fNOOFFFZ7g8KkQlwb4gA==
X-Received: by 2002:a1c:4c13:: with SMTP id z19mr2002383wmf.121.1603365192716; 
 Thu, 22 Oct 2020 04:13:12 -0700 (PDT)
Received: from lb01399.pb.local (p5b05ee11.dip0.t-ipconnect.de. [91.5.238.17])
 by smtp.gmail.com with ESMTPSA id
 z11sm2944873wrh.70.2020.10.22.04.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2020 04:13:12 -0700 (PDT)
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] physmem: improve ram size error messages
Date: Thu, 22 Oct 2020 13:13:02 +0200
Message-Id: <20201022111302.8105-1-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=pankaj.gupta.linux@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: pbonzini@redhat.com, pankaj.gupta@cloud.ionos.com,
 Li Zhang <li.zhang@cloud.ionos.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Ram size mismatch condition logs below message. 

   "Length mismatch: pc.ram: 0x80000000 in != 0x180000000: Invalid argument"

 This patch improves the readability of error messages. 
 Removed the superflous "in" and changed "Length" to "Size".

Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Reported-by: Li Zhang <li.zhang@cloud.ionos.com>
---
 softmmu/physmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index e319fb2a1e..8da184f4a6 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1756,15 +1756,15 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 
     if (!(block->flags & RAM_RESIZEABLE)) {
         error_setg_errno(errp, EINVAL,
-                         "Length mismatch: %s: 0x" RAM_ADDR_FMT
-                         " in != 0x" RAM_ADDR_FMT, block->idstr,
+                         "Size mismatch: %s: 0x" RAM_ADDR_FMT
+                         " != 0x" RAM_ADDR_FMT, block->idstr,
                          newsize, block->used_length);
         return -EINVAL;
     }
 
     if (block->max_length < newsize) {
         error_setg_errno(errp, EINVAL,
-                         "Length too large: %s: 0x" RAM_ADDR_FMT
+                         "Size too large: %s: 0x" RAM_ADDR_FMT
                          " > 0x" RAM_ADDR_FMT, block->idstr,
                          newsize, block->max_length);
         return -EINVAL;
-- 
2.20.1


