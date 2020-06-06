Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DA4C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDE2206A2
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDE2206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYjU-0002jk-Kl
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgO-0006wA-BD
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:20 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:43461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgN-0007e1-BI
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:19 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MryGj-1jDSb13tf3-00o0iB; Sat, 06 Jun 2020 15:16:11 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 02/19] linux-user: return target error codes for socket()
 and prctl()
Date: Sat,  6 Jun 2020 15:15:50 +0200
Message-Id: <20200606131607.1250819-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GH+GrF61wHfttu5TUBrKLAny1ovnhkSV9hrq+T78UXDQd2VTHXN
 v8oOSdcx9UAFcnEz2F6AcL64oi3dDbAyNdy7XV7woA7/sUKFD1v54ZEvL1OkB49lE3fo1BR
 m9nSHkRFiS7aXkGFSein0PMPqc3DfzfpgRf0jK4qXZRz8OaWaE1uxS8DEbpi6bY+6rrB8ow
 ZSi/56H37FvvVu2nrIz9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zUKadZFEiHw=:jXE6eTZp9BEDYrUzZBw8FJ
 ia9iyFbyY7ypzCOTZ4ItB05eNnrRRLaG4rTyzkytKBXkf57hPHCzCra2EiG5YMjBmHI3Pks4W
 OniFcXnWVMBq1ttwCDZQSv6QnPKSiUA7kPhvvBi27RZ+Ap5GLFKgtWGzemMFvRS4hSjg8TuN7
 LEAMwxk/h3/vlHWZxbLb/ZfuzYNMCMIZeTav3gHR+vRT/HIE9hVwQ/0Z3atyauo+XoxlfNetI
 p8VjM6PXP9vD5QQKwG3G6dpI/yYtOwtFfTHpkeD9pUj/ZIM5wJFa3AWX/o+Yl4l/CUOir1vqV
 tqWGD9mCubMtvZjAwSQBIlszN0tlTeFpJyJ5h2XMqVlOzwq0tMUf2hFBijTo6D8kuetHDBQot
 zumimwtGrCyNJxC20vgzTCnSNWL2iuZatAV6kShLnn2w97dOZ/EBjtNDjx7OYIgUS06Ukq0ve
 ZDwJ6osgoEF6a/xDwi71hP11is7Cbsylzr2tH7ia7HXyQ60cvLFYASWV0kE5ZIj24HEuOH3+k
 7TBIhFU8mhZIvYHh06oFyBg1ve6WJQ5w/hkwoW/OtSEPC6rQQpjB/8dEI834ilBAXgkr8w5xq
 kufYE67lOAzWHW7W+MaZ8Mj1TKquQs1YKyzovbkBDefeHcoD2Nurmq2PbXVXkz0cdd8eP+rQn
 swAAoJBuwg7ic17Syl1aKKSjHLV/ve90WsLJAJ5yV1YmVhdXdqECHI15Z8iPZD0XTdpBPc7+2
 p5EV0OGf4r920Ga0Vk199s+rkQbJbL01TsLqmQqC1BMgruUnpJ0mrYxjj/phYWoXvhtrCCeBX
 MsSS8Q4g4mU9dKfL3W5k0V1sJ5s8Yc7OOnxOvezGsdSnO/gPBFhpZOViS7qWLL2m3ULV2FV
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:16:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Helge Deller <deller@gmx.de>

Return target error codes instead of host error codes.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Message-Id: <20200424220033.GA28140@ls3530.fritz.box>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e89b815ce983..fd5c4f1d73e6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2987,7 +2987,7 @@ static abi_long do_socket(int domain, int type, int protocol)
 #endif
          protocol == NETLINK_KOBJECT_UEVENT ||
          protocol == NETLINK_AUDIT)) {
-        return -EPFNOSUPPORT;
+        return -TARGET_EPFNOSUPPORT;
     }
 
     if (domain == AF_PACKET ||
@@ -5856,7 +5856,7 @@ static abi_long do_get_thread_area(CPUX86State *env, abi_ulong ptr)
 
 abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 {
-    return -ENOSYS;
+    return -TARGET_ENOSYS;
 }
 #else
 abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
-- 
2.26.2


