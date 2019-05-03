Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C008C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5BF2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5BF2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38487 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWO4-0001AT-Aj
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:29:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWEz-0000YA-Mw
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWEy-0002PG-Pm
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:20:33 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWEy-0002OG-HQ; Fri, 03 May 2019 07:20:32 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MmD6U-1gwDtP3RcO-00iDrO; Fri, 03 May 2019 13:20:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:19:53 +0200
Message-Id: <20190503111958.30825-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503111958.30825-1-laurent@vivier.eu>
References: <20190503111958.30825-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WVENs8aRRHdh926/GOI50v7+7FsI2RMUfj5W4u8niyT+lnGMKmk
	ROSFvnfwdYfkW4xsdL68TdI6Bpiuf1NyJ18z4fWaq0nc/CVZL3+POUAiHXLGV6HHHJ84Kc7
	pSqlXGCPlM/VPae1KDk96C42veb6rV9NLsC5NZvkXSodQ2Yf1kbbgjwXTdKDACxqoVP0Zzd
	CO9CZJMYoTb0T4WRuIZgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O9C7hKXj8yk=:Hws+ek0Agkb4v1o48Vxu5V
	eQO8BYP6pg8Wb8sutSn/C35wJh3kQfkdCyD6sC6jHjY1fCyQkUuMBJ/+FxJ1/ixhQpN9UAIHT
	J+rpAV1hMDbnpJmeSPbsI+VN4snNqseedBeT81+HRxy/9P2xbNcQgiM/G5ZyiYVhQNJoZgOa1
	K+smrwvc/EvN/19rtchj/prjZ4CrSQwoWix7Y29aHewHoXr5/ljNqFq2TOJBv5WJblbb0i/Ur
	m42GAup2mBHDtBnqjGCSG0rhCQmO2/tJs+jfL+eg9QBuNQzQKGlM9rSElgzJTM/GtSrwufqmY
	1G3+fe0wDWVJRq+ofqFNzGA0Fizv1j/hW4ueu1BOdOVfVB74HN8MLlxTROwtyYwn8rYvK8SRl
	pxR3AO4z00+3Za8E6hU02TWZ061cm6RTNNFcxTxvwhJWHgW3bkE2g+tOXBnnZxRu/j7XBc+1h
	SeujFhw3b/IlOX08x7Y33u+jh8WTGNgx9agzz8SFX9aBJ1dkAe4rRpMv5jVb5IRuCSMOmRNtI
	LLydemXlmWwMluR2fATs96T/lNUwH/KaavfxFAzPk4rY9JAxWsPJ6KowRCihHemiBBmhhSiKp
	sUaXi9GGfp8B+ssT3x5PqGKNYfhOWbU8PCt6L0iKI7RFfqJkPxfvFBDJsTZ3i9JWzugDtCnnS
	3crUWMEPc2fcxiJoqYm8tmLvAIchoj8KysD2I0Nf137jFK4EQdSoTZR4YBkWHhHVxDfySvf/s
	oKkCW1MD9gMN4tPntPG/psQ6czpbBeE4cr4Tnj2wX6QmETSS5jbRv8/tHfU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL v2 07/12] Update configure
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-trivial@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503111953.7JBsuxEdtOBPkpvw76mm7PCs6ch9X4TputrN8TFtIJU@z>

From: Stefan Weil <sw@weilnetz.de>

The last *.aml file was removed in commit 13b1881aacc7e5018773bd545bbaf8d5476699ee.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190409053320.14612-1-sw@weilnetz.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure b/configure
index a2607afb3408..14f02452f9d4 100755
--- a/configure
+++ b/configure
@@ -7880,7 +7880,6 @@ LINKS="$LINKS python"
 for bios_file in \
     $source_path/pc-bios/*.bin \
     $source_path/pc-bios/*.lid \
-    $source_path/pc-bios/*.aml \
     $source_path/pc-bios/*.rom \
     $source_path/pc-bios/*.dtb \
     $source_path/pc-bios/*.img \
-- 
2.20.1


