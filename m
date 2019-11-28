Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DFEC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A7C21741
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A7C21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaOaB-0002gu-9I
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 13:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iaNrh-00065v-J9
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iaNrZ-0007Me-Iv
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:45:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:52282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iaNrV-0007DY-KZ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:45:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iaNrK-0005f6-QW
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 17:45:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C628E2E80C8
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 17:45:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Nov 2019 17:35:56 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided;
 assignee=lersek@redhat.com; 
X-Launchpad-Bug-Tags: feature-request
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: lersek philmd
X-Launchpad-Bug-Reporter: Laszlo Ersek (Red Hat) (lersek)
X-Launchpad-Bug-Modifier: Laszlo Ersek (Red Hat) (lersek)
References: <157355353271.7205.5763587027166419396.malonedeb@gac.canonical.com>
Message-Id: <157496255696.22452.16681130329432438765.malone@chaenomeles.canonical.com>
Subject: [Bug 1852196] Re: update edk2 submodule & binaries to
 edk2-stable201911
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b399d2c60c54df0ea8023730b88b328f76b2f073
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1852196 <1852196@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Yes, I do have a reason for delaying this LP until after 4.2.0 is out.

When I filed this ticket (on 2019-Nov-12), QEMU had already entered the
4.2.0 soft feature freeze (on 2019-Oct-29). Despite possible
appearances, this LP is actually a feature addition -- that's why I also
set "Tags: feature-request" when I filed this LP.

The reason this is not a fix but a feature addition is the following:
- CVE-2019-14553 is irrelevant (doesn't exist) until we enable HTTPS Boot,
- we have not enabled HTTPS Boot earlier exactly because of CVE-2019-14553,
- the plan is to enable HTTPS Boot now, with CVE-2019-14553 fixed,
- so what remains are CVE-2019-1543, CVE-2019-1552 and CVE-2019-1563, which=
 are native OpenSSL problems.

The upstream edk2 project advanced to OpenSSL 1.1.1d because of the last
point (i.e. because of those three OpenSSL CVEs). That submodule update
was tracked in:

https://bugzilla.tianocore.org/show_bug.cgi?id=3D2226

As you can see:

(1) there was zero analysis or explanation how those OpenSSL CVEs would
*actually* affect edk2 platforms,

(2) edk2 advanced to OpenSSL 1.1.1d (on 2019-Nov-05) approximately two
months after upstream OpenSSL 1.1.1d was released (on 2019-Sep-10).

Furthermore,

(3) all the listed CVEs are marked "low severity":

https://cve.mitre.org/cgi-bin/cvename.cgi?name=3DCVE-2019-1543
https://cve.mitre.org/cgi-bin/cvename.cgi?name=3DCVE-2019-1552
https://cve.mitre.org/cgi-bin/cvename.cgi?name=3DCVE-2019-1563

(The first two items are declared low severity on cve.mitre.org, while
the last item is declared low severity in
<https://www.openssl.org/news/secadv/20190910.txt>.)

These points (1) through (3) tell me that the edk2 advance was more or
less "better safe than sorry" or "cargo cult".

While that approach is not necessarily wrong, if you have infinite
amounts of time, my capacity falls near the other end of the spectrum.
If someone runs QEMU in production, they should build their firmware
from source anyway -- the bundling of edk2 binaries with QEMU is a
convenience.

If you'd like to submit a QEMU patch set (just for the sake of the CVE
fixes, not the HTTPS Boot feature), and are willing to make the case for
getting that into 4.2-rc4, I won't block it, but I don't think it's
worth the churn, to be honest.

Thanks!
Laszlo

** Bug watch added: bugzilla.tianocore.org/ #2226
   https://bugzilla.tianocore.org/show_bug.cgi?id=3D2226

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2019-14553

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2019-1543

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2019-1552

** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2019-1563

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1852196

Title:
  update edk2 submodule & binaries to edk2-stable201911

Status in QEMU:
  New

Bug description:
  edk2-stable201911 will be tagged soon:

    https://github.com/tianocore/tianocore.github.io/wiki/EDK-II-
  Release-Planning

    https://github.com/tianocore/edk2/releases/tag/edk2-stable201911
    [upcoming link]

  It should be picked up by QEMU, after the v4.2.0 release.

  Relevant fixes / features in edk2, since edk2-stable201905 (which is
  what QEMU bundles at the moment, from LP#1831477):

  - enable UEFI HTTPS Boot in ArmVirtQemu* platforms
    https://bugzilla.tianocore.org/show_bug.cgi?id=3D1009
    (this is from edk2-stable201908)

  - fix CVE-2019-14553 (Invalid server certificate accepted in HTTPS Boot)
    https://bugzilla.tianocore.org/show_bug.cgi?id=3D960

  - consume OpenSSL-1.1.1d, for fixing CVE-2019-1543, CVE-2019-1552 and
    CVE-2019-1563
    https://bugzilla.tianocore.org/show_bug.cgi?id=3D2226

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1852196/+subscriptions

