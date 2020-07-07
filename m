Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BDAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFFB206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFFB206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jslG2-0005Sa-4j
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDl-0001IP-Ul; Tue, 07 Jul 2020 06:53:05 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDk-0000M5-6l; Tue, 07 Jul 2020 06:53:05 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mt7Ll-1km6xX10Jt-00tU5b; Tue, 07 Jul 2020 12:52:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 1/7] fix the prototype of muls64/mulu64
Date: Tue,  7 Jul 2020 12:52:49 +0200
Message-Id: <20200707105255.362318-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707105255.362318-1-laurent@vivier.eu>
References: <20200707105255.362318-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BUoMo39jGy6GF1XgD/UoYfsWaDEFsIM0YiRFiPc1eU5F/G4+x8W
 kxGOKjQif+7tZEB69NrdVmWuT2ZH3WFCMvJPLoDqjeR/lhuekrIRk79p6cvZXvkeV8mCOM0
 uErjqvYTRv6mKAFUFgQCdXMm438Z8LYGXnWLk/VidyBslWD7DnxAHf/4SV7GgWhLLc+34YR
 SAXaCbA7BuXaxPg+4dKLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1BMuvl2WX5E=:+9ubi42N74bGBUvgEdXGmU
 M3zCsGgFRMy3M61FVv0BK4yVsevSauq7fDHeK8xoQByZaEFHRzlAtdd7mFqOYIzNUimLlyRJF
 nR1F07/bYOWurL3YNLHtQT62n7jCoDRxkfKaZlb0T4w0FurAtaUdvM0JFGQWIrA+uruG1uBOF
 8Njs97gF3iVnLNMsg7o983Ka9YR84hP+RIfSRO9wpAx+PGP+koSFN8uh0knz1x9TceQejK2kY
 MDs+j+2BuKl6wa6hXU5djWShg7sV0a9UVJsMAepJaDEKj8d40T8cKWqCQgTFuhu96aYXSb6n0
 52w4f0RQTRQuRSjOIQHr9U3vPoM+bJDzZZL9DYRCloUY8oeXYpzjMMWx4DSeL57Qey/4EVZaw
 ZsvYknJXN3SX/6jrhzA4G2ezLtkQHgXSnBiKDBVXJ8FdArBMYBhwBulCO4F9xhy9XnCgJk318
 gKgRjbJweAfEN3Og75Wt+WFJSdp9HWZARMHQ5KtSak82JwWFwAtF3DfgTIjsj+Qg4VXa6D/e5
 mHb3tt+IgPDDi3w6atFd5p3ftMgF6fKZK1pmJW1mslpSGD/h4mnLOU49O4jFQ1dKIEgsuJSBy
 B6NV0wzLBoFtNZiEceLC7YvDKuM9hoLdrfnZqO/c1n8x0rm/oQNT/kNv02dgQ9M2GrT1qdSr7
 Pz9BEXsO24SL/Pbq9R1ct8vs09D6XIrptF5rpezhxnVnOObqd9OpbV4tiSukkHvveOT3pUOP2
 k1b2cuYXpHe22UJjy0hlvjjqGwkNkE3KLLBSqcZxWlIFibKDcu0y7bhxlW3zFP5BsQzS4Tlba
 08KXDGzUDrXRJ1d0kp1GhjhiBapsSlwCMgG4jIHOnjZj7mE+GaO/UN6JmW0GyK50vfu5xm4
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
Cc: qemu-trivial@nongnu.org, Lijun Pan <ljp@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lijun Pan <ljp@linux.ibm.com>

The prototypes of muls64/mulu64 in host-utils.h should match the
definitions in host-utils.c

Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
Message-Id: <20200701234344.91843-10-ljp@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/qemu/host-utils.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 4cd170e6cd53..cdca2991d8a8 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -77,8 +77,8 @@ static inline int divs128(int64_t *plow, int64_t *phigh, int64_t divisor)
     }
 }
 #else
-void muls64(uint64_t *phigh, uint64_t *plow, int64_t a, int64_t b);
-void mulu64(uint64_t *phigh, uint64_t *plow, uint64_t a, uint64_t b);
+void muls64(uint64_t *plow, uint64_t *phigh, int64_t a, int64_t b);
+void mulu64(uint64_t *plow, uint64_t *phigh, uint64_t a, uint64_t b);
 int divu128(uint64_t *plow, uint64_t *phigh, uint64_t divisor);
 int divs128(int64_t *plow, int64_t *phigh, int64_t divisor);
 
-- 
2.26.2


