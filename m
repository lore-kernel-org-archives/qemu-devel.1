Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC43CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A91F2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A91F2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNvDG-0005Ze-WD
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNv4u-0000bP-M6
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNv4p-0007ij-L5
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:12 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:58789)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNv4h-0007bq-Rl; Fri, 25 Oct 2019 04:36:01 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M42zo-1iNv450zGi-00072i; Fri, 25 Oct 2019 10:35:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/19] qemu-options.hx: Update for reboot-timeout parameter
Date: Fri, 25 Oct 2019 10:34:53 +0200
Message-Id: <20191025083511.11463-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025083511.11463-1-laurent@vivier.eu>
References: <20191025083511.11463-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:c/zMktz+3JjDH+N71EHAEvM5mmPJFDBf9jhIDyxk7TxzV9fd6VF
 REjLhdpVtuT+qJJnkSVRY8ew+4aN3YxXoxXTeY8UycOnzgJS8DHvTvEseeCpOQFDy6OSCR8
 aOiLgpYlSLipBEF0WEqUxXkw8hfoJSbOxR8uKNmO7BMxTAyJ+SDfj7eiV7ERp40lT+h2UbQ
 nf6VK2l31V84+k9iosYqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9u9gYdmRFEM=:IHDA2tZj9/PN/GSiW8JqI9
 3ui4rUZFYZTm+TAtJxWQ+8XTasyD/3lGBWFFqzkVoBXKAJhk93dh8FpDaTE2GGLK5PbbRSEBm
 /xLbvcGjUBldmt5vtvZhNZNTqat711fn/8QhfwHpYdCsYK8nuxmuDNirNRaMTSCRX0ixofiip
 /OpNz7oVvqcWcnj1J0PlRWspCPoupOznVS6bFaZtyp+6u+mtxmB7Np15ecx2nHe1ia3O0ohX+
 2xALIeofdbNe6dv5/z8gPEjul/cv5/6Mq4D4eg0WUz4Sf1C0X8+Br9NZpQFjGwfXjDd5AD084
 eoMF1uG8aNL6ptNoHXPb6zHf6KKK7JLgv4nUzCiDLO/ULYHdNU+mYykxch67BabWWv9fjBMlg
 hCZAnZCwFm3qgsvstOlr1QZp+278O0WkiNwXvbgO3I9VnFOTFh6kY1HKbh4dcHBinQT8w/A4I
 573cTrMiUc2vfSvTH+W0M1GhqnRnEBb2azODXUZtFtu+K/PuHWReTa6EC9bS0ey5pk8aIf7gV
 u5wHEUBSCpPtCOYfM1PwXYc5XeFW+flTHHRQYsejTit+9YhWK7F0d530FrzXIOv5O70hvCB2J
 ZqUUP2PWnlVlwf6uwRq3bq8Pvk98sQ1FvxQlV4QAXurdqUFuPZecAZ0MMJ/BUpW/K3QAa5LUj
 iEkqZiwPLexcdpfEg+M2sjkEuLxQiyTOPrFvlIib/59myXyPHE8d0236VrNgGmM1qrTROuy2U
 klz1OyeMnz8wlbjPibWqWQOX3q4FnldOZF5xboT09ly4anmWhKSbp5Yim4cuWCxzyQ02jK4vd
 ta8ms9UC4T4SwDq8fcr0aF6+dQQJsEqR8nuY4sGbWXMzZIZmB2AlVaIVOClG0nsE5aFx9pU3M
 NIzwbvNDxl9ZWFn0OcbjfHgalfCFN2rBmrbw4Q55s=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Han Han <hhan@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Andrew Jeffery <andrew@aj.id.au>,
 Laurent Vivier <laurent@vivier.eu>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Han Han <hhan@redhat.com>

Since ee5d0f89d, -1 is not valid for the value of reboot-timeout. Update
that in qemu-options doc.

Signed-off-by: Han Han <hhan@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191015151451.727323-1-hhan@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 996b6fba7461..88b05599b1cd 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -327,8 +327,8 @@ format(true color). The resolution should be supported by the SVGA mode, so
 the recommended is 320x240, 640x480, 800x640.
 
 A timeout could be passed to bios, guest will pause for @var{rb_timeout} ms
-when boot failed, then reboot. If @var{rb_timeout} is '-1', guest will not
-reboot, qemu passes '-1' to bios by default. Currently Seabios for X86
+when boot failed, then reboot. If @option{reboot-timeout} is not set,
+guest will not reboot by default. Currently Seabios for X86
 system support it.
 
 Do strict boot via @option{strict=on} as far as firmware/BIOS
-- 
2.21.0


