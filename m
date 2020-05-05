Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00837C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CF2207DD
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 15:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CF2207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andreas-weller.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVzUX-0002T1-RI
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 11:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jVzE9-0007dn-J0
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:11:21 -0400
Received: from indium.canonical.com ([91.189.90.7]:53844)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jVzE7-0005E3-V8
 for qemu-devel@nongnu.org; Tue, 05 May 2020 11:11:21 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jVzE3-0003ja-26
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 15:11:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 59B3D2E8136
 for <qemu-devel@nongnu.org>; Tue,  5 May 2020 15:11:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2020 14:58:46 -0000
From: Andreas Weller <weller@andreas-weller.de>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Invalid; importance=Undecided; assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=seabios; component=main;
 status=Fix Released; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ahasenack dbaxps0220 dgilbert-h janitor paelzer
 tstrike34 weller-andreas-weller
X-Launchpad-Bug-Reporter: tstrike (tstrike34)
X-Launchpad-Bug-Modifier: Andreas Weller (weller-andreas-weller)
References: <158386023038.12575.5865810528923078550.malonedeb@soybean.canonical.com>
Message-Id: <158869072702.5304.17840768967181155510.malone@soybean.canonical.com>
Subject: [Bug 1866870] Re: KVM Guest pauses after upgrade to Ubuntu 20.04
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a24693a1f0eb9db59b147dd88800033e13a34e68
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 11:11:17
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 05 May 2020 11:27:41 -0400
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
Reply-To: Bug 1866870 <1866870@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello!
Unfortunately the bug has apparently reappeared. I have a Windows 10 runnin=
g in a VM, which after my today's "apt upgrade" goes into pause mode after =
a few seconds of running time.

Tail output of my /var/log/libvirt/qemu/win10.log
char device redirected to /dev/pts/1 (label charserial0)
2020-05-05T08:53:23.733051Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(48FH).vmx-exit-load-perf-global-ctrl [bit 12]
2020-05-05T08:53:23.733122Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(490H).vmx-entry-load-perf-global-ctrl [bit 13]
2020-05-05T08:53:23.736093Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(48FH).vmx-exit-load-perf-global-ctrl [bit 12]
2020-05-05T08:53:23.736110Z qemu-system-x86_64: warning: host doesn't suppo=
rt requested feature: MSR(490H).vmx-entry-load-perf-global-ctrl [bit 13]
2020-05-05T08:54:04.912098Z qemu-system-x86_64: terminating on signal 15 fr=
om pid 1593 (/usr/sbin/libvirtd)
2020-05-05 08:54:05.112+0000: shutting down, reason=3Ddestroyed


Apt upgraded packages (from /var/log/apt/history.log):
Start-Date: 2020-05-05  09:32:02
Commandline: apt upgrade
Requested-By: andreas (1000)
Install: linux-image-5.4.0-29-generic:amd64 (5.4.0-29.33, automatic), linux=
-modules-extra-5.4.0-29-generic:amd64 (5.4.0-29.33, automatic), linux-heade=
rs-5.4.0-29-generic:amd64 (5.4.0-29.33, automatic), linux-modules-5.4.0-29-=
generic:amd64 (5.4.0-29.33, automatic), linux-headers-5.4.0-29:amd64 (5.4.0=
-29.33, automatic)
Upgrade: linux-headers-generic:amd64 (5.4.0.28.33, 5.4.0.29.34), linux-libc=
-dev:amd64 (5.4.0-28.32, 5.4.0-29.33), linux-image-generic:amd64 (5.4.0.28.=
33, 5.4.0.29.34), linux-generic:amd64 (5.4.0.28.33, 5.4.0.29.34)
End-Date: 2020-05-05  09:33:11


Kind regards,
   Andreas

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1866870

Title:
  KVM Guest pauses after upgrade to Ubuntu 20.04

Status in QEMU:
  Invalid
Status in qemu package in Ubuntu:
  Invalid
Status in seabios package in Ubuntu:
  Fix Released

Bug description:
  Symptom:
  Error unpausing domain: internal error: unable to execute QEMU command 'c=
ont': Resetting the Virtual Machine is required

  Traceback (most recent call last):
    File "/usr/share/virt-manager/virtManager/asyncjob.py", line 75, in cb_=
wrapper
      callback(asyncjob, *args, **kwargs)
    File "/usr/share/virt-manager/virtManager/asyncjob.py", line 111, in tm=
pcb
      callback(*args, **kwargs)
    File "/usr/share/virt-manager/virtManager/object/libvirtobject.py", lin=
e 66, in newfn
      ret =3D fn(self, *args, **kwargs)
    File "/usr/share/virt-manager/virtManager/object/domain.py", line 1311,=
 in resume
      self._backend.resume()
    File "/usr/lib/python3/dist-packages/libvirt.py", line 2174, in resume
      if ret =3D=3D -1: raise libvirtError ('virDomainResume() failed', dom=
=3Dself)
  libvirt.libvirtError: internal error: unable to execute QEMU command 'con=
t': Resetting the Virtual Machine is required

  =

  ---

  As outlined here:
  https://bugs.launchpad.net/qemu/+bug/1813165/comments/15

  After upgrade, all KVM guests are in a default pause state. Even after
  forcing them off via virsh, and restarting them the guests are paused.

  These Guests are not nested.

  A lot of diganostic information are outlined in the previous bug
  report link provided. The solution mentioned in previous report had
  been allegedly integrated into the downstream updates.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1866870/+subscriptions

