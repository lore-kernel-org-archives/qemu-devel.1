Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AACDC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 18:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF47C20781
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 18:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF47C20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS3QF-00030E-1M
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 14:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jS3PN-0002TG-B3
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jS3PM-0005NP-EP
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:50:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:47882)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jS3PL-0005Cl-VP
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:50:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jS3PI-00041W-6A
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 18:50:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2C2032E8047
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 18:50:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2020 18:44:18 -0000
From: Konstantin <1874888@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: skotik
X-Launchpad-Bug-Reporter: Konstantin (skotik)
X-Launchpad-Bug-Modifier: Konstantin (skotik)
Message-Id: <158775385817.8537.12364422091879172270.malonedeb@gac.canonical.com>
Subject: [Bug 1874888] [NEW] certain programs make QEMU crash with "tcg fatal
 error"
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="486bbbd6cb608f8eb468ed0d08689a349dfabe49";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ca1c4f5f622caafd53eef846b8163ec752981048
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 14:50:36
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
Reply-To: Bug 1874888 <1874888@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

The following code snippet crashes qemu with

.../tcg/tcg.c:3279: tcg fatal error
qemu-x86_64: /usr/local/google/home/kostik/qemu-5.0.0-rc4/accel/tcg/cpu-exe=
c.c:701: int cpu_exec(CPUState *): Assertion `!have_mmap_lock()' failed.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
int main() {
  /*
00000000 <.data>:
   0:   2e 45 71 ff             cs rex.RB jno 0x3
   4:   e9 00 00 f0 00          jmp    0xf00009
   9:   c4 42 7d 31 3e          vpmovzxbd ymm15,QWORD PTR [r14]
   e:   c4 a3 7d 08 64 82 44    vroundps ymm4,YMMWORD PTR [rdx+r8*4+0x44],0=
x0
  15:   00 =

  16:   0f 1e 0a                nop    DWORD PTR [rdx]
  19:   43 0f ec 20             rex.XB paddsb mm4,QWORD PTR [r8]
  1d:   66 47 0f 3a 0c 3d 00    rex.RXB blendps xmm15,XMMWORD PTR [rip+0x80=
00],0x0        # 0x8028
  24:   80 00 00 00 =

  28:   c4 e3 f9 df 5f 86 0d    vaeskeygenassist xmm3,XMMWORD PTR [rdi-0x7a=
],0xd
  2f:   c4 e2 55 92 74 fc 0a    vgatherdps ymm6,DWORD PTR [rsp+ymm7*8+0xa],=
ymm5
  36:   c4 e2 f9 17 9a 01 00    vptest xmm3,XMMWORD PTR [rdx+0x1]
  3d:   00 00 =

*/
  char buf[] =3D {
    0x2E, 0x45, 0x71, 0xFF, 0xE9, 0x00, 0x00, 0xF0, 0x00, 0xC4, 0x42, 0x7D,=
 0x31, 0x3E, 0xC4, 0xA3, 0x7D, 0x08, 0x64, 0x82, 0x44, 0x00, 0x0F, 0x1E, 0x=
0A, 0x43, 0x0F, 0xEC, 0x20, 0x66, 0x47, 0x0F, 0x3A, 0x0C, 0x3D, 0x00, 0x80,=
 0x00, 0x00, 0x00, 0xC4, 0xE3, 0xF9, 0xDF, 0x5F, 0x86, 0x0D, 0xC4, 0xE2, 0x=
55, 0x92, 0x74, 0xFC, 0x0A, 0xC4, 0xE2, 0xF9, 0x17, 0x9A, 0x01, 0x00, 0x00,=
 0x00
  };
  void (*f)(void) =3D (void (*) (void))buf;
  f();
  return 0;
}
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Steps to reproduce:
1) clang -static repro.c -o repro
2) qemu-x86_64-static repro

Tested with 4.2.0 and 5.0.0-rc4. Both -user and -system variants are
affected.

A few more snippets that cause the same sort of behavior:
1) 0x64, 0x46, 0x7D, 0xFF, 0xDF, 0x27, 0x46, 0x0F, 0xD4, 0x83, 0x5E, 0x00, =
0x00, 0x00, 0x3E, 0x0F, 0x6A, 0xEF, 0x0F, 0x05, 0xC4, 0x42, 0xFD, 0x1E, 0xC=
F, 0x46, 0x18, 0xE3, 0x47, 0xCD, 0x4E, 0x6E, 0x0F, 0x0F, 0x16, 0x8A

2) 0x67, 0x45, 0xDB, 0xD0, 0xAA, 0xC4, 0xE2, 0xB1, 0x01, 0x57, 0x00,
0xF3, 0x6F, 0xF3, 0x42, 0x0F, 0x1E, 0xFD, 0x64, 0x2E, 0xF2, 0x45, 0xD9,
0xC4, 0x3E, 0xF3, 0x0F, 0xAE, 0xF4, 0x3E, 0x47, 0x0F, 0x1C, 0x22, 0x42,
0x73, 0xFF, 0xD9, 0xFD

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1874888

Title:
  certain programs make QEMU crash with "tcg fatal error"

Status in QEMU:
  New

Bug description:
  The following code snippet crashes qemu with

  .../tcg/tcg.c:3279: tcg fatal error
  qemu-x86_64: /usr/local/google/home/kostik/qemu-5.0.0-rc4/accel/tcg/cpu-e=
xec.c:701: int cpu_exec(CPUState *): Assertion `!have_mmap_lock()' failed.

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  int main() {
    /*
  00000000 <.data>:
     0:   2e 45 71 ff             cs rex.RB jno 0x3
     4:   e9 00 00 f0 00          jmp    0xf00009
     9:   c4 42 7d 31 3e          vpmovzxbd ymm15,QWORD PTR [r14]
     e:   c4 a3 7d 08 64 82 44    vroundps ymm4,YMMWORD PTR [rdx+r8*4+0x44]=
,0x0
    15:   00 =

    16:   0f 1e 0a                nop    DWORD PTR [rdx]
    19:   43 0f ec 20             rex.XB paddsb mm4,QWORD PTR [r8]
    1d:   66 47 0f 3a 0c 3d 00    rex.RXB blendps xmm15,XMMWORD PTR [rip+0x=
8000],0x0        # 0x8028
    24:   80 00 00 00 =

    28:   c4 e3 f9 df 5f 86 0d    vaeskeygenassist xmm3,XMMWORD PTR [rdi-0x=
7a],0xd
    2f:   c4 e2 55 92 74 fc 0a    vgatherdps ymm6,DWORD PTR [rsp+ymm7*8+0xa=
],ymm5
    36:   c4 e2 f9 17 9a 01 00    vptest xmm3,XMMWORD PTR [rdx+0x1]
    3d:   00 00 =

  */
    char buf[] =3D {
      0x2E, 0x45, 0x71, 0xFF, 0xE9, 0x00, 0x00, 0xF0, 0x00, 0xC4, 0x42, 0x7=
D, 0x31, 0x3E, 0xC4, 0xA3, 0x7D, 0x08, 0x64, 0x82, 0x44, 0x00, 0x0F, 0x1E, =
0x0A, 0x43, 0x0F, 0xEC, 0x20, 0x66, 0x47, 0x0F, 0x3A, 0x0C, 0x3D, 0x00, 0x8=
0, 0x00, 0x00, 0x00, 0xC4, 0xE3, 0xF9, 0xDF, 0x5F, 0x86, 0x0D, 0xC4, 0xE2, =
0x55, 0x92, 0x74, 0xFC, 0x0A, 0xC4, 0xE2, 0xF9, 0x17, 0x9A, 0x01, 0x00, 0x0=
0, 0x00
    };
    void (*f)(void) =3D (void (*) (void))buf;
    f();
    return 0;
  }
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  Steps to reproduce:
  1) clang -static repro.c -o repro
  2) qemu-x86_64-static repro

  Tested with 4.2.0 and 5.0.0-rc4. Both -user and -system variants are
  affected.

  A few more snippets that cause the same sort of behavior:
  1) 0x64, 0x46, 0x7D, 0xFF, 0xDF, 0x27, 0x46, 0x0F, 0xD4, 0x83, 0x5E, 0x00=
, 0x00, 0x00, 0x3E, 0x0F, 0x6A, 0xEF, 0x0F, 0x05, 0xC4, 0x42, 0xFD, 0x1E, 0=
xCF, 0x46, 0x18, 0xE3, 0x47, 0xCD, 0x4E, 0x6E, 0x0F, 0x0F, 0x16, 0x8A

  2) 0x67, 0x45, 0xDB, 0xD0, 0xAA, 0xC4, 0xE2, 0xB1, 0x01, 0x57, 0x00,
  0xF3, 0x6F, 0xF3, 0x42, 0x0F, 0x1E, 0xFD, 0x64, 0x2E, 0xF2, 0x45,
  0xD9, 0xC4, 0x3E, 0xF3, 0x0F, 0xAE, 0xF4, 0x3E, 0x47, 0x0F, 0x1C,
  0x22, 0x42, 0x73, 0xFF, 0xD9, 0xFD

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1874888/+subscriptions

