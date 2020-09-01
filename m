Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA06C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F65206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F65206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD76i-0004Km-ST
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zI-0005Kk-DY; Tue, 01 Sep 2020 10:10:16 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zC-0003kH-Ej; Tue, 01 Sep 2020 10:10:15 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MF39M-1kO8Wa3wcq-00FPlt; Tue, 01 Sep 2020 16:10:05 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 11/44] hw/i386/kvm/ioapic.c: fix typo in error message
Date: Tue,  1 Sep 2020 16:09:21 +0200
Message-Id: <20200901140954.889743-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8zzF2KBG2U8YkswJX4xybFx0/NJ8yL9YrgzOOzQ6QIWlM//DCjD
 YhJRN20gS/SmybesOw3JPHnJ2hp4c/QL+aUDoP7jrHJV/1gCT77+dFfYdLtOyCUqs2QPsEY
 IARA2i/1ZSzgU4zckYrulNgAfBKO/Ot3Uvj8ZqRumBjXwYjmFS9ycIC8yplkNCB+2WmKoEP
 5XmEjeQ/vq1HePDrQN/Fg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mNv9wNw5Zps=:8zz29vuzW58qf+YH7/w7IT
 aZ4REfq5OnRcYGd4dSN/MCuYyQ/QGQtqPk3iM+kbLHL7pZxQr8jJOOoAqTtzelTwtg+lwmAkX
 dw3S1z0dUKLYIGPFPnezd/cQwhhyBrCQgzYmGoQC5xzJpGLY3MBOX5Ui4CJkpXMkX5XOCHUFC
 ChL73jk+FErtcfEmRsnD19aZsg+LHjfWoLSVkBo767HbjU6oLshmhmxjgiEGy9tPJHbyABs/7
 O7h7ULQjuwSjpcDcOnVcCtyK3fWBhwS0lkLvJCKubExu5Fw7+Ee4gJdvLn9+HAZ+H72p3R0Ds
 czTzfzc9BFc483HOxqw8Yqu8ss4fu4UyyOtpZLfmQQ0iSl91n0M29eDPWwS6fGsMFACZiK7QR
 CzqK/Y7mrmrEKrw7C9+5e1grWrbBOXQvsSJyth6+X+9taMnmPKn0Cg08eLqi568ji+xQrq66L
 SqZNgZl4DYwh1JL5wSaJII4BRAp5jZseD1VcdGq0KT4pmrpJfEdIQ2U9uT8nU320dCpghmEi1
 Cl239yNndcDUHS0p8xw9lWFX6eG3rIoXu/MIW3lqpNXWemyiDlwogF4jkmAmQ93nv2HIC21aN
 vEF2BeMTupGBdquQgdJqzJ1yxp+6wEe8GccAmpiIdmpQWaWEvV9HIauNjviNO3e5zwANncAJG
 Fpzpgv1MLg5fDWA/cHU0OXENxfqEegY0bjlK0vCh6ZrxgrorMteAwIGkBWXmTZS/TF5Xidd2y
 iSYmghZ8nZXayxR2mEaJcAWfFucDJ3/BkNyyqPxi5K/+eAJ+NxslkMn1C1pgslQeXWg8LU7tw
 3tmEVHD1WrrUfPXT7EtudnRr9YSttZAWKPyiBF3Y4qr8YahDTQCpu6EbUnFwG5VFTfReVNm
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: qemu-trivial@nongnu.org, Li Qiang <liq3ea@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Kenta Ishiguro <kentaishiguro@slowstart.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kenta Ishiguro <kentaishiguro@slowstart.org>

Fix a typo in an error message for KVM_SET_IRQCHIP ioctl:
"KVM_GET_IRQCHIP" should be "KVM_SET_IRQCHIP".

Fixes: a39c1d47ac ("kvm: x86: Add user space part for in-kernel IOAPIC")
Signed-off-by: Kenta Ishiguro <kentaishiguro@slowstart.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <20200717123514.15406-1-kentaishiguro@slowstart.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/i386/kvm/ioapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 4ba8e472510d..c5528df942a2 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -97,7 +97,7 @@ static void kvm_ioapic_put(IOAPICCommonState *s)
 
     ret = kvm_vm_ioctl(kvm_state, KVM_SET_IRQCHIP, &chip);
     if (ret < 0) {
-        fprintf(stderr, "KVM_GET_IRQCHIP failed: %s\n", strerror(ret));
+        fprintf(stderr, "KVM_SET_IRQCHIP failed: %s\n", strerror(ret));
         abort();
     }
 }
-- 
2.26.2


