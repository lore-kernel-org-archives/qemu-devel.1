Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B514BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8687B206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8687B206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0YW-000531-N9
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Ur-0007lP-9U; Wed, 10 Jun 2020 09:10:25 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43219)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Up-0003cU-68; Wed, 10 Jun 2020 09:10:24 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MZkxj-1jOsnc1wZT-00WoKz; Wed, 10 Jun 2020 15:10:19 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/16] hw/hppa/dino: Use the IEC binary prefix definitions
Date: Wed, 10 Jun 2020 15:10:04 +0200
Message-Id: <20200610131011.1941209-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZJcuuVvZMn4vd9WaxvKpzIGlpcH+8rkPeaVxzY+wL56wQ5SnrCV
 8nsiZ9XpxJWmulsBA6wbojcB0wLerOd2JYBRjvBsolUqcExn5b+u+rGKTG2ut+84W4vqARR
 wvrMVnIj8D4x+VvmdgCqkklPQ0GlVC5dKAQzkgFWJjAjG1vM4HXRY+o4+Ns9ikDrzttMjTa
 RVpKQ1+vcYat/GTfClYeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JS5sxbSkzn4=:hw/NgN8XCkcbu9zBQ39147
 Of+PRjGZZRJju14sMc59M8qd91EtnE8n9o+asBzRl+/VoM849ivnQk79V3OQ4Uvn0928rOYqc
 S8pi15XRpu30aZEQMLePw2niARh8zUoe3jZH+dSIJm/W/eurwXP0gwQIyiBYubl6w01ngRr8B
 Eq2jYHTHaaXaKumC4t9qO1kfH5nRFTZ4nWw92rxBfk96uKE3UmfaQsGS2iPLCaRbJSELV5o8M
 5kAJ//Xwv6vnK8Ip242X4jxJgBBw4dLhU+a4hLfUyvYPNRwrUehcKijKERXkmk5x/X4/qeAvf
 O/gdCIOOJsrlF2sqImje+lfbP/Hjl31J7QgXqmfX3JEKKrPlL+L/9LUebKdvynTwK7WalKQ5l
 Em1QQNzvSZOFNptCjpU6h0btgnnShTQlxjMKpfmYrG+dwD4K3s2JdZL+huCLCF9fWoGiEl+gq
 v8GQiM/UY5kxp/uMtzlsfarFM+ijvJ1/vYhM3kgjJ5x9NZjvYlgG95pUW9XXDGyjOhh7XQU8p
 oyjZiQZeFQ8CKjINl/P/JD4syFlr8qFhxpmEJVKJ9EXkkFNVH22t5bfuUxmAcL6gso9gr5dDb
 4zC0a68Mh+u+sFx9UNt2GIiFLqObRjeeXoHaltqW4hDfspb+EuZ+6xjqlpbbg7nSd3+QGrMCI
 AE1BMKtVQ8TiUAL8Fj+xhhb1Vvfuya9gS4JSRRSO8Cb/ZCXNi84QAMwZzq9RL1zxQUnBjltIm
 Ud8QtgLJxcDs3SRaqOj8+hzcQ2llifdQiQzQkdk1WriYHvziLR1dvifPKIJBFyrrcRlwU7OMH
 E7SYUM+Mf6CZJ6rJezubFhaSWHXU2maZSw4IugAGKlRjeVtjkUFEh3qY7ZDEyhIoq5VeMkQ
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 09:10:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

IEC binary prefixes ease code review: the unit is explicit.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200601142930.29408-7-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/hppa/dino.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 2b1b38c58abc..7290f23962ce 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -542,7 +542,7 @@ PCIBus *dino_init(MemoryRegion *addr_space,
                                 &s->parent_obj.data_mem);
 
     /* Dino PCI bus memory.  */
-    memory_region_init(&s->pci_mem, OBJECT(s), "pci-memory", 1ull << 32);
+    memory_region_init(&s->pci_mem, OBJECT(s), "pci-memory", 4 * GiB);
 
     b = pci_register_root_bus(dev, "pci", dino_set_irq, dino_pci_map_irq, s,
                               &s->pci_mem, get_system_io(),
@@ -561,7 +561,7 @@ PCIBus *dino_init(MemoryRegion *addr_space,
     }
 
     /* Set up PCI view of memory: Bus master address space.  */
-    memory_region_init(&s->bm, OBJECT(s), "bm-dino", 1ull << 32);
+    memory_region_init(&s->bm, OBJECT(s), "bm-dino", 4 * GiB);
     memory_region_init_alias(&s->bm_ram_alias, OBJECT(s),
                              "bm-system", addr_space, 0,
                              0xf0000000 + DINO_MEM_CHUNK_SIZE);
-- 
2.26.2


