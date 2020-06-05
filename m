Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2380C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 969FE20659
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969FE20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAx4-0008Lj-S8
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoo-0008PT-RJ
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:26 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAon-0006mt-Rp
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:26 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MadC8-1j5NE316hG-00c5UL; Fri, 05 Jun 2020 13:47:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 14/19] exec: Assert CPU migration is not used on user-only build
Date: Fri,  5 Jun 2020 13:46:55 +0200
Message-Id: <20200605114700.1052050-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VrTqMWubQsnZzaCalmzqi/8tWUxzEeChJ88aV28Bmryu8UD1IEt
 6NLRMZP0XifqQboRqdz58fOUPJ/SEfSaW7FlPsTfaawp38sKvneqDCv6y1Q9JzjWrGuvOja
 CMyS/692yoFBrxyGn9wjHNKxb6lyOXWlsP5ek2fCvTcvVlffYp+S335bzBkz26GuFevlKpR
 oK6nZrGuNSPDQxSSgvQcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6zSDkmd6TR0=:hCwsosLIEsNMDOPlPmrNj9
 t0QrJ3W3UONvuau15X5GsokmbxExyzoDVJ/K1fzLJcRJIst6OCxSJh66IGAWeuz9crYymCUdt
 iRSsrExSs9JpxSGFGo/WxvFGaLxQPYVWFAqdu4o5OCwLiRkXwufE9oh3VoaCiKNuPRJaNKRvJ
 uoUO5/7dE6g2UzcqGwl8iBpfyomdgUNP2VljulYF0NF/r36lhnfrIN+CqGv8JXLl6eNtwpSha
 0lugtZ+GwGtKWwFgdyR+gGlrrxIl/ZUUgDkEkeJK4aRZ07+CgkWLGmw6IFFTX8iA1fVTi5Jsc
 j0G10J1/6kvhtga5ROEaFOOdPLcfE0DJny+hSTcub05IUIjUx+a+t0qmox6k/6Oyzc9dsVuFv
 MZy42UIpIh0nmrTnOQ+5heegA9Z7GMhYs0NEaRKRzE/grS5PMvZOeYG+JfXvW255krYcDoLcs
 hLFyMjqLpUEklcn+bMp17t+m7Vk8+X5PWMsRV7Ds49G+bwPunR2Qqm8QrebY+7yQlaQAqnkk8
 BbrumSN0twP9xMFfFRvnJ+cxIs/TCrzwwhRvj+U4nkNdI1Tp2F25duAtI1l+KRaBxH0UunC4u
 P3YNPc7KeBpoq0ZH99+7vsTVtWVLVzwmCPx6SCOmcWHu6kb3kx8ZveiMHy6kzHiv2GN34RtIh
 q9JxpG8NAXl6NTRkXXVavGSqOe/7SLuun5z+5oYVxWTjlVOQJIp0WwvPr15GAW0Vf3H+rheP5
 JmCG709HYUP7WSAtNKnOfI9i8bTillubtdiooIKJbgAeWAErAl5iUsL8tXkVvb6HbDQ1B+7q5
 yp4GxQ1vDyl3cJ2XRVnY4pVhTUGlt7/JO9PQJZ3ButJFq/YZqkX+TER8hEDvyIVDy9ZGfeR
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:47:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200522172510.25784-9-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 exec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 5162f0d12f99..6dfd314469de 100644
--- a/exec.c
+++ b/exec.c
@@ -946,7 +946,9 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
 
     qemu_plugin_vcpu_init_hook(cpu);
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_USER_ONLY
+    assert(cc->vmsd == NULL);
+#else /* !CONFIG_USER_ONLY */
     if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
         vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
     }
-- 
2.26.2


