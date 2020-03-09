Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78526C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D60F20873
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D60F20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBK7Z-00087x-E7
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK2x-0000HV-WE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK2v-00083a-Pg
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:23 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:34875)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK2j-0007w1-29; Mon, 09 Mar 2020 11:10:09 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N79q6-1jPh9b2kkm-017RUo; Mon, 09 Mar 2020 16:09:15 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 14/33] hw/alpha/alpha_sys: Remove unused "hw/ide.h" header
Date: Mon,  9 Mar 2020 16:08:18 +0100
Message-Id: <20200309150837.3193387-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uccyuDrkFn+a+xEWYIJHFbgT2Icbc+Sj4ndp1MFnVVx0HLwwqeP
 la9vjsB5CnghR36yGzsOk/Y3AFTd4A0nSrBItsgyjXayc5Kqho29niLo2I0mAGJg3DhS8n4
 Q+3IuMpRobwcsbq5qzU/QqonQVILD/6FaMWYTVqJEpWXowNdJ1ZUhQA2ZDAduZJi2q1l5io
 80LRGFOeaxEqdTTN6oYpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H0CLhIOz0Nk=:xUwZiqy5V4yKaT2+xD0mEx
 /i05Kz0KbWFGvNO6EQDyHLnZvGTxMZbWdKSphC0934APVF+KRPVIyI0ToU8H6ALe1xdrQKmn2
 ItJVtcaCBUsbs7XLOgAVnAVs6lcdmnpUZ6wHqI/rFPxFfrbmbzvOyKKZzmaWkVwGJsbeur35f
 QA3kABJFi4PhJpQddnWHmol8Uzi+cVrNUdpQkXTa/S9XJtoh9J4ZBwSd92z8vdall+pML6dZv
 d+08yl1DWjlS2w5fQmPFm1PSOiHgVKW17rfdhWpi6TXAz3Y38lS+OJzsl1plEMWX77xK4/Jq3
 t6fB+rNYyNnnsiONlu9IKLcoqJJHwvgfPak47GlGgGraEhdD7iymLqoJhytytlK4Ypk55siFW
 CKxAKmGFadVrlBvCZ6coVyKytOO011kzqYu0u0DqUpfwLqFEF9sXdz0N/KTG4o+lM4cGELBM6
 9kY79RvfPTbupLP0xtPHIa0VSaFy+/sa88FUbYoJcv2gu7GA1bmuzYsn1985HiZV8yD22EdnB
 8ozbw/JtcwZMW9ek2V3m5W0OLFfTkmd5t+VMSQegKihM0pdXFDmSv53mZQg0AxGJYSd8SEXMX
 3m6/HwKKNwPzDuvSp0aBw/8EQNNUymE+j61ExzGWzW6rGa9ZqwuTBso/wTlLBYoXeUJemOXgG
 zUyzobqsrXJkNWwC2w+vHlmKMhOwbXvLBcVpK+hIH3tAiSAHRgSk/FlpkXUxhmNGqe8eBeG43
 Hi8/6/onj+SjANFK6AP1ok+Gog3VT2uWKnDvYP2p6+kwxMIw2lNj77X2I+Rav4+xG+/PyH/x4
 I4Ezc4WUJoxXiE60qdBr1b0BDrgzq6n8LqgX447FRAQ+g7L4Ef6xAFHK18Q6OOFc+NCtuSa
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
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Greg Kurz <groug@kaod.org>,
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

alpha_sys.h does not use anything from the "hw/ide.h" header.
Remove it.

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200228114649.12818-8-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/alpha/alpha_sys.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/alpha/alpha_sys.h b/hw/alpha/alpha_sys.h
index bc0a286226f1..e2c02e2bbe1d 100644
--- a/hw/alpha/alpha_sys.h
+++ b/hw/alpha/alpha_sys.h
@@ -6,7 +6,6 @@
 #include "target/alpha/cpu-qom.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
-#include "hw/ide.h"
 #include "hw/boards.h"
 #include "hw/intc/i8259.h"
 
-- 
2.24.1


