Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DC2C73C46
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 15:37:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C1D420656
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 15:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1D420656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hksAv-0001TT-O1
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 11:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47226)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hks9m-00006z-IM
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hks9k-0005is-Je
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:35:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:46022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hks9g-0005gx-Tc
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:35:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hks9e-0002LA-PS
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 15:35:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id BC9D32E80C7
 for <qemu-devel@nongnu.org>; Tue,  9 Jul 2019 15:35:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jul 2019 15:25:46 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: glaubitz laurent-vivier pmaydell
X-Launchpad-Bug-Reporter: John Paul Adrian Glaubitz (glaubitz)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <156262578461.2222.11301272429426949561.malonedeb@wampee.canonical.com>
 <156267329906.2764.88840211247289671.malone@wampee.canonical.com>
 <06bf8be7-c97e-9a42-06c4-82f303dc1a76@physik.fu-berlin.de>
 <3e3ac1b4-dd46-988a-9801-cd1353e81714@vivier.eu>
 <b88a6279-8e7a-32b6-4fc1-98be496aaaf0@physik.fu-berlin.de>
 <30e7b9fe-a99d-a83c-e4b6-7021a076332d@vivier.eu>
 <0211fabd-65fe-f6b0-00b9-1f0969e4bc1c@physik.fu-berlin.de>
Message-Id: <4b359373-608c-d4a4-c9ac-e2a3af840b21@vivier.eu>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: c9733dfe4db99945e7a7f550e163c1bdcee0311b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: Re: [Qemu-devel] [Bug 1835839] Re: qemu-user: $0 incorrectly always
 reports absolute path
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
Reply-To: Bug 1835839 <1835839@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190709152546.FfahzHnz6HGLD5kuguJS0eHMoULi2nNobPSMdXb2CNU@z>

Le 09/07/2019 =C3=A0 17:09, John Paul Adrian Glaubitz a =C3=A9crit=C2=A0:
> On 7/9/19 4:01 PM, Laurent Vivier wrote:
>> What is the content of:
>>
>> /etc/binfmt.d/qemu-m68k.conf
>> /proc/sys/fs/binfmt_misc/qemu-m68k
> =

> root@nofan:~> cat /etc/binfmt.d/qemu-m68k.conf
> :qemu-m68k:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00=
\x02\x00\x04:\xff\xff\xff\xff\xff\xff\xfe\x00\xff\xff\xff\xff\xff\xff\xff\x=
ff\xff\xfe\xff\xff:/usr/bin/qemu-m68k-static:P
> root@nofan:~> cat /proc/sys/fs/binfmt_misc/qemu-m68k
> enabled
> interpreter /usr/bin/qemu-m68k-static
> flags: OCF
> offset 0
> magic 7f454c4601020100000000000000000000020004
> mask ffffffffffffff00fffffffffffffffffffeffff

This is not consistent: you have 'P' in /etc/binfmt.d/qemu-m68k.conf but
'OCF' in /proc/sys/fs/binfmt_misc/qemu-m68k.

Check "systemctl status binfmt-support.service"

With 'P' when you change the binary you must reload the configuration
because the binary is loaded in memory once when the configuration is
updated.

Thanks,
Laurent

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1835839

Title:
  qemu-user: $0 incorrectly always reports absolute path

Status in QEMU:
  New

Bug description:
  We just ran into an issue with the Perl package on Debian/m68k when
  being built with qemu-user [1].

  The problem can be boiled down to qemu-user always reporting absolute
  paths for the shell variable $0 no matter on how the command was
  invoked.

  A simple reproducer is this:

  On normal system (no emulation):

  root@nofan:~> sh -c 'echo $0'
  sh
  root@nofan:~>

  On qemu-user:

  (sid-m68k-sbuild)root@nofan:/# sh -c 'echo $0'
  /bin/sh
  (sid-m68k-sbuild)root@nofan:/#

  > [1] https://lists.debian.org/debian-68k/2019/07/msg00007.html

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1835839/+subscriptions

