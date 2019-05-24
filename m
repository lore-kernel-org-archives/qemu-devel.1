Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0FFC282E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8932520675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPHn8Y8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8932520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCjR-0008Tb-Ni
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:07:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdZ-00040u-H2
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdX-0001yQ-Fk
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:33493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdT-0001ro-3E
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:37 -0400
Received: by mail-wm1-x331.google.com with SMTP id v19so1524834wmh.0
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=w/5AzzgSm31hkbsLF/f98Nh4j5Hl7pf560kiGv1+cKk=;
	b=aPHn8Y8XUF1T5v4fuzbYn81vsLz6X/O2xaheVSUrjvzCXKu0NJUJSf+z17X/MZdjBo
	sv+Jb12Oj7qE/+pzhiHodJZJFGghF0g5zqfDsjyqJ4agnj92X6oiqytnOkyFpejly3DF
	cylbOfCsZ2AEdDdPZmjSwiv1VqO5nrSEnLpO2fdCX3I3o7fgOBhsDITRWZAL5UOzsCer
	RrzTxmJnRLBfoRdD1UkH+K57LkltBvKmbjdAKpdRXrxJCEWzj7RJfUlV/7CXPOzWMNbG
	5AbrtTRcT296iOEiq/xNieCXbkGVTR7FeC4YbozqtXLCNEVd8Lvz3vC4FB3hzwtWhVSE
	ZDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=w/5AzzgSm31hkbsLF/f98Nh4j5Hl7pf560kiGv1+cKk=;
	b=ryjCPKE7jbWyWSA/13p/EaQXAjnTdYYEOTMjxQab2DSp7Mry/E+mA4beg4JTvPcThr
	50uZNHE0EonCpwkYKqWp4A0OddHpoUb8uKe/A0+2sPYROZ86U2MKGEZ49blCsnP1hb5t
	ZCMfy2QYLAVES30iiHrQnjPBRvLE5W5SYLWI9HIQ4nfLgbf85SaWpIHG6fmZoMFLAwHz
	lWYpAoh7ZW+QpbMQZIxhZrSqHTXBEdnolOcv8W5Bd1/4M1e1CsQ/zlO1Prz2XuJaxTQF
	QLYtLQjbFt13tgWfEOvCjmcnQOk4cFAh7hIs30p1/lfxKdcsQNqKLWLedsxKzRLAhS9+
	mv+A==
X-Gm-Message-State: APjAAAXlSNbQShPacQv33QlahShoYsfObGchtp9HKq6/ingxKweXWjxr
	nSiwY51b+l9K3DzJRmKx8ONXahvI
X-Google-Smtp-Source: APXvYqwrMmBVr2468uI5WbNgWjZbTg7wGs2KT1Q7KwyM8Hw7T06eO7PEJZI63HTHOOV3H/xo29RcAA==
X-Received: by 2002:a1c:7a0d:: with SMTP id v13mr446137wmc.44.1558713688944;
	Fri, 24 May 2019 09:01:28 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:28 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:00:58 +0300
Message-Id: <20190524160118.31134-1-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PATCH v11 00/20] gdbstub: Refactor command packets
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

version 11 changes:
- Add reviewed by tag
- Requires review:
  gdbstub: Implement deatch (D pkt) with new infra
  gdbstub: Implement breakpoint commands (Z/z pkt) with new infra
  gdbstub: Implement set register (P pkt) with new infra
  gdbstub: Implement get register (p pkt) with new infra
  gdbstub: Implement file io (F pkt) with new infra
  gdbstub: Implement v commands with new infra
  gdbstub: Implement generic set/query (Q/q pkt) with new infra
  gdbstub: Implement target halted (? pkt) with new infra
  gdbstub: Implement qemu physical memory mode
- Already reviewed:
  gdbstub: Add infrastructure to parse cmd packets
  gdbstub: Implement thread_alive (T pkt) with new infra
  gdbstub: Implement continue (c pkt) with new infra
  gdbstub: Implement continue with signal (C pkt) with new infra
  gdbstub: Implement set_thread (H pkt) with new infra
  gdbstub: Implement write memory (M pkt) with new infra
  gdbstub: Implement read memory (m pkt) with new infra
  gdbstub: Implement write all registers (G pkt) with new infra
  gdbstub: Implement read all registers (g pkt) with new infra
  gdbstub: Implement step (s pkt) with new infra
  gdbstub: Clear unused variables in gdb_handle_packet

version 10 changes:
- Remove kvm added API as this is not really required and can be
  accomplished by defining a coprocessor callback with a system
  specific xml (see: 200bf5b7ffea635079cc05fdfb363372b9544ce7)
- Remove the new QEMU extended commands to read KVM MSRs
- Various fixes from Code Review by Alex Bennee
- Change the QEMU specific command to read physical memory to non-User QEMU 
- Per patch changes:
  gdbstub: Add infrastructure to parse cmd packets
    * remove the union for the flags in GdbCmdParseEntry
  gdbstub: Implement deatch (D pkt) with new infra
    * Changed default handling for error flow / command not found
  gdbstub: Implement continue with signal (C pkt) with new infra
    * Added comment we dont support C sig;[addr] commands
  gdbstub: Implement set_thread (H pkt) with new infra
    * Change num_params check to be equal and not less than
  gdbstub: Implement breakpoint commands (Z/z pkt) with new infra
    * Merged z/Z commands into a single patch
  gdbstub: Implement read memory (m pkt) with new infra
    * Change num_params check to be equal and not less than
  gdbstub: Implement file io (F pkt) with new infra
    * Changed to have a single command parser
  gdbstub: Implement generic set/query (Q/q pkt) with new infra
    * Merged q/Q and qemu.Supported patches into a single patch
  gdbstub: Implement target halted (? pkt) with new infra
    * Removed TODO comment and added a note about it in the commit msg
  gdbstub: Implement qemu physical memory mode
    * Added CONFIG_USER_ONLY where required

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


