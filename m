Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458C1C43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:30:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4002081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqAu7L/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4002081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46508 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6AJ-0004jJ-4a
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:29:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM68j-0003lM-GT
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hM68c-0001Yo-45
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:16 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:53132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hM68O-0008Sg-9E
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:28:04 -0400
Received: by mail-wm1-x332.google.com with SMTP id j13so1288342wmh.2
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=f8g9QD70FGf0ymybDzam88kdXKNpm8p5e0I3HrWU7Nc=;
	b=iqAu7L/4a05FTzh2Zbxup7QVRDTfNHqVxj8flmOzl8efmlgrys2OJuLHkhFUkwt3sJ
	nQxF+m3IQwm5JmiqlEs1JERg5LlCcQK8Gsc5tF1NzQD3alt7/4BbcFUrhoJNwPVOUNIS
	Q/zVF/LYxyXKT2QVVSZJ+kB9Y0dErKs2y1kTDiR77xgHrXEFTClh9ae5pXgCQUqqvjDP
	uJa56WAejDEeIYY/mK+wwIdKrX9yQa5hlN/aO0F4obOXV/KxgjbEd0c0KHTITddrvFjk
	55b3J2ue8Mwa1f0gbFLijPI/pLdCbaLGMPp966dzIaXY+oyuJwdG6QrNem5gnqyU96cu
	6F9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=f8g9QD70FGf0ymybDzam88kdXKNpm8p5e0I3HrWU7Nc=;
	b=QFLNfRq0yCBB46cS0guAlU9YSh1Dh+5YHhAtH1znEPoZ/vfmFh6xqVDTnqY001/04w
	7drTPIqgmsFHQvjEmLqyjPSOnp4NEyBUwJwR7rerP1jSG3ySFndH6IwCRFXnTAZIOU75
	LQcCEcFDXVd6s1pb/v8rEQ7vxvEj82ydNz312/MI5kzaFDXEpqC4Fakjhj/dBi1ili7M
	IeldKmdhSjkhHGrDDXF+ipbNgnd93Kbv/RaI7Thb+WuXLjXNJyE/S9kJKA9e3JU8p3iR
	5MvMU7DHFNQ4BK9+zj7vIEVLZ18UMXIA/nhgYbf7gBkybPhxdlkqfCktVZAHDjjDA/4e
	dEpA==
X-Gm-Message-State: APjAAAX5PhDBB2i45MYBk8jesI2zDpH/WYy3d5kmusLIaGGISL10Pmxn
	1DcRmk3kMrdiOWoVNPzB0ZPN7L51
X-Google-Smtp-Source: APXvYqxqJ158eXHFgkg+pjPawsnvcYIoSKZE03vvsWR4k4K2EIEvbPcYp2nSyYhPCuxR999WqkVK0w==
X-Received: by 2002:a1c:eb07:: with SMTP id j7mr1149618wmh.138.1556782012159; 
	Thu, 02 May 2019 00:26:52 -0700 (PDT)
Received: from localhost.localdomain ([176.230.64.186])
	by smtp.gmail.com with ESMTPSA id z5sm8769289wre.70.2019.05.02.00.26.50
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 02 May 2019 00:26:51 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 10:26:14 +0300
Message-Id: <20190502072641.4667-1-arilou@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::332
Subject: [Qemu-devel] [PATCH v8 00/27] gdbstub: Refactor command packets
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
Cc: liran.alon@oracle.com, alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502072614.VHl7XAlyLr07C-3yfCOyhL7w3ca4L80JfWOSxk3molA@z>

This patch series refactors the old gdbstub command packets handler
with a new infrastructure which should ease extending and adding new
and missing gdb command packets.

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

Jon Doron (27):
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
  gdbstub: Implement generic query qemu.Supported
  gdbstub: Implement qemu physical memory mode
  gdbstub: Add another handler for setting qemu.sstep
  kvm: Add API to read/write a CPU MSR value
  gdbstub: Add support to read a MSR for KVM target
  gdbstub: Add support to write a MSR for KVM target

 accel/kvm/kvm-all.c  |   39 +
 gdbstub.c            | 1807 ++++++++++++++++++++++++++++++------------
 include/sysemu/kvm.h |    2 +
 3 files changed, 1359 insertions(+), 489 deletions(-)

-- 
2.20.1


