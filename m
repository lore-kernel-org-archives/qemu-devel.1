Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D666CC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9651B2074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0S8DNfy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9651B2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEBYO-0007vU-Py
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEBXd-0006S4-N8; Fri, 04 Sep 2020 09:14:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEBXc-0002Yd-7N; Fri, 04 Sep 2020 09:14:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so6735694wrm.2;
 Fri, 04 Sep 2020 06:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pUn9OQfvIDUS2owgm25WBMJmc8HrxsJALivDp1WyLus=;
 b=t0S8DNfyCrw+6326yuho28EHfZtwxIw2KXDtB7c1/BmmgEjUjwLdfMBa9DLaUUclF4
 Z6R9aL1+T2Tb8asyj5NGO+fpTKy4XP4BBFzflUfWLhMdkVLnmdIGR0MVOTG6AioxT94B
 nluhSIlNlK75VjoMOuqyIUpDfgfLIkDiUL7Tjk9ka2OtaRrkq+Rr3dAt+ENeRhY3uoBQ
 CR1uoW0RLH2OaYm+guWvS6uLqosEIneYPtvRV8X+FlEJdbxtFlVpnDVBTfFAkU84IUJA
 5PMkp7uSblXCLsMPz1smHQax/gsJeRpbxCBEpUhNmIOrVQLBlHYMt17dut3/LdxJUMcl
 CIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=pUn9OQfvIDUS2owgm25WBMJmc8HrxsJALivDp1WyLus=;
 b=DP4Y8rIVj63cNmmjmlOZuuj5ExaSLUfkLJeATthQ+/v0ydN2JYnBdxCZ1r9B6AgQBu
 paQauOikYjfcVCNBKOLaIPmWftODs5kXrAhBqgcejboYh4xFjgLkMNIDHhomF9lx+ChM
 5+0LsmJgh3UN14E2FbMOyPLSiyRzUUDv1Oi66Yg3DsFGItdFNTlhLXLZduj5vzjyi3fS
 uBz9Ee8woZU5G0kVZe7wgz+iQqidS3Nqk9+oehiwQBG9C1Zw+S+pss7fKBjTpGRNL+a8
 veJie9Qmc3ry7kc3l+0C4KhNmiJV6BeEI0OY2s+5No2q76rppqSr0+JQ2icelIYsQasY
 nFNQ==
X-Gm-Message-State: AOAM533TAU+myAw724MZZ4CG13Xb++eetSBvD9MmO5AFJHBIdAOPm+SM
 Jk2aHCcXwPExeTS0Cap5iksTvyF+Bn4=
X-Google-Smtp-Source: ABdhPJzLV6g4Dgv0eESpOeTF74h/1V0KaOo6HQFhbeKOhVGKSk2d5pysLascdKoRlEYpoWXXWoC/uw==
X-Received: by 2002:a5d:45c9:: with SMTP id b9mr7477835wrs.283.1599225246129; 
 Fri, 04 Sep 2020 06:14:06 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id b1sm11923559wru.54.2020.09.04.06.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 06:14:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/net/e1000e: Remove overwritten read handler for STATUS
 register
Date: Fri,  4 Sep 2020 15:14:01 +0200
Message-Id: <20200904131402.590055-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904131402.590055-1-f4bug@amsat.org>
References: <20200904131402.590055-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The STATUS register readop handler is initialized first with
the generic e1000e_mac_readreg() handler:

  2861 #define e1000e_getreg(x)    [x] = e1000e_mac_readreg
  2862 typedef uint32_t (*readops)(E1000ECore *, int);
  2863 static const readops e1000e_macreg_readops[] = {
  ....
  2919     e1000e_getreg(STATUS),

Then overwritten with the specific e1000e_get_status handler:

  3018     [STATUS]  = e1000e_get_status,

To avoid confusion, remove the overwritten initialization.

6f3fbe4ed0 ("net: Introduce e1000e device emulation")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/e1000e_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index bcd186cac52..5170e6a4563 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2916,7 +2916,6 @@ static const readops e1000e_macreg_readops[] = {
     e1000e_getreg(TSYNCRXCTL),
     e1000e_getreg(TDH),
     e1000e_getreg(LEDCTL),
-    e1000e_getreg(STATUS),
     e1000e_getreg(TCTL),
     e1000e_getreg(TDBAL),
     e1000e_getreg(TDLEN),
-- 
2.26.2


