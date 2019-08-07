Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664BCC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:22:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 306A521E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYPbCnhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306A521E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMpP-0007IZ-Gm
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38984)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <danielhb413@gmail.com>) id 1hvMok-0005va-MS
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1hvMoj-0008Uk-Nr
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:21:30 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:43536)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1hvMoj-0008TR-Hy
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:21:29 -0400
Received: by mail-qt1-x841.google.com with SMTP id w17so7861392qto.10
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G0E13pgClOksrsEbvVIlbdOm7uHMdM2Odzlcy7OLB2w=;
 b=SYPbCnhnUhIIcFDVi+D1+5tn2DcC4RqFCHUkAXQ8S+pFWxitAcSFSc9ykngqh+7a//
 SJNyIhFv2CskE+IS37FEbS9DuDbcu0fGqkvcL6q2Kiv9UfO15sCK12EvSbLBZQ3Nranf
 DWpXZGh+1C5dwoJD72P0CkRfgc3ex5QZ9DYo6J4s4kJobgTh/mX40YwwDUe2qm4/iFjI
 7t5zF0nCVZB2Y09KBmFvk1EqrnxXAVjif9fgjvA0T5o8d5vAYCerx3vSyx2mPghpNjOX
 ITGcvSILFWkViT9PlsVyhIQExFjI6jxBytkhNr1hW9J1fYcVxtydJkbRYzPF907xm8Fh
 trBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=G0E13pgClOksrsEbvVIlbdOm7uHMdM2Odzlcy7OLB2w=;
 b=fZG1LTTYSSefaG6QPhCRlLeVW0MjEuKjh61RLewvz1JGuX+vzlwoCtUluX/92y8gHu
 83Xt8tpnl1d5vIIKY1TM0GVbe1RAxL5Zz395sum+/YmkkAhToh5JzFde11vBm8gQDgEJ
 uWWJCBbcKsDAfnlJSQ1zLElbU2b3wxPbwNYLJbkQTrejyZTqLBhKN1u2hU6e4Hj5v9Xc
 Gr+F8GCHVgjmwWqx5UR3j98Lnfunm+99NGCjp/SIDWmXmCjveYkOyDFgZkeX1Zpnu4co
 HegNM/Fg4/jPPMKRj4SbV3oxxd94kQnDRUSE6Y2Gx2t8/vPAs4cFpz/HPC99vbP/8lnm
 zVkQ==
X-Gm-Message-State: APjAAAUdkzUtyXh77iI9bk2nLNoBSUcdWYv84fWd7H0RRvIWv2tI4HV0
 YpyVBOzz3/Icxz7R2/EigWpqLtNZ
X-Google-Smtp-Source: APXvYqzlLBlv2IeQYCb5knIeektkBxYfCiw6OJoLb9S4MXx/KdBLbOQrMEK61BWuuRmZQxfyzFoNFg==
X-Received: by 2002:a0c:89b7:: with SMTP id 52mr8346471qvr.199.1565187688245; 
 Wed, 07 Aug 2019 07:21:28 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:5ef4:7266:b7a7:9def:f8fc])
 by smtp.gmail.com with ESMTPSA id e18sm31472034qkm.49.2019.08.07.07.21.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 07:21:27 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 11:21:10 -0300
Message-Id: <20190807142114.17569-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH v5 0/4] delete created files when
 block_crypto_co_create_opts_luks fails
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
Cc: kwolf@redhat.com, jsnow@redhat.com,
 Daniel Henrique Barboza <danielhb413@gmail.com>, berrange@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes from previous version 4 [1], all suggested by Kevin
Wolf:

- changed bdrv_co_delete_file interface to receive a BlockDriverState
instead of a file name;
- delete created files even if pre-existent, since they'll be
truncated/corrupted if the process fails anyway

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg06435.html

Daniel Henrique Barboza (4):
  block: introducing 'bdrv_co_delete_file' interface
  block.c: adding bdrv_delete_file
  crypto.c: cleanup created file when block_crypto_co_create_opts_luks
    fails
  qemu-iotests: adding LUKS cleanup for non-UTF8 secret error

 block.c                    | 77 ++++++++++++++++++++++++++++++++++++++
 block/crypto.c             | 20 ++++++++++
 block/file-posix.c         | 28 ++++++++++++++
 include/block/block.h      |  1 +
 include/block/block_int.h  |  6 +++
 tests/qemu-iotests/257     | 67 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/257.out | 11 ++++++
 tests/qemu-iotests/group   |  1 +
 8 files changed, 211 insertions(+)
 create mode 100755 tests/qemu-iotests/257
 create mode 100644 tests/qemu-iotests/257.out

-- 
2.21.0


