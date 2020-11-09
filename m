Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40EFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:02:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209BB206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 08:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209BB206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc28J-0008Ic-7J
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 03:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kc26p-0007Qf-Vc
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 03:01:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:58406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kc26j-0006lc-Om
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 03:01:03 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kc26h-0006Eh-Ib
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 08:00:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 86E982E8023
 for <qemu-devel@nongnu.org>; Mon,  9 Nov 2020 08:00:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2020 07:52:46 -0000
From: ssedt <1903493@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: s12a
X-Launchpad-Bug-Reporter: ssedt (s12a)
X-Launchpad-Bug-Modifier: ssedt (s12a)
Message-Id: <160490836647.18396.16400473727011669931.malonedeb@wampee.canonical.com>
Subject: [Bug 1903493] [NEW] About wireless network card bridging
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 5c852a51cf087c3d8519aa5c29b60de3bda0f044
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:40:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -66
X-Spam_score: -6.7
X-Spam_bar: ------
X-Spam_report: (-6.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Reply-To: Bug 1903493 <1903493@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

As a rookie, I don=E2=80=99t know if I should ask this question here. If it=
=E2=80=99s
not right, I hope people who see it can help submit it to the right
place. Qemu-kvm can add wireless network card bridging, after all, now
you see that vbox and vmware can directly choose wireless network card
bridging, and even hyper-v can be easily set up, arp proxy is too
difficult for us rookies . I hope that qemu or other links can add a
function to bridge the wireless network card, which can be directly set
in virt-manager (for so many years, it seems that I can only use bridge-
utils to bridge the Ethernet)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1903493

Title:
  About wireless network card bridging

Status in QEMU:
  New

Bug description:
  As a rookie, I don=E2=80=99t know if I should ask this question here. If =
it=E2=80=99s
  not right, I hope people who see it can help submit it to the right
  place. Qemu-kvm can add wireless network card bridging, after all, now
  you see that vbox and vmware can directly choose wireless network card
  bridging, and even hyper-v can be easily set up, arp proxy is too
  difficult for us rookies . I hope that qemu or other links can add a
  function to bridge the wireless network card, which can be directly
  set in virt-manager (for so many years, it seems that I can only use
  bridge-utils to bridge the Ethernet)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1903493/+subscriptions

