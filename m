Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D22C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B18206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B18206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyUle-0008Ez-B0
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 01:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1hyUk8-0006w9-1m
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hyUk6-0004TP-Q7
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:25:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:54282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hyUk6-0004Su-KL
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:25:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hyUk5-0004uU-So
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:25:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D71022E8053
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:25:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2019 05:16:11 -0000
From: Thomas Huth <1826172@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: fonthime pmaydell
X-Launchpad-Bug-Reporter: Gwendolyn Haller (fonthime)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <155609911336.14005.5630723939838624325.malonedeb@gac.canonical.com>
Message-Id: <156593257228.27026.3825521199497138514.launchpad@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: d97c46bd40e574e4a2f7a4d72d608ffff8374899
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1826172] Re: Compilation on MSYS2/MinGW-w64 fails
 with error: "__USE_MINGW_ANSI_STDIO" redefined
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
Reply-To: Bug 1826172 <1826172@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826172

Title:
  Compilation on MSYS2/MinGW-w64 fails with error:
  "__USE_MINGW_ANSI_STDIO" redefined

Status in QEMU:
  Fix Released

Bug description:
  Compilation against GIT master fails at the following step:

  =C2=A0=C2=A0CC      qga/commands.o
  In file included from qga/commands.c:13:
  C:/Tempy-chan/qemu/include/qemu/osdep.h:97: error: "__USE_MINGW_ANSI_STDI=
O" redefined [-Werror]
  =C2=A0#define __USE_MINGW_ANSI_STDIO 1

  In file included from C:/msys64/mingw64/x86_64-w64-mingw32/include/vadefs=
.h:9,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/msys64/mingw64/x86_64-w64-mingw32/inc=
lude/_mingw_stdarg.h:14,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/msys64/mingw64/x86_64-w64-mingw32/inc=
lude/stdarg.h:140,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/msys64/mingw64/lib/gcc/x86_64-w64-min=
gw32/8.3.0/include/stdarg.h:1,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/Tempy-chan/qemu/include/qemu/osdep.h:=
88,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from qga/commands.c:13:
  C:/msys64/mingw64/x86_64-w64-mingw32/include/_mingw.h:431: note: this is =
the location of the previous definition
  =C2=A0#define __USE_MINGW_ANSI_STDIO 0      /* was not defined so it shou=
ld be 0 */

  cc1.exe: all warnings being treated as errors
  make: *** [/c/Tempy-chan/qemu/rules.mak:69: qga/commands.o] Error 1

  Passing --extra-cflags=3D"-D__USE_MINGW_ANSI_STDIO" to configure
  resolves the error. Digging deeper in
  x86_64-w64-mingw32/include/_mingw.h, it looks like
  __USE_MINGW_ANSI_STDIO is only defined for _GNU_SOURCE in C++
  compilation. With C only code it's ignored and doesn't define
  __USE_MINGW_ANSI_STDIO as expected:

  /* We are activating __USE_MINGW_ANSI_STDIO for various define indicators.
  =C2=A0=C2=A0=C2=A0Note that we enable it also for _GNU_SOURCE in C++, but=
 not for C case. */
  #if (defined (_POSIX) || defined (_POSIX_SOURCE) || defined (_POSIX_C_SOU=
RCE) \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| defined (_ISOC99_SOURCE) \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| defined (_XOPEN_SOURCE) || defined (_XOP=
EN_SOURCE_EXTENDED) \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| (defined (_GNU_SOURCE) && defined (__cpl=
usplus)) \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| defined (_SVID_SOURCE)) \
  =C2=A0=C2=A0=C2=A0=C2=A0&& !defined(__USE_MINGW_ANSI_STDIO)
  /* Enable __USE_MINGW_ANSI_STDIO if _POSIX defined
  =C2=A0* and If user did _not_ specify it explicitly... */
  #  define __USE_MINGW_ANSI_STDIO			1
  #endif

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826172/+subscriptions

