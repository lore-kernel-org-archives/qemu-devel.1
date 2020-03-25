Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEEDC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA032077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="PGwZwVcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA032077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2xu-0005h7-0t
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jH2vS-00023b-EX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jH2vR-0006oR-2B
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:06:18 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jH2vQ-0006l8-Ae
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585130731; 
 s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
 h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
 bh=qV35QxrPA1Rglc7fhjbGhHSG7Mz4+LROtokT3HhtmqQ=;
 b=PGwZwVcMNhNE4bC9WqFLakCRZ46Bt4Ht/hfJsbAYZQxD3umV6SH5a4x/iDagBNKG
 foG1hYmYb0Gbzl6JOkLMxxTMZqxfybXSwZDaWWLRxF8UQqOlKcHlHh+P3eRaP74vBbZ
 dGm7cSCGmZhry7ltGNu3OAfdFIyv+hfWEAKPCxmM=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by
 mx.zoho.com.cn with SMTPS id 1585130728726272.80738341019037;
 Wed, 25 Mar 2020 18:05:28 +0800 (CST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Message-ID: <20200325100520.206210-1-jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] target/mips: Add loongson gs464 core
Date: Wed, 25 Mar 2020 18:05:17 +0800
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 124.251.121.243
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
Cc: chenhc@lemote.com, aleksandar.qemu.devel@gmail.com,
 aleksandar.rikalo@rt-rk.com, aurelien@aurel32.net,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Loongson gs464 core can be found in Loongson-3A1000 processor.
This patchset add minimal support for that core.
There are still some instructions missing, I'm going to work on
them later.

The corresponding hw board is also missing. I'm using modified kernel
for malta for testing purpose and planing to take the design of Lemote's
KVM virtual machine.

Official manual of this core can be found here [1] (In Chinese).
My collection of instruction documents mainly based on Chinese
version of manual, binutils gas code and experiments on real machine
can be found here [2] (In English).

[1]: http://loongson.cn/uploadfile/cpu/3A1000/Loongson_3A1000_cpu_user_2.pd=
f
[2]: https://github.com/FlyGoat/loongson-insn/blob/master/loongson-ext.md

Jiaxun Yang (3):
  target/mips: Introduce loongson ext & mmi ASE flags
  target/mips: Add loongson ext lsdc2 instrustions
  target/mips: Add loongson gs464 core

 target/mips/mips-defs.h          |   2 +
 target/mips/translate.c          | 166 ++++++++++++++++++++++++++++++-
 target/mips/translate_init.inc.c |  25 ++++-
 3 files changed, 188 insertions(+), 5 deletions(-)

--=20
2.26.0.rc2



