Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BF6C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38DE21773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 10:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UqJbUiR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38DE21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50468 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT1bU-0006zp-SG
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 06:02:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1Z4-0005c3-OU
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hT1Yz-0007Hp-Ql
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:50348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hT1Yz-0007Gj-L6
	for qemu-devel@nongnu.org; Tue, 21 May 2019 06:00:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id f204so2308599wme.0
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=HVp3+7QXwafF95eXj2kNErxIodVQxKQbZp1gVA13mW0=;
	b=UqJbUiR+QygEDDpS+k2090yj1NQrTQ4RLOHrz/Mq+CFEQLq56TFZE0o8jIZXcWcODb
	r9DFee+h7NhsIQ65+uqIsSbEM4Jeo2V83PSGcwImfyvhP1ySAT/tIG/Ir66/KfM0G3dl
	RdvB637Yy0mZznLVBP9ml0JvoUnNkhCMUSgBUmXNH/KCS9Eh3vD6dQ90TPLpU1VCMyPw
	J0Xy45cLd64wYzfabLAMwppsA3TBK5Gvfc62wY9Vp2kYCPOK/UsPExw8TYmhSzH5r0uu
	w0Un4oB8y7Y2mAQ1+rm7Dcz2+iyVfxsqiM/qI7Iavzf2fAUPB4a3VmtOjTG8H1fOBerk
	zkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=HVp3+7QXwafF95eXj2kNErxIodVQxKQbZp1gVA13mW0=;
	b=LMzm44INnz+uXQP9U5AyOcDHTEjW5zDGTyttEjxxVmWr0odtKzydlfF477j4vK3Ucj
	GsaWIJHUsyXSpVpKVr9pi6jcoTyqTqBOpSXc8aXXsDdl45QyMT0vgHafskigOKLJslfT
	ks/GHttKDr3GeQqMcDN1+I+7OpxPUzRZpRM9fypRNHEbCQgypAu5g66/Q55AoHoAkDXt
	jcsL2z+vvwbTi+EH27KCcwt55jJMiYirPjJccZApBOVcdtNIlYKoD5WGZwNKJwvIBZ3q
	32XVHa8FuYusfUuIs7ahroipNGpOS7Jez5a8ysZYsDa2c+cAvflBydlUYVLpEacvoOVM
	/Z/g==
X-Gm-Message-State: APjAAAUfqo737Nqt7gEynEhdFQkAB7ZhjCIa/FnK86xkddqq6STPK9SH
	VWUbWp9fibELByVXYvsnnEixKgmS
X-Google-Smtp-Source: APXvYqwJxNgyWt3ITdjwd8mOjQsgmxPMUCU62cpmVJCzi2QtM5WIJ3sX8fehPmUb8M9yyEqIKEm5mw==
X-Received: by 2002:a1c:9dc7:: with SMTP id g190mr2615266wme.121.1558432804078;
	Tue, 21 May 2019 03:00:04 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.64])
	by smtp.gmail.com with ESMTPSA id 65sm3080257wro.85.2019.05.21.03.00.01
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 21 May 2019 03:00:03 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue, 21 May 2019 12:59:28 +0300
Message-Id: <20190521095948.8204-1-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::32b
Subject: [Qemu-devel] [PATCH v10 00/20] gdbstub: Refactor command packets
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
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch series refactors the old gdbstub command packets handler
with a new infrastructure which should ease extending and adding new
and missing gdb command packets.

version 10 changes:
- Remove kvm added API as this is not really required and can be
  accomplished by defining a coprocessor callback with a system
  specific xml (see: 200bf5b7ffea635079cc05fdfb363372b9544ce7)
- Remove the new QEMU extended commands to read KVM MSRs
- Various fixes from Code Review by Alex Bennee
- Change the QEMU specific command to read physical memory to non-User QEMU 

version 9 changes:
- checkpatch fixes

version 8 changes:
- Add new command to display the Supported qemu generic query/sets
- kvm: Add API to read/write a MSR
- Add new commands specific for qemu:
  * Command to swap the memory GDB sees to be the physical memory
  * Commands to read and write a MSR

version 7 changes:
- Fixed few checkpatch complaints
- Feedback from Alex Bennee

version 4-6 changes:
- mostly feedback from Richard Henderson

version 3 changes
- Split the single patch to many individual patches for easier reviewing

version 2 changes
- Code convention fixes

Jon Doron (20):
  gdbstub: Add infrastructure to parse cmd packets
  gdbstub: Implement deatch (D pkt) with new infra
  gdbstub: Implement thread_alive (T pkt) with new infra
  gdbstub: Implement continue (c pkt) with new infra
  gdbstub: Implement continue with signal (C pkt) with new infra
  gdbstub: Implement set_thread (H pkt) with new infra
  gdbstub: Implement breakpoint commands (Z/z pkt) with new infra
  gdbstub: Implement set register (P pkt) with new infra
  gdbstub: Implement get register (p pkt) with new infra
  gdbstub: Implement write memory (M pkt) with new infra
  gdbstub: Implement read memory (m pkt) with new infra
  gdbstub: Implement write all registers (G pkt) with new infra
  gdbstub: Implement read all registers (g pkt) with new infra
  gdbstub: Implement file io (F pkt) with new infra
  gdbstub: Implement step (s pkt) with new infra
  gdbstub: Implement v commands with new infra
  gdbstub: Implement generic set/query (Q/q pkt) with new infra
  gdbstub: Implement target halted (? pkt) with new infra
  gdbstub: Clear unused variables in gdb_handle_packet
  gdbstub: Implement qemu physical memory mode

 gdbstub.c | 1753 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 1262 insertions(+), 491 deletions(-)

-- 
2.21.0


