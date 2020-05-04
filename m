Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8614DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:02:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ABA32073B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ABA32073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZnS-0007qd-Cr
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjq-00030D-3B; Mon, 04 May 2020 07:58:22 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:33173)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjo-0002Cl-RB; Mon, 04 May 2020 07:58:21 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MCJvA-1jNMH71Nv0-009S6y; Mon, 04 May 2020 13:58:15 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 13/20] blockdev: Remove dead assignment
Date: Mon,  4 May 2020 13:57:51 +0200
Message-Id: <20200504115758.283914-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
References: <20200504115758.283914-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IrQCQUvJnCBMuzwPerB6rAw1jQmYN+bT1Cvx+93KqSD86XtX9sQ
 O5tJv1kjfJE1EIvQLnqXJR4MeUnxKk7fuFM8qhXnZJ9I43ZqkMf70Wh2GI4ECjxtJxpI49H
 VBCfemjnhy0G9v1VPjRA3b+yClFsawGAizCZXY10edquG5mJB0uYHxrWUuipNDPz3gdCJ1n
 z3F9cUQh3S2RtXsMRAvGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y2mFQFLM/B0=:lwMeXtxT+sVjvIhZR3sI3D
 7dy3wEAM/yRCtRw3vAjQZldLC4OQ4Og4qiR7201APxQoPyfd50e5qPD3iyp81E9OxpRG2cdpx
 I1fAGYBRQWU1aieUdWJBLrBeE6wEMe8D/CHJWPhhxEHWyA2ijyqrin20ZazdHbgH8youlignk
 xP+G/s/3D82tE9EsNWH15oIgmHmYiivIISYzvNDe0cEWIs9SFhWrqKJAj5KYDA2CxXgaPHdoF
 oHUFQYNQdUw56M5XSSkrb+h24qXZb7j3gYp9OIkcBQJ7N+U3Ky5TnNZ9fr3nYKw8IOoH9Wjs0
 eVD+EQm6UdFsP6U7mY8DYHpp40JgOpb+a+sqxbGtk3XMXMRX0sjSGIbdnvhLtOd8zme8h8nuk
 +ybK0sNdOvpXYvGTvP128vL8t2CXNLoMLFwzJnOaFTBLVG6Ry77MZjXlzbfpOAhkbvoOJu406
 SAp7hMyTk4YwV9cxKXPCQxmYsEhm6nO9Czxith1U7vE2uXXrse4X8K3mmGxwPcN4B9kFpRGaq
 OLSlFM4tQWP8pjX+nEc5DKOPeK7VTKJZLJ0K5jgcIqf/fryVIoNlg3U7AOg3Yk8YrBgSYg7oB
 wBmL4+Bc3NvKFgHu1G0LhGr3xfZM0iesCG0rRyQseussc3GDIF/MrKC0QmXGd1Sr+TMdsvqob
 1dCoHCwmDZzi+rNwjD4ovhhUVSWEKCsuNlpe9npLWBKkOpVzyEn96E8qUN0alxjuOpBi9KtTA
 oXmx2oCCkaym/dQNgocSTTr4jbCyLrOpF4teIUX8uUybUsdfPlEPsA5zCNUxBuSgMXFwffKxZ
 O3S9BUWG/G+Kc8zStUgj3rIzGcuanmb18jbbGbAbu7mcPbVX0erLCedxreDSM+gVBLJPMEc
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 07:58:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fix warning reported by Clang static code analyzer:

    CC      blockdev.o
  blockdev.c:2744:5: warning: Value stored to 'ret' is never read
      ret = blk_truncate(blk, size, false, PREALLOC_MODE_OFF, errp);
      ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200422133152.16770-3-philmd@redhat.com>
[lv: fix conflict because of "Add flags to blk_truncate()"]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 blockdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index dc1a0c7c2fd4..708d0c323fd2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2741,7 +2741,7 @@ void qmp_block_resize(bool has_device, const char *device,
     }
 
     bdrv_drained_begin(bs);
-    ret = blk_truncate(blk, size, false, PREALLOC_MODE_OFF, 0, errp);
+    blk_truncate(blk, size, false, PREALLOC_MODE_OFF, 0, errp);
     bdrv_drained_end(bs);
 
 out:
-- 
2.26.2


