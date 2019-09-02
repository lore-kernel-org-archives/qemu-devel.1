Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F49C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 20:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3CA21670
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 20:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jA9Y3cfn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3CA21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4tQW-0006gm-89
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 16:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1i4tPZ-0005pW-WA
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1i4tPY-0004A5-Tr
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:58:53 -0400
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735]:40210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1i4tPY-000488-Pl
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 16:58:52 -0400
Received: by mail-qk1-x735.google.com with SMTP id f10so13646014qkg.7
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 13:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/rd+4vLxW8yIL7kOWOUa4POXexobmjsIH333sqv4xUk=;
 b=jA9Y3cfnEyAwR4weniKiME3SXzLyPtYSXZqcELjN4mIPQN5Mwgz2PA1c0h2zhumtsH
 p8YJU18rQzBtSA2Z4V9N7BeZ4+Yu2tCWuGGrPiPfCOMFFl7hbCAYkP7T1MIeJmyjqFYz
 GZl6DhBXa4fH9n25FNcVtizU2ogS4MxmahzkFo05hobZ42iUb+43rf0CNHtNZgNQbI3e
 H1OCf3sbHMyw2WeRETxSX0KYSaszH4vh1YqLybWnh98Rxy0DFPXfHxR33vet828FwUGc
 fgjxZZA6aaHN1cjWljRoXvWiPdkDhFsdAuAOYUrWQi2WI9FS0olvCOdDet4fzmLSFydJ
 7U8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/rd+4vLxW8yIL7kOWOUa4POXexobmjsIH333sqv4xUk=;
 b=MDjSUkQ5ysbaKfKntcVGOz6kAGgBaQS+et/dY/Um+nvjkP6pXBSaQBsfrdajDzu+Ab
 UToE05Lo5DmhXJ3D05pX8sJ6WLVaqdTnrdL+d5dv4MG9m/rfHyBxkrClBBrSxKRYlfnW
 9YFMDGCd7JKxRX1i+pEqDMFB3lIUs/1qPqf95mEy5yk0PvSxSM7soAryyia7TVPtqVdX
 iu2toPApyn21LLU6Xr+5frmBri20kLyxmt+cK7DL+ojr0xBf6OgzxISunABMITQAAFrk
 kZRKIDdfP71QXpGhttury04YmMQ7xK+R2ZJFfgJRbtV93k5ktdcY0DK8phlY/KMAKhkq
 EKxg==
X-Gm-Message-State: APjAAAVIPuSmWx+NrZ381z+ZQPAKyUsq540HbPuUkf/VweqvVOh/PP8v
 nkE8X8CQ5GBepZxmrMM7aRwWzApi
X-Google-Smtp-Source: APXvYqzABRbreX704cl7H7a3fPk33u7Z015DIOWzfuIfpyIAP23GOYc3hgUkAfMs83bEM4UquJGmTQ==
X-Received: by 2002:a37:4fcf:: with SMTP id
 d198mr30427658qkb.394.1567457932126; 
 Mon, 02 Sep 2019 13:58:52 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:9589:1351:c7eb:87b:c9d5])
 by smtp.gmail.com with ESMTPSA id w80sm4604038qka.62.2019.09.02.13.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 13:58:51 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  2 Sep 2019 17:58:38 -0300
Message-Id: <20190902205842.1884-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::735
Subject: [Qemu-devel] [PATCH v6 0/4] delete created files when
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

Changes from previous version 5 [1] suggested by John Snow:
- patch 2: return ENOMEDIUM with !drv, return negative error
codes in bdrv_delete_file
- patch 3: clarify the meaning of returning ENOENT in the
comment

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg01173.html


Daniel Henrique Barboza (4):
  block: introducing 'bdrv_co_delete_file' interface
  block.c: adding bdrv_delete_file
  crypto.c: cleanup created file when block_crypto_co_create_opts_luks
    fails
  qemu-iotests: adding LUKS cleanup for non-UTF8 secret error

 block.c                    | 78 ++++++++++++++++++++++++++++++++++++++
 block/crypto.c             | 22 +++++++++++
 block/file-posix.c         | 28 ++++++++++++++
 include/block/block.h      |  1 +
 include/block/block_int.h  |  6 +++
 tests/qemu-iotests/259     | 67 ++++++++++++++++++++++++++++++++
 tests/qemu-iotests/259.out | 11 ++++++
 tests/qemu-iotests/group   |  1 +
 8 files changed, 214 insertions(+)
 create mode 100755 tests/qemu-iotests/259
 create mode 100644 tests/qemu-iotests/259.out

-- 
2.21.0


