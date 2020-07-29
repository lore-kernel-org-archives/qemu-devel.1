Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2C3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 02:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A7EC2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 02:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7EC2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0bsV-0005wI-Oe
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 22:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0brn-0005Mu-Sy
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 22:30:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:56788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0brl-0006eq-C7
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 22:30:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k0brj-0000xg-5k
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 02:30:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2A5A92E80D2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 02:30:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2020 02:23:39 -0000
From: Heiko Sieger <1856335@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: babumoger djdatte h-sieger janklos sanjaybmd
X-Launchpad-Bug-Reporter: Damir (djdatte)
X-Launchpad-Bug-Modifier: Heiko Sieger (h-sieger)
References: <157625616239.22064.10423897892496347105.malonedeb@gac.canonical.com>
Message-Id: <159598941967.4737.7676730076336265460.malone@soybean.canonical.com>
Subject: [Bug 1856335] Re: Cache Layout wrong on many Zen Arch CPUs
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 08872598b18dba3036718d0d745c2e2c7690d062
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 22:30:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Sanjay,

You can just increase the number of vcpus, such as:

<vcpu placement=3D"static" current=3D"48">64</vcpu>

then continue to define the vcpus:

    <vcpu id=3D"32" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"33" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"34" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"35" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"36" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"37" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"38" enabled=3D"no" hotpluggable=3D"yes"/>
    <vcpu id=3D"39" enabled=3D"no" hotpluggable=3D"yes"/>
    <vcpu id=3D"40" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"41" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"42" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"43" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"44" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"45" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"46" enabled=3D"no" hotpluggable=3D"yes"/>
    <vcpu id=3D"47" enabled=3D"no" hotpluggable=3D"yes"/>
    <vcpu id=3D"48" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"49" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"50" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"51" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"52" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"53" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"54" enabled=3D"no" hotpluggable=3D"yes"/>
    <vcpu id=3D"55" enabled=3D"no" hotpluggable=3D"yes"/>
    <vcpu id=3D"56" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"57" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"58" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"59" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"60" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"61" enabled=3D"yes" hotpluggable=3D"yes"/>
    <vcpu id=3D"62" enabled=3D"no" hotpluggable=3D"yes"/>
    <vcpu id=3D"63" enabled=3D"no" hotpluggable=3D"yes"/>

(6x enabled=3Dyes, then 2x enabled=3Dno.)

You will get more vcpu ids than you have threads, but since you disable
16 out of 64, you will have 48 active.

vcpupin should continue as follows:

    <vcpupin vcpu=3D"32" cpuset=3D"24"/>
    <vcpupin vcpu=3D"33" cpuset=3D"36"/>
    <vcpupin vcpu=3D"34" cpuset=3D"25"/>
    <vcpupin vcpu=3D"35" cpuset=3D"37"/>
    <vcpupin vcpu=3D"36" cpuset=3D"26"/>
    <vcpupin vcpu=3D"37" cpuset=3D"38"/>
    <vcpupin vcpu=3D"40" cpuset=3D"27"/>
    <vcpupin vcpu=3D"41" cpuset=3D"39"/>
    <vcpupin vcpu=3D"42" cpuset=3D"28"/>
    <vcpupin vcpu=3D"43" cpuset=3D"40"/>
    <vcpupin vcpu=3D"44" cpuset=3D"29"/>
    <vcpupin vcpu=3D"45" cpuset=3D"41"/>
    <vcpupin vcpu=3D"48" cpuset=3D"30"/>
    <vcpupin vcpu=3D"49" cpuset=3D"42"/>
    <vcpupin vcpu=3D"50" cpuset=3D"31"/>
    <vcpupin vcpu=3D"51" cpuset=3D"43"/>
    <vcpupin vcpu=3D"52" cpuset=3D"32"/>
    <vcpupin vcpu=3D"53" cpuset=3D"44"/>
    <vcpupin vcpu=3D"56" cpuset=3D"33"/>
    <vcpupin vcpu=3D"57" cpuset=3D"45"/>
    <vcpupin vcpu=3D"58" cpuset=3D"34"/>
    <vcpupin vcpu=3D"59" cpuset=3D"46"/>
    <vcpupin vcpu=3D"60" cpuset=3D"35"/>
    <vcpupin vcpu=3D"61" cpuset=3D"47"/>

This is if you pin all vcpus to the VM, which may not be the best thing
to do. The maximum number of vcpus you can pin on a Threadripper 3960X
are 48.

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

