Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CB7C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:00:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D1920724
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D1920724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9rTf-0006XS-0N
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 11:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9rSr-0004r1-HD
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 10:59:21 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:52415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9rSp-0006dz-PQ
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 10:59:21 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MrgcU-1kxGiW1FZ6-00nljk; Sun, 23 Aug 2020 16:59:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] linux-user: Adjust guest page protection for the host
Date: Sun, 23 Aug 2020 16:59:09 +0200
Message-Id: <20200823145912.1171738-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200823145912.1171738-1-laurent@vivier.eu>
References: <20200823145912.1171738-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uVSC+BN8iffnkVovJ5et5KG/MimAMbh6ytMx2N7MYhuKxwm2lXf
 pm5282ABPtW5oxmMgi8dvLGg1PHoCBh7R9znGic0L6LkcjmsD7cP0i998jpvA9vM43rDp8m
 JWTsw1dGeO4sD83jxN9m3iJJDSDodXoDjPEv0n3TLlAWSHCNjM7JDF0NozNvdcJNDr0kOi/
 oDB4YsaeOXMh4iPgQObnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+930OTmX7ew=:8+r9hGeTbX+k/Jokb28Vju
 1WkyEYFeX/sgS41Z8vCpUedbsFB67c5ffe27pzM/1R21p9TlBWPE5Zw5kTgu1lbW7mnUoG0Zr
 QZZrazNnfOdhYj9mK6cxXClavvpJuBWinxIyhAQMvNI1FFIQq0sGQKjGJpVA/ye5oVN5ga8X3
 GLU/hQ2BpfXUU9twhnGgy5g7GVJ201N/JvjDCfK+oeGiVpknnfmbjO8s3IgiavRTzd5OF83bF
 q522eFKL8FljtGwr/NcceQhrVflAYd/SSBVt4RKgum7Q/Gs4LG7rGpwY4SN7BExSJMKyHptcN
 2h+2GYrNXeJ0l6QdOhTYikltVlk0d/ePaTqaV9iw6FRkwOvttnuO733D8+fS4mGDsN9AKSjTu
 RaC/iKJQl8myWOCSu587DVMX+JnCfVBeP9mZipcelC/u4ZBYqQ/X9kP4+QeEri/n3J9UkqgDI
 dA1dKcWqke0siqB7SsKZgLGimX90e4r32lFTMBrhaIM1s9F2iKlM5g+w7qxG2TXKn1hLDA3R1
 Vl0/OkYIbSO5NN/QZAcXTw1+dpxtt1m1+xQNeez/wsAdMXnBxeC5kP3g8RkoJDoyMsnjUXvUC
 bxqvgs0QNSgQx+0r6GTlJh6AgFvYlHz1BKw5Ixyn/3zGtcX4KxpfJ/BBGGirbvbtzBIW9F0b8
 3dals+rooEVUAS7G5rLzuvynzXkDRTCmyl7fi4KMBCkBcYSbqCVOzYfXPWG05qjCDKrqsw9ET
 D96FpSUc2ufv0d0Y79al93nJgsuqPybMeYBqGl1e7/IbK6pnIXCMAOC4sdSQhRNWWjyq+Zhjr
 eYHeeakIbNpQYj1gIesn8TcMWo4e2BJJYKxFmb5yHMtCdYOKZAhsy8kEOSCyIpqIb4pC+m6
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 10:59:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Executable guest pages are never directly executed by
the host, but do need to be readable for translation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200519185645.3915-3-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 46c7eeba9bd2..f2615634201d 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -76,8 +76,12 @@ static int validate_prot_to_pageflags(int *host_prot, int prot)
      * don't bother transforming guest bit to host bit.  Any other
      * target-specific prot bits will not be understood by the host
      * and will need to be encoded into page_flags for qemu emulation.
+     *
+     * Pages that are executable by the guest will never be executed
+     * by the host, but the host will need to be able to read them.
      */
-    *host_prot = prot & (PROT_READ | PROT_WRITE | PROT_EXEC);
+    *host_prot = (prot & (PROT_READ | PROT_WRITE))
+               | (prot & PROT_EXEC ? PROT_READ : 0);
 
     return prot & ~valid ? 0 : page_flags;
 }
-- 
2.26.2


