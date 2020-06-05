Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0106C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995D9206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995D9206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhHMM-0002K0-TG
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 14:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jhHLc-0001tv-La
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 14:45:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:48810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jhHLb-0001z0-Mc
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 14:45:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jhHLZ-0000zT-K1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 18:45:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 94EC92E810A
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2020 18:45:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2020 18:38:43 -0000
From: Roman Bolshakov <1827005@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: hvf
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cuser2
X-Launchpad-Bug-Reporter: Chen Zhang (cuser2)
X-Launchpad-Bug-Modifier: Roman Bolshakov (roolebo)
References: <155660771706.7289.11621855018434071577.malonedeb@chaenomeles.canonical.com>
Message-Id: <159138232442.8765.368189202357349332.launchpad@wampee.canonical.com>
Subject: [Bug 1827005] Re: hvf: ubuntu iso boot menu issue
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ef9fc486e875d54078fa61cf91e898b895125d89";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 115aef9e1464e86442a88d62aad963eded19d3ed
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 14:45:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Reply-To: Bug 1827005 <1827005@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Tags added: hvf

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1827005

Title:
  hvf: ubuntu iso boot menu issue

Status in QEMU:
  New

Bug description:
  With hvf acceleration on macOS, ubuntu server installation ISO boot
  language menu shows fractured images.

  To reproduce the issue:
  ./x86_64-softmmu/qemu-system-x86_64 -m 800 -accel hvf -cdrom ~/ubuntu-16.=
04.4-server-amd64.iso

  Control:
  ./x86_64-softmmu/qemu-system-x86_64 -m 800 -accel tcg -cdrom ~/ubuntu-16.=
04.4-server-amd64.iso

  Host: macOS Mojave 10.14.3
  Guest: Ubuntu Server 16.04.4 ISO
  QEMU: version 3.1.94 (v4.0.0-rc4)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1827005/+subscriptions

