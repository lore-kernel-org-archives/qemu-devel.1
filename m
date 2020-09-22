Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A06C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5896B207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 21:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5896B207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqDx-0003r4-F0
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 17:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kKq1y-0003MS-Um
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:40:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:57520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kKq1u-0000rA-3b
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 17:40:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kKq1q-0004F2-QC
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 21:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C287A2E8071
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 21:40:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2020 21:30:49 -0000
From: Toolybird <1896096@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange bonzini fredb74 laurent-vivier pmaydell
 toolybird
X-Launchpad-Bug-Reporter: Frederic Bezies (fredb74)
X-Launchpad-Bug-Modifier: Toolybird (toolybird)
References: <160036517624.17887.51064102046414127.malonedeb@soybean.canonical.com>
Message-Id: <160081024954.1762.12834254270986744591.malone@chaenomeles.canonical.com>
Subject: [Bug 1896096] Re: Git version: Build process is broken in
 block_curl.c.o
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: f92f8e4c707290bde485807917d725b0506e601d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:45:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1896096 <1896096@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Attachment added: "meson-log.txt"
   https://bugs.launchpad.net/qemu/+bug/1896096/+attachment/5413347/+files/=
meson-log.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1896096

Title:
  Git version: Build process is broken in block_curl.c.o

Status in QEMU:
  Invalid

Bug description:
  Gcc version: 10.2.0
  Glusterfs: 8.1
  Libguestfs: 1.42

  Configure options used:

  configure \
      --prefix=3D/usr \
      --sysconfdir=3D/etc \
      --localstatedir=3D/var \
      --libexecdir=3D/usr/lib/qemu \
      --extra-ldflags=3D"$LDFLAGS" \
      --smbd=3D/usr/bin/smbd \
      --enable-modules \
      --enable-sdl \
      --disable-werror \
      --enable-slirp=3Dsystem \
      --enable-xfsctl \
      --audio-drv-list=3D"pa alsa sdl"
      =

  Error log attached. Here is the beginning:

  /usr/bin/ld: /usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/../../../../lib/Scrt=
1.o: in function `_start':
  (.text+0x24): undefined reference to `main'
  /usr/bin/ld: libblock-curl.a(block_curl.c.o): in function `curl_block_ini=
t':

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1896096/+subscriptions

