Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288F6C34050
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F23C824658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F23C824658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MRg-00064y-VN
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4MPX-0003LL-Pi
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:16:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4MPV-0004sT-EG
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:16:55 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:39821)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4MPU-0004pI-UQ; Wed, 19 Feb 2020 05:16:53 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MNLVU-1ipaRu3OTC-00OrHB; Wed, 19 Feb 2020 11:16:33 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 07/17] hw/scsi/esp: Remove superfluous semicolon
Date: Wed, 19 Feb 2020 11:16:02 +0100
Message-Id: <20200219101612.1033925-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219101612.1033925-1-laurent@vivier.eu>
References: <20200219101612.1033925-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TtUMqIvOygZSymGVXMgCdx69WEZpgE/60FDyGgBnut0oG2qBKNX
 IjpJvMfk3WcIcJMX2pv73EcYhJJBxWkXQfWCpVuJ4lxgwpa71bx+RJymoAQYdgpYcsoocRB
 e5HzwrFY1TnYnKZMsCBOQD9dM8hNfWqwPygBt1VNfyaTzEM0wQCB8SnbM9MxhsumPWgUA33
 3d6YoHYAhx6AwI+W8+Unw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZOSx72c1NTU=:D8XcRDDw6YAzHMq+3s+jZ1
 O625pkQiV+N3S6T7Tfsr1mvkhioE4q9g/tp04AN2nYBGao5CnpPaIsj/S6WFcq9aJjOEC3HKw
 l6x2lg+dNbUdFn5sUUm+JC+AUndhMu/cT7XhrgJb/MHXw02ixML/3ENh92k+fovVR3WwuLN68
 EQdtLAkLtHnqG4LBaAieG/MJOcTE3g13netwq+F6mxC/AqzmakvW9PBH3qZMWRMFRGDxXvWK8
 2zgO7saXY6zP16b+TSQXhn8Omho4PJE0p/JLQTRsniVMHGMNls8btqjPU3VcP9F1XlMNSRjb4
 lKrm7l96mF2fj4TDg9mFwEWJC3WiDXXnZ+VOFrpu2hv2C0X+WTJxroxmm6szo0EpfIu03fI0U
 VmKZFkcIoHGvpc/wsXMqoU+33eiW+xBPBBjXHcgV727nIHe/sCVJwrZpbmHqAG/q1BP5IlYm/
 whlMR06Y5FxiOQJ008ZJo36edrsGTVVJG/X/SLkz6I/BY7/GnI6LElXVQUZDVQvBvjptrRbUf
 TE0f4TmFLP+cOwoBe65cg5CVs2K0uAULabKHyBrUo4fsb16McO6j7h4ApYX/VgcZW2FiCizou
 aR29g/z1SKxjhwY/Sa73hNMRTLFUVz3pOCJdzUXTuV8GGcMJ7m+uf2oMF2BFQMp1vJSMuaekB
 bLm4lGTTOpKdQ4Bx1jAVQqUkxx9GB/8h0tyP8tyFj8HeN7jYz91OUZZSuEo3wrOpu9WSE4R8Q
 azrIseUmAB9+n/odRWdoAxXEaluslyPek0wVnGWVCnNuaNcoxtlHAIqTNQRUJG8WdbgwwAbh3
 6Yvyc5c7bm64lTgTUrxVfcM+mx9AKD7v5IJ6cv14n3e5uhL7g239arj7nzFOpwXNonY+6l3
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Chris Wulff <crwulff@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fixes: 74d71ea16bc
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20200218094402.26625-8-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f8fc30cccbd4..405f8b7cbcf7 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -293,7 +293,7 @@ static void handle_satn_stop(ESPState *s)
         s->dma_cb = handle_satn_stop;
         return;
     }
-    s->pdma_cb = satn_stop_pdma_cb;;
+    s->pdma_cb = satn_stop_pdma_cb;
     s->cmdlen = get_cmd(s, s->cmdbuf, sizeof(s->cmdbuf));
     if (s->cmdlen) {
         trace_esp_handle_satn_stop(s->cmdlen);
-- 
2.24.1


