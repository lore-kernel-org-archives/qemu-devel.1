Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04EDC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:52:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C89921741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C89921741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgdU-0002ia-QR
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1izgcM-0000j7-96
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1izgcL-0005K6-B3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:50:50 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:40183)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1izgcL-0005HO-2U; Thu, 06 Feb 2020 07:50:49 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MLRI3-1jIAyA3eFP-00IUxA; Thu, 06 Feb 2020 13:50:34 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] hw/smbios/smbios: Remove unused include
Date: Thu,  6 Feb 2020 13:50:16 +0100
Message-Id: <20200206125027.1926263-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206125027.1926263-1-laurent@vivier.eu>
References: <20200206125027.1926263-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+3n0YO0QvTIjSQEknkdfsEfpTCPU42TUPsP6TjbitggmiHP1E+M
 RByE75jAEA5SE+wkOjw6p7PFWoJnIu0zIB5155gtr8QESRj+7fr82vaTiSMn6/AKw8pKUP5
 pISTWZkDQDr8y2IgZbxDoqo0m7FVIVQdbl4JysShTpPCQ9ygL2FHMv6vLaRDkIXmacOn5tF
 rscj+o2aL05jRX+5uiHWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:odg5yYKeunY=:DbiVs2SHG0vDv8/rh/IG29
 UaPa51Zdy1INZz6ddPgvV+3V5uTCilCrubLwWlaVh9asTZMDjlEsV3dI60HAJY956EpzEHoYN
 gYh8D7jfjvR6yeurHO9HqIG60ARM3zSBYZHd4T+jz0o+uG7SP5mQdhW+hczwThMMLeVCpQ8+N
 N7t8k4l+hXkyxHlVK9mXEKR+XAIiDZUH/0mUPRGPJi9i2oTKZOhGGVLcdrpwQENuA12mEbh4T
 ssWQi7+WAtuK6LcmAuQYVwadSasReo6NJQc7S3XcxhPdhfI1kVjo3v6Z7jEObNi4B/lsn9NbJ
 Sjeyb5w0Pgvv/l3xYdK2O/se2WaMEQ0K2LHDQdBVVGD9ZewLgDqRibSSOAGLHeExk1TCE0Uhe
 J5QPk9lvlN7hOqy1dSeP51RYfavD/QslF/Je+EDCOHSAtEFCslfb55WtIaDV5FCedGXF9mQQl
 wBdJB9n5i0XcOnLSRUYtK6cZOh+Qd71Q3n7AZgYk2yvH/rnMoYkeuaYzv0i/3WEKhmQ/HsG59
 UTy6nPt89t5ziYgzVWF/EuQR6o2RIPKcJ1GqiD3oaX147bW5RYzVC74uPnb/bluX5fu7wzdOu
 4ZuAEFYumm5SBulV+qd83fNwt5RrzM7nxIkK1ojSar3gfPHMTrqM/wfZMzYh/NaLO/4lurT2o
 HrB/vZx2nzeyFAOL+rtHgymw6S8AIGpqfu29O2hX1qsuqBVNjYLGohNnDXCt3YbjSfHPFq1FE
 HQYnkbKF7NvnCxpCh7qMEdNmA1NxCXU/PMpYIM8klEM3O54/hgZjP0uFImZMzVMe1t/gQDw89
 AZLjfXPw4dq0xtJ5ZXX2NCMNUL04m8kXG0YplZzMwYFC+9vb0PTLE2Wne7nebmPPncuT80Y
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.131
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-trivial@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Nothing from "sysemu/cpus.h" is used by smbios.c, remove the include.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20200109112504.32622-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/smbios/smbios.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 11d476c4a2cb..ffd98727ee9e 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -24,7 +24,6 @@
 #include "qemu/option.h"
 #include "sysemu/sysemu.h"
 #include "qemu/uuid.h"
-#include "sysemu/cpus.h"
 #include "hw/firmware/smbios.h"
 #include "hw/loader.h"
 #include "hw/boards.h"
-- 
2.24.1


