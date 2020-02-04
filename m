Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4623C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9752082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9752082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35045 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1yr-0002o5-K4
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:27:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iz1jf-00077o-70
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iz1je-0001aE-8s
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:11:39 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:44553)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iz1jd-0001Vn-VR
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:11:38 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N7Qp3-1jbANI0sk1-017j0m; Tue, 04 Feb 2020 18:11:05 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/4] linux-user: add missing TARGET_SIGRTMIN for hppa
Date: Tue,  4 Feb 2020 18:10:50 +0100
Message-Id: <20200204171053.1718013-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204171053.1718013-1-laurent@vivier.eu>
References: <20200204171053.1718013-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Hez+TaxwiZ2OgXOrVQURJqgTRNhu9vhh7IwL997qbImZdCkSOCO
 iL6DaVN84nP1Qf3a/Ly0FdaMtAmx50E/b88LiKp/wCw/nLFKXGYKTDnioS+NwI1Qj44HKkJ
 8T6POmK3KbeWyZqb+ZUdGKHeo2IdrZx9krBPtu1ckb56eO6RShIw/CUvmwNNJKyeT9fIlEN
 FjE6DeankRszdfUuKfeRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5iRV4ZfC85o=:knBopFuukOzK23u//SFYxe
 UO1M8apNQ3nDB/f0AiaFJmKGpdB7U9xtzw65maA4UqqyVYgzwpSAd9TolSYkOUg+RD3NrrnCC
 i/2kpaWdoacdheYHq/powQ0rha8ZDauA6RNrUw4tcMuH1ZnBml98cp8stcdMhX1KYnq6mgpDs
 tHqTdOY0kWLafPKHMo2tZnxuSj2ZNx6hJjy9Jvsv0diE70PUPoS2xcWkGZD2jOIoiNjccFWYv
 YxskVKZ/mAADfEJlQkE/z2mWf6v7fv65ZJh4Xyhno7YbF/8uwdFTur4WynXgU7Mfbbit2TEoe
 JzeR2bNDcobCdzAr+0hiinFK38H+SHAZLTxLRns08L8pzhg7cZJRHq5BJvohTMYMoOEnXAZoX
 DdPBcZArNQb5ezCPa7tO7FRQSgwSJL3nCTZ+kWy55MC3qnpB3vSEGUp09s9OW6hMcs7vONPFl
 3zN2gDDUVQcSnIpSHrKQDwbN9ZbJpjNlwv1j/iHXkd9dpfnhewpY6UTxTfWhSPYwNXdZG1Zev
 33hl2Q5ixGtyN1mWK9v+zfNxBZusZvzk4Hi2iuGM5M2Di2pqNvfCMtojdVCHahfzG+7kp2xcg
 EkVYH93FFRGpNsjGiBTxKhpYrf0NZmjkxyThU91Mg2/ROuxU2HbbmSZAZkZmyhvllp+oNan4d
 5vhKQ+ORQKJHRtcrGDa4tHH5HGbkNPseHA+kP1YHwEboHtSVl0v3uIVsK12dd6riPMzS3fjpH
 bofM5+5L0EfhWVWZTa/FYcws8nma+X0rv4hBMLlDDd2iXYMHgnVtq1SVYkq0zJsGb7uGu9FAp
 AFVd3KMxTGgBqtNPefB0V+Fh3Cbf3/XMkMtNTgVZTsIVzzfIQhaHB7wFUEV9VaUOIwFRElp
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Matus Kysel <mkysel@tachyum.com>, milos.stojanovic@rt-rk.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This signal is defined for all other targets and we will need it later

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/hppa/target_signal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/hppa/target_signal.h b/linux-user/hppa/target_signal.h
index ba159ff8d006..c2a0102ed73d 100644
--- a/linux-user/hppa/target_signal.h
+++ b/linux-user/hppa/target_signal.h
@@ -34,6 +34,7 @@
 #define TARGET_SIGURG          29
 #define TARGET_SIGXFSZ         30
 #define TARGET_SIGSYS          31
+#define TARGET_SIGRTMIN        32
 
 #define TARGET_SIG_BLOCK       0
 #define TARGET_SIG_UNBLOCK     1
-- 
2.24.1


