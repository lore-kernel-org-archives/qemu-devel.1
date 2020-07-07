Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A049AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7766A20674
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7766A20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspzy-0008KN-Pn
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jspwv-0004CH-LY
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:56:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:33954)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jspwt-0004GD-Od
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:56:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jspwr-0006kE-9B
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 15:55:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 341622E8105
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2020 15:55:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2020 15:47:58 -0000
From: "Laszlo Ersek \(Red Hat\)" <1886602@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: circuitsoft lersek
X-Launchpad-Bug-Reporter: Alex Austin (circuitsoft)
X-Launchpad-Bug-Modifier: Laszlo Ersek (Red Hat) (lersek)
References: <159408874500.32011.1427435858163411654.malonedeb@gac.canonical.com>
Message-Id: <159413687880.31619.7434333036925904809.malone@soybean.canonical.com>
Subject: [Bug 1886602] Re: Windows 10 very slow with OVMF
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ffd32ad7291fe66b5578d7c1407aaae58d1e0170";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b50ae2f44997737e22321dc476e281e4777c81ac
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 11:43:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1886602 <1886602@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sorry, no input from me. OVMF is apparently from November 2018, and QEMU
is version 3.1. Please try to reproduce with recent upstream components
(build both OVMF and QEMU from source), and if the issue persists,
please provide the complete QEMU command line, capture the OVMF debug
log (see OvmfPkg/README for instructions on that), and please also
provide the host CPU characteristics (/proc/cpuinfo,
/sys/module/kvm_*/parameters/*).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1886602

Title:
  Windows 10 very slow with OVMF

Status in QEMU:
  New

Bug description:
  Debian Buster

  Kernel 4.19.0-9-amd64
  qemu-kvm 1:3.1+dfsg-8+deb10u5
  ovmf 0~20181115.85588389-3+deb10u1

  Machine: Thinkpad T470, i7-7500u, 20GB RAM
  VM: 4 CPUs, 8GB RAM, Broadwell-noTSX CPU Model

  Windows 10, under this VM, seems to be exceedingly slow with all
  operations. This is a clean install with very few services running.
  Task Manager can take 30% CPU looking at an idle system.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1886602/+subscriptions

