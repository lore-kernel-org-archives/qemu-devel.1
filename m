Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEF1C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0809521655
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 15:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCxLK1lk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0809521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs7Qp-0000Ff-3y
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 11:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43561)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7PM-0006pe-P5
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hs7PL-0007AD-SJ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 11:17:52 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hs7PL-00079p-Lk; Mon, 29 Jul 2019 11:17:51 -0400
Received: by mail-pg1-x544.google.com with SMTP id t132so28415138pgb.9;
 Mon, 29 Jul 2019 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2qHkahVEkN1zu8CSs6/qp7V0fV616Ybkp0QDQj4tHxQ=;
 b=WCxLK1lkWaRPKpbvSdxkBLv1HcNsF3ywlDY+z/zCCq/BOmwKYJ3jwYFFZInEvRg1cV
 fJPvE+4rPvS/JyTVH89DtxX7dJtnD49ceY9+IX7vMO23T86PGhiJyHIIDa4bXI3/deJ/
 qaNW5SpsuFS/+QSosm2ecl726wjLpkcxkX3HlZpxeGzMmnTJjyU601MzxSduQWgC9xQo
 R6/jjcQwiO7OXQhPPoxfqMMAJUG4U28VrBJHMH0NDl/cZUSESF/Mk2KYfcgKsuThHEcy
 v4nGEZEVZZsfDemWhEOguimIJ/WHx4lJ3b+iUJ0zekvFFYaju9Tj4EMllGUw0adYpXSR
 ZEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2qHkahVEkN1zu8CSs6/qp7V0fV616Ybkp0QDQj4tHxQ=;
 b=UFWsnJlw8UrN7eaQxlVAQajRmrQNeCPovZOqveYlS07SQDnxcdTZ69R95tAkCfirkB
 EveYUQzZgsrY1el+q8t4QlmnOoFc3MhYem6jLqInj4mRAnD6oxNxOEO0hZJW3T/PLCF1
 6ksuCO9Gqb64+Myfqc+q4PllT7LXSr0qfJlnUaFyQ1SrlKLd0A2UYnS8KMfpjuA0Yki0
 Z7YHKlItyc5t2c/EhmHf3ktnGEWunnDIdVMmhv/J8JNQZ4+Gp1lSGYI0lbp0ZzaV/3xl
 wGV48H7equgwBsP9ie3GEcX08V3TqkOw//bjW+bL5zXWjTq5tbVQXIBAeHcxc+xV1laS
 7WuQ==
X-Gm-Message-State: APjAAAU+Qw6NfTfdf3ZPxAxlQIw3KJpBhXXJyuw1xkYMWrA0qhj5kl1T
 Q6uOwC4hiPfNQdWzUC5JtO2Cln/RGsgVkQ==
X-Google-Smtp-Source: APXvYqwy0340v6Bhv9d0IE0r+GKW65wsAumSUsrydFW191dJjTVErfvTWN4hJ84VGjHcfAntsrF7DQ==
X-Received: by 2002:aa7:8007:: with SMTP id j7mr36857767pfi.154.1564413470389; 
 Mon, 29 Jul 2019 08:17:50 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.97])
 by smtp.gmail.com with ESMTPSA id h129sm58693941pfb.110.2019.07.29.08.17.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 08:17:49 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Jul 2019 20:46:39 +0530
Message-Id: <20190729151651.21306-4-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729151651.21306-1-mehta.aaru20@gmail.com>
References: <20190729151651.21306-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v7 03/15] block/block: add BDRV flag for
 io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Maxim Levitsky <maximlevitsky@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 include/block/block.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/block/block.h b/include/block/block.h
index 50a07c1c33..e29baa172c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -121,6 +121,7 @@ typedef struct HDGeometry {
                                       ignoring the format layer */
 #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
 #define BDRV_O_AUTO_RDONLY 0x20000 /* degrade to read-only if opening read-write fails */
+#define BDRV_O_IO_URING    0x40000 /* use io_uring instead of the thread pool */
 
 #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)
 
-- 
2.21.0


