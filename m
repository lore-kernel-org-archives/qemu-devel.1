Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063ACC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 13:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A26921D7F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 13:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A26921D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFdPB-0000YM-4H
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 09:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kFdOb-0008S7-UD
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 09:10:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:58226)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kFdOZ-00051c-W3
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 09:10:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kFdOY-0007bC-KW
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 13:10:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 97ACE2E806F
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 13:10:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2020 13:00:47 -0000
From: Eric Blake <1894781@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: eblake vklimovs
X-Launchpad-Bug-Reporter: Vjaceslavs Klimovs (vklimovs)
X-Launchpad-Bug-Modifier: Eric Blake (eblake)
References: <159953760175.19565.14791337348074084173.malonedeb@gac.canonical.com>
Message-Id: <159957004740.15983.17399401978922700830.launchpad@loganberry.canonical.com>
Subject: [Bug 1894781] Re: [Feature request] Provide a way to do TLS first in
 QEMU/NBD connections (not after NBD negotiation)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="90a5703803d95539bdb5c0b289b1675630569e1e"; Instance="production"
X-Launchpad-Hash: dcb1e7e0d649e6f300fb222dcdd414f26ed5d257
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:20:40
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
Reply-To: Bug 1894781 <1894781@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Bug watch added: gitlab.com/libvirt/libvirt/-/issues #68
   https://gitlab.com/libvirt/libvirt/-/issues/68

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1894781

Title:
  [Feature request] Provide a way to do TLS first in QEMU/NBD
  connections (not after NBD negotiation)

Status in QEMU:
  New

Bug description:
  (following from
  https://gitlab.com/libvirt/libvirt/-/issues/68#note_400960567)

  As is very well explained in https://www.berrange.com/posts/2016/04/05
  /improving-qemu-security-part-5-tls-support-for-nbd-server-client/,
  and easily confirmed with captures, NBD stream starts in cleartext and
  upgrades to TLS inline (similar to STARTTLS mechanism). As a
  rationale, it is stated that this provides better error messages for
  the user of NBD.

  However, this approach has downsides:

  1) Clear indication to a network observer that NBD (and therefore likely =
qemu/libvirt) is used. In contrast, TLS1.3 hides even the SNI of the server=
s (ESNI, https://blog.cloudflare.com/encrypted-sni/).
  2) Potential for bugs in NBD protocol negotiation code. That code just st=
atistically, likely less looked at code than gnutls. This is not a reflecti=
on on NBD code quality, just the fact that TLS code does receive a bit more=
 scrutiny. =

  3) Inability to inspect TLS listener interface for compliance, e.g. with =
a security scanner. Making sure TLS listeners only select certain ciphersui=
ts is a requirement of some compliance regimes. =


  I think it's fully possible to satisfy the original requirement of
  good error messages as well, detecting that the other end is
  initiating TLS connection.

  It's very unlikely that it's currently sae to recommend to run QEMU
  migration stream over a hostile network, but it should be possible to
  do with TLS only option.

  Solution to this, just like in the case of SMTP, is to provide TLS
  only option (no initial cleartext at all) for QEMU migration, which
  hopefully it not a large addition.

  Thank you for your consideration!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1894781/+subscriptions

