Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CDDC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AAB2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGvlprkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AAB2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55149 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUAqW-0004rD-Fz
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:06:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAoP-0003SB-2Z
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAnj-0002OP-5q
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:03 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:42637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hUAnj-0002Nf-0X; Fri, 24 May 2019 10:04:03 -0400
Received: by mail-pg1-x52f.google.com with SMTP id 33so2162792pgv.9;
	Fri, 24 May 2019 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=MOLjMhKSGechndhxC45XWXBaUt38Hb0jpsQqlDASuQI=;
	b=fGvlprkOGqYCx4shyGCXwfblzCKE0Jui6v0XhIbUPpbOAlKZ3i92xPf2Brz9hun9RG
	HrhZw5Rly2nxpT7Wl5fNvIj1bkNcHOkYN3VHLoyph3fV8C1BaQSl5OSOBZGYEXs3e5rf
	kjuQ78sFSR5L092ejLITDJ7t72QPg2A0T2uX8DAEtIWcdXzY7FAtAQQhf15fecaQiYlY
	OnY/Qd/OGXofsKrK43C0ZitTERn62AksTaBSNFWrfgrQABt9ptClsVXd4NpVsXZLcIUo
	BK/1R8kJJLjlMFdbrC5r4OdjkmE8g4ecq+t2A+Efb3jjc/JiNgc6EbIX0bWaGc/xlIa4
	nVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=MOLjMhKSGechndhxC45XWXBaUt38Hb0jpsQqlDASuQI=;
	b=qQRv8o462FApOmSdwABrnOb6ka/ZzOnZMmLb+uqVchF/JLnoAa2cYk3+Efr11aX2Wf
	1ACP9kTbXD4mPAqR6xdC4UoMbNwAFzyNM4NR3jPu/oKHNlvWUah7S8fkrKsZj/dF3xHB
	NV0S6U9hj9r8zl4+rRGlVrCQtDzpZ22VHO32q4bguL818JYHnZZ7UTVV+q2qGU2K1MAM
	dE5MgAVWFRTgAx/lNLYDbKPDm1czVYXtrafodicW5NzvI5ieeoPkgcMstGZKjbN3fhsF
	kztJmOeSUv5YcXCI+s9xf9trOIS3LAAFaE8mgLYwebKDLWMpMevftDGH0g4f/z/rZB0O
	Jv2A==
X-Gm-Message-State: APjAAAXmqEnkGQ2p/l9fgwRbVId0Cy+4GMfGOaLYhHHSnBOBKRkzaSw3
	8xZqvjvXVmtaWCnEiHsxAeiWKfUXujZxmQ==
X-Google-Smtp-Source: APXvYqxI41XB2iojAX6k1A6EenTsYGvVYmRkHnYZX6Hi+pyNFL0uIouqGFdvoL94qtml9EdtvhXglQ==
X-Received: by 2002:a62:2e46:: with SMTP id
	u67mr114236791pfu.206.1558706641550; 
	Fri, 24 May 2019 07:04:01 -0700 (PDT)
Received: from localhost.localdomain ([120.57.120.132])
	by smtp.gmail.com with ESMTPSA id
	u11sm2556766pfh.130.2019.05.24.07.03.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 07:04:00 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:33:29 +0530
Message-Id: <20190524140337.13415-2-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524140337.13415-1-mehta.aaru20@gmail.com>
References: <20190524140337.13415-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52f
Subject: [Qemu-devel] [RFC PATCH v2 1/9] qapi/block-core: add option for
 io_uring
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
	saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 qapi/block-core.json | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..0e927b247d 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2776,11 +2776,13 @@
 #
 # @threads:     Use qemu's thread pool
 # @native:      Use native AIO backend (only Linux and Windows)
+# @io_uring:    Use linux io_uring (only Linux)
 #
-# Since: 2.9
+# Since: 4.1
 ##
 { 'enum': 'BlockdevAioOptions',
-  'data': [ 'threads', 'native' ] }
+  'data': [ 'threads', 'native',
+            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX)' } ] }

 ##
 # @BlockdevCacheOptions:
--
2.17.1

