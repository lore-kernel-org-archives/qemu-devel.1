Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35E8C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4493D214F1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4493D214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGoqK-0006EZ-97
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGonq-0002gS-44; Fri, 11 Sep 2020 15:33:46 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:35715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kGono-0000oV-Gx; Fri, 11 Sep 2020 15:33:45 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MLRgp-1jyKLM0plL-00ISSv; Fri, 11 Sep 2020 21:33:35 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/18] hw/mips/fuloong2e: Convert pointless error message to an
 assert()
Date: Fri, 11 Sep 2020 21:33:13 +0200
Message-Id: <20200911193330.1148942-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
References: <20200911193330.1148942-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:W6d0M8xiDFfJGbyVtJHHG7N7kNRbKGLWK4jJG48cK3TzhzDMdia
 IVRiUrQ5TRdaCsCYLGPJa+bJe0hP63R3jyLnpGn14uNeFtQk5bDsYITACheJjl6VN40yzVr
 HuIaSg1YBkH+3F8o659PoPgVSI9edT4qdzzvFYOeT9k4IUB+KNCv3qbD0VNcfN9q62B1SGo
 LRVO5giEnv9pdFegavjZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1liJtNPbD+A=:yDw3vphphqB8zWAli9r/3z
 wKVRpHPWodn94qiIE2Gdxi00rRXVKhZ2mbl8MsBzQFf5+j86C8vyuep6jhMbrYYnQPxNQ/trN
 asBGTDzVMBdFnQBNHoZKwlawyB78Wk0O4ded82/tTv4GiLH78DOl31kmE75tDcIOkXZFYrDYV
 0VgDLjev3tIyixyPZlAIFzrZYnYDq0oJ3wUz0quGd1pA9ViwBBpGmdr4bwxuTgemxleUA97R2
 1ZBoVhiCjFiEJ7kIaXm/lUqXvkoGhkK6Y5iuQlrJvDyAsR64i0JyC8O3XYx5+e8yqfn/tE8OT
 eVT0DLisnvXo9ue/86rOtlSNmCtahTWCpia57o2OMZFnwKirpjyAJJG3jfpgilsVgdFXjDi1L
 A2GM1bdjSzaD4uCU2mqXPwbmf/gk0EJvb1itns1QHF+sdu/h+aVtAriCByVoHNWm/m5qVH6b/
 AUdr6XxXo/loZDbeIg2wnFwRGuZbCSJzU5gxAVkTQj60w6kAiqvJtf9e/823qD49XCA9pmtkO
 ZWmPSLlMb/qtXwLAHtz2JthRgSC3s988qkR25hceYEm+tPmGfGuOFiPEMlXDa6fqgMaIeLOKF
 6g7WUGI5i+fThANYco3+504Nw8e5rWxocEl9MyCpmgG7T2Hm5gieLr+vNTue75s88PzWnhKC2
 bprTsnKzsNQ85jcLIdlyIeq8WYkvN75KYzs7AqBiMs9+Ha+LapBEeeNd9o078nZLgyts+kgm6
 yH87G2LGUxhH2u+x267ahSSMl48iBwZjfBS97EedlyyRBhv0tnLkaLv2TNSrl8+RmaO7inKIu
 +SMe1CbVVpd3qSS6S94Tv4Pjki9nII0lmua4qSm2IjjfyEj4H4pe36qvFeBX6HIm0nVYuf1
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 15:33:43
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
Cc: qemu-trivial@nongnu.org, Huacai Chen <chenhc@lemote.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Displaying "vt82c686b_init error" doesn't give any hint about why
this call failed. As this message targets developers and not users,
replace the pointless error message by a call to assert() which
will provide more useful information.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Huacai Chen <chenhc@lemote.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200901104043.91383-3-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/mips/fuloong2e.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 8ca31e5162c4..f28609976bf4 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -240,10 +240,7 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
     PCIDevice *dev;
 
     isa_bus = vt82c686b_isa_init(pci_bus, PCI_DEVFN(slot, 0));
-    if (!isa_bus) {
-        fprintf(stderr, "vt82c686b_init error\n");
-        exit(1);
-    }
+    assert(isa_bus);
     *p_isa_bus = isa_bus;
     /* Interrupt controller */
     /* The 8259 -> IP5  */
-- 
2.26.2


