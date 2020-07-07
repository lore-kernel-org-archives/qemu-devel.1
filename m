Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47214C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE3E206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE3E206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jslGO-0006gW-CU
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDr-0001WD-Lu; Tue, 07 Jul 2020 06:53:11 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jslDp-0000NK-R3; Tue, 07 Jul 2020 06:53:11 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N4Qg2-1kruOW14zO-011UiC; Tue, 07 Jul 2020 12:53:02 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 6/7] intel_iommu: "aw-bits" error message still refers to
 "x-aw-bits"
Date: Tue,  7 Jul 2020 12:52:54 +0200
Message-Id: <20200707105255.362318-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707105255.362318-1-laurent@vivier.eu>
References: <20200707105255.362318-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Tjxij94jaeCZuREeSdluUcIJZxXxYNA+lTOYf6jE3evR0QxF+6w
 eYp5VY+Qn1vQIrbrSJyYFAVFKXGt9xbQUTOUGBdmZmjdHahiNmZ+y/zfrneOun2KqMjZuGB
 /S96OUlMu+2fpI262zUr/1p+SMCDrPLp0i5YfxDWpiY2+IhoHOL0YRagT5ls4lS5eERflZS
 5CFywyDks0E9cqzTf1+WA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/1/l8sSZFUI=:Ksx3k/xJG6PmVt11Q1ZtRk
 UsPcRkK4dWxBDQLjY63674+WIQEI22wKo1GKWPWh+lHZ6OhwjoPVqlONPBJ8y0/dJxYKYQnCd
 3QKwM9uoG5zyIiJUwKozwXd29TVtR7R6cNPX3tdOembsbCDyGmRuIgghFEoIjE8TT+zYSvTRY
 fTYtOiXPDKSTAFRSnomDhSLVZ1MDVJaMb+Z7rLNbZ6wE4tpO9yW5Flrr7wtw18y6azMn0/ruK
 hU/eUbPjPmfYhbvjA1vQsFhLEquGw3pByqE6YCImaM2GT8yParEcFPsZDEcXTS++jBERByP6p
 9lw2IOL0t1+MLy3Aj3o6Hwq+YQduNXolFFG8TnHWYg3rnbnB8dGdJtbSXwDbXd2aDxNqUhcqc
 FYjw85gQuLf0kWp3s4KpNSqP5VUj7mT1MwjrtbH+icGP1sYRrUmgM4nR0J9fShw1hyr7E17Ze
 6Y643GDqP6tYYOZOz1+sP8669+dhSWzu8dNRE8LlynisrCAaBNdp9qUUaGOBBH/LD99jl2w2n
 Lkfmw+N9T7WoBowxcpfK3XBmGrxMRA5SLUkpURoQcHZtqBPzM5169H8CEXxT2goo5BPn7dwvj
 nIzjTlDX2TQHGgSvJhQs6HkZmvpG2Y98EWaHuTpS25YoZPQrQbn1SvI1w+lZ0rdWEAP+cBHHg
 SFbHOYWDJqAsXCdIfaehlPjB+LoWfTZHavRSZux0CzU5mr7skM/A3+yO1+Plbo9bkQUUkPW6z
 hILstGqvmRLHP5Pm40AstfEDKpM7pB6mqFQUuEepfGSE2DofbrPMYaR7/ZEMADDUJ718NogRW
 9UW8yD4Ap3B3h+5pDOkE8KgOjuJ3F7O1QCGSRdC8U6g6iddzbdN9Xz4aRii0i5ohk9Pt9Fp
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 05:54:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: qemu-trivial@nongnu.org, Menno Lageman <menno.lageman@oracle.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Menno Lageman <menno.lageman@oracle.com>

Commit 4b49b586c4 ('intel_iommu: remove "x-" prefix for "aw-bits"')
removed the "x-" prefix but but didn't update the error message
accordingly.

Signed-off-by: Menno Lageman <menno.lageman@oracle.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200625155258.1452425-1-menno.lageman@oracle.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index df7ad254ac15..c56398e99177 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3758,7 +3758,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
     /* Currently only address widths supported are 39 and 48 bits */
     if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
         (s->aw_bits != VTD_HOST_AW_48BIT)) {
-        error_setg(errp, "Supported values for x-aw-bits are: %d, %d",
+        error_setg(errp, "Supported values for aw-bits are: %d, %d",
                    VTD_HOST_AW_39BIT, VTD_HOST_AW_48BIT);
         return false;
     }
-- 
2.26.2


