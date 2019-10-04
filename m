Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAE7C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CBC207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CBC207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGN9O-0007E2-D9
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 08:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iGLLA-0007Jv-Sb
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1iGLL7-0006JK-Mn
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:01:39 -0400
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43]:12948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1iGLKz-0005ul-I1
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:01:37 -0400
Received: from yt-mxoi1.gw.nic.fujitsu.com (unknown [192.168.229.67]) by
 mgwym04.jp.fujitsu.com with smtp
 id 255e_808b_6e3b8c25_83d6_403b_96fa_b1a4298d9cf8;
 Fri, 04 Oct 2019 20:01:09 +0900
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local
 (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
 by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 8BB1CAC014A
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 20:01:08 +0900 (JST)
Received: from g01jpexchkw35.g01.fujitsu.local (unknown [10.0.193.4])
 by g01jpfmpwkw01.exch.g01.fujitsu.local (Postfix) with ESMTP id AD4A569228E;
 Fri,  4 Oct 2019 20:01:07 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 g01jpexchkw35.g01.fujitsu.local (10.0.193.50) with Microsoft SMTP Server id
 14.3.439.0; Fri, 4 Oct 2019 20:01:07 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <virtio-fs@redhat.com>
Subject: [Virtio-fs] [PATCH] virtiofsd: Add pread64() to seccomp list for
 posix_fallocate()
Date: Fri, 4 Oct 2019 20:07:58 +0900
Message-ID: <20191004110759.32665-1-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.128.242.43
X-Mailman-Approved-At: Fri, 04 Oct 2019 08:49:27 -0400
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
Cc: qemu-devel@nongnu.org, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I test virtiofs with NFS 4.0 as backend and notice that fallocate
causes system hang (kernel: 5.4-rc1, qemu: virtio-fs-dev branch):
 $ mount -t virtiofs myfs /mnt
 $ dd if=/dev/urandom bs=1000 seek=1 count=1 of=/mnt/file
 $ fallocate -l 2000 /mnt/file # system hang

This is because:
 1. virtiofs supports fallocate syscall while NFS 4.0 does not.
 2. virtiofsd uses posix_fallocate() and it fallbacks to pread64()/
    pwrite64() sequence to reserve blocks if fallocate syscall is
    not available.
 3. pread64() syscall is prohibited by seccomp and virtiofsd thread
    is killed by SIGSYS.

So, just add pread64() to seccomp white list to fix this problem.

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
---
 contrib/virtiofsd/seccomp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/virtiofsd/seccomp.c b/contrib/virtiofsd/seccomp.c
index 93b679271d..88b61bca42 100644
--- a/contrib/virtiofsd/seccomp.c
+++ b/contrib/virtiofsd/seccomp.c
@@ -61,6 +61,7 @@ static const int syscall_whitelist[] = {
 	SCMP_SYS(ppoll),
 	SCMP_SYS(prctl), /* TODO restrict to just PR_SET_NAME? */
 	SCMP_SYS(preadv),
+	SCMP_SYS(pread64),
 	SCMP_SYS(pwritev),
 	SCMP_SYS(pwrite64),
 	SCMP_SYS(read),
-- 
2.21.0


