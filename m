Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34801C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CFE206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CFE206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYX4w-0004Et-QW
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kYX40-0003Gq-6g
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:15:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:49108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kYX3x-0007Zq-RZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:15:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kYX3v-0005VA-3m
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 16:15:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 137202E811E
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 16:15:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2020 16:06:34 -0000
From: CandyMan <1902267@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: candyman30
X-Launchpad-Bug-Reporter: CandyMan (candyman30)
X-Launchpad-Bug-Modifier: CandyMan (candyman30)
Message-Id: <160407399412.14863.7198304237559619710.malonedeb@wampee.canonical.com>
Subject: [Bug 1902267] [NEW] CPU not support 32-bit stack in 32-bit unreal mode
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="96ff31b88b65a0d0ea73b89333fe7c4a2669d8fb"; Instance="production"
X-Launchpad-Hash: cd00c19fddb4940f97fe6d00381ab611e8b7a96a
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 11:55:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1902267 <1902267@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

QEMU version 5.0.0 supports 32-bit and 16-bit unreal mode. Great!
Unfortunately, QEMU does not support 32-bit stack in unreal 32-bit mode.
After the INT instruction, the stack is switched to 16-bit, which should no=
t be the case. =

At BOCHS, my code works 100%. At QEMU not works.

Sample code to find out:

use32
cli
mov ax,cs
shl eax,16
mov ax,NewInt80h
mov [IDT32+4*80h],eax
mov edx,esp
mov esp,0x10000
int 80h
NewInt80h:
xchg esp,edx
cmp edx,0x10000-6
jnz IsStack16Bit

Stack selector loaded from GDT:
GDT:
real32_GDT            =

dq 0
dw 0xFFFF,0x0000,9A00h,0xCF     ; 32-bit code descriptor
dw 0xFFFF,0x0000,9200h,0x8F     ;   4 GB data descriptor
dw 0xFFFF,0x0000,9A00h,0x00     ; 16-bit code descriptor
dw 0xFFFF,0x0000,9200h,0xCF     ; 32-bit data descriptor stack

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "my operating system"
   https://bugs.launchpad.net/bugs/1902267/+attachment/5429520/+files/FLATD=
OS.IMG

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1902267

Title:
  CPU not support 32-bit stack in 32-bit unreal mode

Status in QEMU:
  New

Bug description:
  QEMU version 5.0.0 supports 32-bit and 16-bit unreal mode. Great!
  Unfortunately, QEMU does not support 32-bit stack in unreal 32-bit mode.
  After the INT instruction, the stack is switched to 16-bit, which should =
not be the case. =

  At BOCHS, my code works 100%. At QEMU not works.

  Sample code to find out:

  use32
  cli
  mov ax,cs
  shl eax,16
  mov ax,NewInt80h
  mov [IDT32+4*80h],eax
  mov edx,esp
  mov esp,0x10000
  int 80h
  NewInt80h:
  xchg esp,edx
  cmp edx,0x10000-6
  jnz IsStack16Bit

  Stack selector loaded from GDT:
  GDT:
  real32_GDT            =

  dq 0
  dw 0xFFFF,0x0000,9A00h,0xCF     ; 32-bit code descriptor
  dw 0xFFFF,0x0000,9200h,0x8F     ;   4 GB data descriptor
  dw 0xFFFF,0x0000,9A00h,0x00     ; 16-bit code descriptor
  dw 0xFFFF,0x0000,9200h,0xCF     ; 32-bit data descriptor stack

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1902267/+subscriptions

