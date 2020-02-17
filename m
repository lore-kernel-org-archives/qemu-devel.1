Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DEAC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE862070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE862070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3cn1-0003AT-PU
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j3ckI-0007Zz-3x
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j3ckH-0001vi-5v
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:18 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:42845)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j3ckG-0001ui-O8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:16 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MLiTI-1ilxKN2wUa-00HgQP; Mon, 17 Feb 2020 10:30:43 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] linux-user: xtensa: Remove unused constant
 TARGET_NR_syscall_count
Date: Mon, 17 Feb 2020 10:30:31 +0100
Message-Id: <20200217093031.678348-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217093031.678348-1-laurent@vivier.eu>
References: <20200217093031.678348-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TXXhuvfjPLwb3WIwyZhFkD5D5vViYJZIP3iK/0dADGJwU7tVU6S
 pHfb77V0WHlghNt45gKelZY/sOSj3x7/QOhHbHQwJwN72aMaZnHWaDZUUWkS95xGlg+OOzr
 5INIBelzm+jNNz5MpmRfz1gwlxK71TpjN1C0/ccf3bBCI9uOzd35xxeYref9qu19/7espTp
 nN9LE1G75JDaUfRA0QLoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H9Mb5/sOrH8=:FR1tKWw3HL+CuC3xmPQI5q
 un5JS3v1QN/Z5LpRC7otUotY2GI54tAoHQa92rnTKTVJj+AgX08ZQfSsY8X4xyHBmCAVx5ZbR
 f7pW+yvb7NIn7Hx9RBqni5bt8MUZpPmQ4P3EK0qGJBaYSlMKEtCNzCWTrAGtSwhwWC5My4mwQ
 1IbOhNZH0TrX7hFPxATuN2jtou/xjqcpF5yIcWKzT+Rh3x22hNVsZi7fYqGLqW+yfkMhr+0np
 aCOFGLj7IJWHzgKW8585t+P8PrHjLataQoPdJq0UnNs8T2wBai9+QNyh5/VWJqi+pyaY/RsYO
 s5W/LKlGo7RYyf0zqAJT6zZs8CfWUfpE8zVUzimtkYdEFN5hZ/MSVK2eCmTpacY6MzQGNo4lW
 JllChgo16d1lO7OL+hin884ab1cCBwurgZe2AF6qQyiJtoUlpM4MZ/vHlyz5ih3KyUtTb8dyG
 ch4SH2vq4wqW3zG4OmQVAW1uB6TextsHR0hgwPqc8zANMuqN520ZSpBYwrhi7XqllVz1c3YBn
 Mj07T2Ught9W4vWHi4xuz/v01ABHi+VyZXCQ8jCAzf0/oNAHuNZvF75ZhdBxZLVm96WC2Sc6P
 6/nR0Y06Yachhe7rqbyrLJypsT/X4H7C2ediaqvIMpMkHDO2hjHdRa17wOWbiz2/6T5f/FX72
 eJtXIF9Mpc6suzivC2bw8U2DPUylFngUKXV64RttuHx7aOEOdROQ4iRzaFaAb+v04BVfQMOju
 AZKbNgaIPxwVgoLk6rB3Ozqpe26DQ5RqXo3oWtmkYXDWbj6IPZgYT3vzi8qNAAg4EaJl/D8i3
 X8jWpJSr16PulbTFqZ58OXv/s20dfZZF2G/S+y54GwBuVbnn8o9I7EG/1LA4mp0cOFP8lGd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Currently, there is no usage of TARGET_NR_syscall_count for target
xtensa, and there is no obvious indication if there is some planned
usage in future.

CC: Max Filippov <jcmvbkbc@gmail.com>
Acked-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1581596954-2305-10-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/xtensa/syscall_nr.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/linux-user/xtensa/syscall_nr.h b/linux-user/xtensa/syscall_nr.h
index 3d19d0cb70a6..39bff65dca08 100644
--- a/linux-user/xtensa/syscall_nr.h
+++ b/linux-user/xtensa/syscall_nr.h
@@ -466,6 +466,4 @@
 #define TARGET_NR_pidfd_open                         434
 #define TARGET_NR_clone3                             435
 
-#define TARGET_NR_syscall_count                      436
-
 #endif /* XTENSA_SYSCALL_NR_H */
-- 
2.24.1


