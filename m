Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B61CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B342070A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 23:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B342070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbYG2-0002Eb-0R
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 19:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jbYFH-00018F-QD
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:35:31 -0400
Received: from indium.canonical.com ([91.189.90.7]:57796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jbYFG-0005fV-AW
 for qemu-devel@nongnu.org; Wed, 20 May 2020 19:35:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jbYFE-0007Kx-5Q
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 23:35:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 20CC62E802D
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 23:35:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2020 23:28:43 -0000
From: Heiko Sieger <1856335@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: babumoger djdatte h-sieger janklos
X-Launchpad-Bug-Reporter: Damir (djdatte)
X-Launchpad-Bug-Modifier: Heiko Sieger (h-sieger)
References: <157625616239.22064.10423897892496347105.malonedeb@gac.canonical.com>
Message-Id: <159001732338.19840.6413596738980744971.malone@soybean.canonical.com>
Subject: [Bug 1856335] Re: Cache Layout wrong on many Zen Arch CPUs
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 079046ef53b245e410feb415b9974e39f6d8fd9a
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 17:55:46
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
Reply-To: Bug 1856335 <1856335@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the CPU cache layout as shown by lscpu -a -e

CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE    MAXMHZ    MINMHZ
  0    0      0    0 0:0:0:0          yes 3800.0000 2200.0000
  1    0      0    1 1:1:1:0          yes 3800.0000 2200.0000
  2    0      0    2 2:2:2:0          yes 3800.0000 2200.0000
  3    0      0    3 3:3:3:1          yes 3800.0000 2200.0000
  4    0      0    4 4:4:4:1          yes 3800.0000 2200.0000
  5    0      0    5 5:5:5:1          yes 3800.0000 2200.0000
  6    0      0    6 6:6:6:2          yes 3800.0000 2200.0000
  7    0      0    7 7:7:7:2          yes 3800.0000 2200.0000
  8    0      0    8 8:8:8:2          yes 3800.0000 2200.0000
  9    0      0    9 9:9:9:3          yes 3800.0000 2200.0000
 10    0      0   10 10:10:10:3       yes 3800.0000 2200.0000
 11    0      0   11 11:11:11:3       yes 3800.0000 2200.0000
 12    0      0    0 0:0:0:0          yes 3800.0000 2200.0000
 13    0      0    1 1:1:1:0          yes 3800.0000 2200.0000
 14    0      0    2 2:2:2:0          yes 3800.0000 2200.0000
 15    0      0    3 3:3:3:1          yes 3800.0000 2200.0000
 16    0      0    4 4:4:4:1          yes 3800.0000 2200.0000
 17    0      0    5 5:5:5:1          yes 3800.0000 2200.0000
 18    0      0    6 6:6:6:2          yes 3800.0000 2200.0000
 19    0      0    7 7:7:7:2          yes 3800.0000 2200.0000
 20    0      0    8 8:8:8:2          yes 3800.0000 2200.0000
 21    0      0    9 9:9:9:3          yes 3800.0000 2200.0000
 22    0      0   10 10:10:10:3       yes 3800.0000 2200.0000
 23    0      0   11 11:11:11:3       yes 3800.0000 2200.0000

I was trying to allocate cache using the cachetune feature in libvirt,
but it turns out to be either misleading or much too complicated to be
usable. Here is what I tried:

  <vcpu placement=3D"static">24</vcpu>
  <cputune>
    <vcpupin vcpu=3D"0" cpuset=3D"0"/>
    <vcpupin vcpu=3D"1" cpuset=3D"12"/>
    <vcpupin vcpu=3D"2" cpuset=3D"1"/>
    <vcpupin vcpu=3D"3" cpuset=3D"13"/>
    <vcpupin vcpu=3D"4" cpuset=3D"2"/>
    <vcpupin vcpu=3D"5" cpuset=3D"14"/>
    <vcpupin vcpu=3D"6" cpuset=3D"3"/>
    <vcpupin vcpu=3D"7" cpuset=3D"15"/>
    <vcpupin vcpu=3D"8" cpuset=3D"4"/>
    <vcpupin vcpu=3D"9" cpuset=3D"16"/>
    <vcpupin vcpu=3D"10" cpuset=3D"5"/>
    <vcpupin vcpu=3D"11" cpuset=3D"17"/>
    <vcpupin vcpu=3D"12" cpuset=3D"6"/>
    <vcpupin vcpu=3D"13" cpuset=3D"18"/>
    <vcpupin vcpu=3D"14" cpuset=3D"7"/>
    <vcpupin vcpu=3D"15" cpuset=3D"19"/>
    <vcpupin vcpu=3D"16" cpuset=3D"8"/>
    <vcpupin vcpu=3D"17" cpuset=3D"20"/>
    <vcpupin vcpu=3D"18" cpuset=3D"9"/>
    <vcpupin vcpu=3D"19" cpuset=3D"21"/>
    <vcpupin vcpu=3D"20" cpuset=3D"10"/>
    <vcpupin vcpu=3D"21" cpuset=3D"22"/>
    <vcpupin vcpu=3D"22" cpuset=3D"11"/>
    <vcpupin vcpu=3D"23" cpuset=3D"23"/>
    <cachetune vcpus=3D"0-2,12-14">
      <cache id=3D"0" level=3D"3" type=3D"both" size=3D"16" unit=3D"MiB"/>
      <monitor level=3D"3" vcpus=3D"0-2,12-14"/>
    </cachetune>
    <cachetune vcpus=3D"3-5,15-17">
      <cache id=3D"1" level=3D"3" type=3D"both" size=3D"16" unit=3D"MiB"/>
      <monitor level=3D"3" vcpus=3D"3-5,15-17"/>
    </cachetune>
    <cachetune vcpus=3D"6-8,18-20">
      <cache id=3D"2" level=3D"3" type=3D"both" size=3D"16" unit=3D"MiB"/>
      <monitor level=3D"3" vcpus=3D"6-8,18-20"/>
    </cachetune>
    <cachetune vcpus=3D"9-11,21-23">
      <cache id=3D"3" level=3D"3" type=3D"both" size=3D"16" unit=3D"MiB"/>
      <monitor level=3D"3" vcpus=3D"9-11,21-23"/>
    </cachetune>
  </cputune>

Unfortunately it gives the following error when I try to start the VM:

Error starting domain: internal error: Missing or inconsistent resctrl
info for memory bandwidth allocation

I have resctrl mounted like this:

mount -t resctrl resctrl /sys/fs/resctrl

This error leads to the following description on how to allocate memory
bandwith: https://software.intel.com/content/www/us/en/develop/articles
/use-intel-resource-director-technology-to-allocate-memory-
bandwidth.html

I think this is over the top and perhaps I'm trying the wrong approach.
All I can say is that every suggestion I've seen and tried so far has
led me to one conclusion: QEMU does NOT support the L3 cache layout of
the new ZEN 2 arch CPUs such as the Ryzen 9 3900X.

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

