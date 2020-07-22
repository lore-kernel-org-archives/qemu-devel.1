Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E86AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39AC20787
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39AC20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyIrM-0005ET-8P
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 13:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jyIpz-0003ew-OU
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:47:27 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40519)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jyIpy-0000ZX-4H
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:47:27 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MQvL7-1kDLHe3RSx-00O0ho; Wed, 22 Jul 2020 19:47:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] linux-user,
 ppc: fix clock_nanosleep() for linux-user-ppc
Date: Wed, 22 Jul 2020 19:46:12 +0200
Message-Id: <20200722174612.2917566-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722174612.2917566-1-laurent@vivier.eu>
References: <20200722174612.2917566-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qRk3mvJqFrFFsaLxOZzBIQJZ4h4SWGFQegvzr4AVId6zrcJYVCP
 YLsl2IKIhMR1Kj+SZuHvmixkiKu9xpyzifJa3rQsYPZ9bcYRI+vsxL3rbsKHNjlMnvpnfRe
 qdXI5h6wfGcCOh4oTHVIKwgg1RT9FaleHn+UOSS6/5ksuZ4WIA8dJs2B0zOaMqPCa2Ppb2m
 g5fPlqIPM7edgHtBzLM6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EWjAxMYpbhg=:zMG6Y5l5WHWLt6tOa4jBLN
 1brSIkbJveFkRH858bxf5965BXGr1zpA397ZvQpmAFa+SXHFQKWBnLFaa8BODnv8HcXeIJRcL
 C1fBJ1MSJYxOvhfgOMEmzLBh5XLcCsbc6f5XWvjFNg69TLi+3lG0DYtr4HRXoVt/25bfN9Nvi
 /W5hhgPIbPMJ4S5pHkasbgniHA/LOO5VolsZYnyUqphuSS/BaF5upW4rXp4QSZtxZf/Q4z/fX
 8ivt9J9NNFxeIPHaj4K6xQrllILGTp6LOhC/Frx5wc4zASBPB60n8Xz+hsOkgUwesSzOOUqZm
 yd+UboOt6frLCCSbUn0suj7oYwTJMSIsK3pzHrhDDNOWXC6Z5EUZuVrUyV/vpP09A26/YzHWG
 H/jKTMex530OPYb6qdlsmbzt+yplz/VUtjLOvF/T3np8YedLddUqKnWrlmTiHKtaabEwdXII4
 iBVM6MCIYGmVmvMdcKYleQuwEIc42cELsI46RHz3YtvzBAAxeSv4jMkb9jAyd4MgnH/m7vaUj
 NnB8LUOLDNvbbRTO9v+3Ca/evJSDFwczMbixQutpZpSjfkmZBxbi0zaTLuTS4GI8LBRKgvB3d
 +21FcqZFQ0kWaCe9rGOcmYOIxbbRcKc96y4J1NTCz5eqFcx4zsuTmOphykoqrS7n/hdKfJsyK
 XGrIzOTZ77KTRlgKUuUW3KLOu/5ynirhA64Fx+Jshr66fkFRxzAlP0m/2HfDLBDqWCW88qUJt
 eRZrwyebyXSOfkT9Zl2qtpal4L7/uBHaAn6CUq3dO4Mdq2oj+1AgZOjiPITDqYj4Yw8CiPLaH
 NzqPVhSgQ3e/7LAydgokIkcmbnieRe40wFg2Jcsp3XzpYeEMf8YLUedtZizDzrjI0ZpOsOFqi
 gCanv+EmIzHB2JSAzVDs+x4tDWASwaw72Eh0869RcfzZEHqPm8tdoz1gMp4tIOl6g4Hrlc8ie
 Y0YPmqasMYnWcOFbePINbkQ+Elpc1qPryu+ctBZ2fqwmFnHIb6yn3cl3IltStpxm8Gr6iZXQo
 sB1/Yod2AsKPY5iMEhUEpWKsmFtBoksDru5eUxFXMb7CXut9Zg0MJJvvyF4kSz7/rJ+NXbtSM
 gGUQLHthbq2B5htXQCMOXiRmEwfWLxv/FduvR68Qv/0PQ5VVkk/cxRscZ+O0qbPEYCkPj877F
 P20mzdbDz4vKaEHUsHC0YsqyUmgyj7wWv4ed+1yYg82caE2g==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 13:46:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our safe_clock_nanosleep() returns -1 and updates errno.

We don't need to update the CRF bit in syscall.c because it will
be updated in ppc/cpu_loop.c as the return value is negative.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---

Notes:
    v2: new patch, remove the PPC part as ret is < 0,
        CRF will be updated in cpu_loop.c

 linux-user/syscall.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 43a6e283961b..f5c4f6b95db4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11840,13 +11840,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             host_to_target_timespec(arg4, &ts);
         }
 
-#if defined(TARGET_PPC)
-        /* clock_nanosleep is odd in that it returns positive errno values.
-         * On PPC, CR0 bit 3 should be set in such a situation. */
-        if (ret && ret != -TARGET_ERESTARTSYS) {
-            ((CPUPPCState *)cpu_env)->crf[0] |= 1;
-        }
-#endif
         return ret;
     }
 #endif
-- 
2.26.2


