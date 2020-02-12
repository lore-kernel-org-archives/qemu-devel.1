Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4155C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D82020659
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D82020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1rZ9-0005xt-OC
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 07:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j1rYS-00059K-FP
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j1rYR-0001y9-9y
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:55:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:59902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j1rYR-0001xL-4n
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 07:55:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j1rYP-0000J0-5i
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 12:55:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0641A2E8078
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 12:55:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Feb 2020 12:45:17 -0000
From: crocket <crockabiscuit@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: crockabiscuit laurent-vivier
X-Launchpad-Bug-Reporter: crocket (crockabiscuit)
X-Launchpad-Bug-Modifier: crocket (crockabiscuit)
References: <157762661516.5433.16221584605990009162.malonedeb@gac.canonical.com>
Message-Id: <158151151743.29423.2827524736516781132.malone@chaenomeles.canonical.com>
Subject: [Bug 1857811] Re: qemu user static binary seems to lack support for
 network namespace.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d03db767847d4493c0538cc2f16f00b39a0aca80
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1857811 <1857811@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

def _configure_loopback_interface():
	"""
	Configure the loopback interface.
	"""

	# We add some additional addresses to work around odd behavior in glibc's
	# getaddrinfo() implementation when the AI_ADDRCONFIG flag is set.
	#
	# For example:
	#
	#   struct addrinfo *res, hints =3D { .ai_family =3D AF_INET, .ai_flags =
=3D AI_ADDRCONFIG };
	#   getaddrinfo("localhost", NULL, &hints, &res);
	#
	# This returns no results if there are no non-loopback addresses
	# configured for a given address family.
	#
	# Bug: https://bugs.gentoo.org/690758
	# Bug: https://sourceware.org/bugzilla/show_bug.cgi?id=3D12377#c13

	# Avoid importing this module on systems that may not support netlink sock=
ets.
	from portage.util.netlink import RtNetlink

	try:
		with RtNetlink() as rtnl:
			ifindex =3D rtnl.get_link_ifindex(b'lo')
			rtnl.set_link_up(ifindex)
			rtnl.add_address(ifindex, socket.AF_INET, '10.0.0.1', 8)
			if _has_ipv6():
				rtnl.add_address(ifindex, socket.AF_INET6, 'fd::1', 8)
	except EnvironmentError as e:
		writemsg("Unable to configure loopback interface: %s\n" % e.strerror, noi=
selevel=3D-1)

If I execute _configure_loopback_interface in a qemu-aarch64 chroot, I
see the following error.

Unable to configure loopback interface: Operation not supported

https://bugs.gentoo.org/703276 explains the issue.

** Bug watch added: Sourceware.org Bugzilla #12377
   https://sourceware.org/bugzilla/show_bug.cgi?id=3D12377

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1857811

Title:
  qemu user static binary seems to lack support for network namespace.

Status in QEMU:
  New

Bug description:
  Whenever I execute emerge in gentoo linux in qemu-aarch64 chroot, I
  see the following error message.

  Unable to configure loopback interface: Operation not supported

  If I disable emerge's network-sandbox which utilizes network
  namespace, the error disappears.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1857811/+subscriptions

