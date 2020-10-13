Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC574C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F8520797
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F8520797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEHt-0005LA-2V
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 02:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBj-0005MW-4u; Tue, 13 Oct 2020 02:53:35 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:34615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBh-0000HG-9q; Tue, 13 Oct 2020 02:53:34 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N7Qp3-1kOlDv2bAD-017lZu; Tue, 13 Oct 2020 08:53:26 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 12/15] goldfish_rtc: change MemoryRegionOps endianness to
 DEVICE_NATIVE_ENDIAN
Date: Tue, 13 Oct 2020 08:53:10 +0200
Message-Id: <20201013065313.7349-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013065313.7349-1-laurent@vivier.eu>
References: <20201013065313.7349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+QPS27oS1/dsBBHKFOL+t/CKzz6mpZv45f6hLo1RQRLpHx63+q6
 7+KrbH9ahjbjZE0FonsA/k28zNuVQBaxwEizyz7ftTa/0PSer/QjDWZT5HxSzQA2+X+KX+k
 yaZB3InfAQ7CaCm+wz9ML4x4NxHc522W2r3wICwehCJGTQHuVusYVijwP9E606zj5TwAIbm
 jfp57Gi+A7/0Of5/u9MUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:91riXVbfGek=:DrIlnm/mDmYuFm2RMc782F
 Z6qRETPAzsh3AGjDbhlq+ngsSHhAA7OTgO62/HA/Ij0A40m/UWVZNOUIKuwNAa6guQfZWuhVI
 QPpj158N6CZ7/YYvCRC1bvklkTq0nGkJ8uOq3seZunCwQs0t+7rqC0U+U1OJKQh6LbI52K5jN
 Jm/IZEYUF9Zx9xLta5rQRRpmETJR8uaAR7blNg34XtFTxpBRb++haePpKNw6nwXm0embTu91m
 gl19RjjBQBjxAEUEgJoUtiTPxqMeWjUn36ytO/UNOjt637emIhPaMhqdbfnvv7FxZ8o3X3J+N
 Q3c0nE+haWi8GnXfIYfEFiCNOXfw2MULW8ecRdH6vJ/Nh1GWVZO5Pr9DvPVOa3AkQmDPjQdJ6
 CHhd3yLGO5gVotSricaLEB5y1+TkwUqyjW7F37NbHKD44tVFCeyvPySNMBO/FZ6ioOzLq/1Hh
 ym1WE1iKS9g9d3n01x1y/s+lWMBJcG/YHsKt+wYpftydJsBN5D7SBq7XPc3SA3rfQuPw+l/I8
 caGcjiDEfJIjRlXXdh687kQOhsCmg40lz+mGAN2OC77FeGQLiAeLRhB5T61cKOkUmpKBDCmFq
 1cyozDLwW++ryJLNLdX/p3pe7UJ9K81CHkIEhKIqEnDCL3SlS32ZSvbLHchHHutbOgecjds2/
 hFk+cTWQ4eq3CM79ofDcqXz47N1UycJBMoHXDWTqzOAJ4zeB0y0WG7sIxEBCFZDqjNItQ3uIP
 V9vBSg2+tTyTerHy8cCoqQtZSP8oYqaHueBzxO9+Wg24aoCH0micmUfVE9Bl0mPsUy/V5P23L
 dObU6o1H3ict0YfJ+dq+Q7ZJxc4cY/072GFq7sSXlPGug0RFA01dUjACEI+ChJwCA2+fUF/
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:53:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-trivial@nongnu.org,
 Anup.Patel@wdc.com, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

The doc [1] doesn't define the endianness, but the kernel driver
uses readl() to access the registers, so we can guess it depends
on the architecture endianness.

As riscv architecture endianness is little it might not change anything
for it.

Moreover, android implementation uses DEVICE_NATIVE_ENDIAN [2]

[1] https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
[2] https://android.googlesource.com/platform/external/qemu/+/refs/heads/emu-master-dev/hw/timer/goldfish_timer.c#177

Fixes: 9a5b40b84279 ("hw: rtc: Add Goldfish RTC device")
Cc: Anup.Patel@wdc.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20201009113843.60995-2-lvivier@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/rtc/goldfish_rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
index 6ddd45cce039..0f4e8185a796 100644
--- a/hw/rtc/goldfish_rtc.c
+++ b/hw/rtc/goldfish_rtc.c
@@ -217,7 +217,7 @@ static int goldfish_rtc_post_load(void *opaque, int version_id)
 static const MemoryRegionOps goldfish_rtc_ops = {
     .read = goldfish_rtc_read,
     .write = goldfish_rtc_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
+    .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
-- 
2.26.2


