Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160AAC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF941208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF941208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBK50-0003JK-23
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK2K-0007QF-Rh
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK2I-0007af-Q0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:44 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:37311)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK2G-0007Ya-Dt; Mon, 09 Mar 2020 11:09:40 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MHX3X-1j7DR62up7-00DXxH; Mon, 09 Mar 2020 16:09:01 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/33] vl: Add missing "hw/boards.h" include
Date: Mon,  9 Mar 2020 16:08:12 +0100
Message-Id: <20200309150837.3193387-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0Fkei+2Tt1Tdpv8J++VfECwShiRaK3eOrGgS7RSiid7DnfG9jQ7
 wiHY6j6PhMpnumCxFjkerbQ6HhAkUIKw8m/a4HZ5tawrCyfvCwH/sIX4hE+dC1Vpy+nOc0N
 byu+c+a91Nu3kUNh7/b4Yk29kfjlPSmrpewB5Q3haXNQTbDp+d8d4r8D2YtenHl9zffWqsS
 ML/O7o0l0ZYVKQz3xBAvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mzwa1rvCDwA=:pXKJSSDa+HrCXHL1s9xszf
 nEicKRMDuoRr4cPdjnIc6z0BFL42vaQLcNKyUQkvI/yO4SC4TmUUtWb2bld/im6rsttBxn7Rh
 lBuyX7He+FQbPQisrwdwLV7PiUWwA8R9fAdnegTI9n9qKT16KeXUdeo1dXe0rFHfjrOJl9KFc
 ralgwx9UNhcki3/lBeFJyrmmnc8ZRIUsXS1SxBwdx/+j6HMQkjrbPuqTMdG8RNTgU61rqP7mF
 k4tfaXmcek85v7eptBqp/eKu4NzENr98JlfbTgI8ipZhYpI0vrbwJOzpivvABI2yOMPgWH/en
 ysBGNhYGfF5tsJHmVj5LVWsb3rP5fawdbh12tlQ0cL9MTRi1DiVozkKQ6yKEy9XmhbwWOeDWX
 3XnT5Zs9+Fs+CISWGhQSmRlTFE0ojs3umaM406SKRF6CTLt42PuphAj3zmBCEZv8LIr15TUt4
 ARwLh/gk3TiXEZ06ogccC9KXYksdgoFgx/1B6YQZVflxeDmshtFbU1XNxjAzqyEmnwHXnGIKD
 cZNYUTFij5dXOjVRlDMbD7IDTNYYctyJuyQBoAMb8bh3NiGY9gV04npEtaXC8wwUJOKae2SSf
 mgi4PCcwq0lEpCfooRz4jEdc/61O8zW26OGn3GJPjhiMVAIPAmiL3nEORipsSTLES/wfOqf/N
 o/Aq+wjOANi9v9vPzx1b9ASiDxFF+q3vV325XIK0nQHy04+VYhQ3X8lPzpfhp5TRPLgEnq3Ov
 IN8r2GHKYl08xclBMj74s0nBqIvpXRH++/rJB5QuaA9AqIFp5cccoyn4S0TBrSL/2sDu/BvsX
 vXLm3Ues3mv+FEn7D8J25OrjuUb+m4vQizwd4ZoWNxtBDgqxyfs6+W5T1hGJshO228LVf7l
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

vl.c calls machine_usb() declared in "hw/boards.h". Include it.

This fixes (when modifying unrelated headers):

  vl.c:1283:10: error: implicit declaration of function 'machine_usb' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
      if (!machine_usb(current_machine)) {
           ^
  vl.c:1283:10: error: this function declaration is not a prototype [-Werror,-Wstrict-prototypes]
  vl.c:1283:22: error: use of undeclared identifier 'current_machine'
      if (!machine_usb(current_machine)) {
                       ^

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200228114649.12818-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 softmmu/vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 5549f4b61986..ff2685dff845 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/units.h"
+#include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu-version.h"
-- 
2.24.1


