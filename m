Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F26AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 20:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4C02074D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 20:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4C02074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k48YY-0001EV-9S
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 16:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k48X6-0000fP-HE
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 16:00:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:44940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k48X3-00006d-8I
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 16:00:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k48X1-0004Ys-C3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 19:59:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 510AB2E808D
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 19:59:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2020 19:49:54 -0000
From: Christian Schoenebeck <1500265@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: d-haid metux-its schoenebeck th-huth
X-Launchpad-Bug-Reporter: Daniel Haid (d-haid)
X-Launchpad-Bug-Modifier: Christian Schoenebeck (schoenebeck)
References: <20150927211256.29032.14479.malonedeb@chaenomeles.canonical.com>
Message-Id: <159682979495.5096.1114650893392955671.malone@soybean.canonical.com>
Subject: [Bug 1500265] Re: nested 9p filesystem with
 security_model=mapped-xattr
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: fa3910271492ee61715e5443b9b5f4091dd92849
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:41:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1500265 <1500265@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The status of this issue is unchanged in QEMU, i.e. user.virtfs.* is
still filtered out.

If someone wants to see this changed, please use the common way for sending=
 the patch via ML:
https://wiki.qemu.org/Contribute/SubmitAPatch

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1500265

Title:
  nested 9p filesystem with security_model=3Dmapped-xattr

Status in QEMU:
  Incomplete

Bug description:
  I do not know whether this is a bug or a feature request, but on a 9p
  virtfs with security_model=3Dmapped-xattr, access to extended attributes
  starting with "user.virtfs" coming from the guest seem to be silently
  ignored. Would it not be more correct to use some sort of "escaping",
  say map to "user.virtfs.x" on guest to "user.virtfs.virtfs.x" on host
  or something like that, so that the guest can use arbitrary
  attributes.

  In particular, this would allow nested virtual machines to use nested
  9p virtfs with security_model=3Dmapped-xattr.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1500265/+subscriptions

