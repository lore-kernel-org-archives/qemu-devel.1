Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7337EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D88B2086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D88B2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2tIl-0000kL-IQ
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 05:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2tHa-0008Ig-5H
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:30:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:34836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2tHX-00010o-E6
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:30:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k2tHV-0004lE-7N
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 09:30:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 362482E80D2
 for <qemu-devel@nongnu.org>; Tue,  4 Aug 2020 09:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2020 09:23:44 -0000
From: Daniel Berrange <1879672@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Opinion; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange philmd ubuntu-weilnetz
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Daniel Berrange (berrange)
References: <158996968484.21371.12685815665992748631.malonedeb@wampee.canonical.com>
Message-ID: <20200804092344.GC4020825@redhat.com>
Subject: [Bug 1879672] Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 9f3ec8ede52dcb61936066b65f1980cc214aadfd
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 03:31:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1879672 <1879672@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200804092344.UoVuVAmynB4pMcSpm4UwV7JeikPYdXIGGoZ6i7wTKNY@z>

On Tue, Aug 04, 2020 at 10:10:31AM +0200, Thomas Huth wrote:
> On 04/08/2020 09.42, Stefan Weil wrote:
> > Am 04.08.20 um 09:23 schrieb Philippe Mathieu-Daud=C3=A9:
> > =

> >> On 8/4/20 8:55 AM, Stefan Weil wrote:
> >>> Am 04.08.20 um 08:43 schrieb Thomas Huth:
> >>>
> >>>> On 03/08/2020 22.25, Stefan Weil wrote:
> >>>>> We can add a CI pipeline on Microsoft infrastructure by using a Git=
Hub
> >>>>> action.
> >>>> Sorry for being ignorant, but how does that solve the legal questions
> >>>> just because it is running on GitHub instead of a different CI?
> >>>>
> >>>>  Thomas
> >>>>
> >>> Sorry, I though that would be clear by looking at the included shell =
script.
> >>>
> >>> The build does not use the Microsoft SDK. It gets the required header
> >>> files from Mingw-w64. They added them in git master.
> =

> Great, thanks for the clarification!
> =

> >> Oh, so we can do that with GitLab too now, we don't need to rely on the
> >> GitHub 'Actions' CI in particular, right?
> > =

> > That's right. The build script was written for Ubuntu, so depending on
> > the distribution used for GitLab CI it will need some modifications. If
> > GitLab already has a recent Mingw-w64, it might be sufficient to fix the
> > case of the header file names. Mingw-w64 uses winhvplatform.h while QEMU
> > expects WinHvPlatform.h and so on. I used symbolic links to add the
> > camel case filenames.
> =

> I'm currently working on a patch series for our gitlab-CI that uses our
> containers to all possible kinds of cross-compiler builds (basically the
> ones that we are doing on shippable.com so far), including the 32-bit
> and 64-bit MinGW cross-compilation jobs. I can have a look whether I can
> integrate these headers there!

Fedora rawhide carries mingw64 v7.0.0, which was released in Nov 2019

The WHPX headers were added to mingw64 git a week later, so they're
not available in any distro yet. =


The mingw64 release schedule looks "sporadic" so maybe we can just
request a new release to make WPHX stuff available. It'll thus be
available for our CI in rawhide/sid shortly thereafter, which will
be the best solution to let us do this in GitLab.

We certainly don't want to add yet another separate CI system just
for WHPX.

Regards,
Daniel
-- =

|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1879672

Title:
  QEMU installer with WHPX support

Status in QEMU:
  Opinion

Bug description:
  People often ask the community to add WHPX support to the QEMU installer =
for Windows,
  but it is impossible due to the license limitations of the WHPX SDK.

  The WinHvEmulation.h and WinHvPlatform.h header files needed are "All
  rights reserved".

  However these headers only contain struct definitions and integer constan=
ts,
  no functional code in macros or inline functions. See:
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg645815.html
  It is questionable whether the headers alone can be considered copyrighta=
ble material.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1879672/+subscriptions

