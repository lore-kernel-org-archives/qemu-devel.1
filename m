Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEBFC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269B420727
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269B420727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKQR-0001Sr-Ab
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK3K-0000zR-Nf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK3H-0008Np-AH
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:44 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57057)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK3H-0008M0-1F; Mon, 09 Mar 2020 11:10:43 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MwQKp-1jSA6N3Q1t-00sMOB; Mon, 09 Mar 2020 16:09:59 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 32/33] display/exynos4210_fimd: Remove redundant statement in
 exynos4210_fimd_update()
Date: Mon,  9 Mar 2020 16:08:36 +0100
Message-Id: <20200309150837.3193387-33-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vnjbFk+4XeEO6Y7jzUGToROLl3IXCk9V3Q5V/w1bgIDJkoBbJUq
 Rt0UUGtbZQ9WFlsz9dJscI+gw//SWSi9MfbBkqjjXKYpyN0yeYDgQa0RXsS1YWnRVRctQHr
 8Zoo+VCnvsd8plirugAetWJF6BpPX+FDPAB0sPsKc7ItAAdMWEb/R/RHixvLLe3SoAedMN3
 5trKziwslXaWxH1wEVdZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PVN/VKUgigo=:FhbXvK/Xvtl+yIGhXW2hn/
 P2HCxe6JY1samg9teh4w1/0xqyRec41DWzYWFe/K4ij3wWtUBemc0JfvtHYVGPuWYlT48H3Vi
 8qNNchT3iOWYHS6BnXTZcLysjs5cvKjmQPfNt143SaG5CLPhAmf52SLT26YUxrfjWNiGOJuVx
 k1skcHA4l8jTUcZNgR1v9TCm+uwDlkjYZM3Z6gIrzFTeCsI4+8iI6WKibm9VfGXX1wokHZxkS
 CBp6avvIci1O7W5063i84wbe9ZNgFswO3vtGBm3sUox12292pJglT4kDnjZIoIbsyDP94brSf
 LcqZKKwyiRnezy6O0G9fgA8iqR5OdZHgpPR2ab0aHJ+e+1IqqWkXNVHKD79MiV/SUjJo7Jx5F
 vMUccIiHeFx+tMAA/49HUev95X5LO3xjpvxkfNyLms5GsLse4kckQ/fsVwQS7X9HJ8YqO5BYl
 WbWQpJU9ChtZU0G7UZDfKexxFIDKkxavPEQgHhvH8vgntSm3J+NiTkqGPEeJCn0GDi8q2qCW7
 ysrMJQUdYhH+k2evorDPHrs8qH6wMdKPDaPwHKw8fR7EAaUY7BGcIvwFVO9hyuY5zASkddG0+
 p67nOAEI0/aeqo2qkQqCPA022zwKQjWojO5CEmi0MQOURQG/QMcZUSq/1eyzQ/sgjUEm8/5AV
 XMBwZ0SwuWYAzD3qIjp43D1bz35Fd2HPJw8SGlEC/6OHyscKZ3iZIWM14a+p/fKNbyq2Ls5+J
 YVvARaG6BkQmE/Jm93qb+TUk6nrdjJV+31bIIXw8AD09Tx/AaSdizSp997Bg/HBol6/3QgEMF
 YJYWBL1UGqfMZVVfEGqfx4CS0OulIbE2TPRBvOmcrVPppAO6KbEDTl/YjdA6XfDe9taftKo
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Euler Robot <euler.robot@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Clang static code analyzer show warning:
hw/display/exynos4210_fimd.c:1313:17: warning: Value stored to 'is_dirty' is never read
                is_dirty = false;

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200302130715.29440-9-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/display/exynos4210_fimd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index ec6776680e41..1c0266ce9f2d 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1311,7 +1311,6 @@ static void exynos4210_fimd_update(void *opaque)
                 }
                 host_fb_addr += inc_size;
                 fb_line_addr += inc_size;
-                is_dirty = false;
             }
             g_free(snap);
             blend = true;
-- 
2.24.1


