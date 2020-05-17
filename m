Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D623AC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 11:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4D420758
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 11:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4D420758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaHWe-0001QD-UE
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 07:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jaHVR-0000a8-5H
 for qemu-devel@nongnu.org; Sun, 17 May 2020 07:30:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:55932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jaHVQ-0008Nj-8r
 for qemu-devel@nongnu.org; Sun, 17 May 2020 07:30:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jaHVN-0005wX-JW
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 11:30:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 59D452E810E
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 11:30:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2020 11:25:41 -0000
From: Jan Klos <1856335@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: babumoger djdatte h-sieger janklos
X-Launchpad-Bug-Reporter: Damir (djdatte)
X-Launchpad-Bug-Modifier: Jan Klos (janklos)
References: <157625616239.22064.10423897892496347105.malonedeb@gac.canonical.com>
Message-Id: <158971474131.23185.9265338361868580750.malone@gac.canonical.com>
Subject: [Bug 1856335] Re: Cache Layout wrong on many Zen Arch CPUs
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0385b538081bc4718df6fb844a3afc89729c94ce";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ba494315dafa97c3f59bcd169ff8e7b9df3a7756
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 06:50:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1856335 <1856335@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Damir:
Hm, must be some misconfiguration, then. My config for Linux VMs to utilize=
 3 out of the 4 CCXs. Important parts of the libvirt domain XML:

  <vcpu placement=3D"static">24</vcpu>
  <iothreads>1</iothreads>
  <cputune>
    <vcpupin vcpu=3D"0" cpuset=3D"3"/>
    <vcpupin vcpu=3D"1" cpuset=3D"15"/>
    <vcpupin vcpu=3D"2" cpuset=3D"4"/>
    <vcpupin vcpu=3D"3" cpuset=3D"16"/>
    <vcpupin vcpu=3D"4" cpuset=3D"5"/>
    <vcpupin vcpu=3D"5" cpuset=3D"17"/>
    <vcpupin vcpu=3D"6" cpuset=3D"0,12"/>
    <vcpupin vcpu=3D"7" cpuset=3D"0,12"/>
    <vcpupin vcpu=3D"8" cpuset=3D"6"/>
    <vcpupin vcpu=3D"9" cpuset=3D"18"/>
    <vcpupin vcpu=3D"10" cpuset=3D"7"/>
    <vcpupin vcpu=3D"11" cpuset=3D"19"/>
    <vcpupin vcpu=3D"12" cpuset=3D"8"/>
    <vcpupin vcpu=3D"13" cpuset=3D"20"/>
    <vcpupin vcpu=3D"14" cpuset=3D"0,12"/>
    <vcpupin vcpu=3D"15" cpuset=3D"0,12"/>
    <vcpupin vcpu=3D"16" cpuset=3D"9"/>
    <vcpupin vcpu=3D"17" cpuset=3D"21"/>
    <vcpupin vcpu=3D"18" cpuset=3D"10"/>
    <vcpupin vcpu=3D"19" cpuset=3D"22"/>
    <vcpupin vcpu=3D"20" cpuset=3D"11"/>
    <vcpupin vcpu=3D"21" cpuset=3D"23"/>
    <vcpupin vcpu=3D"22" cpuset=3D"0,12"/>
    <vcpupin vcpu=3D"23" cpuset=3D"0,12"/>
    <emulatorpin cpuset=3D"1,13"/>
    <iothreadpin iothread=3D"1" cpuset=3D"2,14"/>
  </cputune>
  <os>
    <type arch=3D"x86_64" machine=3D"pc-q35-5.0">hvm</type>
    <loader readonly=3D"yes" type=3D"pflash">/usr/share/ovmf/x64/OVMF_CODE.=
fd</loader>
    <nvram>/var/lib/libvirt/qemu/nvram/ccxtest-clone_VARS.fd</nvram>
  </os>
.
.
.
  <qemu:commandline>
    <qemu:arg value=3D"-cpu"/>
    <qemu:arg value=3D"host,topoext=3Don,hv-time,hv-relaxed,hv-vapic,hv-spi=
nlocks=3D0x1fff,host-cache-info=3Don,-amd-stibp"/>
  </qemu:commandline>

The CPUs with cpuset=3D"0,12" are disabled once booted. The host-cache-
info=3Don is the part that makes sure that the cache config is passed to
the VM (but unfortunately does not take disabled cores into account,
which results in incorrect config). The qemu:commandline is added
because I need to add -amd-stibp, otherwise I wouldn't be able to boot.
This overrides most parts in the <cpu> XML part.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1856335

Title:
  Cache Layout wrong on many Zen Arch CPUs

Status in QEMU:
  New

Bug description:
  AMD CPUs have L3 cache per 2, 3 or 4 cores. Currently, TOPOEXT seems
  to always map Cache ass if it was an 4-Core per CCX CPU, which is
  incorrect, and costs upwards 30% performance (more realistically 10%)
  in L3 Cache Layout aware applications.

  Example on a 4-CCX CPU (1950X /w 8 Cores and no SMT):

  =C2=A0=C2=A0<cpu mode=3D'custom' match=3D'exact' check=3D'full'>
  =C2=A0=C2=A0=C2=A0=C2=A0<model fallback=3D'forbid'>EPYC-IBPB</model>
  =C2=A0=C2=A0=C2=A0=C2=A0<vendor>AMD</vendor>
  =C2=A0=C2=A0=C2=A0=C2=A0<topology sockets=3D'1' cores=3D'8' threads=3D'1'=
/>

  In windows, coreinfo reports correctly:

  ****----  Unified Cache 1, Level 3,    8 MB, Assoc  16, LineSize  64
  ----****  Unified Cache 6, Level 3,    8 MB, Assoc  16, LineSize  64

  On a 3-CCX CPU (3960X /w 6 cores and no SMT):

  =C2=A0<cpu mode=3D'custom' match=3D'exact' check=3D'full'>
  =C2=A0=C2=A0=C2=A0=C2=A0<model fallback=3D'forbid'>EPYC-IBPB</model>
  =C2=A0=C2=A0=C2=A0=C2=A0<vendor>AMD</vendor>
  =C2=A0=C2=A0=C2=A0=C2=A0<topology sockets=3D'1' cores=3D'6' threads=3D'1'=
/>

  in windows, coreinfo reports incorrectly:

  ****--  Unified Cache  1, Level 3,    8 MB, Assoc  16, LineSize  64
  ----**  Unified Cache  6, Level 3,    8 MB, Assoc  16, LineSize  64

  Validated against 3.0, 3.1, 4.1 and 4.2 versions of qemu-kvm.

  With newer Qemu there is a fix (that does behave correctly) in using the =
dies parameter:
  =C2=A0<qemu:arg value=3D'cores=3D3,threads=3D1,dies=3D2,sockets=3D1'/>

  The problem is that the dies are exposed differently than how AMD does
  it natively, they are exposed to Windows as sockets, which means, that
  if you are nto a business user, you can't ever have a machine with
  more than two CCX (6 cores) as consumer versions of Windows only
  supports two sockets. (Should this be reported as a separate bug?)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1856335/+subscriptions

