Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DEAC2D0EC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 18:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFAE20757
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 18:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFAE20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMyMK-0002E4-5C
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 14:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jMyLa-0001Ym-OE
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 14:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jMyLZ-0004Cl-8j
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 14:25:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:39818)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jMyLZ-0004C5-3f
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 14:25:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jMyLX-0001xP-Qs
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 18:25:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C57572E8106
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 18:25:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2020 18:16:50 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kekepower pmaydell
X-Launchpad-Bug-Reporter: =?utf-8?q?Stig-=C3=98rjan_Smelror_=28kekepower=29?=
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <158654057369.6269.6354060003943218170.malonedeb@chaenomeles.canonical.com>
Message-Id: <158654261048.28566.10803184840829065949.malone@gac.canonical.com>
Subject: [Bug 1872113] Re: qemu docs fails to build with Sphinx 3.0.x
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: bb5b0fe77256f7b69609d876e184ae0c63a6bd99
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
Reply-To: Bug 1872113 <1872113@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hmm, that's not ideal. The C is valid C which the compiler accepts, so
I'm not sure what Sphinx is complaining about, and I don't have a system
with that new a version of Sphinx.

It does suggest that we ought to make our configure --enable-werror
/--disable-werror (and the code that makes the default be disable for
releases) control Sphinx's warnings-as-errors option as well as the
compiler's, which would at least mean that for released versions the
build doesn't fail entirely on Sphinx warnings.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1872113

Title:
  qemu docs fails to build with Sphinx 3.0.x

Status in QEMU:
  New

Bug description:
  We've just updated Sphinx to version 3.0.1 and qemu fails to build the
  docs with this version.

  Here's the relevant section in the build log.

  CONFDIR=3D"/etc/qemu" /usr/bin/sphinx-build-3  -W -b html -D version=3D4.=
2.92 -D release=3D"4.2.92 (qemu-5.0.0-0.rc2.0.1.mga8)" -d .doctrees/devel-h=
tml /home/iurt/rpmbuild/BUILD/qemu-5.0.0-rc2/docs/devel docs/devel
  Running Sphinx v3.0.1
  making output directory... done
  building [mo]: targets for 0 po files that are out of date
  building [html]: targets for 14 source files that are out of date
  updating environment: [new config] 14 added, 0 changed, 0 removed
  reading sources... [  7%] bitops
  reading sources... [ 14%] decodetree
  reading sources... [ 21%] index
  reading sources... [ 28%] kconfig
  reading sources... [ 35%] loads-stores
  reading sources... [ 42%] memory
  reading sources... [ 50%] migration
  reading sources... [ 57%] reset
  reading sources... [ 64%] s390-dasd-ipl
  reading sources... [ 71%] secure-coding-practices
  reading sources... [ 78%] stable-process
  reading sources... [ 85%] tcg
  reading sources... [ 92%] tcg-plugins
  reading sources... [100%] testing

  Warning, treated as error:
  /home/iurt/rpmbuild/BUILD/qemu-5.0.0-rc2/docs/../include/exec/memory.h:3:=
Type must be either just a name or a typedef-like declaration.
  If just a name:
  =C2=A0=C2=A0Error in declarator or parameters
  =C2=A0=C2=A0Invalid C declaration: Expected identifier in nested name, go=
t keyword: struct [error at 6]
  =C2=A0=C2=A0=C2=A0=C2=A0struct MemoryListener
  =C2=A0=C2=A0=C2=A0=C2=A0------^
  If typedef-like declaration:
  =C2=A0=C2=A0Error in declarator or parameters
  =C2=A0=C2=A0Invalid C declaration: Expected identifier in nested name. [e=
rror at 21]
  =C2=A0=C2=A0=C2=A0=C2=A0struct MemoryListener
  =C2=A0=C2=A0=C2=A0=C2=A0---------------------^

  make: *** [Makefile:1095: docs/devel/index.html] Error 2
  make: *** Waiting for unfinished jobs....

  I found this commit for memory.h that includes the section that faults.
  https://github.com/qemu/qemu/commit/5d248213180749e674fbccbacc6ee9c38499a=
bb3#diff-d892cbf314945b44699534cc1de4ebbd

  You can see the whole build log here.
  https://pkgsubmit.mageia.org/uploads/failure/cauldron/core/release/202004=
10161120.tv.duvel.699/log/qemu-5.0.0-0.rc2.0.1.mga8/build.0.20200410161338.=
log

  System: Mageia Cauldron

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1872113/+subscriptions

