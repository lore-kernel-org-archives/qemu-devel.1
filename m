Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3116CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F141920734
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmNw4K8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F141920734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5D7-000558-9S
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl58e-0007u7-2y; Tue, 16 Jun 2020 02:32:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55597)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl58c-0003LG-N1; Tue, 16 Jun 2020 02:32:03 -0400
Received: by mail-wm1-x343.google.com with SMTP id c71so1700267wmd.5;
 Mon, 15 Jun 2020 23:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fwp2bV7YJjkiLZTrttPTVnsH6xKa3HonthSU7rRzJJA=;
 b=MmNw4K8/gon6mgxA9LK3rVLZq+tpX8RgeZx33g6F8PL2+ox2TeCYAIdN+aKQoxMEHA
 X4MYXVYC6qgJ41XhPfRzB+VVTksKfMtjpOLrhHcNYZ/zpjd7qW9rC10Nmh5HuwWL54Ou
 QnWdq6q776ucKZ2WGHFuiKAiURLEhoGejsj5N8BtD8Vzu5hRjT+/I2SVpdDbxB5DcF7j
 8ZiHXRHJ4YI2W1AEAPlPzg5mpl1vj13rzEv0CofGxkbcWPnf1R38mY34BN0aYnfsqz3v
 eSJ2y1OnqTYGRyUOHc9fDzwD7lZm3WAN6+iOZ3ycwUnmSEnCySP+or7sq60Cfdly8vci
 0vjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fwp2bV7YJjkiLZTrttPTVnsH6xKa3HonthSU7rRzJJA=;
 b=N5GK4OZrGloQHTZqdC/b1zi21eazo27bU+8IDfePCfljSR7N/bgU3rdJiolumlcuVv
 MAOlDsVGJrrXiCbIx0MGNFrUlY6pCGMakhBOLaso1J3ViAgH8nN6QKAZVA1lXH45sKth
 m3aRJ+vr/IV/G5W9Vd+184jcX0J+fJ16PP2VdqNFo7CbeqNG1RaoJ2zOwJWtoWInav6v
 Y8m9k7SUMry7zXjmnPOTD3pyf8EdVTOIcFoBVqP4K2JS/ryCdvcortXJZHwQ3ljnfx5n
 VVhHj7gFWhZ25+afCQjmxuI0PEEvEOLZG8EjLyAyUNVYmX2iIBTAkq0bgPwybAfQMT4w
 BfjQ==
X-Gm-Message-State: AOAM531a0a1U3VsBLeP1u+PlcYViVoDqk0nKVftaoe6w60pZMPXR4PXr
 ojM2UbBlQCo7Ma5HDlrfKtPRNkan
X-Google-Smtp-Source: ABdhPJx10W4CD/+D2U162LBnW0cMnx/cbfyPobFSBmDgmfSepliwqzYA30FyjDPW629GJTT6dr2lvw==
X-Received: by 2002:a7b:cf31:: with SMTP id m17mr1446887wmg.47.1592289120628; 
 Mon, 15 Jun 2020 23:32:00 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t188sm2483250wmt.27.2020.06.15.23.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 23:32:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] hw/arm/mps2: Rename CMSDK AHB peripheral region
Date: Tue, 16 Jun 2020 08:31:51 +0200
Message-Id: <20200616063157.16389-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200616063157.16389-1-f4bug@amsat.org>
References: <20200616063157.16389-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To differenciate with the CMSDK APB peripheral region,
rename this region 'CMSDK AHB peripheral region'.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index f246213206..3cc02c9018 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -212,10 +212,11 @@ static void mps2_common_init(MachineState *machine)
      */
     create_unimplemented_device("CMSDK APB peripheral region @0x40000000",
                                 0x40000000, 0x00010000);
-    create_unimplemented_device("CMSDK peripheral region @0x40010000",
+    create_unimplemented_device("CMSDK AHB peripheral region @0x40010000",
                                 0x40010000, 0x00010000);
     create_unimplemented_device("Extra peripheral region @0x40020000",
                                 0x40020000, 0x00010000);
+
     create_unimplemented_device("RESERVED 4", 0x40030000, 0x001D0000);
     create_unimplemented_device("VGA", 0x41000000, 0x0200000);
 
-- 
2.21.3


