Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCE0C04E84
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE9421670
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 06:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksceROhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE9421670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48222 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVsJQ-00029n-Dv
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 02:43:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHl-0000xM-GJ
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hVsHk-0008R8-4z
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hVsHj-00082Z-Mm
	for qemu-devel@nongnu.org; Wed, 29 May 2019 02:42:03 -0400
Received: by mail-wm1-x344.google.com with SMTP id u78so714416wmu.5
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 23:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=DNesXkw4uFG5S3S+i96emMhDrpdtG4gZUzveJRup6TU=;
	b=ksceROhusRGOeYffJjb+iSvyPhP8YV9MDLBufuV5If4goMZ5vwUXLfcerSoOEZ9KWl
	au2ncEJQ40gr79TlAckG7GhcEPIJjooVt/ijKpD158ByEpDh57HNU7FpQr4WjHL1ekNY
	19EQYNcrHhPRYpu/9502vFwKfE6gfhXfJLC4HjVbI8lyOyIyYNp3W8B1rCUbTW88dUOC
	QMRCPBqOOpRHEzEs72FNg1rNxSczcj0QOU0OcCZWpjWeP4f+17F6Sm20tsS1kFbw5G9u
	eCmKPp6ThRWK4AhqC4fsGufOin0zeaXpP1TmKtdA6YRX5P37xNAby8gfv4ntFPUamwz8
	3Q/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=DNesXkw4uFG5S3S+i96emMhDrpdtG4gZUzveJRup6TU=;
	b=o2LYVkArUyLKZV6DmjgQXpXeS9cRVPI/cYg4TW9Eu7f4xY0HXZKiv3SOX1BydX0QeW
	L3dg/OwB45Jk2FJog65rbfRVx1Tuh+JMnFWQEHU00DaQU5KUDg4bXx8pA7f2cwafyKLC
	2DbHfgifIbO2TcnxqRvjZrGhqdSjqc7kThjvTEnFQD+3mLoQnvcwigFWlpTUoNiK2nfl
	zFz4SlHR8nT7zEVWdu7SDlnxHwvTxKHi8/WEoHAQ+tF6G+Ra4urmKoc4JPnGwTeG2tQi
	LtMz9InONuaYYx9R0vCMs/En4wR1vA2gjqMViOZ1ZUgPJL13KcQ6k+nRvBVPrtc9le2l
	IgmA==
X-Gm-Message-State: APjAAAVEQgjxMv78GWKLBWuM79YoS5VnmlBtqWEyWqKmHA/A65O5BkMa
	jaciB9MyI/sGdO+E2ZDttj3LMPAZ
X-Google-Smtp-Source: APXvYqxenGuydLxuE0WaSpmknIdfay2axtXLb/5ylli9lQRihP15xxUTqRcaed6UlVEQI2u557rJOg==
X-Received: by 2002:a1c:4102:: with SMTP id o2mr5554221wma.91.1559112121472;
	Tue, 28 May 2019 23:42:01 -0700 (PDT)
Received: from linux.local ([31.154.166.148])
	by smtp.gmail.com with ESMTPSA id f2sm6831168wme.12.2019.05.28.23.42.00
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 23:42:00 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 29 May 2019 09:41:28 +0300
Message-Id: <20190529064148.19856-1-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v12 00/20] gdbstub: Refactor command packets
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

version 12 changes:
- Fixed a bug during rebase of v10 which broke:
  "Implement breakpoint commands (Z/z pkt) with new infra"
  which basically broke the remove breakpoint command
- Changed gdb_handle_packet call to process_string_cmds with a wrapper
  which handles errors appropriately.
- Patches which require review:
  gdbstub: Implement deatch (D pkt) with new infra
  gdbstub: Implement breakpoint commands (Z/z pkt) with new infra
  gdbstub: Implement set register (P pkt) with new infra
  gdbstub: Implement get register (p pkt) with new infra
  gdbstub: Implement file io (F pkt) with new infra
  gdbstub: Implement v commands with new infra
  gdbstub: Implement generic set/query (Q/q pkt) with new infra
  gdbstub: Implement target halted (? pkt) with new infra
  gdbstub: Implement qemu physical memory mode

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

 gdbstub.c | 1761 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 1270 insertions(+), 491 deletions(-)

-- 
2.21.0


