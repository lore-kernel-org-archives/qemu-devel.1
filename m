Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F4BC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:10:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF69520868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF69520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47240 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTp2-0003aD-OG
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 12:10:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTmu-00029M-Ac
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTmr-0003mM-Ve
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:19 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:45063)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTTmr-0003b0-8C; Wed, 22 May 2019 12:08:17 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MZTua-1h6oR11uZa-00WRq1; Wed, 22 May 2019 18:07:33 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:07:16 +0200
Message-Id: <20190522160723.31484-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522160723.31484-1-laurent@vivier.eu>
References: <20190522160723.31484-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jljocFWONHU390H0jNzDJadl4tUZ4KnZQsilBGFp50u0xC8Xc4w
	H2zUlzVa6E5/9/OQFsK3po0aAitkWEvRGFZV8FPmsXJl4qtZrY68k+LE+HkZ4se90ETqmq4
	AOUiI4wbp4InOBH912tWnuWGQJxOTqmkCcSuK3U1HfbXMj2G+nooNjcnL2UDZMxkY6YFTm2
	P0Cf88U7/k/HQ1TVSqgNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U6HlSEZRSVU=:kkXsYqQMRrO15L7XkI9nyK
	KhwP0ogsHg0nmpLlI+1WJW5+2cbPFD7NT4oN/ukk4duMC1bxOogfmnSvu8k/nnImoFCtMGpwm
	bWfa1em/WuQeeSuVh/rVWvKBf//+S8rutgdBnT3ucsWbA5uRKRfPRVzGS8nW2E3VJJJ7NHMY7
	XbcdrJN5b4H/q3d47ofJcB9qQvgP1nIV7KKBrq1DRt751JklRrc2ebLbskJB+WPrgWAk3ezqV
	QYJyUwclLZvlBYiBVwCFjuy+TMwPy+xr235r5Z1lEKLFRKNPENZY1wCOPWyPaZutCJlpdN9t8
	SA+zROC/VXNVzMkJ61njtWfu2NoXAEX/xaebI2IoKP2OiRZL0PvGb2SZa34ibBw5khSEzVymS
	PX++Zum+Fv7yQ34xaGCacvF2CAIMnpXeuaWhoM66cByoqYvI47aqSJ3e8Yfd/VPfwL287q5Lw
	JnM6h4qqonBe9UnUqct5J1A5Hod9hCoQdxdTrYK0b38acqFdEctYW/kQoHhjkgo5klvQsQU1Q
	VenIOFbk0oUP9M/eLRVDmLtV3xEywNin+yurJzo/YjGNJyd+Jh+6UIPGmThqbypGJTIXwqcB1
	ttdNYX6tDFCHs3YYDp2+Jf3OWTmaYLZdic5Gq7AjZcWub4Pd8rQpbYEgJcVAIa2pbjMDaUSx/
	qHMSKz0l1TBRFC12HLtLKM4W4ObQ5o8blNSihcW/StD2IF9nogw5bZ7hUyshoHkVUQnQ0/Vfs
	LtVe3m2SxQiTrkAJ/R0OXVzqaxJgUB3cj8uCxD1HPj3H2w0CcKrhgyqEHD0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 2/9] roms: Correct the EDK2_BASETOOLS_OPTFLAGS
 variable description
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
	Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
	Laszlo Ersek <lersek@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Alex Williamson <alex.williamson@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In commit 1cab464136b4 we incorrectly described the
EDK2_BASETOOLS_OPTFLAGS can pass CPPFLAGS and CFLAGS
options to the EDK2 build tools, but it only expands
the CFLAGS (not to the CPPFLAGS).
Update the description to be more accurate.

Reported-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190506141923.12183-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 roms/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index 0ce84a45ad57..ea6aec56abdd 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -121,8 +121,8 @@ build-efi-roms: build-pxe-roms
 		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
 		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
 
-# Build scripts can pass compiler/linker flags to the EDK2 build tools
-# via the EDK2_BASETOOLS_OPTFLAGS (CPPFLAGS and CFLAGS) and
+# Build scripts can pass compiler/linker flags to the EDK2
+# build tools via the EDK2_BASETOOLS_OPTFLAGS (CFLAGS) and
 # EDK2_BASETOOLS_LDFLAGS (LDFLAGS) environment variables.
 #
 # Example:
-- 
2.20.1


