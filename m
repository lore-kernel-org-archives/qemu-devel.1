Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAC8C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDF721783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDF721783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUT8Z-0001wS-Ri
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:11:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iUT4s-0004uT-Mg
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iUT4r-0003Gv-Ix
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:07:14 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:49925)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iUT4p-0003Fk-6M; Tue, 12 Nov 2019 05:07:11 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MnIxu-1i54Mr1TPg-00jH64; Tue, 12 Nov 2019 11:04:37 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] ivshmem-server: Clean up shmem on shutdown
Date: Tue, 12 Nov 2019 11:04:28 +0100
Message-Id: <20191112100429.11957-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191112100429.11957-1-laurent@vivier.eu>
References: <20191112100429.11957-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yLDYQSxCQhgDFCTR/0qu35xiPvOF8VZbC2a+Ebcv0epbuMBNkmx
 CP1zi4n5zQjav7AqnIWomZZz/quxwTZKg0/+qD2wWDu/u9pGpZ2iAUvUB0/43juXi39RWqX
 SDrm04iLaFFDF7n6vOA6zB/sGi+XuoEXdXZPsZgA74bx3vyYWIBOxXu7kIONW+FI444zeTj
 j0M7ggTQpem9C8IU1Yngw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q0vKXxH5xSE=:dJQhLkVNwmWdEel8iZ9YYr
 JEfpHyETccKomt3HrInEOi7QBk5ZB9mn5bYlI3eQSZk6q5Je8q3kVlDNdDgbP+uY3Ik0TlOFD
 GC6UQoDMt0uyqqhKZyspZS4rCnURVlVP3Wz8Mgk5VycU2QoZUpDLOmwOP6X6gi93Fxrk1YTTI
 gaNdOG9KtJ04OqKU0KfeitYXzIysUyOa4qlrty3wWgTADpy5gZ0SQ11DvRNbtcoXC0ruE/HJ0
 8qQRV/R1q8QMNNG1CMRCBq88Nkaz5DgAK9L5lR/aK3TSCAaC6IjqUrsazMo1pI0ub+A/LF9nE
 ExZf7sYfAmUfqCQOXCj6UGRNNPbiii2+0s93V3rDV5X1PFRCGjtkVOz04G15AC5749RnhC1RM
 ywY7VCykZlwBO7BCmYUnSWa1YLvSL/l6IGZDC5UGBKkQbX4pO5TRbS92ppunkWgVFVvIUi2Op
 emiVWWP4f/kMr0pl5CuM36a6h8IzR5FHnuYf1rWCM3bR9NWtUi7iW5pBd6vdLj+v8NUBv7ojE
 GpxZYrODM3zKzL+I5AG6PBN2xA1UDZ2GC9cbFTaNjlm8B7i4ejY4T65hqXBSmUl/AlN76TW/J
 +URqP/41GhWjiDkKMRy0qvCf9hBmUnUmDadSoGh+c2roRN3JkGB5E01PpoH1TLfaVDHI1ct90
 6iKgxSc3xDQa9G494ly+b9nSZuEpH700UXyBn7d4DR/TE6enVCKM2K61DZqgjZXkU7biYPhDF
 +gtetCICcapJl7rkAWaV5we9NqzbGXcs9Jxmr4iiTKX7Yd0alYU9EZTqFeQTzaJHjxlcJoxqC
 mPXJSlURWeSDjTKbj1HgcCZ9NO54hsz8jYf4YODPa72kiw88hUay9qY6EJczBFMvbqCmOfR3a
 /MZ/h3sTb11BWBTsP12g==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.10
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Jan Kiszka <jan.kiszka@siemens.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Claudio Fontana <claudio.fontana@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

So far, the server leaves the posix shared memory object behind when
terminating, requiring the user to explicitly remove it in order to
start a new instance.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Claudio Fontana <claudio.fontana@suse.com>
Message-Id: <d938a62c-7538-9d2b-cc0a-13b240ab9141@web.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 contrib/ivshmem-server/ivshmem-server.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/contrib/ivshmem-server/ivshmem-server.c b/contrib/ivshmem-server/ivshmem-server.c
index 77f97b209cb9..88daee812d65 100644
--- a/contrib/ivshmem-server/ivshmem-server.c
+++ b/contrib/ivshmem-server/ivshmem-server.c
@@ -353,6 +353,9 @@ ivshmem_server_start(IvshmemServer *server)
 err_close_sock:
     close(sock_fd);
 err_close_shm:
+    if (server->use_shm_open) {
+        shm_unlink(server->shm_path);
+    }
     close(shm_fd);
     return -1;
 }
@@ -370,6 +373,9 @@ ivshmem_server_close(IvshmemServer *server)
     }
 
     unlink(server->unix_sock_path);
+    if (server->use_shm_open) {
+        shm_unlink(server->shm_path);
+    }
     close(server->sock_fd);
     close(server->shm_fd);
     server->sock_fd = -1;
-- 
2.21.0


