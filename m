Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2929CC2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 01:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F194D20644
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 01:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F194D20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLdAB-0001DG-5O
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 21:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jLd9N-0000HC-8o
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 21:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jLd9J-0007t8-OW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 21:35:37 -0400
Received: from indium.canonical.com ([91.189.90.7]:34538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jLd9J-0007sk-Ir
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 21:35:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jLd9I-0003WN-1R
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 01:35:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D69402E810F
 for <qemu-devel@nongnu.org>; Tue,  7 Apr 2020 01:35:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Apr 2020 01:29:50 -0000
From: Michael Lee <1871270@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: michaellee8
X-Launchpad-Bug-Reporter: Michael Lee (michaellee8)
X-Launchpad-Bug-Modifier: Michael Lee (michaellee8)
Message-Id: <158622299039.23234.8027719061228410112.malonedeb@wampee.canonical.com>
Subject: [Bug 1871270] [NEW] [Feature Request] add usbredir device reset
 blacklist options support to allow macOS guest to iOS device usbredir
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a296f04231dee355be5db73cc878b9e21689a253";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: afbbea48f0ef926d68baba81dd45e21c62c9fa41
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Bug 1871270 <1871270@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Description of problem:
Currently, when a iOS device is redirected to a macOS VM, it falls into a r=
eset-not-found loop.
Version-Release number of selected component (if applicable):
latest
How reproducible:
100%
Steps to Reproduce:


Connect an iOS device to Ubuntu 18.04.2 LTS (I believe it is the same for a=
ny distro.)


Connect virt-manager/virt-viewer to a macOS VM through SPICE (I am using OS=
X 10.15 Catalina)


Attempt to redirect the iOS device (iPad in my case) to the VM through usb =
redirection.


Actual results:
For any odd number of attempt, the guest macOS will send a reset to the iOS=
 device which causes the host to reset the USB connection in the host side.=
 In the UI, it will be displayed as a successful connection for a few secon=
ds before it disconnects. After this, the iOS device will reconnect itself,=
 but via a different device name /dev/bus/usb/x/y+1.
For any even number of attempt, when I select the iOS device in the virt-ma=
nager/virt-viewer UI, the connection will not success and instead a LIBUSB_=
ERROR_NOT_FOUND error will be provided. Then the UI will reload and get the=
 new device name of the iOS device, falling into the behavior of the aforem=
entioned odd number of attempt.
Expected results:
The macOS detects the iOS device and connects to it happily.
Additional info:
It seems that this bug has been first identified as in https://bugs.freedes=
ktop.org/show_bug.cgi?id=3D100149, for a Samsung Android device, which the =
developers of SPICE applied a hotfix in https://gitlab.freedesktop.org/spic=
e/usbredir/-/blob/master/usbredirhost/usbredirhost.c#L147. However, there w=
ere no settings available for users to fix it.
A similar bug that also consists of a macOS guest/iOS device pair, but inst=
ead of being usbredir, is usb-host, has been identified and patched in http=
s://github.com/qemu/qemu/commit/ba4c735b4fc74e309ce4b2551d258e442ef513a5, w=
hich is further modified into https://github.com/qemu/qemu/blame/146aa0f104=
bb3bf88e43c4082a0bfc4bbda4fbd8/hw/usb/host-libusb.c#L1486. Following such p=
atch, I have attempted to apply such patch at host-side in https://github.c=
om/michaellee8/qemu/blob/master/hw/usb/redirect.c (not correctly formatted =
currently, pls ignore it atm), however I discovered that this is not enough=
 since it is also a SPICE issue, which resolves to virt-manager/virt-viewer.
This is probably a cross-project issue between qemu, spice (usbredir) and v=
irt-manager/virt-viewer, which would some effort to coordinate a solution. =
However a working solution for this problem would probably benefits a lot o=
f users whom relies on connecting a mobile device into a VM, for purposes l=
ike easier mobile development. Considering the report for the Samsung Andro=
id Device on a PC use case, such issue is probably cross-OS/cross-device.

cross-references:
- https://bugzilla.redhat.com/show_bug.cgi?id=3D1821518
- https://bugzilla.redhat.com/show_bug.cgi?id=3D1821517
- https://gitlab.freedesktop.org/spice/usbredir/-/issues/10

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1871270

Title:
  [Feature Request] add usbredir device reset blacklist options support
  to allow macOS guest to iOS device usbredir

Status in QEMU:
  New

Bug description:
  Description of problem:
  Currently, when a iOS device is redirected to a macOS VM, it falls into a=
 reset-not-found loop.
  Version-Release number of selected component (if applicable):
  latest
  How reproducible:
  100%
  Steps to Reproduce:

  =

  Connect an iOS device to Ubuntu 18.04.2 LTS (I believe it is the same for=
 any distro.)

  =

  Connect virt-manager/virt-viewer to a macOS VM through SPICE (I am using =
OSX 10.15 Catalina)

  =

  Attempt to redirect the iOS device (iPad in my case) to the VM through us=
b redirection.

  =

  Actual results:
  For any odd number of attempt, the guest macOS will send a reset to the i=
OS device which causes the host to reset the USB connection in the host sid=
e. In the UI, it will be displayed as a successful connection for a few sec=
onds before it disconnects. After this, the iOS device will reconnect itsel=
f, but via a different device name /dev/bus/usb/x/y+1.
  For any even number of attempt, when I select the iOS device in the virt-=
manager/virt-viewer UI, the connection will not success and instead a LIBUS=
B_ERROR_NOT_FOUND error will be provided. Then the UI will reload and get t=
he new device name of the iOS device, falling into the behavior of the afor=
ementioned odd number of attempt.
  Expected results:
  The macOS detects the iOS device and connects to it happily.
  Additional info:
  It seems that this bug has been first identified as in https://bugs.freed=
esktop.org/show_bug.cgi?id=3D100149, for a Samsung Android device, which th=
e developers of SPICE applied a hotfix in https://gitlab.freedesktop.org/sp=
ice/usbredir/-/blob/master/usbredirhost/usbredirhost.c#L147. However, there=
 were no settings available for users to fix it.
  A similar bug that also consists of a macOS guest/iOS device pair, but in=
stead of being usbredir, is usb-host, has been identified and patched in ht=
tps://github.com/qemu/qemu/commit/ba4c735b4fc74e309ce4b2551d258e442ef513a5,=
 which is further modified into https://github.com/qemu/qemu/blame/146aa0f1=
04bb3bf88e43c4082a0bfc4bbda4fbd8/hw/usb/host-libusb.c#L1486. Following such=
 patch, I have attempted to apply such patch at host-side in https://github=
.com/michaellee8/qemu/blob/master/hw/usb/redirect.c (not correctly formatte=
d currently, pls ignore it atm), however I discovered that this is not enou=
gh since it is also a SPICE issue, which resolves to virt-manager/virt-view=
er.
  This is probably a cross-project issue between qemu, spice (usbredir) and=
 virt-manager/virt-viewer, which would some effort to coordinate a solution=
. However a working solution for this problem would probably benefits a lot=
 of users whom relies on connecting a mobile device into a VM, for purposes=
 like easier mobile development. Considering the report for the Samsung And=
roid Device on a PC use case, such issue is probably cross-OS/cross-device.

  cross-references:
  - https://bugzilla.redhat.com/show_bug.cgi?id=3D1821518
  - https://bugzilla.redhat.com/show_bug.cgi?id=3D1821517
  - https://gitlab.freedesktop.org/spice/usbredir/-/issues/10

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1871270/+subscriptions

