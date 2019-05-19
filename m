Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA90EC04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7287820675
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 20:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/5t8SuJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7287820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53039 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSSVM-0008GW-IE
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 16:34:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSI8-0005qE-U0
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hSSI4-0007mU-AQ
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:19 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hSSI2-0007hi-Fm
	for qemu-devel@nongnu.org; Sun, 19 May 2019 16:20:14 -0400
Received: by mail-pf1-x441.google.com with SMTP id 13so6147608pfw.9
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=vXq6cXFo3n3RVYR19bI6vVgQuVdOYZC397oTA+hZL94=;
	b=h/5t8SuJPF66yPg5KIK/1+q6l/zoXStcVF83BnUmASs+IJyugUpLxXyx5pkEHO2hpM
	H60lx4VC1JmsMfBFxLoFBP/dDHmB4KUBE1wAm2POAJVNHffSISkK3n1K1/PW6X9dgoSt
	oi42aOs3OfIIss0p1G0wVS2nKOrqanShKyLZ88xgPkyo8JQji5K5/SWyW0OWBDF4MfSP
	52VOditXiH+azKus5npX8TUrWWLx9+/RZGT489fFhCzdhXVjTBb0gyQpfbXS83HotV3w
	TEL56sGRpuijYhDzz3evCXg1VSkd8WbNutAO/vNp8ED01h9N2n9mUyJa3PRMkvpnk6QD
	x3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=vXq6cXFo3n3RVYR19bI6vVgQuVdOYZC397oTA+hZL94=;
	b=YHtAbUFEITZskA8tWuXYnQY8Blc+18qzGHDIxDMILaZ/HBl/Y9K8yYGIcm+3QpK2J+
	gSNs2rigz/0ktmGlJoX8HJsE5YwaK2Qc9lkHSLJ0utwuVF5w8R75Xvu3DxzvwQbdlIlZ
	/bk1pE+0qzl/s8X9a1Z+xz77G1UyvLLJj3MZC8hupFesMpSaXVS0Boj1vx4qR8Mojst+
	TOsjQ/u4tMmNCxHCPB+U+8bzmrMtJS9oXERsrz2yQ+x09fgaJhHBqAoKYzye/n2ZS6KA
	myQUta9EBE2io8XcZhfOuM7ZvjqIwLGa0sL5/xSuSC56ozbLholmrTd5uoGTxSUKtiWi
	QMlA==
X-Gm-Message-State: APjAAAUKjStjMbwXxyHTjVT13q2QkwPVKOegQ9ev1p/D7+K3x3p4Nddo
	f2jKKz7koYghwIMWp2zKNZy8zghcDRI=
X-Google-Smtp-Source: APXvYqyW5CgWr5ssPcFw3NOv4uJ2N2G1k/twgBwCXJ6CUimg/ZXCE5WFTkmnx/+XUQZsJYQ9VLB7GA==
X-Received: by 2002:a63:1e4d:: with SMTP id p13mr71552853pgm.125.1558297212217;
	Sun, 19 May 2019 13:20:12 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	e14sm18166264pff.60.2019.05.19.13.20.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 19 May 2019 13:20:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sun, 19 May 2019 13:19:53 -0700
Message-Id: <20190519201953.20161-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190519201953.20161-1-richard.henderson@linaro.org>
References: <20190519201953.20161-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 13/13] linux-user: Align mmap_find_vma to host
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This can avoid stack allocation failures for i386 guest
on ppc64 (64k page) host.

Suggested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 10796b37ac..af41339d57 100644
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
2.17.1


