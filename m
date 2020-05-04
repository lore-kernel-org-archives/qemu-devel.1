Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1F5C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F842073B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F842073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVZnZ-00087f-Qe
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjq-00031r-L2; Mon, 04 May 2020 07:58:22 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:60045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jVZjo-0001yc-Rt; Mon, 04 May 2020 07:58:22 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mg6qO-1ivzfO3x3G-00hgP6; Mon, 04 May 2020 13:58:05 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/20] crypto: Redundant type conversion for AES_KEY pointer
Date: Mon,  4 May 2020 13:57:42 +0200
Message-Id: <20200504115758.283914-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504115758.283914-1-laurent@vivier.eu>
References: <20200504115758.283914-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ij71dasd6aUUvAuk8Gmh4BUmqjgTzMBaXMzWHHUi5ztnC+Py9+5
 BsP46QK/FpKMNIeA9KHKsKPJ/Wn3cZXiqgntgON/NaLqeR+XqSweKl8egrzQbHvPJ/ONnSH
 zyxoeiyVMxPuFEsMS6F8eXF5PMO7jU3ooAdMQ96HasjhJ9aOtx9XIr+p4zzfRKAW7BnYoGr
 ugXPmJfBmTOpIfWBCMazg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z8Cj/S1lsNk=:OSal1EPwiLQ1ysdDI0m4Fy
 bdPOi134lpFET8LIMJ7Q4K/9tB5la0AfyEJLstH2F4w+0TW2Rq8OHzuA5Qoyp3W94/1QZH2T/
 RMrLaOsFurnVSFWawXtMY7o0j4H7FasP2ocOx5pZC4nCnoeQ+d0Jy4bXVN5IjWMSubuiFOSwb
 ZMB+ma4+0tVchG1/Hn6/O2RByqB8qy5sJLfxN851gASBV8dh7nVqgqBwy1+YmniIGc/kBvRVM
 FopFBauITjurxGXVTc3OzoKfrFo8WN3ehjy9aVK3C2z47+WRWIsxUFx7x4WqNBtbtKGaiTXBl
 YDbqIu0K81XKRTLkdVFgi4Mk2rCXa9Ry1ElhzW6Wm8lQ2sx+zAiN2kG6i6OxzPUn750vxy0+N
 MMPMWUcXEUOPrsurnV0v+w19AvEtQ+AxX8ziWOwwNrL9AFEywLYywEtygWpc2nrQWgBWvxNNe
 lyk6f2fJE60Zlf9UkNeWhcdsTwetj0F3eZxwTgYHITIdX8HeyTUWrdzoJ+lC30hJ0McYBlB88
 qdLQNL5ryIRl+B7ZSMdFFY0uDL1xMy8U9PBlpYracMzDcEz68Jw6fnZ+nFx+1Aon7FaoHE7LD
 oiD+iuE0DOzxOAPrOSNzfZEuaILSl1pF4EEJHf6kPQywBTDwYg7f5ds3PFHWXCr13M/giso+Z
 tjVjLla3mK34GbTLMJMaRS4Az+r7KE0QlktC+1HoInQzaP2YbWyCpdHaLxJAV9zErNI/DNLax
 t1kvxe+h+g7esON7H+GCHVFLQZ+HzsYP8Afa/DJhAlqIp7RGlT+frvoC5INmPz1q1PO5bBbA5
 ASJ7BvA0mCOcgbB81xmHBfHEfnpCp8+uStOImgK9YhgkItEdeB9jfjPDm0wcTsfSz6/5nji
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Euler Robot <euler.robot@huawei.com>,
 Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Fix: eaec903c5b8

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200325092137.24020-4-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 crypto/cipher-builtin.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
index bf8413e71a6e..99d6280a1669 100644
--- a/crypto/cipher-builtin.c
+++ b/crypto/cipher-builtin.c
@@ -133,8 +133,7 @@ static void qcrypto_cipher_aes_xts_encrypt(const void *ctx,
 {
     const QCryptoCipherBuiltinAESContext *aesctx = ctx;
 
-    qcrypto_cipher_aes_ecb_encrypt((AES_KEY *)&aesctx->enc,
-                                   src, dst, length);
+    qcrypto_cipher_aes_ecb_encrypt(&aesctx->enc, src, dst, length);
 }
 
 
@@ -145,8 +144,7 @@ static void qcrypto_cipher_aes_xts_decrypt(const void *ctx,
 {
     const QCryptoCipherBuiltinAESContext *aesctx = ctx;
 
-    qcrypto_cipher_aes_ecb_decrypt((AES_KEY *)&aesctx->dec,
-                                   src, dst, length);
+    qcrypto_cipher_aes_ecb_decrypt(&aesctx->dec, src, dst, length);
 }
 
 
-- 
2.26.2


