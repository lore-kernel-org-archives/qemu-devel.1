Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C795C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1192221D7E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1192221D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBK6z-0006tn-6W
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK2L-0007Tk-Va
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK2K-0007bX-Gp
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:45 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57699)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK2B-0007Up-0b; Mon, 09 Mar 2020 11:09:35 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MD9Kp-1j2piJ2lxh-009AEZ; Mon, 09 Mar 2020 16:08:54 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 05/33] hw/net/e1000: Add readops/writeops typedefs
Date: Mon,  9 Mar 2020 16:08:09 +0100
Message-Id: <20200309150837.3193387-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Qt3XGoPWrOD3BOImoMd7HNggjubM61z0oqiZ7LhCP7pIMl1lmam
 W+B1pBUpHxxgKYc+QeT9fJZVePjB1nbc/cyBXufeZCuGjvXvRhh/ztiE9SBPBBXtg0/tYh+
 sJqtkyt4p/cNboE5VGPxDBeVTwkUVEDnqK0DknnOLbRmUDIpn+dMSshEsInbamEv8d4LGdL
 8hd2cVZpto4DRzEPSi/LA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+H0uxhaaPt8=:tGeZfvwQVmF9M2qjfCs55R
 N4nHzotQRiMkvedJMn9gcLNCjzxesAogaqO+zFpPsZovO6nCQt3jA2XTIIYHoRMHzb1eFii6G
 ZZKmqmUtWc+73UZ/0O5HgC0tdsejeUdkh2zwDw4OUBQrXWVnuW1QEW2RmYcCfPZhdmc8gunSE
 r5MAKEeFGdIi1Y46YULAXz69LmdwPqYdfYHiLVux36mSVJPzfO2iExTP+xy555AVYsabIl+kh
 YG+GKp1i9yeaikyWFcSOSTkpnYAC7XTmBGOSo+luqWaMIttV+kS51tU4Em1daZPQxgAKqTfj/
 aRC90uRg7vTvP0oG0bo/Mwc+KW3zMgd4FqhjArhzyu+O9sy2pp41cQYy19wWXf4ZxCSvdiuBF
 Y/5rBjJSEyplUDA/ZrWImL+UcofvE9r0VvkWEHIR7P8ki2p/y7gJBPMnnKIeoKpO4wFo+XNcz
 G+lVsywOfUjj5zoh20uoBZNp1ZCA8yJkLKqjcU4lOYkJxMdeoBIv3jItUKfnHgPWomPNLpw+Y
 sakx+4YTrXZ3ceOaOSPz7e+qdqc8hjbi0tuApftEkBNvMIm4FhkjslPzI+5aQFeFwrlsKTwBa
 USEVUIK8yuvW+EdpCIrigUhNgPopuIO0A/5dnnceWxSMRcgvrMoVDEwWPeWaPsGyqa5pgGpUI
 AuyVfNCXC9r2FghE4v3x3Ihs3Ng+J1W+v2Pj2dQ6nFqPBDsaMbNeH7CdfdGTcwMHVoQ+QFKnK
 5t0KZA5atoLd2C1kkvixoHpxZJUUtsXzzuowV1IXVXTYqGOZfQ9zNJisxWkSHeLHivqov/hGV
 GIrAxd55koq74hE+Ylc/IfFSo4snzb/nBfP1U5QJmCSxvjsFZazVIFn34qXiUynf+nOYOD2
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
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
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Express the macreg[] arrays using typedefs.
No logical changes introduced here.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200305010446.17029-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/e1000.c       | 6 ++++--
 hw/net/e1000e_core.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 0b833d5a152e..972d9b508399 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1150,7 +1150,8 @@ set_ims(E1000State *s, int index, uint32_t val)
 }
 
 #define getreg(x)    [x] = mac_readreg
-static uint32_t (*macreg_readops[])(E1000State *, int) = {
+typedef uint32_t (*readops)(E1000State *, int);
+static readops macreg_readops[] = {
     getreg(PBA),      getreg(RCTL),     getreg(TDH),      getreg(TXDCTL),
     getreg(WUFC),     getreg(TDT),      getreg(CTRL),     getreg(LEDCTL),
     getreg(MANC),     getreg(MDIC),     getreg(SWSM),     getreg(STATUS),
@@ -1205,7 +1206,8 @@ static uint32_t (*macreg_readops[])(E1000State *, int) = {
 enum { NREADOPS = ARRAY_SIZE(macreg_readops) };
 
 #define putreg(x)    [x] = mac_writereg
-static void (*macreg_writeops[])(E1000State *, int, uint32_t) = {
+typedef void (*writeops)(E1000State *, int, uint32_t);
+static writeops macreg_writeops[] = {
     putreg(PBA),      putreg(EERD),     putreg(SWSM),     putreg(WUFC),
     putreg(TDBAL),    putreg(TDBAH),    putreg(TXDCTL),   putreg(RDBAH),
     putreg(RDBAL),    putreg(LEDCTL),   putreg(VET),      putreg(FCRUC),
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 94ea34dca56d..38bdb90114c6 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2855,7 +2855,8 @@ e1000e_set_gcr(E1000ECore *core, int index, uint32_t val)
 }
 
 #define e1000e_getreg(x)    [x] = e1000e_mac_readreg
-static uint32_t (*e1000e_macreg_readops[])(E1000ECore *, int) = {
+typedef uint32_t (*readops)(E1000ECore *, int);
+static readops e1000e_macreg_readops[] = {
     e1000e_getreg(PBA),
     e1000e_getreg(WUFC),
     e1000e_getreg(MANC),
@@ -3061,7 +3062,8 @@ static uint32_t (*e1000e_macreg_readops[])(E1000ECore *, int) = {
 enum { E1000E_NREADOPS = ARRAY_SIZE(e1000e_macreg_readops) };
 
 #define e1000e_putreg(x)    [x] = e1000e_mac_writereg
-static void (*e1000e_macreg_writeops[])(E1000ECore *, int, uint32_t) = {
+typedef void (*writeops)(E1000ECore *, int, uint32_t);
+static writeops e1000e_macreg_writeops[] = {
     e1000e_putreg(PBA),
     e1000e_putreg(SWSM),
     e1000e_putreg(WUFC),
-- 
2.24.1


