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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFAEC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0ECC20879
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 14:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4855LGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0ECC20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUAtO-00078T-RG
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 10:09:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAoO-0003KZ-4h
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mehta.aaru20@gmail.com>) id 1hUAnn-0002RN-Br
	for qemu-devel@nongnu.org; Fri, 24 May 2019 10:04:08 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
	id 1hUAnn-0002Ql-5F; Fri, 24 May 2019 10:04:07 -0400
Received: by mail-pf1-x443.google.com with SMTP id a23so5409603pff.4;
	Fri, 24 May 2019 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=3FKBJA17va/jv2u1TvUxLDB1xiagIFwWCBsEV/clovc=;
	b=a4855LGhNEYcj8uL4x3QndWURkakTYZkaqqP4d4oYiu192b2tsudRdYqWJjtJis+CR
	aSGOvI1YVvX6dqwTqTGW29AuQf40xqhZzMW8uBfIQpfChhAJ/in/L3PdYlto6au16/G3
	5ax5wdRu9u30VKEXCfdle3XWpyNPfA8vcnGnA/+MbmGNzlxhE5zkL2j8U5tm/FVnsquz
	g5QOxGHjg0Y9Jgj5ogUH3+oETzqsGLFsaX2i6EsUFxEmqAzBGWm4dqbxNUg6KBJ2TuFT
	NU9Bdvp+D2+MKrUfzrC7D7k+SPYLQkPBZdu10Eku1h+VhIO7pbyIi9R7R+Cfhamp3ae3
	Nasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=3FKBJA17va/jv2u1TvUxLDB1xiagIFwWCBsEV/clovc=;
	b=tqOFfloyBsYgf0IboauHwc/PnO4DF6Po/YQxmgL8ft27JZuZsmjmst9e/KqDhYeYY6
	ohQ/CEZiOLKcCc89vQ7y9TA4E0TMEs4v2YrBwvUCR6MMUqG1Zt48il4W7piuavzTJRxN
	KCWc8wm4o3Y6sGLoSkFNH0NcpJqPbs1/b0UBS59dLw9roAYBUtGzUJBBylEj1j+y1pdZ
	sSDkeOiwMbJjoCStopIyUt5Dxo2oZEsve/qLpvFHXThqeRPu9+qTmsq7p0MekKyfJdgM
	9TDiDL7VstKW8Mea4sbTfxWFdj3KwFzuFDE2cAJJjW/qZcM7XQTQQLdsXGMtE69AseNQ
	Sn/g==
X-Gm-Message-State: APjAAAUuF//OpYlFcMovV8twNy3grYlKavmdR3mlP3PxTkbKvDRNHk+w
	QeXrlMqmIjfZxh4vQmdFFzl66Eu2Vxk+Hw==
X-Google-Smtp-Source: APXvYqy4l/3ibeoF9lugxLRcZk2nFEzQ/rSSZqVuB3NnKQayxkGKq4FFbqh7sQgtkZ/6z2qw5pyqqw==
X-Received: by 2002:a63:d00d:: with SMTP id z13mr9056359pgf.368.1558706645836; 
	Fri, 24 May 2019 07:04:05 -0700 (PDT)
Received: from localhost.localdomain ([120.57.120.132])
	by smtp.gmail.com with ESMTPSA id
	u11sm2556766pfh.130.2019.05.24.07.04.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 07:04:05 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:33:30 +0530
Message-Id: <20190524140337.13415-3-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190524140337.13415-1-mehta.aaru20@gmail.com>
References: <20190524140337.13415-1-mehta.aaru20@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [RFC PATCH v2 2/9] block/block: add BDRV flag for
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

