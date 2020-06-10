Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9B9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:23:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED7B2072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED7B2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0hn-0001Wz-EI
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Uy-00081B-QI; Wed, 10 Jun 2020 09:10:32 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:56849)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Ux-0003iZ-GY; Wed, 10 Jun 2020 09:10:32 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N5mOZ-1iqdNM3MqZ-017G53; Wed, 10 Jun 2020 15:10:24 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 15/16] hw/openrisc/openrisc_sim: Add assertion to silence
 GCC warning
Date: Wed, 10 Jun 2020 15:10:10 +0200
Message-Id: <20200610131011.1941209-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8hggNOYDOPfXdValh0/LtwKsrJvnZ4EGWVtbAUwp4s8OL/Fywjr
 XM8ycjFTSCPGAN2lT70Si/9ZKlNzKz4q/t6UAuSq8IoixVgFpI9l3zb6Yv9nxbTdu7T4cw9
 /QZ1kAQqEZfpoOKWn01BZtV70gNxTqFmEySF5H27YRkrwHpsP+mRxvZNVJrXZMiZtsk4SxM
 INW3G9NIAo32IrI1A2ngw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZQZSn2q+FiE=:utUpGYNOY2gkjdSNwg1Qdr
 SuHTxbDfUhNJeHTex7w5KiKoeXtrpaPqRVRZxxYoqK+CR8u0z6oBT5s8HuuwpL7Q8LUb6sVun
 yb3JTSV3ixfDOLK2slgywpc4e9A1tPCd5uZk4Ht/WE7FqZLlyqtfZWDVOeY8vpogUciuTk7v8
 Wyl67YSXn2k3WxM2A8ejAHGyhsSR5kXnHWLADJ5IsifLok4RX8LHC8onEvFUqxaUxh777UmIj
 HcAshB5/pfmTKejbNJmuQPSwPEyaXW0VnfZnO7MvHubSvZAIbsaLTjzL77xx5Qpr/DDgu5e62
 29O6pLA2RNzpm7ryrA/M1WeVFoVxXMZYffHXSznimV8LjI4kfg2d3M2X1P+3ehMtbWP6SiaW1
 A38ePOtiKNCNPT5RMsczmXftCkYndT0oGoFlNLyLOsSDomjDvjXBLrswwwbfLSIwhkttN/I4W
 YSHFocH4FCyYnnJbSH1Ie9EYhW3qJ3emBbY/pibenvOadoiq5qLjxFbdV50ML/1VXuj4vjwG6
 SSxBmNaH6I6QgXdx12+IsNlmqgk3xXK1Yl8ev9OJL2W/3W2LS6jYZPJ40njrQIPT9+fZwLKJm
 SRX/xLKfpdH+RiW0juQmdyLCg4AMDa8TG3JwopX/76KKZ+NYNY24DU47SbD8OoopC+zrx/lrC
 R+rhM4+Xso7/tS7w70Y24poBpfks/gCILThahOZdEk/50OCQJpqqA6sHUPTFy0hu2qgsoI5la
 fT1Ou/xEV521eoAxXP/3FvgXPd5JzCt7fa6FtcWpFei2fMR4iLOTb7PRVunH6IaFEqS5nn3SL
 EkCvG2eciz2EfVaNkyfzeM4eDpHMcFu0Qu4npbjWfiOb+BCJ84XOmQfy3D1jhzdSsjC1CgV
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 08:14:00
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-trivial@nongnu.org, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Stafford Horne <shorne@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

When compiling with GCC 10 (Fedora 32) using CFLAGS=-O2 we get:

    CC      or1k-softmmu/hw/openrisc/openrisc_sim.o
  hw/openrisc/openrisc_sim.c: In function ‘openrisc_sim_init’:
  hw/openrisc/openrisc_sim.c:87:42: error: ‘cpu_irqs[0]’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
     87 |         sysbus_connect_irq(s, i, cpu_irqs[i][irq_pin]);
        |                                  ~~~~~~~~^~~

While humans can tell smp_cpus will always be in the [1, 2] range,
(openrisc_sim_machine_init sets mc->max_cpus = 2), the compiler
can't.

Add an assertion to give the compiler a hint there's no use of
uninitialized data.

Buglink: https://bugs.launchpad.net/qemu/+bug/1874073
Reported-by: Martin Liška <mliska@suse.cz>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Stafford Horne <shorne@gmail.com>
Message-Id: <20200608160611.16966-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/openrisc/openrisc_sim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index d08ce6181199..02f5259e5e33 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -134,6 +134,7 @@ static void openrisc_sim_init(MachineState *machine)
     int n;
     unsigned int smp_cpus = machine->smp.cpus;
 
+    assert(smp_cpus >= 1 && smp_cpus <= 2);
     for (n = 0; n < smp_cpus; n++) {
         cpu = OPENRISC_CPU(cpu_create(machine->cpu_type));
         if (cpu == NULL) {
-- 
2.26.2


