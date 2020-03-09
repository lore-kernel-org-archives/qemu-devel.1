Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9FAC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964FA2067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964FA2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKFz-0002Kn-LO
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK35-0000Ti-1q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK30-00087I-6s
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:10:30 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:43071)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK2w-00080q-Qu; Mon, 09 Mar 2020 11:10:23 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mz9d7-1jX6La2m0Z-00wCPd; Mon, 09 Mar 2020 16:09:29 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 20/33] hw/i2c/smbus_ich9: Include "qemu/range.h"
Date: Mon,  9 Mar 2020 16:08:24 +0100
Message-Id: <20200309150837.3193387-21-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Alwa6Yq6anJ25qqFb2ZJCqayl5qxuKrCwWQL2K641TjDVv8DxnD
 UJkIGN3SM0DllsWqOE1Q2KYBM0cIesPhI79sdPoQyBdoLbAXe9AJLhVRYpKiLGQqpDKHzDt
 GrC7m/3NQDbiIJRmlWUBWUgCziy5lGGkrNjNN5Bor9wIBQ+JOLewBBQgn8yVC1/vrTmv4rS
 cz4gI88sb4xqWMZZ0aC6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PuxzSjGLkMI=:rKTJ09YAr7MO8ckm3p+HHB
 nTQRRCXJ2wnTUopWfg0flpXTcAvErHxm0yhofCwSwtfMkxvZYCUmlww4Rr5KjT0ebccRMoJV2
 sWbXdgymVKmJsuUnJr+Cx3Hrfxtu8O5zCnWsUbaWn3q5bz3cpKQ7AFEuNccDI/kWt89TzCgxf
 14BUy+Ay1kIj9ZaMtJYQWkKTJMVYIad5jHYJyijOYkHy9wlg1roIGHDgjzhYhqCMKd/4KxyjC
 QYfsJJahDeu4o5Jx0bH100FvOCImi3vF2X5QFtpvbsEKl78DbmlwBrmvvX/ZBTlXdF3wvi7Dw
 7E5sDlMt/RZwc53y3kx013vZYz5VD4iTrqw62D0G+TTC9ksGNQdPHstZlbD+yZCFbjr6f6nMP
 crFuMsqjos+n2Owy5H7y2BG4Pb+CLIpqTIN+9F39PDSyzueQLuf7wsZAIkKtUG4iXKoFaXmgi
 NSZuZjsb55f+8Of5wjTfQiQRjYVhhpHwVUcJwxC5ds1BsS3KBRzjMkkc82LjYhFhw0Sh/TfJ/
 fanwylNwK4bbIVBb/KWeEi7y6sN7tZUB4G+BIC8K5VFzT7UzCpe2SlDwLtFdYLXCA2guwGhR6
 +h/TEbmQW9cdtfZsX4k7pRZx1LetraWGqUN3LYaHVxFjsjaolT86SQzPcTTQ+HoMq9NFGgdL6
 kn0Ex0zP1qvLA70+6i6VN7G6jmr2AmIIFy4G/54vkqR9vfTeA+VOdst7ntoZYCXzBTXrCX4BU
 /2Fe/dAkdmLwyTtmNHgzhmdpqnl/W4JpieDDgL0jufxp1kxgvtl21OjePQTmKSMttB/8r/0jO
 H5ORpJRfTO/RZIbCVT6OUbbg3Nv2pQRAUAqN529o4yy+sHk2WHfvJGvZm7JQ6rmv22X+T4T
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

hw/i2c/smbus_ich9.c calls range_covers_byte(). Include "qemu/range.h"
which declares it.

This fixes (when modifying unrelated headers):

  hw/i2c/smbus_ich9.c:66:9: error: implicit declaration of function 'range_covers_byte' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
      if (range_covers_byte(address, len, ICH9_SMB_HOSTC)) {
          ^

Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200228114649.12818-14-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/i2c/smbus_ich9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index fd50fb851af4..48f1ff419174 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -21,6 +21,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/range.h"
 #include "hw/i2c/pm_smbus.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
-- 
2.24.1


