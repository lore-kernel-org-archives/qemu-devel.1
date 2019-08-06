Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05C5C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07AF20818
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKIkuFWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07AF20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huwwq-0005TE-Gk
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 06:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45179)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <nirsof@gmail.com>) id 1huwwD-0004y6-6d
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1huwwC-00005W-5F
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:43:29 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:34620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1huww9-0008Ts-O8; Tue, 06 Aug 2019 06:43:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id w9so8643681wmd.1;
 Tue, 06 Aug 2019 03:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=feX+OjGAd/Uoc4o5Rx9iSVvWGO9R185/t3wqxZsB3zM=;
 b=XKIkuFWcvyNAsbq3C6Hk8HiUJPE8KorMtsj05DXDAL2fykC6m0RC4/FRuVSgF7j7jJ
 pI6ZPAk9LHeiZ1KPmB/jVtzv/o41ItaWxAqvwX/QvEuKognitHRm/+fZbfgBvW7SrkUL
 MsARz0RfM+8mpn1nLJvg4zG2z7+JG/aikcChvX8+4/0hoyjw1Zshnt7iELpogI+7xZl3
 MH3ynU/q6vUydnugkiD1Do6P+TeVY/kok8KQyGVgnVGxI6sgYHDpDstZvm5lcM/62e30
 Y4RBjNmLhDUn/dIDP10CWhal226IYsjbEeMMnUDtqEn6HC2yAsY5n49m9CJrj2vPkLr9
 LehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=feX+OjGAd/Uoc4o5Rx9iSVvWGO9R185/t3wqxZsB3zM=;
 b=OMbWOKeC3PEz646s36EBNdI1Ekig4f26GAogrTa6DhTdPE7R8gty7bNn4Ah1b1RIWm
 8KJBdH/uj+B4zeVeBnWq/+4ojqyx0GWDKlBEtOsfZ42QTbZnY/JSQakZBv8LfMa1M8yL
 rfWe86rxK5e5/ArquRegQd1dXWk+q8tsZsLtVJaiWxZFtejfL9oSKoE8sqSp/Bn491Ic
 NsQNZou/lb6y7jL4YyA2qh5VTiEgT46WBhQD3lug5HwYJrDhGV04nMsMrAPNdZ4getkf
 azHZd9z7HurnYS43R1X6Am7gfUaEdjMYUYIYYTrZz1Gc5qR7zBUsTkDp8EbDA7y0dClZ
 z57g==
X-Gm-Message-State: APjAAAVSQRVrOMIubp4eZ4pXmntP3a7NnwD94f1m2CgGPEH1i+JDAOE1
 FIvqj7YdfnRTl0VtnmiZKSJRAxeLZ30=
X-Google-Smtp-Source: APXvYqzZGJRqljYj2NqfMMSfGrRsusRKgtDJpUh2xwzja0g4x0CZJUJKIDhUioPyd6W/G3j9fOs3ng==
X-Received: by 2002:a1c:f115:: with SMTP id p21mr3813277wmh.134.1565088203049; 
 Tue, 06 Aug 2019 03:43:23 -0700 (PDT)
Received: from localhost.localdomain (109-186-222-214.bb.netvision.net.il.
 [109.186.222.214])
 by smtp.gmail.com with ESMTPSA id c78sm122121781wmd.16.2019.08.06.03.43.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 03:43:22 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-block@nongnu.org
Date: Tue,  6 Aug 2019 13:43:16 +0300
Message-Id: <20190806104316.29328-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: [Qemu-devel] [PATCH] block: file-posix: Fix alignment probing on
 glsuter
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Gluster storage with sector size of 4096 bytes, buf_align may be
wrong; reading 4096 bytes into unaligned buffer succeeds. This probably
happens because the actual read happens on the Gluster node with aligned
buffer, and Gluster client does not enforce any alignment on the host.

However request_alignment is always right, since the same size is use on
the Gluster node to perform the actual I/O. Use the maximum value for
setting min_mem_alignment.

With this change we can provision a virtual machine with Gluster storage
using VDO device and fuse mount.

This is a partial fix for https://bugzilla.redhat.com/1737256. To make
this work, the management system must ensure that the first block of the
image is allocated, for example:

    qemu-img create -f raw test.img 1g
    dd if=/dev/zero bs=4096 count=1 of=test.img conv=nortunc

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 4479cc7ab4..d29b9e5229 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1122,7 +1122,7 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
     }
 
     raw_probe_alignment(bs, s->fd, errp);
-    bs->bl.min_mem_alignment = s->buf_align;
+    bs->bl.min_mem_alignment = MAX(s->buf_align, bs->bl.request_alignment);
     bs->bl.opt_mem_alignment = MAX(s->buf_align, getpagesize());
 }
 
-- 
2.20.1


