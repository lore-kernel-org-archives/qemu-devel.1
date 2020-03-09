Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651BBC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB3120873
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB3120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBK7S-0007sG-DZ
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK2O-0007Zh-0Z
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK2M-0007dE-RC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:47 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:53871)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK2D-0007WR-9J; Mon, 09 Mar 2020 11:09:37 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mn2eH-1jaW6g006p-00k9D7; Mon, 09 Mar 2020 16:08:57 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/33] hw/net/e1000: Move macreg[] arrays to .rodata to save
 1MiB of .data
Date: Mon,  9 Mar 2020 16:08:10 +0100
Message-Id: <20200309150837.3193387-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YyRFb0QVs++UPBSB53XqpVLXEQfKS7K49GB3cL3acP1AOQCExY9
 TtdIBd7g6SYuGpmv+dOlPNbhE9xHYum80NKXyqzLvjt5TeDJjumfiIcTQaljmqKILkU1BG+
 wH2s8w6MW46GmtE95JFraQoQJO4p3m2sizdf+NfwkVNXh6mNEB8AnOMaKl3C75q0EF+yjHk
 tb0b4IEA7aZfHvmNXFgnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zw3fgSlGvOE=:J5jVvWgMih5r6yNQLJ9g9J
 fBY3mZLV18RGoCgNp1nhVCsuewAU6Yfc9uSNeaf0qCvZDUYzprYb5rxxByBW8W8622rryJ3qX
 AJSgatMlFwhd8TWv0h7sbcq9y56Pw6qYXUCVAv7LkaECS3dEpdfMi85mOkLcG4Ni2bHfd9neA
 J54tvsxY0JH2+ZUOxUmo4WyR3Hwa0+GRKjtvGd33GeNG/0a+sZjbDHtVLPs8aWXDp7G1d09w8
 asJCG/wA45+q+F+jYlVj9/geDlh1TlwV0w6NileQESE1motDTbeE0U5THfrURLKo00ECZ1l8b
 S0CMaDBpYEQhyWSMhw5oB8yWJibAFafiYoLxoRUIzjcv4/pU+j4X4G0YOWR+zr72arng4R9/8
 4Xpb67IDaHGcYN1zOxp9oKWNVOyG1DjVAo2S2lgmWVxt2VlT2k9C4qbCtp63uxHU7ThCLjgZK
 ivCzhaBc2v0QmAoXlEpJQ0azzQT2ztnNypfp+7Z0Tu/uOFLHG13PBAxdeDCzG0JhRm0UgI2Ck
 iXNRMriIOmhNsqQb7jJtCtbS+PJ5Ea/EyuaLbJGDAuoGaaRm0ALuD81F08y5rtWPU1rBCe4In
 A5uRtHGiJH0s78dFePJTItdKMtreZRMbYtnUAlE3n525BknXIScqJJI0QnwJC56Bqp5w3jgOe
 BLOxG6jsAOhf5rdSWgAOmvIk1tbs9xX6AlwvSB3qnnJQcfyB+6WGW4V/WpYq2lLqPe8m4my7+
 X5lLgqv0yySiTYD+9yMUL2R8SyB5DcHeDfQTD8A4QkmYIl21q3BgsHST4uaPNx+VaVZ4ieRmb
 xuq9u4FXMGNqKhBKsTCz0+cDSXooLeReOfv3pG8D8xh3ZtgAf/Xp/aNeYbYUJAa/BPLbTIS
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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

Each array consumes 256KiB of .data. As we do not reassign entries,
we can move it to the .rodata section, and save a total of 1MiB of
.data (size reported on x86_64 host).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200305010446.17029-3-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/e1000.c       | 4 ++--
 hw/net/e1000e_core.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 972d9b508399..9233248c9af0 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1151,7 +1151,7 @@ set_ims(E1000State *s, int index, uint32_t val)
 
 #define getreg(x)    [x] = mac_readreg
 typedef uint32_t (*readops)(E1000State *, int);
-static readops macreg_readops[] = {
+static const readops macreg_readops[] = {
     getreg(PBA),      getreg(RCTL),     getreg(TDH),      getreg(TXDCTL),
     getreg(WUFC),     getreg(TDT),      getreg(CTRL),     getreg(LEDCTL),
     getreg(MANC),     getreg(MDIC),     getreg(SWSM),     getreg(STATUS),
@@ -1207,7 +1207,7 @@ enum { NREADOPS = ARRAY_SIZE(macreg_readops) };
 
 #define putreg(x)    [x] = mac_writereg
 typedef void (*writeops)(E1000State *, int, uint32_t);
-static writeops macreg_writeops[] = {
+static const writeops macreg_writeops[] = {
     putreg(PBA),      putreg(EERD),     putreg(SWSM),     putreg(WUFC),
     putreg(TDBAL),    putreg(TDBAH),    putreg(TXDCTL),   putreg(RDBAH),
     putreg(RDBAL),    putreg(LEDCTL),   putreg(VET),      putreg(FCRUC),
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 38bdb90114c6..df957e0c1a09 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2856,7 +2856,7 @@ e1000e_set_gcr(E1000ECore *core, int index, uint32_t val)
 
 #define e1000e_getreg(x)    [x] = e1000e_mac_readreg
 typedef uint32_t (*readops)(E1000ECore *, int);
-static readops e1000e_macreg_readops[] = {
+static const readops e1000e_macreg_readops[] = {
     e1000e_getreg(PBA),
     e1000e_getreg(WUFC),
     e1000e_getreg(MANC),
@@ -3063,7 +3063,7 @@ enum { E1000E_NREADOPS = ARRAY_SIZE(e1000e_macreg_readops) };
 
 #define e1000e_putreg(x)    [x] = e1000e_mac_writereg
 typedef void (*writeops)(E1000ECore *, int, uint32_t);
-static writeops e1000e_macreg_writeops[] = {
+static const writeops e1000e_macreg_writeops[] = {
     e1000e_putreg(PBA),
     e1000e_putreg(SWSM),
     e1000e_putreg(WUFC),
-- 
2.24.1


