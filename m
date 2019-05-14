Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55D7C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB2D520873
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 21:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCW0K+X+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2D520873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54326 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQeh8-0000W5-VN
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 17:10:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeV6-0007X1-L5
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hQeIQ-00072a-J2
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:11 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hQeIQ-0006wX-8J
	for qemu-devel@nongnu.org; Tue, 14 May 2019 16:45:10 -0400
Received: by mail-lj1-x242.google.com with SMTP id h21so458021ljk.13
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 13:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=59Z2PWdwY+45T/oCcgCygNXGS/qq2nGAirk2nQ9eYNc=;
	b=aCW0K+X+yh2jKi5RM32rs2qiuEMGRGPzMu0nboYpCaunN1yh/sGcxOuQrxjXVKqxdq
	6JZNPUmg4GKeFpBdEIZ0K4tp2c1osp2RpkBjFJUNGxEDRylR5YWVZsTz/RAVOzpoL2je
	8CtcUCFSC/tJBWt9HTOQniekMLxJc4nVz0LwzHRLMwNMWzWlL2bmErsGVeEwHimHUbao
	9GcI/Dnk7KRBD99sbbsIGJ+97hTKaf2e6pwaxc9qaXv6ESsDrFjKIBbK4T+9IRp2tVId
	p5kQphry0G+dPYKNY4aHwbkSPr83vSp3W6pvEbX1TEkuzDhWZN9XEF0I6ahNGmo93uO6
	+WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=59Z2PWdwY+45T/oCcgCygNXGS/qq2nGAirk2nQ9eYNc=;
	b=rlYY6cRE+NAqh15GB8inkdmdvmzxzhG8c5UAxjuT0g+uuWylaYtOPnGrMxi7JnYmZy
	Ek06VrRlaFy2+CXqlyGa2zP01kgRzDCR5kUi3wgA1YBXgcRkb7tPXWSZKSKH+yeowHl1
	r78meTxTKPT2cxSKJ9MvGI/Q7kd+gAbUkee6b2YwfYGDqybJ45oTQwN6rExHPdZHT1En
	Wo8ttxxW3Y2kYDl5qzw6tI7/i5kereoREUq1zeCJ/JID+Y7TOXS9xSjSCjmv8SkFoZKj
	DZzSHREXU6HhxITQnCL0JR4Vy/DJ1Vu7hHO80blb8Kz5qVwxIlR27s4kRF9kibg6do11
	WPxg==
X-Gm-Message-State: APjAAAVofWI7Z7l0kZ/TH74tAR5Ei0JJ20AsQEuDDrnybhTLLq8e/G6e
	eFau9fsHmfN1a0HmKXerI/JHodgpcpk=
X-Google-Smtp-Source: APXvYqxn8QersrDZdNeqlASuqsjhMOo9QwAXqDgSeagI0gID6oYxEP3liuXjNvZCazcl1dg0P36Tjg==
X-Received: by 2002:a2e:978f:: with SMTP id y15mr239656lji.125.1557866707315; 
	Tue, 14 May 2019 13:45:07 -0700 (PDT)
Received: from octofox.cadence.com
	(jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
	by smtp.gmail.com with ESMTPSA id 78sm4011lje.81.2019.05.14.13.45.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 13:45:06 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 13:44:38 -0700
Message-Id: <20190514204447.17486-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.11.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: [Qemu-devel] [PATCH 0/9] target/xtensa: implement options for
 modern cores
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

this series implements options used by the modern xtensa cores: memory
protection unit, block prefetch and exclusive access and adds special
register definitions and IRQ types for a few other options not fully
implemented: ECC/parity, scatter/gather and IDMA.

Max Filippov (9):
  target/xtensa: get rid of centralized SR properties
  target/xtensa: make internal MMU functions static
  target/xtensa: define IDMA and gather/scatter IRQ types
  target/xtensa: add parity/ECC option SRs
  target/xtensa: implement MPU option
  target/xtensa: implement DIWBUI.P opcode
  target/xtensa: implement block prefetch option opcodes
  target/xtensa: update list of exception causes
  target/xtensa: implement exclusive access option

 target/xtensa/cpu.c               |    2 +-
 target/xtensa/cpu.h               |   58 +-
 target/xtensa/helper.c            |    1 +
 target/xtensa/helper.h            |    6 +
 target/xtensa/mmu_helper.c        |  532 ++++++-
 target/xtensa/op_helper.c         |   42 +
 target/xtensa/overlay_tool.h      |   43 +-
 target/xtensa/translate.c         | 2951 ++++++++++++++++++++++++-------------
 tests/tcg/xtensa/test_exclusive.S |   48 +
 9 files changed, 2574 insertions(+), 1109 deletions(-)
 create mode 100644 tests/tcg/xtensa/test_exclusive.S

-- 
2.11.0


