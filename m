Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A03C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 06:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C974A2145D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 06:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C974A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNsCx-0005mt-QS
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 02:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kNsBl-0005Jm-HE
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 02:35:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:60402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kNsBg-00068Z-DR
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 02:35:37 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kNsBe-0001vA-Si
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 06:35:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D7D752E8072
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2020 06:35:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2020 06:30:03 -0000
From: Kostya Serebryany <1898011@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ksserebr
X-Launchpad-Bug-Reporter: Kostya Serebryany (ksserebr)
X-Launchpad-Bug-Modifier: Kostya Serebryany (ksserebr)
Message-Id: <160153380394.6201.10648910301442382269.malonedeb@soybean.canonical.com>
Subject: [Bug 1898011] [NEW] mmap MAP_NORESERVE of 2^42 bytes consumes 16Gb of
 actual RAM
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d50d1e75c500726862802414f880ee3e3bb759bf"; Instance="production"
X-Launchpad-Hash: f74a548b0993c28ee4626af11ff2863b2f2215f5
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 01:15:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1898011 <1898011@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Run this program:

#include <sys/mman.h>
#include <stdio.h>
int main() {
        for (int i =3D 30; i <=3D 44; i++) {
                fprintf(stderr, "trying 2**%d\n", i);
                mmap((void*)0x600000000000,1ULL << i,
                        PROT_NONE,
                        MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED|MAP_NORESERVE,-=
1,0);
        }
}

(tried qemu-x86_64 and qemu-aarch64, 4.2.1 and trunk/5.1.50)

On each iteration qemu will consume 2x more physical RAM, =

e.g. when mapping 2^42 it will have RSS of 16Gb.

On normal linux it works w/o consuming much RAM, due to MAP_NORESERVE.

Also: qemu -strace prints 0 instead of the correct size starting from size=
=3D2^32
and prints -2147483648 for size=3D2^31. =


mmap(0x0000600000000000,1073741824,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_=
FIXED|MAP_NORESERVE,-1,0)
=3D 0x0000600000000000

mmap(0x0000600000000000,-2147483648,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|MAP=
_FIXED|MAP_NORESERVE,-1,0)
=3D 0x0000600000000000

mmap(0x0000600000000000,0,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED|MAP=
_NORESERVE,-1,0)
=3D 0x0000600000000000

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1898011

Title:
  mmap MAP_NORESERVE of 2^42 bytes consumes 16Gb of actual RAM

Status in QEMU:
  New

Bug description:
  Run this program:

  #include <sys/mman.h>
  #include <stdio.h>
  int main() {
          for (int i =3D 30; i <=3D 44; i++) {
                  fprintf(stderr, "trying 2**%d\n", i);
                  mmap((void*)0x600000000000,1ULL << i,
                          PROT_NONE,
                          MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED|MAP_NORESERVE=
,-1,0);
          }
  }

  (tried qemu-x86_64 and qemu-aarch64, 4.2.1 and trunk/5.1.50)

  On each iteration qemu will consume 2x more physical RAM, =

  e.g. when mapping 2^42 it will have RSS of 16Gb.

  On normal linux it works w/o consuming much RAM, due to MAP_NORESERVE.

  Also: qemu -strace prints 0 instead of the correct size starting from siz=
e=3D2^32
  and prints -2147483648 for size=3D2^31. =


  mmap(0x0000600000000000,1073741824,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|MA=
P_FIXED|MAP_NORESERVE,-1,0)
  =3D 0x0000600000000000

  mmap(0x0000600000000000,-2147483648,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|M=
AP_FIXED|MAP_NORESERVE,-1,0)
  =3D 0x0000600000000000

  mmap(0x0000600000000000,0,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_FIXED|M=
AP_NORESERVE,-1,0)
  =3D 0x0000600000000000

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1898011/+subscriptions

