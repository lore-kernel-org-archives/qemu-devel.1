Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1B7C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67AE02341F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 13:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmW3REn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67AE02341F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59Kw-0005CA-Vm
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 09:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1i59JB-0003Im-GQ
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1i59J9-0005ho-IY
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:57:21 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c]:45298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1i59J7-0005hD-KT
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:57:17 -0400
Received: by mail-qt1-x82c.google.com with SMTP id r15so14344000qtn.12
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+ZIku0IAuAdDBvlJHqjS3AHizFa/YaK5IEgECxAInhE=;
 b=FmW3REn8zwkhPoHaa3TR3HLqb4INta1hAFD1pdecctIbJxM9hDwVC4KpOqyoY7BHD2
 NTbYN7yUzmkW4XTaFnFuIQHmrHcgeDZwGTLekv74TeVsMbz/QELy8k2PWUSWvxH3qRcS
 yaVKAAxotQHqZCRD9m9lSwJomhzqmo0HAC1unBqp2MAhTgR5h+cZxx5ZNVqCMBZWhu1O
 8PKwdhSW32DCLILFNzOmWMAsA6gvSGJVkLelNZ2ap8yfdiWKsgVbj7Rk7d6UPzo3ziQW
 iglKWk/trLyTOUqqpCE6Q0QhjRuenWy1Zt7HNWbrl3qgUXTquCnI9CW/13eqtFp8oRfX
 7kDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+ZIku0IAuAdDBvlJHqjS3AHizFa/YaK5IEgECxAInhE=;
 b=e7oiUeMOAGAIpv9FLKPSqLFSr6Yty3qHRbhzMRUd/yuRrtWFIBkGSWyIuy/A1ODs7e
 ZXM335ccbc1MVG4mfRU7BxNdw6kiDBqRkFfWpxIAPhQsONHlNfk1N3SDl15sp9WtPF6k
 Mqf5WiV4UQ6Ur/Ju1rje3+/HbXHd0U21dgX49+MaBGprgjjr2U4sT1MI7+0qXxBw6wqm
 IsDDoTbkpM9nq9hz9jZSD5ycdpzMw/lqmuzhizDhxtjqGiGLz4BWz5Ng4heSA7FldyVz
 jBjG8DV9lX9tDnmyRIWIqRoIGWRGIcagBvMVD6dibk/pPWktBmb5Hnkn1os1WKgjToHh
 8meg==
X-Gm-Message-State: APjAAAUCqDkeQkpMF0U433g2nI3M39Jo1OeofRHlFZ7vgZBhbePHLPNy
 0RWwa/uyK2piyMahUoaXJFFvAbTx
X-Google-Smtp-Source: APXvYqxDBjB1S9RmFggtR8nd8VtvObRkPtiGgKWynG6BHc1FDUp4kWyOGuI6/aiDks5hq6xiUQUP7Q==
X-Received: by 2002:a05:6214:164:: with SMTP id
 y4mr21563973qvs.123.1567519036784; 
 Tue, 03 Sep 2019 06:57:16 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c7:5c9f:9471:e230:52b:8c93])
 by smtp.gmail.com with ESMTPSA id k49sm9211158qtc.9.2019.09.03.06.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 06:57:16 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 10:57:04 -0300
Message-Id: <20190903135708.21624-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82c
Subject: [Qemu-devel] [PATCH v7 0/4] delete created files when
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
Cc: kwolf@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes from previous version 6 [1]:

- bdrv_delete_file() now uses BlockDriverState as a parameter rather
than a filename string.

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg00139.html

Daniel Henrique Barboza (4):
  block: introducing 'bdrv_co_delete_file' interface
  block.c: adding bdrv_delete_file
  crypto.c: cleanup created file when block_crypto_co_create_opts_luks
    fails
  qemu-iotests: adding LUKS cleanup for non-UTF8 secret error

 block.c                    | 73 ++++++++++++++++++++++++++++++++++++++
 block/crypto.c             | 22 ++++++++++++
 block/file-posix.c         | 28 +++++++++++++++
 include/block/block.h      |  1 +
 include/block/block_int.h  |  6 ++++
 tests/qemu-iotests/259     | 67 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/259.out | 11 ++++++
 tests/qemu-iotests/group   |  1 +
 8 files changed, 209 insertions(+)
 create mode 100755 tests/qemu-iotests/259
 create mode 100644 tests/qemu-iotests/259.out

-- 
2.21.0


