Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543A3C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D2220797
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 07:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D2220797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSEM0-0001jp-Jr
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 03:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBk-0005Qw-Pk; Tue, 13 Oct 2020 02:53:36 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:33213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSEBi-0000HT-UD; Tue, 13 Oct 2020 02:53:36 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MuluN-1kAyFa3K6N-00rlgu; Tue, 13 Oct 2020 08:53:26 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 11/15] hw/char/serial: remove duplicate .class_init in
 serial_mm_info
Date: Tue, 13 Oct 2020 08:53:09 +0200
Message-Id: <20201013065313.7349-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013065313.7349-1-laurent@vivier.eu>
References: <20201013065313.7349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:deymScBIsP96b62FQfdXR1P7S5QpWc0kXxsLUrNgcoVURcCuhgW
 QZcCBcCUfxK87jYYig7ML25m288gbs5vU30Un09qjtjp+LXpsABqXoAwdd/5prMqOQAyg0r
 uBDFkbop1de+nHHPfVGXq1KLwpdhBo2qeJpXTk1Bt2BohBV7r6UnW0y7Hje7lwc0kR7Pvdu
 yPiY2eIpt5tt9qq3DktFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B9Yf8OzXxs0=:CSSa6tG/hv5vkn62pYBCyO
 DVgaaTxUdi/wrjQxdGg8tbv/5UDt9mycqYG9oHyyttrrAvTtiE68JZMrVnmJ2PQCcpWFJNEH6
 OcaazVL4eAW7Y/EhKuzrVSQzA8lswrnnt0scFxO+SyfGX6DlBGgTfRiR0pOXYxiLpsgeBIlMs
 D2xGfo0OuTyWrXHT54o0EMnUZkOJODp0Nq8AI3ozsk30Q+cNe5YZQ93OrLUQMooFQ0iF2354b
 GZ3DmCVJsTMdwOiJeC8Myuzzr5P5z7nzer18PL8lo6BdksYPPEOR1z6namhT3Ulc1XhCF9hMs
 rCgbZWbB2cuZtmmBOC2vw5rlDQmeYbYcAawuWJbZHIRNZUUU3aoWd6AI8hWzoMZX8NP3Ja8EQ
 etZntlRY6ziiMvM/XnOV/2xJiTUP7HUVljspjch39kzKfIk82ByE/6fERXVEeBsodJ37+uUTY
 AvpmIa6FwkFM9j2fLhoWKauXitesvo1lyRUPcR8YNTk7QygQ6cxNGAKZsMb7C8xvXJd1OXH4U
 4Ooxu5aN2k1JOMA25S+3+WxhYv7yDWhf6uHpWcOyh1ZDeZLVVI5hAnQHiOjQKnUEE3PuNTFWo
 jfE3pHIzrjA74dg5I78OHSgxxkMmLZjKDrtyPpEyiDvhWUqAQZYbh3B6i2ybTdCGKId59sAnR
 D4WA+fS6goKbjs1R08JyMwz+19/NVmCUpjp7G+X/ysQMz8g+sRRC8AP3aVVtPoBmx3dxux12r
 tGcK5jfgSG+wMvJxs5ogp42a2zUBin3nz4nwMINBZ0Rva28r3i2D1UVE6dUwxe+f038JMs/Qy
 dXOKORuZ0KgrpgW7F1DjMAN7INefjfXG5ImUGQkI53P0TRtHTPZXKvC4BIKPBvi7LqJ2aCj
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
 Michael Tokarev <mjt@tls.msk.ru>, Li Qiang <liq3ea@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Laurent Vivier <lvivier@redhat.com>

.class_init is already set to serial_mm_class_init.

Remove the duplicate entry.

Fixes: 17fd1a6490b1 ("serial-mm: add "regshift" property")
Cc: marcandre.lureau@redhat.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20201009113843.60995-1-lvivier@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/char/serial.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 4386adabd466..97f71879ff2a 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1120,7 +1120,6 @@ static const TypeInfo serial_mm_info = {
     .class_init = serial_mm_class_init,
     .instance_init = serial_mm_instance_init,
     .instance_size = sizeof(SerialMM),
-    .class_init = serial_mm_class_init,
 };
 
 static void serial_register_types(void)
-- 
2.26.2


