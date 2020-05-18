Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF0CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B716620758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzUkQrcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B716620758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jai8K-0001qC-SI
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4v-0003J9-GK; Mon, 18 May 2020 11:53:21 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jai4u-00007U-9n; Mon, 18 May 2020 11:53:21 -0400
Received: by mail-wm1-x343.google.com with SMTP id n18so9383wmj.5;
 Mon, 18 May 2020 08:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cD0HVhIueot6xPtNOGreyU0JTmhLcSi0Ka6Qp1Nps5Q=;
 b=UzUkQrcnedIIS0eyBH/lUMfwWEMl0dN7u8jvYptYKbxkrDH/d7z9FHA5lgbVk4b94O
 9YAsA3AZn2b3y23TJXdtQz1KIUNf5Kvipq/cnwubNhPTe53nxW24cMT50ESHX3H4/wcQ
 izcXRSOCK5zCoYLLjt/KGEQqmZ2xpp7fgYwN6WliyF/fNgU4etLfxeZKj8Dfe4i9Q/Sr
 k+accbUYJeyeAfmxcwQTfyKvG3PYOmsnm3vdHwfVqIiDFu1ZpptTbNsUCxJf+JeIb1C8
 vxCoLsu7zynaFKgFBWTWnh3KBOoSK1a7SAlaqYJ94LEYAqcFAYBIpjyYkeJlDWSWQwVo
 QmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cD0HVhIueot6xPtNOGreyU0JTmhLcSi0Ka6Qp1Nps5Q=;
 b=ZUbOPjUqQNlwjH4troZcuUdjD5JjPfPqD6tfF4GWwHJGJh2xfl3aeTBatOGTGKt0NY
 8Y8OSDkMg9VpUXfNgOA2S31UEsgCuHJNwjOQD4eSsx07SHtves701fCoB/9j+eXrbVTO
 e/pfVjOz21AknA7aFsMq4SKCcVjrI4q5/JZP72THD7LJVwg0cwXigTPdfybIChvJIto1
 hJb1CSH1hEQmhq8Xy4Hvi5mW1Ra8x75hjU81WaN41vyYpDjiWc3zofL8cMWaiopVjfRN
 su8vf7bfl2DyG5QIz2NsB1Afn0qn+Iv+2BP4V13XCXYw/i4dMGUqJe+SA+pPCw84h+mc
 HdgA==
X-Gm-Message-State: AOAM53056N05FalAtvQFRsF+VQOn2lGeGySpKZfiXG3Bj+s/pXEa2nrv
 wfK2fSiBdUmPrihKRA3ukntZt60whUY=
X-Google-Smtp-Source: ABdhPJzPg4xQnJ1fbHB57rgtpUNAn887oqh+iTpxfl6MyQ6sTjdHGtlxSB7D9n1FDS3I8jeo+FDEwA==
X-Received: by 2002:a1c:7e03:: with SMTP id z3mr52303wmc.88.1589817198412;
 Mon, 18 May 2020 08:53:18 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 7sm17647462wra.50.2020.05.18.08.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 08:53:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 7/7] hw/core/loader: Assert loading ROM regions
 succeeds at reset
Date: Mon, 18 May 2020 17:53:08 +0200
Message-Id: <20200518155308.15851-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518155308.15851-1-f4bug@amsat.org>
References: <20200518155308.15851-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we are unable to load a blob in a ROM region, we should not
ignore it and let the machine boot.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
RFC: Maybe more polite with user to use hw_error()?
---
 hw/core/loader.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 8bbb1797a4..4e046388b4 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1146,8 +1146,12 @@ static void rom_reset(void *unused)
             void *host = memory_region_get_ram_ptr(rom->mr);
             memcpy(host, rom->data, rom->datasize);
         } else {
-            address_space_write_rom(rom->as, rom->addr, MEMTXATTRS_UNSPECIFIED,
-                                    rom->data, rom->datasize);
+            MemTxResult res;
+
+            res = address_space_write_rom(rom->as, rom->addr,
+                                          MEMTXATTRS_UNSPECIFIED,
+                                          rom->data, rom->datasize);
+            assert(res == MEMTX_OK);
         }
         if (rom->isrom) {
             /* rom needs to be written only once */
-- 
2.21.3


