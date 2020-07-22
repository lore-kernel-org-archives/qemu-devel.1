Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEA7C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C827520792
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jl7i98mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C827520792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBCk-0006CD-2E
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAvA-0002gU-UU
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:17 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:52342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAv8-0005hA-DB
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:20:16 -0400
Received: by mail-pj1-x1031.google.com with SMTP id gc9so867819pjb.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hnT4LfCpRz4l4mcm1WiBHzRG6KMccLv2xCUhcy2MNm4=;
 b=jl7i98moEc7uKcaQDt8Zv3z+6E6JJ3m6kZ3sEzZY+UIRYC06rpUDz+8AnBUNt8JGPD
 dZLR/t7zeY2x8g2ZQ0gyBbZNtAlPkG68PyUPihTQkOJUKBdiYmlvPhjw41/4Wdp8czbX
 8SzKAuoHXuDTD9wqqeUNHQzynnkQOyhZt51/5kanlYrV63kQ+BXJ0oZhCzj6BSWttvkj
 viMqr9ovm9Jr+tVgg7VDxto5T0aQsLLefo79UGHoecyURDXF5WTqQUBPGDN2ZrcrdaFU
 JFOuC0+98EkXqRhuYGGjJhYwDVKJo9s/AabRTCli7RD3xUJIozWVgL2ZF6AwfwE7BvhS
 mbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hnT4LfCpRz4l4mcm1WiBHzRG6KMccLv2xCUhcy2MNm4=;
 b=ZuTb0GU3Rpk2mnOe2ks4Wr93bcfOK2paTjx3C9zvmA13DB7CGY2BZWWvHQEomXCtsW
 xcl2Gbnyt8oViqL9Egw74IVU6aB/cM8U7AXVy2kFeYe3kRIpHwe/8jspGEzPLdZqnOQ2
 HszCxFTdYbsz53Er0xaNcXG/Q610t0UgMU8jNIsyfzpUrq9CuWjmqrFY3VYnuZ7hSDUa
 GWZRb7iA0oIt5OR60pes+Gw9LM3qRopYEPaCFgUUGH/T9Yh1aggld9sv/JDxm/1PROrb
 YLBJNDL2zJTbMq1cjB/RGoYGpLLHN2uBDgZX7GY8gnSYYHhB51HfmZRsPvbClpHpU0Bc
 7oPw==
X-Gm-Message-State: AOAM532db5zR8hXWBKJhHZgFo+AK3PwHGoLwKWbsMzQGS8RPhP7ORv/w
 Dfme2BWJIWnI/Jgwjvh4WSgFL3uWySU=
X-Google-Smtp-Source: ABdhPJypycV7D0mV1C755O1O+znJ0HxE4i6ft8KLTpebJ3tTVGGQhaIPNA6hCiWwcwT7RKBvmbSwZw==
X-Received: by 2002:a17:90a:3769:: with SMTP id
 u96mr9395366pjb.198.1595409612979; 
 Wed, 22 Jul 2020 02:20:12 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:20:12 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 36/76] target/riscv: rvv-0.9: element index instruction
Date: Wed, 22 Jul 2020 17:15:59 +0800
Message-Id: <20200722091641.8834-37-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x1031.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/insn32.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 4560bc4379..01316c908d 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -579,7 +579,7 @@ vmsbf_m         010100 . ..... 00001 010 ..... 1010111 @r2_vm
 vmsif_m         010100 . ..... 00011 010 ..... 1010111 @r2_vm
 vmsof_m         010100 . ..... 00010 010 ..... 1010111 @r2_vm
 viota_m         010100 . ..... 10000 010 ..... 1010111 @r2_vm
-vid_v           010110 . 00000 10001 010 ..... 1010111 @r1_vm
+vid_v           010100 . 00000 10001 010 ..... 1010111 @r1_vm
 vext_x_v        001100 1 ..... ..... 010 ..... 1010111 @r
 vmv_s_x         001101 1 00000 ..... 110 ..... 1010111 @r2
 vfmv_f_s        001100 1 ..... 00000 001 ..... 1010111 @r2rd
-- 
2.17.1


