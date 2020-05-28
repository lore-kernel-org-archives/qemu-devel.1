Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9A7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358ED21548
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358ED21548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeHIf-0001na-EA
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 08:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jeHI5-0001KV-8B
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:05:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:55258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jeHI4-0005U5-0d
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:05:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jeHI1-00055w-Su
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 12:05:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D2F112E8105
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 12:05:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2020 11:58:25 -0000
From: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF?= <1877052@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Incomplete; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Tags: qemu-20.10
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: paelzer weller-andreas-weller
X-Launchpad-Bug-Reporter: Andreas Weller (weller-andreas-weller)
X-Launchpad-Bug-Modifier: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer?=
 =?utf-8?q?=29?=
References: <158875190128.5304.17617014708809905297.malonedeb@soybean.canonical.com>
Message-Id: <159066710517.13516.998216433280668112.malone@soybean.canonical.com>
Subject: [Bug 1877052] Re: KVM Win 10 guest pauses after kernel upgrade
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="275d46a24253e557e4403d52832837e4bfa425b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: dd89e901be88a4ac5b74d7dac748456f7cedbbf5
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 08:05:38
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
Reply-To: Bug 1877052 <1877052@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The warnings in the report like "MSR(48FH).vmx-exit-load-perf-global-ctrl" =
are unrelated (in regard to guest hang).
Those happen on
a) too old kernels that don't support the feature
b) mismatch of expectations of a chips vs its actual capabilities
E.g. if libvirt thinks a feature should be supported by a chip, but isn't.
There are toomany SKUs out there to be perfect - so these are red-herrings =
at best.

I have not seen similar reports recently nor anyone else chiming in on this=
 one.
After loosing what e thought could be a track to the bgu I'm puzzled what t=
o do now on this?

@Andreas - did you in the meantime find any new insight on this?

** Changed in: qemu (Ubuntu)
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1877052

Title:
  KVM Win 10 guest pauses after kernel upgrade

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  Incomplete

Bug description:
  Hello!
  Unfortunately the bug has apparently reappeared. I have a Windows 10 runn=
ing in a VM, which after my today's "apt upgrade" goes into pause mode afte=
r a few seconds of running time.

  Until yesterday it used to work and I was able to boot the VM. During
  the kernel update (from 5.4.0-28.33 to 5.4.0-29.34) the VM was active
  and then went into pause mode. Even after a reboot of my host system
  the problem still persists: the VM boots for a few seconds and then
  switches to pause mode.

  Current Kernel: Linux andreas-laptop 5.4.0-29-generic #33-Ubuntu SMP
  Wed Apr 29 14:32:27 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

  Maybe relevant logfile lines:
  2020-05-06T07:46:42.857574Z qemu-system-x86_64: warning: host doesn't sup=
port requested feature: MSR(48FH).vmx-exit-load-perf-global-ctrl [bit 12]
  2020-05-06T07:46:42.857718Z qemu-system-x86_64: warning: host doesn't sup=
port requested feature: MSR(490H).vmx-entry-load-perf-global-ctrl [bit 13]
  2020-05-06T07:46:42.860567Z qemu-system-x86_64: warning: host doesn't sup=
port requested feature: MSR(48FH).vmx-exit-load-perf-global-ctrl [bit 12]
  2020-05-06T07:46:42.860582Z qemu-system-x86_64: warning: host doesn't sup=
port requested feature: MSR(490H).vmx-entry-load-perf-global-ctrl [bit 13]
  2020-05-06T07:47:22.901057Z qemu-system-x86_64: terminating on signal 15 =
from pid 1593 (/usr/sbin/libvirtd)
  2020-05-06 07:47:23.101+0000: shutting down, reason=3Ddestroyed


  Kind regards,
  =C2=A0=C2=A0=C2=A0Andreas

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1877052/+subscriptions

