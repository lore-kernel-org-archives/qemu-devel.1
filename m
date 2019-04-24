Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D21C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0E8218FE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="GwZv4O5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0E8218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42453 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJIlv-0007MZ-FR
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:21:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIfe-0002XI-84
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIY4-0006iM-5m
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:06:57 -0400
Received: from m12-14.163.com ([220.181.12.14]:53821)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hJIY2-0006eH-BK
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=2TTlu/WUmtNBcWno47
	ofLFqkm5RSgRV/gD7rqr6U8rw=; b=GwZv4O5yknvbcjuGXvKNRrR7lGVKtX8ZMq
	Fv7TTmfmFyoUZQaQqlMQUSxAsK/lfCnJJ7Q+Iuee7nsuQmFTczM0Y4073UgYN+Ss
	dtEoFbS5VQzYRGbk5hnKT+8oRWNjtzrO0stuSe8ycr+q25D5ylf96lKseZPn4K7F
	FsXrRtjpU=
Received: from localhost.localdomain (unknown [115.200.201.0])
	by smtp10 (Coremail) with SMTP id DsCowAC3Ayl0bcBcrks9CA--.5531S2;
	Wed, 24 Apr 2019 22:06:45 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com, thuth@redhat.com,
	lvivier@redhat.com, pbonzini@redhat.com
Date: Wed, 24 Apr 2019 07:06:38 -0700
Message-Id: <20190424140643.62457-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DsCowAC3Ayl0bcBcrks9CA--.5531S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw13Wr43GFy7tw43Kw4rXwb_yoWDCrb_WF
	97A3s8Gw4DZFyDJFW7Jw45tFyjqFW8Cr1rJFn0gFsakrW7Ar1DJFsFgrykuryUGF45Cr9x
	CwsrWry8Awn8ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8489tUUUUU==
X-Originating-IP: [115.200.201.0]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/xtbBoQCgbVQHEpk9xwAAsO
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.14
Subject: [Qemu-devel] [PATCH v2 0/5] fw_cfg_test refactor and add two test
 cases
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190424140638.MR2DX6WCV0c6ap9LuPuT_aAOsOqLR2_Oti_mYxm_3bg@z>

In the disscuss of adding reboot timeout test case:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03304.html

Philippe suggested we should uses the only related option for one
specific test. However currently we uses one QTestState for all the
test cases. In order to achieve Philippe's idea, I split the test case
for its own QTestState. As this patchset has changed a lot, I don't bump
the version.

Change since v1:
Add a patch to store the reboot_timeout as little endian
Fix the endian issue per Thomas's review

Li Qiang (5):
  tests: refactor fw_cfg_test
  tests: fw_cfg: add a function to get the fw_cfg file
  fw_cfg: reboot: store reboot-timeout as little endian
  tests: fw_cfg: add reboot_timeout test case
  tests: fw_cfg: add splash time test case

 hw/nvram/fw_cfg.c     |   4 +-
 tests/fw_cfg-test.c   | 125 +++++++++++++++++++++++++++++++++++++++---
 tests/libqos/fw_cfg.c |  55 +++++++++++++++++++
 tests/libqos/fw_cfg.h |   9 +++
 4 files changed, 184 insertions(+), 9 deletions(-)

-- 
2.17.1



