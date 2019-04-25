Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F582C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11901206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFu/xg4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11901206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57322 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeYm-0007Jj-6t
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:37:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeOx-0007er-WD
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hJeOx-0008SR-3K
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:26:59 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:47045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hJeOw-0008Q9-TK
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:26:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id t17so30289054wrw.13
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=NRTnT+8H9O/H4BMVYiIgYXr+TA/uKJ2DVnn2B5A1mNg=;
	b=iFu/xg4BuXrl0DcW58bHWxSJz9PBAZ6cRhFzfrZ1Qc0WnmyG9qNhecYT4A3EC7kDD9
	vTfa0kbZI8SCpFQ1IT5LbXwU1hbuSjlM6dBCppgBnK03D+GXeB3eigU8NbBiqQ5SUrB5
	iinwK9GDsLvnsSn2ksmyFS5j3Ooh/IeJHwz1IRYfI+5jZRJ36Ed5AHF0f8PIubXFlL/Q
	j6FqxgqhBBj7KW1ZHZ8OnLtkEPSnY64MILXivWBGyDUW7GpMLYZn9wCql0MVk8IK9LEs
	VWfEetbS3O5ao/CSWhNuDQO6OrNFk6HlxqeVJq+TRTPGa2ozW/gA5ZI+hL7TsRWTl3lF
	6akQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=NRTnT+8H9O/H4BMVYiIgYXr+TA/uKJ2DVnn2B5A1mNg=;
	b=nPN/Lmxfzps9qY9k7no3AZjd5onsXkICyetNTz8xevYRNyetBB/H6OwcE/9mJctpCC
	BxPU56v9WrNldZ9kn07lVfH0UU7n0GE14XGRRBUcCLC0K0boHkOlc12qxQeYQL8u7wbO
	sid6Hz2y9ynGlILga0C/W/jZvIIMlOSphlhrEX4iyB/+Y9X1FRxz/s+ZVj8wBow643tG
	BswyaZBV3zI9MWr7jbjFR3LtWf94nxiPz4eqeiTMFGy+SD5NCWsZIafMDgMAbePqG3OS
	RgtdWSfVWlxWQdq9X5acs0P7YFmZKoRnUiKfjt2NpaG+LEDOKKBEIQiaNPZg/tvMZ8ys
	43Hg==
X-Gm-Message-State: APjAAAVA99Z1N5wpor08yNPpfjAvJ95eOq1AWDdrDRrj3AENK2pKqwsq
	2baVI5A+5Kvek5i9Tdtp71QeOLlZ
X-Google-Smtp-Source: APXvYqzchs66h63bUQqacBP5tgVQDpmL47D5FmyE0Tzn90i1ldbAaz2Q0edANQWp/rGuhVEvRognlQ==
X-Received: by 2002:a5d:62cf:: with SMTP id o15mr4508472wrv.45.1556198814512; 
	Thu, 25 Apr 2019 06:26:54 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-178-247-46.red.bezeqint.net.
	[79.178.247.46])
	by smtp.gmail.com with ESMTPSA id y4sm2316540wrt.34.2019.04.25.06.26.48
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 06:26:50 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 25 Apr 2019 16:26:15 +0300
Message-Id: <20190425132636.31636-1-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v6 00/21] gdbstub: Refactor command packets
 handler
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425132615.oWXuTg87IMJ-h8V_U4PfMHB0oDyqeedNyMyyAxiKGNQ@z>

This patch series refactors the old gdbstub command packets handler
with a new infrastructure which should ease extending and adding new
and missing gdb command packets.

version 4-6 changes:
- mostly feedback from Richard Henderson

version 3 changes
- Split the single patch to many individual patches for easier reviewing

version 2 changes
- Code convention fixes

Jon Doron (21):
  gdbstub: Add infrastructure to parse cmd packets
  gdbstub: Implement deatch (D pkt) with new infra
  gdbstub: Implement thread_alive (T pkt) with new infra
  gdbstub: Implement continue (c pkt) with new infra
  gdbstub: Implement continue with signal (C pkt) with new infra
  gdbstub: Implement set_thread (H pkt) with new infra
  gdbstub: Implement insert breakpoint (Z pkt) with new infra
  gdbstub: Implement remove breakpoint (z pkt) with new infra
  gdbstub: Implement set register (P pkt) with new infra
  gdbstub: Implement get register (p pkt) with new infra
  gdbstub: Implement write memory (M pkt) with new infra
  gdbstub: Implement read memory (m pkt) with new infra
  gdbstub: Implement write all registers (G pkt) with new infra
  gdbstub: Implement read all registers (g pkt) with new infra
  gdbstub: Implement file io (F pkt) with new infra
  gdbstub: Implement step (s pkt) with new infra
  gdbstub: Implement v commands with new infra
  gdbstub: Implement generic query (q pkt) with new infra
  gdbstub: Implement generic set (Q pkt) with new infra
  gdbstub: Implement target halted (? pkt) with new infra
  gdbstub: Clear unused variables in gdb_handle_packet

 gdbstub.c | 1680 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 1194 insertions(+), 486 deletions(-)

-- 
2.20.1


