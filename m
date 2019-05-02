Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39782C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB5D20651
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB5D20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57405 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMH1C-0008D9-7i
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 15:05:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvo-0003lJ-1k
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvm-00035o-2B
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:43 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMGvk-00034V-1e; Thu, 02 May 2019 14:59:41 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1N9M5y-1gjvKl3vXg-015GfB; Thu, 02 May 2019 20:59:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 20:58:33 +0200
Message-Id: <20190502185835.15185-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502185835.15185-1-laurent@vivier.eu>
References: <20190502185835.15185-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Jbw4DFL3kvmwxXXd9rzfjPC2Ip/dTFEAYMbD8QAvxeCw5T+swVq
	w6UKqnjj/kzVazLA1918SMeXEWtkyutlNkix1ViekyBV4m150PTXokWytCraJd0F7mmiMy6
	1pNcUZsN8p2O9tKg92xJPEblyBULzpezZhScFHgjkhGfhEnMgUqJm11xr2Mng61+soJbdVA
	5qxWaYo1pXoAMlfzvG5aA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hyiRxIsEq0A=:wEJ0I4jLEfp8BiJPKbQR4k
	24tKzc5osHLwzNNaj31hHFTIvFDq23RafyVJ8PDZjS8dRS+awJzLFXb4vrZNHlj8x+Y1hhi/0
	wH14l6aR8/3vEDEZ3zEZG9VG8Yl/Ys6Vs5Ed1ltacVqC16hfymGFUXBA/KyLbZwzFV9Q1TkKb
	6MENWDlVeLCV1hmhgzSHud1zp8nK4jasIXl0Dfu2eSWjkCLkjWivdJXr6+qJT2zhVJBd59sWO
	pqWXGImEK7QYtuSHZLNYuidzdHr8pNDFGoIylepvcJRkzg63JjikbS3wipqcCRq90UsfDR9t3
	HOF/cqHwkIZXg/my3hrJfR9+a0hiBaYkb5vl6ROrFg3okSnpYd2yW92Mb1ayVdAacIpq99vUi
	GMv93NiaXMVPh+6ygwAjOTxdjxlzTh7JbNthNQ7yNvchZe82kQoniiwXqHnW0GJtMyvG5xv0N
	aN2piYn45OPV8c1yUFmtPkD03JLqfS5j9OZUfRe5/i7tq5XOvqfjXzbowa+si9nXsxKoNKvDJ
	G3FyN4NE+B+4V7DCJYvb10LgBs8ZAtKpT1vN9t5Q7D/XxxbETdL1l6yukUdDlPmWTzh2NFL87
	BqxfkE5vXOQ5iEKjhLxrTzYuGnfOwCgkAkmLnEIFqNhvTw3SHRdVknJ2lYuD1VXfzLwn4GPpz
	oYj3jRaRwGrhq3T5tPBJqYfv6k7EtGH97ehy1w7K2IeKSJ2zWkHvPxnACdVtm6Aek8jWNmVul
	SM6pRmvDClODmHutaNeB0bcZjMGB/YpUuhF0Za5g/RTJVcctL+4Sf2Mwftg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL 11/13] Makefile: Let the 'clean' rule remove
 qemu-ga.exe on Windows hosts
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Weil <sw@weilnetz.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Fabien Chouteau <chouteau@adacore.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502185833.wpmGjl6KkXxDbb5DTq6Wyc_lArDo278g9eJtFbrkVoQ@z>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Commit 48ff7a625b36 added the QEMU Guest Agent tool with the
optional ".exe" suffix for Windows hosts, but forgot to use
this suffix in the 'clean' rule. Calling this rule let a dangling
executable in the build directory.
Correct this by using the proper optional suffix.

Fixes: 48ff7a625b36
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Message-Id: <20190427161322.24642-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 43a7a047b452..e223bfe2a3a1 100644
--- a/Makefile
+++ b/Makefile
@@ -639,7 +639,7 @@ clean:
 		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
 		-exec rm {} +
 	rm -f $(edk2-decompressed)
-	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *.pod *~ */*~
+	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga$(EXESUF) TAGS cscope.* *.pod *~ */*~
 	rm -f fsdev/*.pod scsi/*.pod
 	rm -f qemu-img-cmds.h
 	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
-- 
2.20.1


