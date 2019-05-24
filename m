Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCB3C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424B3217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424B3217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52736 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU8OX-0000GH-Fp
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 07:29:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8Kk-0005SC-CE
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hU8Kj-00015y-Gg
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:58 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57863)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hU8Kj-00015R-8D
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:25:57 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MaIvT-1h6hmj3NPZ-00WEao; Fri, 24 May 2019 13:25:33 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 13:25:19 +0200
Message-Id: <20190524112520.17684-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190524112520.17684-1-laurent@vivier.eu>
References: <20190524112520.17684-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vWZCbtxrZGHp6JZLg7Zj19cF/UIF8dyMPQqnm7PQN4E+olpYLJM
	LUcQLi6eZJAn5av/lBrlUDoVRq9FyziNqGQJMVRtqUD406VlOCse7UVYCrelNTUMVYnjmPr
	6AzBPN2YsfiaoZ6YOtRdQrdGO/6L4blMqZ9i40Q7HaMm61Cn0mvngjD+sIPAhSbal8jPDNK
	lDKjHDdAUp68rUpD8P2Hg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Laiz8PsXD4=:ZT5DOPHNjWS0AsoxTJb/X6
	cyqd5+mCdsuAIM4BMZph1H9AdADjhkmnzRPYma2UXaW9/79THOMtIYXB5Hlg296qNpqGKeqLc
	j5qPksKS2zVwVNldggU38VBzzPKvNU4Lcd8Osi2icCD6gDMeuaFbU90wUJNGEzSu8U42zhwQY
	BztFFYLcfl7cLMWatJOchPqwDE0UJznDJ8TQ72sMdoBo7Irg/p1BQtjZfTenp9SfZ+K3qL1/3
	mdPWybNAKa6kB2LqAnPwwUzZSde+u+ns2/OadQ13duD9x0Jsltsv54Jle4UDx59kGlZn0ROe+
	IUDMMbScp92YCnv3JTJdP68RPCsQrLoAXggKtlSI309h5fo324ptkoNOsw52em3erVapQ66/R
	D1ppuohHdoKfp0D2q+srcOmwFR511Uyt+Wlo7V5kx0cbm/pbMYWBs5FQSbBycP110Pxl4n3aq
	n1LNskQJfrX0AbmjsYoVHZGawHWneGl/eevlFHlYXyd0FRjSqNyUV5vikJEbySYx9OSMYs3OV
	dp49GXTc0WW/G8sbn23vx24QtTzdxV72cP8CyFgLHO66YXHyc9bX1pg+0ujzxTqcyVUoQ+ZJN
	fB1aqsfyp6RrddgWRx5gasG0V7H67VlKSh6cewi4KX+jw/trEDDrsW6M0ciw7Z6mmfTLXMTqP
	tkr1QxQRLfLs76KEDlw4559w4vCnk6ldOTWwffb9ucvWnTVEIUA65IIdxiW4CRuWQoultyqne
	Nt6dZnAD/8LIcVc8Kb4xoZ43ZPirzy+oVou/eg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: [Qemu-devel] [PULL v2 8/9] linux-user: Align mmap_find_vma to host
 page size
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
	Richard Henderson <richard.henderson@linaro.org>,
	Laurent Vivier <laurent@vivier.eu>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

This can avoid stack allocation failures for i386 guest
on ppc64 (64k page) host.

Suggested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190519201953.20161-14-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 10796b37ac7b..af41339d576b 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -262,6 +262,8 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
     abi_ulong addr;
     int wrapped, repeat;
 
+    align = MAX(align, qemu_host_page_size);
+
     /* If 'start' == 0, then a default start address is used. */
     if (start == 0) {
         start = mmap_next_start;
-- 
2.20.1


