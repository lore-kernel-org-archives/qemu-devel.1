Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53843C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:44:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10545207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10545207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBeg5-0000JK-4d
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBeaC-00049C-E4
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:20 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:47231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBea8-0007Hm-QR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:38:20 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MUl4z-1k2gQw4A9h-00Qg2V; Fri, 28 Aug 2020 15:38:08 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 14/18] linux-user: fix target_to_host_timespec64()
Date: Fri, 28 Aug 2020 15:37:49 +0200
Message-Id: <20200828133753.2622286-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828133753.2622286-1-laurent@vivier.eu>
References: <20200828133753.2622286-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Qfsq6b94jqQKAP9drriZ6LkOSDv9q1rbn5oZsTi5RTrmRfSYYt2
 JTDkF1a8XN1vTze8cejKdM3Tse1T8Cg7Ysee1dN4EyIwTUdmi1Cdk4JirXtEsgFMIlXdv6w
 24VPSaK55SGrl9sCIGNWHR43Z6sjYj8VtAJ9z4A9TH1U4GdWO8IvJRFkz3WfP+WHRY/yCeK
 BLm8C/0B0nUTPGea+h/bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:File1mpwMLE=:sjL1ljiU5dOKGpYPMdalH8
 dl0wJgLMhmM94K9mMyGDhdQDKnDaIk/OI4l4DrbDyixf5oF7QVoKFqdjeU4s2HWyGRHwnyPt2
 mX0akO46a+p6x3Bjn0WGqZmz14THPoFsMbtxi57yDsMsD4G6GsynqNbEDxuPsQ1tZwc4G8hJX
 FXREF8mEe3/ROcvbQtYlzU57bAM0l6zkgnL42pWJckM+TBRjVdzy6eCsURsPAc6xloVbdQUCx
 xVmH4S6z4lFHS+IxhEEvX+yDpKaRUbgRkNC7CTFxemypLwulc5Uu20p9Xd6w16Yax3o2BDB4B
 xm1IXjsR4TGXyX3gIcaV+Ki7JGTlEsH0kMg4nH5Uo9/qCY2MFIqIULCtUc9X+ZSxqEOyGvvjw
 rSCOL5r7is3caYxJ14txY/yBKG1P/66xfauT0pg+6cKsyANGRcrAy6lRU7gXC9tvnDI4B5FYP
 BlQQSu5ushRAMuRjRt/wefq9ad7jVVC+yxaXPjZQEQ1eTfW5gxKWRbR3IuVZeZVnPuwoBIpgF
 Lkooe2dSCSRG3GghZa1loP1JPQIjmWUa0yod532h29R6y7KaATNALquBrpNxh5cieXQRjhlGF
 6E3abF68nI/qSA1oLNx0kDTtADjYcOzUJZS/uScRxWyOatVMQpmuab5rU8pJq6KDlvYC13HRN
 YmHJTmp0fnh4gRK44SGawFQVrIdEoRh4FkaTgn5cyHg0+1Cdd/lSHnwTvaZL3EEE07hyZ7sgD
 Ab4z585JYZBGP+VoTQ4EZCRR+kVm4nDF0OiPb5384TTFNPdlCFN+4GKciP+NlMIuyXtXb6hjE
 eS7teEj0SkY/I50DlbJSswgmFcbzlASH7YDYChT8qMvqx1sNFRJ8jGBpqTr2j4FuVCTOrvB
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 09:38:06
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

in 32 bit mode, drop the padding in tv_nsec. If host is 64bit and target
is 32bit, the padding bytes will be copied from the target and as the
kernel checks the value, the syscall exits with EINVAL.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200827070449.2386007-1-laurent@vivier.eu>
Fixes: c6c8d1026e75 ("linux-user/syscall: Add support for clock_gettime64/clock_settime64")
---
 linux-user/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fd13e72305de..3b725bbe2513 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1229,6 +1229,8 @@ static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
     }
     __get_user(host_ts->tv_sec, &target_ts->tv_sec);
     __get_user(host_ts->tv_nsec, &target_ts->tv_nsec);
+    /* in 32bit mode, this drops the padding */
+    host_ts->tv_nsec = (long)(abi_long)host_ts->tv_nsec;
     unlock_user_struct(target_ts, target_addr, 0);
     return 0;
 }
-- 
2.26.2


