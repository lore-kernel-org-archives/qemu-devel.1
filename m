Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF72BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AED206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AED206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD73O-0005sJ-Jb
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zH-0005HP-5K; Tue, 01 Sep 2020 10:10:15 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zD-0003l6-Mw; Tue, 01 Sep 2020 10:10:14 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M7auL-1kETUO2Mij-0081Fw; Tue, 01 Sep 2020 16:10:05 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 12/44] hw/isa/isa-superio: Fix IDE controller realization
Date: Tue,  1 Sep 2020 16:09:22 +0200
Message-Id: <20200901140954.889743-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xbZu9qGgfijSoHkTjzR/3GFFaiU2ozU8OfWqHkB/F82rpNxfY3r
 8btq3ZvjhH58kl0ahDfKx/7gF9mv5RwFxXe5vAIMrC9wvvP1Rxpg3M+avnBfQ3sHNvhUmBH
 ynrydryGHd4HpsrIdkTGAN/HHEz3UZ8wS9x+gqEtesVVZfR02oMpsRHsBsOdaijJikq37FY
 3mZToT7lDRqBJPfTiR/mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3+WNcWVgOzk=:bzePoUoElpVzHn3vxvadwl
 bJ46a7KYnhU/F8nek9T/W1JfdIqp4IVt8/XOUrtfIPtgD2U4HnInfAXHAa6n2B+j2BuPiZ64X
 5daLrV6igaJvZ/rLAYqSx4/w0HqV/JarxNec0Vk48RnejktzXXuqAYWWWhB4BL8vONu3kHGcc
 jY5HBTeOHzRiwQrKXCnonoJlXkvM0In02ZwhwE3QihMBxz/G9hMVAHoHUrm87UCKPmtNC3zT8
 zGLO6jSIcMHOQQdQjM+G/tCMO+3D2vCk7YUNq7nun9Dc9GR065P5fndHgB8srypKQ6tnk63Bz
 NM5GWXvMNicljm9aad2wVIz1Zz8yzJ94t7ewQ4r472y5xYP4vIWpudskg5uM5DP0xi4oHTzIB
 uhmwMpKJL7BDlxWO2ZPY1FYmjkhoBp/EdlIST5d9x6GNQFQ5O8Hj4grHJBQSPBP0kT83Q4sTn
 JJYpyOLbVBPtS/TTJjJtR/qWbdmAmxaddGKrn8BSLilv67gjGjlO28oTh31KRxRtEnf19Rquj
 YvsIxgkhuAzEdf/cknB49KHmIyCT+AtSS+4aJ08hSZ+gPU9YjDFBKWrIX84fSCxs5hIiTGdsP
 BPElEqye59YY5a2fhLno07gXhpF0RkZrlosJybRBAWy08fhEiZs/p5EAYWZ+O87xpFz2o/lIj
 OOyN2H1Q6YBCJHmnkYe9UGK4AHAllq3rrD122yBNxl9AtcQknvAKILIFs99yBmG3kqkH4W4+v
 jHPvL8XazWVk2VMhux84PLEVzSRvMAuqXHBUqseusUZAyqlc+rtJE8y8lqqWxjEqheIN8/+Je
 HEM56Cr5hNn0byzP5l9vvvX3UpC9swrgUVFjegq+Yx2Wb8+0XdcgJ+EGT6UmHAW4+NPG2gG
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:10
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
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

When realizing a Super I/O with IDE controller [*], we get:

  qom/object.c:1684: object_property_try_add_child: Assertion `!child->parent' failed.
  Aborted (core dumped)

This is because the device is already realized when we try to
add the QOM property to the parent. Fix by realizing *after*
adding the QOM relationship.

[*] Set ISASuperIOClass::ide.count = N with N not zero
    (no such thing currently exists; the bug is latent)

Fixes: e508430619 ("hw/isa/superio: Make the components QOM children")
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200721124516.9602-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/isa/isa-superio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index e2e47d8fd99a..179c1856956b 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -158,8 +158,8 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
         if (k->ide.get_irq) {
             qdev_prop_set_uint32(d, "irq", k->ide.get_irq(sio, 0));
         }
-        isa_realize_and_unref(isa, bus, &error_fatal);
         object_property_add_child(OBJECT(sio), "isa-ide", OBJECT(isa));
+        isa_realize_and_unref(isa, bus, &error_fatal);
         sio->ide = isa;
         trace_superio_create_ide(0,
                                  k->ide.get_iobase ?
-- 
2.26.2


