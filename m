Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB83C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 22:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BDC2083B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 22:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BDC2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm2qG-0000KE-U1
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 18:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jm2ox-0008Iu-6s
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 18:15:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:44606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jm2ou-0005XT-V5
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 18:15:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jm2or-0004PC-Ty
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 22:15:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DF59D2E80BA
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 22:15:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2020 22:08:40 -0000
From: Ronald Antony <1884095@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: emulation incomplete tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell rcfa
X-Launchpad-Bug-Reporter: Ronald Antony (rcfa)
X-Launchpad-Bug-Modifier: Ronald Antony (rcfa)
References: <159249543912.17037.1746740929144966356.malonedeb@chaenomeles.canonical.com>
Message-Id: <159251812080.6566.12393646335844106563.malone@soybean.canonical.com>
Subject: [Bug 1884095] Re: QEMU not sufficiently focused on qEMUlation,
 with resulting holes in TCG emulation coverage
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: eff608bb47017a1d3b8b6b7b985d0e4d2867c498
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 18:15:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1884095 <1884095@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The comments with the other reports were just in support of getting them
fixed, and providing a reason as to why that matters. Someone looking at
those reports may not read this one, and as the issues are symptoms of
the same larger issue, this report was filed as an overarching report,
as AVX is just one aspect. Depending on the CPU model picked, an entire
slew of error messages are generated.

Fact is, an emulator that claims it emulates a CPU has a bug, if that
CPU cannot be properly emulated. Hence this report.

For the emulator not to have to be considered buggy, =

EITHER =

the CPU type has to be delisted as supported =

OR
the missing instructions must be implemented.

But it=E2=80=99s not proper to say QEMU can emulate an x86_64 Penryn system,
when trying to do so fails miserably because of instructions
unimplemented in TGC.

At the very least the documentation and online help would have to
distinguish between KVM-only CPU types and TGC CPU types.

Downloading and compiling QEMU 5 sources and compiling them on an ARM64
platform results in

qemu-system-x86_64 -cpu help

listing all sorts of CPUs as =E2=80=9Eavailable=E2=80=9C even though these =
have
significant gaps in the covered instruction set. If that=E2=80=99s not a bu=
g, I
don=E2=80=99t know.

How you go about fixing it, is a different matter. You could remove the CPU=
s, mark them as incompletely implemented, or add support for the missing fe=
atures.
Maybe it might even be possible to interest intel to contribute code from t=
heir SDE project to TCG

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1884095

Title:
  QEMU not sufficiently focused on qEMUlation, with resulting holes in
  TCG emulation coverage

Status in QEMU:
  Invalid

Bug description:
  It seems that QEMU has stopped emphasizing the EMU part of the name,
  and is too much focused on virtualization.

  My interest is at running legacy operating systems, and as such, they mus=
t run on foreign CPU platforms. m68 on intel, intel on ARM, etc.
  Time doesn't stand still, and reliance on KVM and similar x86-on-x86 tric=
ks, which allow the delegation of certain CPU features to the host CPU is g=
oing to not work going forward.

  If the rumored transition of Apple to ARM is going to take place,
  people will want to e.g. emulate for testing or legacy purposes a
  variety of operating systems, incl. NeXTSTEP, Windows, earlier
  versions of MacOS on ARM Macs.

  Testing that scenario, i.e. macOS on an ARM board with the lowest
  possible CPU capable of running modern macOS, results in these
  problems (and of course utter failure achieving the goal):

  qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID=
.01H:ECX.fma [bit 12]
  qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID=
.01H:ECX.avx [bit 28]
  qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID=
.07H:EBX.avx2 [bit 5]
  qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID=
.80000007H:EDX.invtsc [bit 8]
  qemu-system-x86_64: warning: TCG doesn't support requested feature: CPUID=
.0DH:EAX.xsavec [bit 1]

  And this is emulating a lowly Penryn CPU with the required CPU flags for =
macOS:
  -cpu Penryn,vendor=3DGenuineIntel,+sse3,+sse4.2,+aes,+xsave,+avx,+xsaveop=
t,+xsavec,+xgetbv1,+avx2,+bmi2,+smep,+bmi1,+fma,+movbe,+invtsc

  Attempting to emulate a more feature laden intel CPU results in even
  more issues.

  I would propose that no CPU should be considered supported unless it
  can be fully handled by TCG on a non-native host. KVM, native-on-
  native etc. are nice to have, but peripheral to qEMUlation when it
  boils down to it. At the very least, there should be a CLEAR
  distinction which CPUs require KVM to be used, and which can be fully
  emulated. It should not require wasting an afternoon to figure out
  that an emulation attempt is futile because TCG lacks essential
  functionality.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1884095/+subscriptions

