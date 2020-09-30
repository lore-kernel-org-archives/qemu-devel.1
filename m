Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3DBC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59ABB20754
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 00:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59ABB20754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNQ3d-0008BX-BK
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 20:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kNQ1L-0006OW-I3
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 20:30:59 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:45257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kNQ1J-000899-Hl
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 20:30:59 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MpUMc-1kmboZ2Hy0-00pqgM; Wed, 30 Sep 2020 02:30:39 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] linux-user: remove _sysctl
Date: Wed, 30 Sep 2020 02:30:33 +0200
Message-Id: <20200930003033.554124-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930003033.554124-1-laurent@vivier.eu>
References: <20200930003033.554124-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Wto9uzI6F5LhnJHCoOF2+rgDB97Fkqd0KuTQvpRn9ISYARb4YSq
 zb4AwhIxQBX/lA+u3QIw88ENdHnxCHgqtjzjXzVybVUlSnya0voZL69TR/8lgGMva1QzoMY
 D0lvS8OzQ4VKFFlmwXmaF+Hv05wWMGF0zmln7RtbZPmTTdpOyxmcXsGor5yOx8knATlcB3O
 YhMc3hPwHwWE9DhTPC11A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:arlaqLgjU24=:ER7/TSc9Oat6hErjb2e8u7
 SQ5vYZ4Z1JS4TYvKXjNKQIggqnJBJEtYhhP7dLDtLAXC5wh9aje1zhiC7iPhktwiESv7HD1Yd
 IQsmXwG4gzaqiLxsSm/lnFQk1bVvO+Xm8s1Y3XAVIDLksg23BT/tpuEx95qiRT/NTZxpsEHEF
 +EmUE3w2FbqMyqSprQIzGJLAglS2EBeG458vyJ8WzvN8BMPtyoRV4bUyvI/G7y2Sxm08Ba/xO
 8DDBMqyaUqEUpbF6hkDqYHX8iKvfDH0K/a7BkkB2wkuztTZD9e7c6+wcAmFGRIkERd89TFAhS
 0LxwNmtUbhwBAsfr4GrdfL+4g4x34Uo3GuxLhvve2lBtV2QXK8MY/8kTjh17NPOmazW4pp62K
 nx7YrzmrtYAFlxvzjeB5scDfFJfPMRA+aphKNy4kW/teWw2IhZsjJtEXgGWg+J6GnX+7a6iUb
 p1H3ujdB4bni2AR1/CuE8jQOQfGsN3Ae7mBJJdRqhDFE3vy1QpixJ4QcUyiQm+fMSLwpw12mj
 up7lr1ZYv1Md9HDLf/0w7MujozTQ6yqD4E4QkmQc+rHgjXmTbtpXXh0x5K4btSilF18rhorH0
 h+QfwInu5yWGlHHZHi6gKw3l6s6l8UhPUXiJ9XcG6iBtZIxBJ0gehTBAxVsv1GKQpPdwuRMIX
 sWgen9nZiNzju79SpT1heh3EA5Suv7MHiyRiW01c7c0etp1kW0RrNEJA9eJ5K45dT6h0EwZfR
 5OPcrAxtdUOqE9UxVxIZq4FjNu/7H/SraCQzlVbhR3RPALuVnqokOerzHo/tMR+7e60sP38AB
 PxHvkx0XlH7d0hIluKKYoWUAkRtJ0B/b9HCDj3KMna8xS39BiUpoApAvPBX8kAZtro0vWsC
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 20:30:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.614, SPF_HELO_NONE=0.001,
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It has been removed from linux since

  61a47c1ad3a4 ("sysctl: Remove the sysctl system call")

It's a good news because it was not really supported by qemu.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 897d20c076ce..0cfc95088fa4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10524,12 +10524,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_NR_fdatasync) /* Not on alpha (osf_datasync ?) */
     case TARGET_NR_fdatasync:
         return get_errno(fdatasync(arg1));
-#endif
-#ifdef TARGET_NR__sysctl
-    case TARGET_NR__sysctl:
-        /* We don't implement this, but ENOTDIR is always a safe
-           return value. */
-        return -TARGET_ENOTDIR;
 #endif
     case TARGET_NR_sched_getaffinity:
         {
-- 
2.26.2


