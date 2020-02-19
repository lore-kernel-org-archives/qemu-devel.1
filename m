Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43C4C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5DF2464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5DF2464E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MZy-00075q-Ea
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4MPw-0003jM-Hd
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4MPv-0005Yq-5Z
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:20 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:53445)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4MPg-00058H-Mq; Wed, 19 Feb 2020 05:17:06 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MgNxZ-1jf54V1bP5-00htd2; Wed, 19 Feb 2020 11:16:44 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 13/17] hw/display/qxl: Remove unneeded variable assignment
Date: Wed, 19 Feb 2020 11:16:08 +0100
Message-Id: <20200219101612.1033925-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219101612.1033925-1-laurent@vivier.eu>
References: <20200219101612.1033925-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xmLVze4fF2jn6gChYFmBkC8c3RIbPEY5H4J7Y5UtgnxBWgF54AD
 Ag+q0XW/9deubnLuPJBpDdoCAX6siUjw26WVfuE9L3m9B5PbLPCZ6zUXmhCZy6neiMYW3vw
 97AZdpCVPLOwz0axZF79dSOpgOu+iRs+yVSUpeQ+TOztIzY0JMz6SgbKCYGM1UTlLcy47gH
 Ga05RO73lqgiGlq6ez7bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D8XpsZO1UK8=:OIz4CJMjqrC+YhdCUvi4EU
 wRh1hONtNA3tWUsqmkvPhVk4IqAC2jW7SAbZxSXeTCrZyoGg9TpK8hSPa6MHGkiQDnMHv9Dkr
 to9LU0Sdza4sxyIAvx+IJYdfmuuKMZltaI7xtiOLbxjFjz3kLiB6Ly0NG3TwrJwP+c/1ziT8c
 5Ph/d8cc2Z3cffAPTIBzc29NEbn78Sjv6zFF+JfhgRG/BUTYA51OmMpAQ7xQl3VoeQWO/QcNI
 mwhG3bXAJxtGKfqPUDJKKLC8ryhlt+rrpvaEEnz8bQkw96Zvq4GnaN+vdRVYDt5kxHnwMo8Rv
 DR7f5fiov5m1NU46nH7vh8piupQNWIVlIlMhsUUon1TUKbPnBdLZTVxaHGfHZ06uqK2OnM9GO
 pu4fYTV2uHgNWljCeKCJz/x3x/q1cWRd+IWxbMPLXG+aKbg0J4Qds8szTat/34jiXN2DLKrkR
 dxbIDw9KJrFSxfOsajRByGEwqNcPzgGi4+BCgQxyzkYqj0fPAHuGMUd4Kxh8cYfyJSpuYOpGr
 WScn+8yAbtm/tgCINF4WJbw609cuMiEPYmsLSpNCEUd+zfVCu2AcgJXmb2mpnYyx+GFqrUhTy
 jT0bW5KqrpD/D8aYjcu9LQ7muGIuLi7NMEAqsdkMsbYTMpQjMr9L1hiPBksrEIJ0AWqP2lcsd
 iY1uNT0Fbr81OnsvAcElMtEMba/tCGb55F8CdzyCZXJmCfieybKUbWbDKcTXkP90xgonfoni6
 LJxU0aw7OFS75n2E7D52tlGj3jxF9vzgGZ7eQXDcQ9SGKTjDfySF6/Yi1nhBSwzg6/t8w6EqT
 nIxwqZX1SWyatARb+OFh80FtKS6YdPpQ3TPn76Mh2lbWW5Rn7Zz3WwtDIJjZmQAMlLWdWNl
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Chris Wulff <crwulff@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fix warning reported by Clang static code analyzer:

  hw/display/qxl.c:1634:14: warning: Value stored to 'orig_io_port' during its initialization is never read
      uint32_t orig_io_port = io_port;
               ^~~~~~~~~~~~   ~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200215161557.4077-3-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/display/qxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 64884da70857..21a43a1d5ec2 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1631,7 +1631,7 @@ static void ioport_write(void *opaque, hwaddr addr,
     PCIQXLDevice *d = opaque;
     uint32_t io_port = addr;
     qxl_async_io async = QXL_SYNC;
-    uint32_t orig_io_port = io_port;
+    uint32_t orig_io_port;
 
     if (d->guest_bug && io_port != QXL_IO_RESET) {
         return;
-- 
2.24.1


