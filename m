Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C21C54E8B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F7F52082E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 09:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7F52082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYQnk-0002gz-MV
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 05:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYQma-0001x8-5u
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:01:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:60060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYQmY-0005is-W0
 for qemu-devel@nongnu.org; Tue, 12 May 2020 05:00:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jYQmW-0002Eu-Pv
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:00:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9E38A2E810B
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 09:00:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2020 08:52:22 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: linux-user ppc64 tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: laurent-vivier mptcultist
X-Launchpad-Bug-Reporter: Catherine A. Frederick (mptcultist)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <158906134520.4878.9001427424029475940.malonedeb@chaenomeles.canonical.com>
Message-Id: <158927354209.4303.16829238998500928223.malone@chaenomeles.canonical.com>
Subject: [Bug 1877794] Re: Constant Folding on 64-bit Subtraction causes
 SIGILL on linux-user glxgears ppc64le to x86_64 by way of generating bad
 shift instruction with c=-1
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0adba12466fc2fec222a0c72fd6e269e401d1726
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 05:00:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1877794 <1877794@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU has been selected to have a GSoC intern to work on new ioctl():
https://wiki.qemu.org/Google_Summer_of_Code_2020#Extend_linux-user_syscalls=
_and_ioctls

Perhaps he can help you by working on DRM ioctl()?
Perhaps you can send an RFC series to the QEMU mailing list?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1877794

Title:
  Constant Folding on 64-bit Subtraction causes SIGILL on linux-user
  glxgears ppc64le to x86_64 by way of generating bad shift instruction
  with c=3D-1

Status in QEMU:
  New

Bug description:
  Hello, I've been recently working on my own little branch of QEMU
  implementing the drm IOCTLs, when I discovered that glxgears seems to
  crash in GLXSwapBuffers(); with a SIGILL. I investigated this for
  about 2 weeks, manually trying to trace the call stack, only to find
  that we seemingly crash in a bad shift instruction. Originally
  intended to be an shr_i64 generated to an RLDICL, we end up with an
  all ones(-1) c value, which gets thrown to the macro for generating
  the MB, and replaces the instruction with mostly ones. This new
  instruction, FFFFFFE0 is invalid on ppc64le, and crashes in a host
  SIGILL in codegen_buffer. I tried to see if the output of translate.c
  had this bad instruction, but all I got were two (shr eax, cl)
  instructions, and upon creating a test program with shr (eax, cl) in
  it, nothing happened. Then figuring that there was nothing actually
  wrong with the instruction in the first place, I turned my eye to the
  optimizer, and completely disabled constant folding for arithmetic
  instructions.  This seemed to actually resolve the issue, and then I
  slowly enabled constant folding again on various instructions only to
  find that enabling not on the shifts, but on subtraction seemed to
  cause the bug to reappear. I am bewildered and frankly at this point
  I'm not sure I have a chance in hell of figuring out what causes it,
  so I'm throwing it here.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1877794/+subscriptions

