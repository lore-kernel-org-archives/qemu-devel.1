Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEECCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22FEE21783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FEE21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpYI-0000Bz-Cq
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMpUf-0004IW-Ti
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMpUe-0004PY-Oy
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:26:17 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56303)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iMpUc-0004Ob-CH; Tue, 22 Oct 2019 04:26:14 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N0Zfg-1i8ROd1uvk-00wTUT; Tue, 22 Oct 2019 10:25:59 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] tests/migration: fix a typo in comment
Date: Tue, 22 Oct 2019 10:25:53 +0200
Message-Id: <20191022082553.10204-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022082553.10204-1-laurent@vivier.eu>
References: <20191022082553.10204-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QjZZARMxjrsfgGzWOUzaO8EmrMkl58p0I0sjkKhARowNTwNKOuc
 7fMnCY211dyqokGFhNTjtCZxgYDoR4oHyaRCtQDJJnwgSOf1/LDCM4jylkR0HgpfWR08a1v
 JotVKKD1EeDy3sPySUG6nrGnC7wPlHO6g/nmaU0TkQv5W/AOfsS9J8SAJdlRNCwbJ4xS+mE
 /eTky+iJticvyncOanPNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kDe/OAJRuJw=:QA6Kjgkq6bzdfjlyuUtMOC
 SQeGYFHsofdPrgJPzxQuPOlTLJlfP+0UZx8rNx1GnlGICXr6qv4OX83uu2AreXkxd0R+Hqb05
 YyOQJAJXJ7N2GajHhG967B8pIf62kdcEv2MrnmeWrM0w2z7JWbdc9Aey2CXLythK2qDxU+Q8i
 dvkKp8kWCf0VFIM/ikNeMs+MGAFuOMdNMrlIwihGjRoTf3aVhLmQriCIt25aRhQfCyB/6NeRh
 R542CuvN416zOo6dRQPCj4KVXq5Rdm9dU8C+c/HLKHx25OlprURWOm2peJAXXE9Z4EofPPlxZ
 Kb0zVcBCEPSMYHhx6aJPPT//sMdmKiyRh1JB2mEQvmapsqtR/6YqXBWIOwGcjuSXFKhn1nn/D
 izhV6lSTZehrTOnmwcu/cfPH6XJ3eIoecwXSqU8mTbqnhggs2YyueHmuwN1VwnZsnC1Ai7wo6
 Bf95mDK0W2vfosNu+MRj4LDly4CzHMx+KKC420ia8n1LMBtyRgmHmN//ZoQTbcEJ9oYXZRd34
 qj7HcGYLnzYVIn3dOwtmUSVTrQ5lR/+RNpwStzsEhltu9oo8oOmArgI1jBcwUHVdOk3p6avIu
 hjbfIRz+ZXo2jbSLxAyznkDqNlqJD2PArGtpLs0/v854ki42dwWkSO+grWGNnvO7oq200C6w9
 u/i7hD9TKg5MwXcC2rbQFRC62kXKFsZ6C/po7hg6xlafPHFizX1J0TJFBv5Wze5/+Gh7SX1fr
 ySsbt2Ux1v5ca2uNaV/mrt4sTnDFe64lQhc4lwFfc8GSKK4LDv+I3+71qzq5uYT7cy/YThfwc
 gYsq/T/FO4muGpbU9SF86LWc51HWDDh4LA2vxGd78WluxyuyB81Xtc4rG0mTtrXK1lqDCkTm7
 X9UrA3QMyhrcRH9IOl2HZ5oneZDd4hL683+HUDdk0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>

Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <1d0aa8142a10edf735dac0a3330c46e98b06e8eb.1570208781.git.maozhongyi@cmss.chinamobile.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/migration/stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/migration/stress.c b/tests/migration/stress.c
index d9aa4afe928b..0c2396469344 100644
--- a/tests/migration/stress.c
+++ b/tests/migration/stress.c
@@ -192,7 +192,7 @@ static int stressone(unsigned long long ramsizeMB)
 
     /* We don't care about initial state, but we do want
      * to fault it all into RAM, otherwise the first iter
-     * of the loop below will be quite slow. We cna't use
+     * of the loop below will be quite slow. We can't use
      * 0x0 as the byte as gcc optimizes that away into a
      * calloc instead :-) */
     memset(ram, 0xfe, ramsizeMB * 1024 * 1024);
-- 
2.21.0


