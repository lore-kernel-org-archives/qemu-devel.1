Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8C9C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FFC20657
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FFC20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfTRt-0001r6-VS
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 15:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jfTQp-0000x8-HV
 for qemu-devel@nongnu.org; Sun, 31 May 2020 15:15:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:59636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jfTQo-00009C-7J
 for qemu-devel@nongnu.org; Sun, 31 May 2020 15:15:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jfTQl-000586-Ng
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 19:15:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AF49B2E8033
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 19:15:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2020 19:08:15 -0000
From: Ethin Probst <1881506@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: harlydavidsen
X-Launchpad-Bug-Reporter: Ethin Probst (harlydavidsen)
X-Launchpad-Bug-Modifier: Ethin Probst (harlydavidsen)
Message-Id: <159095209581.29684.17955799234221982572.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1881506] [NEW] TCG doesn't support a lot of features that should
 be supported
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="275d46a24253e557e4403d52832837e4bfa425b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b8bee8ec780bed5d4a58cc0af581802e00e7234c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 14:59:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1881506 <1881506@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

This is quite odd, and I'm not sure about how to get around it. I'm writing=
 an OS in Rust and require APIC support. When I boot my kernel with qemu-sy=
stem-x86_64, however, it dumps out a [lot] of warnings; it claims that TCG =
doesn't support FMA, X2APIC, AVX, F16C, AVX2, RDSEED, SHA-NI, FXSR-OPT, mis=
alignsse, 3dnowprefetch, osvw, topoext, perfctr-core, clzero, xsaveerptr, i=
bpb, nrip-save, xsavec, and xsaves, but prints these warnings over 80 times=
 before finally doing what I told it to do. Running QEMU 5.0.0 (unknown com=
mit hash), as follows:
qemu-system-x86_64 -drive format=3Draw,file=3Dtarget\x86_64-kernel-none\deb=
ug\bootimage-kernel.bin -serial stdio -no-reboot -hdb disk.img -s -m 4G -us=
b -rtc base=3Dutc,clock=3Dhost -cpu EPYC-v3,+acpi,+apic,+rdrand,+rdseed,+ss=
e,+sse2,+sse4.1,+sse4.2,+sse4a,+ssse3,+syscall,+x2apic -smp cpus=3D8 -sound=
hw all
I would run using HAXM, but my kernel requires RDRAND, and QEMU does not, t=
o my knowledge, automatically support RDRAND (and I don't know how to enabl=
e it).

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1881506

Title:
  TCG doesn't support a lot of features that should be supported

Status in QEMU:
  New

Bug description:
  This is quite odd, and I'm not sure about how to get around it. I'm writi=
ng an OS in Rust and require APIC support. When I boot my kernel with qemu-=
system-x86_64, however, it dumps out a [lot] of warnings; it claims that TC=
G doesn't support FMA, X2APIC, AVX, F16C, AVX2, RDSEED, SHA-NI, FXSR-OPT, m=
isalignsse, 3dnowprefetch, osvw, topoext, perfctr-core, clzero, xsaveerptr,=
 ibpb, nrip-save, xsavec, and xsaves, but prints these warnings over 80 tim=
es before finally doing what I told it to do. Running QEMU 5.0.0 (unknown c=
ommit hash), as follows:
  qemu-system-x86_64 -drive format=3Draw,file=3Dtarget\x86_64-kernel-none\d=
ebug\bootimage-kernel.bin -serial stdio -no-reboot -hdb disk.img -s -m 4G -=
usb -rtc base=3Dutc,clock=3Dhost -cpu EPYC-v3,+acpi,+apic,+rdrand,+rdseed,+=
sse,+sse2,+sse4.1,+sse4.2,+sse4a,+ssse3,+syscall,+x2apic -smp cpus=3D8 -sou=
ndhw all
  I would run using HAXM, but my kernel requires RDRAND, and QEMU does not,=
 to my knowledge, automatically support RDRAND (and I don't know how to ena=
ble it).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1881506/+subscriptions

