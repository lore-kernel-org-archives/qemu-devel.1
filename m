Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1307C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96BD920723
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BD920723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo7GN-0007gF-TU
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 11:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jo7Cf-0003Dv-6m
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:20:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:33924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jo7Cc-0004jj-IY
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:20:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jo7Ca-0004mM-9r
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 15:20:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4834B2E80E7
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 15:20:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2020 15:12:39 -0000
From: Mingye Wang <1884982@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: documentation
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: artoria2e5
X-Launchpad-Bug-Reporter: Mingye Wang (artoria2e5)
X-Launchpad-Bug-Modifier: Mingye Wang (artoria2e5)
Message-Id: <159301155950.13634.250500637103712065.malonedeb@wampee.canonical.com>
Subject: [Bug 1884982] [NEW] User-emu documentation mentions inexistent
 "runtime" downloads
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 28244f4eea0fa8b846b1d9e8952921512e075007
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 11:20:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1884982 <1884982@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

The official documentation for the user-space emulator[1] contains many
references to binary blobs no longer provided by  QEMU.org for download.
The parts mentioning them should be rephrased to avoid confusion and
instructions for building these components should be provided (maybe as
a reference to the LFS book with some scripts, or... cut a deal with
some super slim Linux distros). The specific parts are:

* qemu-XXX-i386-wine.tar.gz, a wine build under the prefix /wine.
* qemu-runtime-i386-XXX-.tar.gz, a glibc build.

=C2=A0=C2=A0[1]: https://www.qemu.org/docs/master/user/main.html

In addition, the documentation contains many other instances of
inexistent "tar.gz" files, such as in "Network emulation". Most of these
are inherited from the days of texi documentation more than 10 years
ago, and they are so old that GitHub's blame have become unreliable.
Someone really should run `fgrep -r 'tar.gz' doc' on the QEMU source
tree.

The issue was previously reported as [2], but nobody bother enough to
google the filename to find out where the confused user got the idea
from.

=C2=A0=C2=A0[2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg5691=
74.html

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: documentation

** Description changed:

  The official documentation for the user-space emulator[1] contains many
  references to binary blobs no longer provided by  QEMU.org for download.
  The parts mentioning them should be rephrased to avoid confusion and
  instructions for building these components should be provided (maybe as
- a reference to the LFS book with some scripts). The specific parts are:
+ a reference to the LFS book with some scripts, or... cut a deal with
+ some super slim Linux distros). The specific parts are:
  =

  * qemu-XXX-i386-wine.tar.gz, a wine build under the prefix /wine.
  * qemu-runtime-i386-XXX-.tar.gz, a glibc build.
  =

-   [1]: https://www.qemu.org/docs/master/user/main.html
+ =C2=A0=C2=A0[1]: https://www.qemu.org/docs/master/user/main.html
  =

  In addition, the documentation contains many other instances of
  inexistent "tar.gz" files, such as in "Network emulation". Most of these
  are inherited from the days of texi documentation more than 10 years
  ago, and they are so old that GitHub's blame have become unreliable.
  Someone really should run `fgrep -r 'tar.gz' doc' on the QEMU source
  tree.
  =

  The issue was previously reported as [2], but nobody bother enough to
  google the filename to find out where the confused user got the idea
  from.
  =

-   [2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg569174.html
+ =C2=A0=C2=A0[2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg56=
9174.html

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1884982

Title:
  User-emu documentation mentions inexistent "runtime" downloads

Status in QEMU:
  New

Bug description:
  The official documentation for the user-space emulator[1] contains
  many references to binary blobs no longer provided by  QEMU.org for
  download. The parts mentioning them should be rephrased to avoid
  confusion and instructions for building these components should be
  provided (maybe as a reference to the LFS book with some scripts,
  or... cut a deal with some super slim Linux distros). The specific
  parts are:

  * qemu-XXX-i386-wine.tar.gz, a wine build under the prefix /wine.
  * qemu-runtime-i386-XXX-.tar.gz, a glibc build.

  =C2=A0=C2=A0[1]: https://www.qemu.org/docs/master/user/main.html

  In addition, the documentation contains many other instances of
  inexistent "tar.gz" files, such as in "Network emulation". Most of
  these are inherited from the days of texi documentation more than 10
  years ago, and they are so old that GitHub's blame have become
  unreliable. Someone really should run `fgrep -r 'tar.gz' doc' on the
  QEMU source tree.

  The issue was previously reported as [2], but nobody bother enough to
  google the filename to find out where the confused user got the idea
  from.

  =C2=A0=C2=A0[2]: https://www.mail-archive.com/qemu-
  devel@nongnu.org/msg569174.html

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1884982/+subscriptions

