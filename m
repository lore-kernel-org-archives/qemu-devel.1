Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BB5C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D2C20874
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 18:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D2C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJhvo-0002Gq-Ty
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 14:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrC-0005w7-SB; Sat, 19 Sep 2020 14:45:10 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kJhrB-0001J8-9B; Sat, 19 Sep 2020 14:45:10 -0400
Received: from localhost.localdomain ([82.252.129.222]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MgARS-1kxzLz25yI-00hiko; Sat, 19 Sep 2020 20:45:06 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/17] ui/spice-input: Remove superfluous forward declaration
Date: Sat, 19 Sep 2020 20:44:37 +0200
Message-Id: <20200919184451.2129349-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200919184451.2129349-1-laurent@vivier.eu>
References: <20200919184451.2129349-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:s/2tQlUDlhHrBU5GriJw/AgUzsxIKA2LOX7Y7ALvXTNNQ3WDnRx
 gXlHkaaQJMf5pxYefSYvgWRD2qs06WAw2BFZS1biI+2OMotndLwh3d28qz2ebdLYyx8TyE+
 QPkP1dP/t2wJxYZ72Dsk+pankKE7dXK+o3G0137iREWPaf3xihKLQbnsKP1e/vjhLnpW1CM
 MQrPrJ4pRebFr7sdUJfUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uONlk90ihh0=:G3iOqUW3ANj1lOQbfr2R1V
 Cg6JPIlF4wFCL/kb27cGSHNX6bHWp64w4aKvSjp7B0WQf5xE0E5UPOOQmlxCGHHreny1TIIGE
 F1PDIsWRZr7hWsNQriLY9g1XM6DSZXTIrU+Mdy72NPhLNuLlP6wat4R/pUInKIzmXx5rVzl3K
 6WmHS2ZOsZs53yl5k0V/JLgUdXK5jwgDrh3IQwdVzOZwmFBAhzhjs8u/OsSKFxWui6NVOl809
 6eXSqYteUnfPdv+LkJLxiWLT6esy1x51VSm7KdZW6vVlNwTw3QjXyH3uJnnk2CmEmyUS8adkv
 GU4U2DQ85PaEYGminBt7XDwYv28w0bOmJ8pYAo7rqwkTRyRInf+4G04f8t9dwxQJhAMwTaqon
 BLiQfH+4t8WWouoazpux0phZaoeJSDZYj5q+lRlZRpilu4uKIOp2OeNz3mO2Gj1QLWG1WQTyT
 Jlh9FrK59kTnoklKfSLmsWe4TEwNFADrosD9YaCz+qsXDI8kaKRPN3fUw4SOBaB/G4ICfHo5n
 D19W9WbqpTIGCsPL9Dtl62lKyTyZUhOulFCvNYBQtTLkLQW/cDjCYAw0iw2n8Ommsn1/Iz1eW
 N22dCxOXRE/i/+hOxfudNw/zfnajffjWyHvcrq4oljhZp6n26XkIb9q+xneGZJoDQzGqr8yUd
 +87xR11xHVBkMVoUH2bU2lS0m05l6Arn6NevHJ0np6Ni/Qph/sxQpb+aFlgyNYwHLfq0CRieF
 0wejDi6hRWTXwpgKtwwDd0jlyH/kFfTCpBd9RZFgqDhYUuAWX+gEGNUOwRuFte/I6cjb7lWEx
 secYcnI6xIYKdSNfv8MNjs3mx7Rm5dXxZhvqrma3/Xl1HOmOlzMsmwJDfuubbXUe3gl46ck
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 14:45:05
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We only need to forward-declare kbd_push_key() and kbd_get_leds()
which are used in kbd_interface, not kbd_leds(). Remove this
superfluous forward declaration.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200909171145.350360-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 ui/spice-input.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/spice-input.c b/ui/spice-input.c
index d5bba231c95c..21990fa9962b 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -36,7 +36,6 @@ typedef struct QemuSpiceKbd {
 
 static void kbd_push_key(SpiceKbdInstance *sin, uint8_t frag);
 static uint8_t kbd_get_leds(SpiceKbdInstance *sin);
-static void kbd_leds(void *opaque, int l);
 
 static const SpiceKbdInterface kbd_interface = {
     .base.type          = SPICE_INTERFACE_KEYBOARD,
-- 
2.26.2


