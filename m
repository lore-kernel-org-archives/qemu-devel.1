Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2685C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86C6206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 07:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86C6206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTKwL-0000Z8-Ov
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 03:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jTKqL-00050k-Ig
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jTKmN-0000BV-Vn
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:39:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:39630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jTKmN-000092-DN
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 03:35:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jTKmK-0008Pt-LA
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 07:35:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9E9192E8107
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 07:35:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2020 07:26:17 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1874674@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd rth
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <158772186217.18152.387783445327371928.malonedeb@wampee.canonical.com>
 <158775567923.17926.10729887989020372018.malone@wampee.canonical.com>
Message-Id: <8c80473f-d4fe-a699-fdf5-170aed4d879a@amsat.org>
Subject: Re: [Bug 1874674] Re: [Feature request] acceptance test class to run
 user-mode binaries
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d1105341713c5be348effe2a5142c4a210ce4cde";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 710558c841e647c3270fef8366fbea6e884f8163
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:20:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1874674 <1874674@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 9:14 PM, Richard Henderson wrote:
> What user-mode testing do you think might be improved by using avocado?

Test unmodified real-world binaries, know to work in the field.

Test can be added by users without having to be a TCG developer, see
https://www.mail-archive.com/qemu-devel@nongnu.org/msg626608.html:

  class LoadBFLT(LinuxUserTest):
      def test_stm32(self):
          rootfs_url =3D ('https://elinux.org/images/5/51/'
                        'Stm32_mini_rootfs.cpio.bz2')
          rootfs_path_bz2 =3D self.fetch_asset(rootfs_url, ...)
          busybox_path =3D self.workdir + "/bin/busybox"

          res =3D self.run("%s %s" % (busybox_path, cmd))
          ver =3D 'BusyBox v1.24.0.git (2015-02-03 22:17:13 CET) ...'
          self.assertIn(ver, res.stdout_text)

          cmd =3D 'uname -a'
          res =3D self.run("%s %s" % (busybox_path, cmd))
          unm =3D 'armv7l GNU/Linux'
          self.assertIn(unm, res.stdout_text)

This is a fairly trivial test, cheap (no need to cross-build), yet it
still covers quite some QEMU code.

> IMO at present we have a fairly comprehensive testing infrastructure for
> user-mode that is simply underused.  With docker, we have a set of
> cross-compilers for most guest architectures, and we are able to build
> statically linked binaries that are copied out of the container for
> testing by the just-built qemu binaries on the host.  This
> infrastructure is used by check-tcg.  It's fairly easy to add new test
> cases to be run on one or all guests.

What you describe is a different and complementary test set. Craft tests
and build them with QEMU.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1874674

Title:
  [Feature request] acceptance test class to run user-mode binaries

Status in QEMU:
  New

Bug description:
  Currently the acceptance test framework only target system-mode emulation.
  It would be useful to test user-mode too.

  Ref: https://www.mail-archive.com/qemu-devel@nongnu.org/msg626610.html

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1874674/+subscriptions

