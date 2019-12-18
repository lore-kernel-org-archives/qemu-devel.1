Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D437C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:25:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D5E2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D5E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZKk-0006i6-Im
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:25:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ihYx2-0001sm-L1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ihYx1-0007jg-60
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 08:01:16 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:49423)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ihYx0-0007cr-Qr; Wed, 18 Dec 2019 08:01:15 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MV5nC-1iHkdk1Ik2-00S5k4; Wed, 18 Dec 2019 14:01:10 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/7] test-keyval: Tighten test of trailing crap after size
Date: Wed, 18 Dec 2019 14:01:02 +0100
Message-Id: <20191218130105.125981-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218130105.125981-1-laurent@vivier.eu>
References: <20191218130105.125981-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/KwXnYruHhuy/nH1ojY3/1GqzJ0WO4MwEZBbVG6GDOboRV3htPd
 cAZ+QVOaOBp6mCWigTaXDp/d9P9qDsOYVJ2eWQZ0fFE+Y6qc/MvwirsyHmM82AlfZnYJH6p
 DP1pGiHI0YQ9nr11ruVHSdsX+FdsqriAbsS45idRMq5noF3VIwkwAgu9K5G4VSzUKJawO3B
 pEi2zq/+5FjFLFAbcrkjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Fa4ROuDO5+A=:vyJqNNO23C6nehVvmfnHA8
 euqJL7y7ELHyi0oxpoIiGT6jOaoKyu0g/Cy0UkOdbu2jROvwR750hbK2ERnc3fUhEkuV2NnzG
 9M2IE4s/L7fLGBFc6IUMquM6Yyti1Wx2EWo1bwBUg1tJZ0riTzCujQF+O4hr1uz2fMPYWB8lj
 mP/XciNJkg/pgqUdEzkcfoD780teVd7i7e1bHrzOoe/LqMmZG02GuDI8NRChNwHlZKyfvmjY3
 TrBD8b74IwDsfzLmSJ4T4obn/H9O1j4ib9ioQXZ/FnG5omHMh7hgUM2Ca2FRoZmvB1GpWPyGf
 X+a7RxZm9XsIedhoYYeEtqD462cehzxBVGulDe22/1DEOg6XQ62ogaIIjrUgs2SLfriga2geT
 Y8QtekViipLVMy82qolZWsNFVZAWEd8ncU16jVrw5O0OyS6gAFJkCoFiSqHZZ0zeN9vXP3baP
 7nUwiO8j6uWHUJc35blo8trwSlvWOEqDZc8sI5+G1oMWZe0iVyqBiGfV5wvAuKrOqZt7CkCNZ
 KxnCqkee44y5UFZOIy/f2NLRIr3vDvBA1i5rprzd4x2H/YbSO65k6YYUZ3x7ypUDPe/6Tf+KQ
 oizzPBrEyAhbZFP/N/2p9djxxbGcSgXf30vZRIyZq2tRPDfuUkeANthu6eRXyB4t+qsMFyy4H
 c8UefFPkNp47Pwv6So2od1qqrUX8hZe9iRhZXQyE/65drcyxPe1Nw4z9p9HGovSgYzIKHSzOz
 yFC/a84irI/Z1EIRMGtw5fV42MVrtbonFZEkxCSnKuuVVcHVYnu4VXmmLu9S/c1SnUZxKQ8C3
 e4uNkquxaDJtmNAHUsdTHPLCO9gM2NzT8BECmr8lUusqHrl3gF3goxkkPNGpCjaQINN5i3JWa
 vcQ6/Hc/NmfkvC5LqgEA==
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
Cc: qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Markus Armbruster <armbru@redhat.com>

test_keyval_visit_size() should test for trailing crap after size with
and without suffix.  It does test the latter: "sz2=16Gi" has size
"16G" followed by crap "i".  It fails to test the former "sz1=16E" is
a syntactically valid size that overflows uint64_t.  Replace by
"sz1=0Z".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20191125133846.27790-3-armbru@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/test-keyval.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/test-keyval.c b/tests/test-keyval.c
index 09b0ae3c68fb..e331a84149d3 100644
--- a/tests/test-keyval.c
+++ b/tests/test-keyval.c
@@ -478,7 +478,7 @@ static void test_keyval_visit_size(void)
     visit_free(v);
 
     /* Trailing crap */
-    qdict = keyval_parse("sz1=16E,sz2=16Gi", NULL, &error_abort);
+    qdict = keyval_parse("sz1=0Z,sz2=16Gi", NULL, &error_abort);
     v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
     qobject_unref(qdict);
     visit_start_struct(v, NULL, NULL, 0, &error_abort);
-- 
2.24.1


