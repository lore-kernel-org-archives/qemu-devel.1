Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7EEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E13206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E13206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jslF3-0003Ty-HL
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDn-0001Kf-6e; Tue, 07 Jul 2020 06:53:07 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56337)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDl-0000MB-9q; Tue, 07 Jul 2020 06:53:06 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MqbI0-1kfJSl2I64-00mbHm; Tue, 07 Jul 2020 12:52:59 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/7] trivial: Respect alphabetical order of .o files in
 Makefile.objs
Date: Tue,  7 Jul 2020 12:52:50 +0200
Message-Id: <20200707105255.362318-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707105255.362318-1-laurent@vivier.eu>
References: <20200707105255.362318-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:caHFmPI/lW0jdW3g9PzSMiD2mqyDGyv8osdr8ngh5ARSGYKArjf
 6iL+sSlNyiMNxNSkLkyhFKKDp4riHiRFYCodT9awDYaI1wIySFzE1x2aCM3EzvzkQ7VpLdU
 3tmQqHMx8OOkcl1CUciA54pIHSv6wTSSfbEaMMmOTQy+9z2vTAEDuvv3pm6ZPmROQK8Dszy
 Y9M1DIq66KcZ2afQC2JJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sZ2ylmb0Ies=:OYe5qlD+XsN50hjz+4xJZt
 y0+hCjy/g5xM4LWN8HYcA+3YgBZFt6KAxXMge4qooWMEC7X88kkf6W7cWMq/EAJurhrt5lDUn
 iCHvlpzsPPUYPCv3ou90hmj/Jfh9b83gbXtpKvFD9vplty4KHRMeaLqdsq3F+NoOjXh8QDCQm
 ED4awX3vWsUhKauDBlLnxGR5mqEBVgQQLMGKTVE6Ynea14/Urn2kjPckCZa+HHkf1MgExJ6Kz
 rU89CwYFoNmj1/1403ldbmWzaHopg6a9vQrHKcsvZPiixxU0wfTCiTBIc7jBlfCF364oiUmEA
 dnpFHp3SAeZIsmu7ENz7L8cIfOHahWOEWrAcsteu2lHmxpcsGKF8qefa/yB8J738CXenGrjhO
 W+kLUNCbriVaGulHZgdLCCbkCkr3kgRPJA7FcF8xrChbLgraaQANMK6ZCdwMpZKETd0kkFXUE
 S7aORzyE9/IjJkObM4MbmDjWv6Q/HaOs2KRk5t8BfmT8gNvgJNyS1pj7GB664K6547p13KWuH
 SJkfHbQdEzMPp5gezrL2HXmcmk/MFg82zeDMcQ5bnfNCuYJ1RZLgWtJYIxkf1ns3D58cx3VTU
 jfFDwH+rLLdGbjwGkOKRvTYBkBlKh6di/Qwai9LSMZGhF+eNdMRRq5MF/Q8TdqhTQ20TCrH6p
 vvbkdVJ5t+ACM0KJ6eJ+Wb3xIRpFltlMcpKt6dSV45dxDbaQxenxqrXMI9hhJrcIs6LRqYQ7e
 mkvkYp8NptaBqCvFMARAVVTyTbYu1NW/8QqcHB1zpBDKGpb64/j6IX4DLho+Qw70tzqv90Ahk
 dSREfOjot1yY0T3h0Pc2hlMUa3Tqqht4oLNqHrJwlOD6RoWm5uwV+rRb5XQmqYZvgWiQlZ7
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:53:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Christophe de Dinechin <dinechin@redhat.com>

The vmgenid.o is the only file that is not in alphabetical order.

Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200629094934.2081180-1-dinechin@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 stubs/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index f32b9e47a3d8..1df8bb3814fc 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -19,10 +19,10 @@ stub-obj-y += replay.o
 stub-obj-y += runstate-check.o
 stub-obj-$(CONFIG_SOFTMMU) += semihost.o
 stub-obj-y += set-fd-handler.o
-stub-obj-y += vmgenid.o
 stub-obj-y += sysbus.o
 stub-obj-y += tpm.o
 stub-obj-y += trace-control.o
+stub-obj-y += vmgenid.o
 stub-obj-y += vmstate.o
 stub-obj-$(CONFIG_SOFTMMU) += win32-kbd-hook.o
 
-- 
2.26.2


