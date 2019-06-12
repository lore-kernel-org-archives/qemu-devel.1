Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B50C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 14:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECA520866
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 14:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECA520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60826 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb43C-0002kS-Om
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 10:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44205)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hb3pE-0002fx-Dc
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hb3pA-0005FK-1g
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:02:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:40294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hb3p6-0005CV-Kd
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 10:01:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hb3ox-0003FR-JY
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 14:01:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3119E2E80D1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 14:01:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Jun 2019 13:46:13 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ddosolitary pmaydell
X-Launchpad-Bug-Reporter: DDoSolitary (ddosolitary)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <155137392124.31316.11495671074765014993.malonedeb@wampee.canonical.com>
Message-Id: <156034717312.30867.1168495929007980486.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18978";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 99c769ccb55deb2f40db994c7f47ea7c87fc2b9b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1818122] Re: QEMU 3.1 makes libxslt to crash on
 ppc64
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
Reply-To: Bug 1818122 <1818122@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Could you try with QEMU 4.0, please? There was a bug/incompatibility
between earlier QEMU and the Alpine Linux libc which we fixed in 4.0,
and so this might be that bug (or some other bug we've already fixed).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1818122

Title:
  QEMU 3.1 makes libxslt to crash on ppc64

Status in QEMU:
  New

Bug description:
  Host: clean Ubuntu Disco with QEMU 3.1

  Guest: Alpine Linux edge with xmlto

  Steps to set up guest:
  curl -O http://dl-cdn.alpinelinux.org/alpine/edge/releases/ppc64le/netboo=
t/vmlinuz-vanilla
  curl -O http://dl-cdn.alpinelinux.org/alpine/edge/releases/ppc64le/netboo=
t/initramfs-vanilla
  qemu-system-ppc64 -m 1G -kernel vmlinuz-vanilla -initrd initramfs-vanilla=
 -append "console=3Dhvc0 ip=3Ddhcp alpine_repo=3Dhttp://dl-cdn.alpinelinux.=
org/alpine/edge/main/ modloop=3Dhttp://dl-cdn.alpinelinux.org/alpine/edge/r=
eleases/ppc64le/netboot/modloop-vanilla" -device virtio-rng-pci -nographic
  This brings up an VM with an in-memory Alpine Linux.

  Steps to reproduce:
  Login as root and execute the following commands.
  apk add xmlto
  ntpd -nqp time.google.com // For TLS OCSP
  wget https://ddosolitary.org/manpage-base.xsl
  wget https://ddosolitary.org/shadowsocks-libev.xml
  xmlto -m manpage-base.xsl man shadowsocks-libev.xml
  The downloaded files are from this project: https://github.com/shadowsock=
s/shadowsocks-libev The former is directly taken from the "doc" directory a=
nd the latter is an intermediate build output generated by asciidoc from do=
c/shadowsocks-libev.asciidoc

  Expected behavior: The command silently succeeds producing
  shadowsocks-libev.8

  Actual behavior: =

  runtime error: file file:///usr/share/xml/docbook/xsl-stylesheets-1.79.1/=
manpages/tbl.xsl line 450 element text
  xsltApplySequenceConstructor: A potential infinite template recursion was=
 detected.
  You can adjust xsltMaxDepth (--maxdepth) in order to raise the maximum nu=
mber of nested template calls and variables/params (currently set to 3000).
  Templates:
  #0 name process.colspan
  #1 name process.colspan
  #2 name process.colspan
  #3 name process.colspan
  #4 name process.colspan
  #5 name process.colspan
  #6 name process.colspan
  #7 name process.colspan
  #8 name process.colspan
  #9 name process.colspan
  #10 name process.colspan
  #11 name process.colspan
  #12 name process.colspan
  #13 name process.colspan
  #14 name process.colspan
  Variables:
  #0
  type
  colspan
  #1
  colspan
  #2
  type
  colspan
  #3
  colspan
  #4
  type
  colspan
  #5
  colspan
  #6
  type
  colspan
  #7
  colspan
  #8
  type
  colspan
  #9
  colspan
  #10
  type
  colspan
  #11
  colspan
  #12
  type
  colspan
  #13
  colspan
  #14
  type
  colspan
  error: file /root/shadowsocks-libev.xml
  xsltRunStylesheet : run failed

  Note:
  I tried increasing --maxdepth as suggested in the error output but that w=
ill result in a segfault.
  This error doesn't occur with an older QEMU (I tested QEMU 2.12 on Ubuntu=
 Cosmic) or different architectures on QEMU 3.1 (I tested x86, x86_64, arm,=
 aarch64, s390x). Also it didn't help to use an older Alpine Linux (I teste=
d v3.8). So I think it is caused by a bug in QEMU rather than the distro/pa=
ckage.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1818122/+subscriptions

