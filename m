Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F10C282E2
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 10:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC6D20675
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 10:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="P2qua9aN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC6D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHmtE-0002PB-0E
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 06:06:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmrH-000119-V2
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmoE-00058i-JL
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:01:23 -0400
Received: from m12-14.163.com ([220.181.12.14]:59355)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1hHmoD-00055m-W7
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 06:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=cqEpHhNRxPDIohSJzA
	C5BYc20j5rmB0Wfqi4GDH+U9Y=; b=P2qua9aN8j6D/LE/uWU/ltTvlAsq6P4i3V
	gzkm38LlGiSJX6ag+/7jE0ZnU+SzGJbdLbAkdph/zWIZM11Um0mSYfZsh7mN8OLv
	rvRzXZ+Sy0KrGyfcuJ00EnPOhjg/SoF2Dg5JQQijbCq8DJfOHBtdd6Kp5aE8iGE8
	PZI2G53NI=
Received: from localhost.localdomain (unknown [183.159.69.175])
	by smtp10 (Coremail) with SMTP id DsCowACHzxnk7bpcMStGBQ--.39886S2;
	Sat, 20 Apr 2019 18:01:09 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
	philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com
Date: Sat, 20 Apr 2019 03:00:52 -0700
Message-Id: <20190420100056.116305-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DsCowACHzxnk7bpcMStGBQ--.39886S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw13Wr43GFy7tw43Kw4rXwb_yoW3twb_WF
	1xA3s8Jw4DZFZ8Jay7Jw45tFyUZFWxCr1rJF1qgFn2krW7Ar1DJFs2grykGry3Cr1Y9rnx
	KwsrGry0ywn8ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8m-e5UUUUU==
X-Originating-IP: [183.159.69.175]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiFBucbVaD0T393gAAsk
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.14
Subject: [Qemu-devel] [PATCH 0/4] fw_cfg_test refactor and add two test cases
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
Message-ID: <20190420100052.exnFjzkEB99V3tlib8kchqjcERbVaU3LN8tns9rYmgc@z>

In the disscuss of adding reboot timeout test case:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03304.html

Philippe suggested we should uses the only related option for one
specific test. However currently we uses one QTestState for all the
test cases. In order to achieve Philippe's idea, I split the test case
for its own QTestState. As this patchset has changed a lot, I don't bump
the version.


Li Qiang (4):
  tests: refactor fw_cfg_test
  tests: fw_cfg: add a function to get the fw_cfg file
  tests: fw_cfg: add reboot_timeout test case
  tests: fw_cfg: add splash time test case

 tests/fw_cfg-test.c   | 122 +++++++++++++++++++++++++++++++++++++++---
 tests/libqos/fw_cfg.c |  55 +++++++++++++++++++
 tests/libqos/fw_cfg.h |   9 ++++
 3 files changed, 178 insertions(+), 8 deletions(-)

-- 
2.17.1



