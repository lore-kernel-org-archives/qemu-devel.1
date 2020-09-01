Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E0FC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935BA207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935BA207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD71N-0001k3-Ir
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zD-00059N-Vy; Tue, 01 Sep 2020 10:10:12 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:48519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zB-0003jX-No; Tue, 01 Sep 2020 10:10:11 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MDyoW-1kKqD20scO-009v45; Tue, 01 Sep 2020 16:10:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 10/44] hw/net/can: Add missing fallthrough statements
Date: Tue,  1 Sep 2020 16:09:20 +0200
Message-Id: <20200901140954.889743-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Qk5yQPmKbbO7HwvQeldik4qKCsyrNhYWxrCrS/d4CqHmAsss2Vb
 n9dnQNfjpo3HVf2Rxt4+y2AN1IARSzKHy8HyKRJo2ATaWybAFctnhQ7Tk1+RWoGORq4W4vx
 KFa5buDCrRGLbQbVKtQJsF5arXWDEuPlRxzmB1tGAQqo6uafaQdRUAi334n5rHCkBntRI4h
 a6JVMjtX4iLfQEMiLi6BA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ajmau5jBnbs=:rRm6FdeXu0AwOqRCrpT1oK
 sK9ueK9+1jUbfm/r9j5ZejbKUpkH8+QB1HEiVJIx2TzZs3kDjF9BBm70ql5kkX5fPSBu2vj7Y
 JOf9kVwLBKS4xJdobnUylh3VELDo3KhAU3KBkLTqZbl8SLC9m2SKpPI6WBqdHMwhbmqCxdFkN
 XQMKX/5aWjik6Y4GvEkSCHVmF1HiQb1ekpzSK+Ou8U1WkhVIE8xiwiAGhBAFdYgMk8eCVKyXz
 uwD65HD8kmZHYZO45a9WvVQBj5IeMWFlw+u2KRkww1iw4B0HYqMsYJLP6HYgeGORzvnEZVxsV
 pDgGN5dhqRYA8Q3BfaiVioTW0TWB+obGj8V/mibUS/z7eRMFQ6zHrQmfQem0zwbAQlk/VNgHZ
 njTi3xfuGMzOR/6/qWPX4ZQ8ZABxol0bVkD4a9WkL4dJ8Xvkgxxz8WohkIvF4rD4rBC7bV2zu
 MSlfBzNQM6FN3AUqBPD7noIqIdvSM/CcOf0iNZaNkReLs8hExiEo6F+7xRX0dyGFC5bec8jV5
 vkw3VooX1g4TXe1zRf1MqN3WAxNJFJzB0q6GlNIab7poqOphjbvrD6KEMRQ1MaTWJ13sORPtV
 /aMB7XtEKnQ9CV28Eu328DVGylbXJnVC5+TfznPEtxmHIaecJqBUaLxRIv8jPvK61aLsHOhKv
 ggmYkk04agU7/SHKfRayhxmKCfybJ1q+S81WmdTge7rmi890mbMJd0+8+Jd6a6SF31ayjgAxE
 fVHgqfmsGyx/3St/UJo6cws5i/vm4m/PZzWH4mprcn1yi0KYZWuI4GJUJmnxJ/JViAGAO3oh0
 bSCrIp6lYY3+KuGemEnCtbq/zI+OKaeurrtqztGg6QMDd65QklQIlDPE1FCsDTmH4KI9TAa
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:07
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Add fallthrough annotations to be able to compile the code without
warnings when using -Wimplicit-fallthrough in our CFLAGS. Looking
at the code, it seems like the fallthrough is indeed intended here,
so the comments should be appropriate.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Message-Id: <20200630075520.29825-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/can/can_sja1000.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index ea915a023a51..299932998a6f 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -523,6 +523,7 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
             break;
         case 16: /* RX frame information addr16-28. */
             s->status_pel |= (1 << 5); /* Set transmit status. */
+            /* fallthrough */
         case 17 ... 28:
             if (s->mode & 0x01) { /* Reset mode */
                 if (addr < 24) {
@@ -620,6 +621,7 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
             break;
         case 10:
             s->status_bas |= (1 << 5); /* Set transmit status. */
+            /* fallthrough */
         case 11 ... 19:
             if ((s->control & 0x01) == 0) { /* Operation mode */
                 s->tx_buff[addr - 10] = val; /* Store to TX buffer directly. */
-- 
2.26.2


