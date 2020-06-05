Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A865EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 812272070B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812272070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhApq-0001jC-IZ
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoe-0008Bn-2O
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:16 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAoZ-0006hV-FG
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:47:15 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MORR2-1jJakS2Lfi-00PwS1; Fri, 05 Jun 2020 13:47:02 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/19] linux-user: return target error codes for socket() and
 prctl()
Date: Fri,  5 Jun 2020 13:46:43 +0200
Message-Id: <20200605114700.1052050-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114700.1052050-1-laurent@vivier.eu>
References: <20200605114700.1052050-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GslVJEoSAb5CAZu2Hhc+gEIgvNCar4tstMInCj1qUerLfWfrvTm
 ejB3GkORYT8WWiAl6tchNwbQRC9mquFGW86XoNNps+S+6BycESLJtFX1gxON+eTb/W4GZOa
 GJM8jVJDTqEW//phqe2XRGWny4GdCdNvZTc+G9bEydgbkIwK1AIMM3UvP3Lan6Bpcv2OikV
 v7X+7ZJGBxhcgCXl4cukw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rovagd2TDYk=:ElE5WBbd2E7lFSXVhKt80I
 QWU57HULLujUQoeqoVuV2aMpG94TbMakb1eJb2Y1QCzhMh5k+PUa6tDy/h8vI9xBsd+5VdiK0
 odM93lIgfct0pQW7U4wNTGIP71VmR+xnOcRVVhcdWCL4qD6bC5V40S1EAyhRgA5IYvXOqqkND
 6NnYLwbb1SiHvsWSFxQvH0B3HXm4VbderqPLLKIwg8XhzSN9/FLYdPxKtAzr6lM3PmlPh9Iqg
 oK17YozI2G3b4hDnFgcmCwnlE7QQXembm0/Er7vmZIlznfAmbB8fUIt8m8Xc3JkolzaxqZluU
 txiwEPX41WlqN6X7jQk88a4yPPX+F+CKrwaOSKCBuGyPuolO26DZ0SZ2L+uOVxDF7ozWLILQO
 IWk0QiMgolsXD9m3gVweqsMEioXf00raQVCskzciOMCsS2znO3ys8G73KL3JKe8w5VehgQIIM
 M2Hvy2bQnZEHHtBQ3LucZlEGik2pivMzPTlmFk23uqYfzIhb+RMG81Wx5r4Wweg7mYsMyuL3f
 SN/uYkXgRjNBQAynf4sj4k8a65PMOSdWxTvR2q2I46cnUGFX5hPm/h6lDd1Tcxx6fHCXUUs00
 QtyW5n/gPcOrbBS0Gv9uGOmDAOjRNzIUCCuakJvb+0x9P2mQu9fo/wXpuhMprVWexI8/wKLgG
 s7rhDCFNtzHAylr8ehC1Cst2c0vGsjM3jUixd0FSXJr6avQpl6btSwjjkHmUu2sHHQ1Y24aI2
 XVgaCBjY0ECbjfKOgkygP+CaOTvydlLxHoI1zLsGVDXTM4RJZjU0XqdOzv7zWFqf6kjrfngBl
 cSc16pd6ctEqvHPWw0KK7hjuuqW0NxLUW/lHu73fWqmUoLzgSCoWQ47adgloGmlUOoVRxm4
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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


