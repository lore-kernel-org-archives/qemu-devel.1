Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3417C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C275A27F7D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 12:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArvqdYK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C275A27F7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34692 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXmQG-0002vl-Pw
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 08:50:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmKu-0007F5-1C
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hXmEv-0007Gp-H9
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 08:39:02 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hXmEv-0007F2-BQ; Mon, 03 Jun 2019 08:39:01 -0400
Received: by mail-pg1-x542.google.com with SMTP id 196so8225134pgc.6;
	Mon, 03 Jun 2019 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=aXswJJxpFfrIA7pwp5302r5rWLg/Xr77T/ARm6SPMIw=;
	b=ArvqdYK/5FpDAWjfcJN9tc1UQvGEl8RNWETXrGacSHoDfXIAZHAimIzIt0jOahP6bJ
	YKJgIKvOpZnLf/xyLJKSkM+CGQi1CLS9LttFujcZWaFa5PpwuCIxFH3dK9njKAzvp+um
	1c2FoM6q0tDJocU4BRXFDHaG5CGLyQyusUa8Me3L8TEIZGL0ZBPr18Cv32xHUVst6dXy
	QhaAAcNE5f4JyYB+DrhUnSeqIwyum1awOF7zOv5cv95cKU2J21IQXAhd9/xokdisN7dw
	PQVl8zpgWTb4v6jio1JLiv6cwS0BIImfDEA+3or7Un77b3yxawbpRk9kt7XcB1Oc6YWR
	alcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=aXswJJxpFfrIA7pwp5302r5rWLg/Xr77T/ARm6SPMIw=;
	b=hljDC4MI+72nnLY4pLHMd5mw5wOrQC/TtxQKnNdZ/HbAp7fwbeB8Z1qriKzFVEw6Zn
	9CRBnqXN/993b2Z3HasP4FR28tWvs6NdvIOLt0fsOl+4Ev2vv8vEf7nC1iwEvKo7RP1d
	QWPkk4G+qlpLQexXGzvwr49XyMkmE2jseRWlQO5CI/hRHQVysNrV645rSr/9CKl0AGBV
	O/1gUaPjRPa2KsYEem/7hedj22EGWrJTOanKLWaox3pKc2sJUWDON6j6lteHNFZ11rhr
	ocHhVE/sWg9Wzu9n1jwYW2lNPeXnHj+zavrNYpL+fkA5gSTNvKpGzkeCPJtiJEZMK/xB
	Qp1w==
X-Gm-Message-State: APjAAAXIjaFxc6BbyO2jNx0+4KBWggRU+L+b1/DAXJxBotHXXb9cY6Wd
	Susqrr4tHhfoHiMDBCDCVaIcz5oWeC207g==
X-Google-Smtp-Source: APXvYqxwo6a5ZCvVa0+MyJNgh/c79SXi2mFmEw74EQ5TlPYbV65T1Fx5+KuclSKWix3EurXpKOej8g==
X-Received: by 2002:a17:90a:a385:: with SMTP id
	x5mr6474538pjp.76.1559565540039; 
	Mon, 03 Jun 2019 05:39:00 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
	by smtp.gmail.com with ESMTPSA id
	k14sm34860257pga.5.2019.06.03.05.38.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 05:38:59 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 18:08:17 +0530
Message-Id: <20190603123823.32661-4-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603123823.32661-1-mehta.aaru20@gmail.com>
References: <20190603123823.32661-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v4 3/9] block/block: add BDRV flag for io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
	Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/block/block.h b/include/block/block.h
index 9b083e2bca..60f7c6c01c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -121,6 +121,7 @@ typedef struct HDGeometry {
                                       ignoring the format layer */
 #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
 #define BDRV_O_AUTO_RDONLY 0x20000 /* degrade to read-only if opening read-write fails */
+#define BDRV_O_IO_URING    0x40000 /* use io_uring instead of the thread pool */
 
 #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)
 
-- 
2.17.1


