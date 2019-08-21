Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265C8C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD7322CE3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD7322CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Oqc-0001iA-1U
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0OfS-00057Q-T4
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0OfQ-0006dV-Qy
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:42 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:58727)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i0OfC-0006UD-Db; Wed, 21 Aug 2019 07:20:26 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M6VNX-1htX2U3K7l-006yF1; Wed, 21 Aug 2019 13:20:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:19:47 +0200
Message-Id: <20190821111947.26580-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821111947.26580-1-laurent@vivier.eu>
References: <20190821111947.26580-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IY6l50A0xPEDA9udGQabyD0pxfy01OHYRizudoGvggfbOXc5CnQ
 nrN+nGGhjBrVeo+9MMeMErAHwvNwe1Xt47eCd4aRDd5bqs2r63b3Z9NISQ8VTlrw27yAaWp
 Z4EgmMGsTtqCV1CQsUMjA6P+QDCRJtU/V0MeDSvlGZMbraLlnhzxFq8YWrSMtEJONUqP6n/
 cusio3oV16io3Ka7PztkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C0HWSpMZ7NA=:NRRiRNRoz198yrqX3hDgzn
 YswRGL2lIvats2Z46huM1e+bnFV7vjeRHEiE2s4kCXfjEMzDFmIknrt9cvGJKhMX/Gzr+32cD
 3B82Lc1DvVYkNBTWMsO7tFOeVTKkxuc0sLHrDWH3GsKKqq9MXe2UleLZl3ss4gKvCTkQjPGFL
 gLNQ285NIqqhYMA6Si4FTixW9JFDQRSj5kMI97LjePghP356dOnTBLNIFyRmFH3Wf04w1GN8t
 CE1+ptvxM35bylB9NatOpUCtEBqWUqhTu7+sccqmie/1Ky8vkpwSseZDDFKDz2hoG50FZsPx6
 xGqwCEo7kBMCklc4C5NqFXuawLDOq2oRTWQQgVTSnAQ+il1C+4rLbR46Tssana7nV2ifP7LHz
 B36ut9lds8i5WxIokNZhRbC/br9HeyhNNxfVF53nLmoygPMZ7vX+rDtqwrYdEonVkxps5xo+m
 3rxcN+JpVpJgWjjAV8CtJuOwrj6yrK4JdcEDj6YBvKhBT3g4msYkZpsgjF3MAOEECnqusa8cm
 A1W0r+kgPjemmtUNqN+kvhYRxjWbYpAUu9oPM/C8ek2KS+3UeJZASYOnrNbRqxrMlmVGAYpNq
 gL3/1vee27lhCbebNXYR7dWIUNYU5Dwti8MvMt/2e/vqfEX8SE5151Ptac2FkPwrGA4k+9TlC
 YFVmuQ41EZ3WfUtyOnzahFquF1hVrHj0T+rmUyU/OAsSqc8WjKMcX5YpgDLeJwj8aXRU3sdy+
 dKpyaVaWFfpFMZs98csYjJjcp2reYbisfMRvFbGAQvjK1Gl3lBNOlA+p9JH2MZ3z4U6ZhEdhv
 WRR+fUD0mXERz8WsuGaiYfXD7okAA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 14/14] hw/display: Compile various display
 devices as common object
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
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Various display devices are not target-specific and can
be compiled once for all the targets.
After this commit, the 'make world' target is reduced by
54 objects

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20190812113739.16587-3-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/display/Makefile.objs | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index a64998fc7b23..0f11d55b14ef 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -31,13 +31,13 @@ obj-$(CONFIG_MILKYMIST_TMU2) += milkymist-tmu2.o
 milkymist-tmu2.o-cflags := $(X11_CFLAGS) $(OPENGL_CFLAGS)
 milkymist-tmu2.o-libs := $(X11_LIBS) $(OPENGL_LIBS)
 
-obj-$(CONFIG_OMAP) += omap_dss.o
+common-obj-$(CONFIG_OMAP) += omap_dss.o
 obj-$(CONFIG_OMAP) += omap_lcdc.o
-obj-$(CONFIG_PXA2XX) += pxa2xx_lcd.o
-obj-$(CONFIG_RASPI) += bcm2835_fb.o
-obj-$(CONFIG_SM501) += sm501.o
-obj-$(CONFIG_TCX) += tcx.o
-obj-$(CONFIG_CG3) += cg3.o
+common-obj-$(CONFIG_PXA2XX) += pxa2xx_lcd.o
+common-obj-$(CONFIG_RASPI) += bcm2835_fb.o
+common-obj-$(CONFIG_SM501) += sm501.o
+common-obj-$(CONFIG_TCX) += tcx.o
+common-obj-$(CONFIG_CG3) += cg3.o
 
 obj-$(CONFIG_VGA) += vga.o
 
@@ -53,7 +53,7 @@ virtio-gpu.o-cflags := $(VIRGL_CFLAGS)
 virtio-gpu.o-libs += $(VIRGL_LIBS)
 virtio-gpu-3d.o-cflags := $(VIRGL_CFLAGS)
 virtio-gpu-3d.o-libs += $(VIRGL_LIBS)
-obj-$(CONFIG_DPCD) += dpcd.o
-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dp.o
+common-obj-$(CONFIG_DPCD) += dpcd.o
+common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dp.o
 
-obj-$(CONFIG_ATI_VGA) += ati.o ati_2d.o ati_dbg.o
+common-obj-$(CONFIG_ATI_VGA) += ati.o ati_2d.o ati_dbg.o
-- 
2.21.0


