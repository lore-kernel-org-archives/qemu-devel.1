Return-Path: <SRS0=Ju6v=UI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DB7C28EBD
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 14:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5CC2070B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 14:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5CC2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZywE-0001Mb-3Z
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 10:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59838)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hZyvL-0000wJ-Mi
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 10:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hZyvK-0003He-N9
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 10:35:55 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:33035)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hZyvK-0003Dw-DQ
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 10:35:54 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MwxRN-1gd2hq1Y1T-00yOa8; Sun, 09 Jun 2019 16:35:33 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 16:35:21 +0200
Message-Id: <20190609143521.19374-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609143521.19374-1-laurent@vivier.eu>
References: <20190609143521.19374-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AXZhvJDozweEOJWOZC9IRN24ObHQy3q1vdQyrRxM9WM5Ur53O4E
 G3xWbwM5qTsEQ/PJdW39Ua348kMgNTKPlt8Cry2IlSFsqKzihyyv0vZDrZ+1GjTIszKikGO
 Oi1FM/WF/WqXBy4M666Qu5vtUlMxQOXHsEYkkrLEykeI/2NnCouN0lya+cd4upW1jWs8QxQ
 q0eokXkeBdpPxPNAIQQXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SnPbHj1v48o=:OlwErCTFrPQ48mqyqsbQxO
 t+GfGhwP+me0DRq3vnyl5eB7EMssgPVrw07bkJChKk79HuKBksP2QdpeVU3fQGFzyewAt4p7r
 PJ1D79nDBl5QmyWju4AOJqA6g1P8m8dF1NvsHkhbgG9sbEzBLsK5a+e0r4hFQfYnsNO3630PL
 w3ms1fMbKXdan/HAN6d3Q7uPF+O3XyVvW8+cQhVBAGWqOD51ScjBaH9Rf0nfcl9+B7y6Y57iB
 K4SiyciX4igBj5nRcB/XKat9z055iRXoBU22/JtueLZYptgphv03/W3Q6K+aY1B/hAwLz7SUe
 GHIY2kPKbwsAtjbm+32VfncXDh8pNHkJCWRWOgjRa4Cf6MiWMHMn05qw0f73537sSVSujz1nH
 94BZhGbuvKVUJf906L6Y8GEB5HmThQKHdep23Rvfporzvp+2I/EyZGB9jkgniTsLtBycL+w6O
 7Dv1UHfygHtaWFsHuLY/Iq7ibrBaN1pEhTyxYy6DV5eES6pF4eqJ3Nz1thJBUPsdA+HQFPB45
 HsAOpaIc03vURAlwKngw14oj0K18hTUi4kbqH5qkPOPwjjQdxkcArEw/UVRD9bWYEAKf9tVGX
 1wMk5g7QiBNDt1EHNmmVWnkei3xFpReL/v+IEt0jQzxA3eFM29x3q+Xgmfji54lngPpNOhGmJ
 WSCxV1VvRssMQ62BlAE9bWHd3zC4MgxAjYu4nii+wqolqIMBib4jwBlO712CZ0HlXNDUbHYVT
 Uv1ZPbIK0+eo2NtssBTrKk6LY/VZajLic/prH/EI7rwPot22wYG7ogz3/jIbC6WXxNqIQMmej
 N2eluOr
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PATCH 2/2] linux-user: set default PPC64 CPU
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The default CPU for pseries has been set to POWER9 by default.
We can use the same default for linux-user

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ppc/target_elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/ppc/target_elf.h b/linux-user/ppc/target_elf.h
index 576a5b9959f4..061661885423 100644
--- a/linux-user/ppc/target_elf.h
+++ b/linux-user/ppc/target_elf.h
@@ -10,7 +10,7 @@
 static inline const char *cpu_get_model(uint32_t eflags)
 {
 #ifdef TARGET_PPC64
-    return "POWER8";
+    return "POWER9";
 #else
     return "750";
 #endif
-- 
2.21.0


