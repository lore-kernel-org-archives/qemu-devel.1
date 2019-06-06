Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9E7C28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D6E2070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D6E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58696 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqWP-0006hl-84
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:25:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqKh-0005aM-OF
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqKg-0003R2-QG
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:13:23 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51351)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYqKc-0003Ma-N0; Thu, 06 Jun 2019 07:13:18 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MbjBo-1gyxyw1siM-00dHVC; Thu, 06 Jun 2019 13:06:40 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 13:06:11 +0200
Message-Id: <20190606110625.32127-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110625.32127-1-laurent@vivier.eu>
References: <20190606110625.32127-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wmpSPsS+7A5QbkzIuo4H2PZEXePK7qndfEAgPOgvQ2LxlfTvhw9
	amvAiKaRxtLucqhiiRKRCyClQcMp60JYWMDX9M+QknvPxj0kNgOs8Peb19vAGcpshprcRxJ
	WcNPTGerQRJL+zpN8WiRua1Ve4iPwPaQSmZGJQpq9kftPb9yMfEDSixtCjVNxGsKMOTZjjX
	7E2gfzmJo65wlVOPo5MUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X49tWX4nr2Y=:QcF6a7H8Yx79kAHKMB8+1R
	Cr9r+2MHZWPvUk3fRGmltvgPkeLVMQVr8vGjaOIRmd5IZTQfMWMwBr1K61OqZFuw7wQnHO2lz
	e9xnVQeTrDiwYNJez9xLMsM1g5HBIkCZqge/0hnqRomBNlraq6/EhLBuJcquFcXeLd6TV8rX7
	C343+aRz3GQLS2ixo+VpDqJtvr7anT1tGtGN/rHgyN+nrzfuvHFEYx7ME7BEpsqM4rDTREAx6
	fg8h7xnoykLDgkvJb3S4gyu25uyH4OMXMOjVSwVKC0YZcgt8Sm5NwEsJyOXe7UpSZ7ljqgo9l
	+R6LBuvMa5gCcBKgdWJFnefL04N/V2IdiPq1i04f4E0nDBmMmgxhWqQCpSXOg+1llT//0H2JZ
	VgiYKnBrpi7s5DGklyLAQD2ecH8GV5JdCMp/AYY59l/SYnmgYiU+ET6u1GTs5x7KD+bLadhvr
	7Zycu0uRbBE2HI2SHxSjMgv+fw5dzPhFlRMgo6J13zx2euNYWzQyzVBT5Dzd3kLntNIz3NrIf
	PVdT12sjtKs1bAy6kMDmMf1cpuNllz+Ttj+1Lo2Sk38zz9b2VQoxZSIiV3cfzl81xd3Qs9X1D
	ikm4ad7bqEP38NHXtS5HE30q9/oKqugqMbM9iuP3+BSvmWkmwhp+Qrzh29jZ9J4Zxi9T58VZ7
	TXCGXUeC75VQNdYvnJGsUeCBLudWknut+9FRy1qUNyp7A9hRtEVhQxPr0//Js3q3FYKLhr15l
	w9ZIvB82HSzCGM9FnAh2UQHCdMla+rNApNbDy6q7u98ZYJLKd+C+4zMVk5o=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 02/16] migration: fix a typo
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, Juan Quintela <quintela@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@163.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Yuval Shaia <yuval.shaia@oracle.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

'postocpy' should be 'postcopy'.

CC: qemu-trivial@nongnu.org
Signed-off-by: Li Qiang <liq3ea@163.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20190525062832.18009-1-liq3ea@163.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 migration/ram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 4c608692262e..359dc8f1bc44 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2236,7 +2236,7 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset)
 }
 
 /**
- * get_queued_page: unqueue a page from the postocpy requests
+ * get_queued_page: unqueue a page from the postcopy requests
  *
  * Skips pages that are already sent (!dirty)
  *
-- 
2.21.0


