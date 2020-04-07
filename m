Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC91EC2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E43206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLjlVWBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E43206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLk5b-0003zc-Nw
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ckmichael8@gmail.com>) id 1jLd9L-0000GL-Ia
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 21:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ckmichael8@gmail.com>) id 1jLd9K-0007uF-1X
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 21:35:35 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e]:41659)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ckmichael8@gmail.com>)
 id 1jLd9J-0007sw-Sc
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 21:35:33 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id a63so1177168vsa.8
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 18:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=GrV0p78i5gwYJ04UoF6aIMp/LpMBVDcYPtaSrKgUy/Q=;
 b=HLjlVWBEapiM6XslcdAW4qeL2HXqjxzJqMoTuLJDNknjfBfbicZuCQEb6rOYMPnPMS
 0TX7fXXYFf+tx6XB2vOZaNgRUy48s4Ni8b+yFwQMs5rMw9Lo8DnLk5YrWax3b/lUFC2t
 GlYdszjoNFjd1hISL6Nx1YeeJygrOh0pAdEFLGNK8pPZXeOTO+EgPNNO6YC2FuL/mhO8
 X2f9qpBHFEBxjdc63dYGT7Rifmha1GIyx3UIbjJdqjel/IMROMOmytYCCaHjaOHeGIz9
 L2j5AbhQ2fzNI5AicafSve7XOPkKtT5GiUMLQ01ZyKP5DiRMkjUhZWIixNxbeXCP4fbv
 fWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=GrV0p78i5gwYJ04UoF6aIMp/LpMBVDcYPtaSrKgUy/Q=;
 b=EMZT5cLSrNBbYeEiq+1LzbQA9MZvqQwW2hYZQ56nGdd8wOxLijQiapynHjRiKKms16
 as9O5/6HWmHjVfu+73tVq9X3G7afj0O0AwEeH5CDx+GuDELknep+qWMDC98qEHw9lqz8
 V12eV+C7yibMWNzaH155A57ROqSc3p6VBmRjrIXHpX628BVOhPlkKlAn7hEb+QlpzQtD
 GHgeapst+UZ1AsLh8vVqwT1GGCWAFTOCUglmNpO7oVW+DHPS0RhrcpxpQpTNoyReiV7T
 QBrIgQKVQZAtJExoo5QB7jAhVDeVybH+gJbR4Ob2a9adqz+M6l5rCF356nX9ge89v+xe
 3Z8Q==
X-Gm-Message-State: AGi0PuamafV/tMPjJiudw9nhyAJ298r6Y4B2cQFNdMFG0RP3Vug4wClF
 93f2/rsCkyVvy2EjCZ8W1LdPP+gbndskgPlFdGU=
X-Google-Smtp-Source: APiQypJ3LpECiH90wnJ60rxJHdMmbTdKt7eQbCu7Jvoc3o4tpeTFAlWdR4091Lwg64xTVNfcWDHpTyI1fpNy1KD2xoI=
X-Received: by 2002:a67:2c8b:: with SMTP id s133mr149202vss.6.1586223332582;
 Mon, 06 Apr 2020 18:35:32 -0700 (PDT)
MIME-Version: 1.0
From: Michael Lee <ckmichael8@gmail.com>
Date: Tue, 7 Apr 2020 09:35:21 +0800
Message-ID: <CAGNnKHAd21Z6L0LR6xj0cLVZ6WS7uNTYZDTvE2-BUhU+GvNiFA@mail.gmail.com>
Subject: RFE: add usbredir device reset blacklist options support to allow
 macOS guest to iOS device usbredir
To: kraxel@redhat.com
Content-Type: multipart/alternative; boundary="00000000000045ed3205a2a966aa"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e2e
X-Mailman-Approved-At: Tue, 07 Apr 2020 04:58:30 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000045ed3205a2a966aa
Content-Type: text/plain; charset="UTF-8"

Description of problem:
Currently, when a iOS device is redirected to a macOS VM, it falls into a
reset-not-found loop.
Version-Release number of selected component (if applicable):
latest
How reproducible:
100%
Steps to Reproduce:

   1. Connect an iOS device to Ubuntu 18.04.2 LTS (I believe it is the same
   for any distro.)
   2. Connect virt-manager/virt-viewer to a macOS VM through SPICE (I am
   using OSX 10.15 Catalina)
   3. Attempt to redirect the iOS device (iPad in my case) to the VM
   through usb redirection.



Actual results:
For any odd number of attempt, the guest macOS will send a reset to the iOS
device which causes the host to reset the USB connection in the host side.
In the UI, it will be displayed as a successful connection for a few
seconds before it disconnects. After this, the iOS device will reconnect
itself, but via a different device name /dev/bus/usb/x/y+1.
For any even number of attempt, when I select the iOS device in the
virt-manager/virt-viewer UI, the connection will not success and instead a
LIBUSB_ERROR_NOT_FOUND error will be provided. Then the UI will reload and
get the new device name of the iOS device, falling into the behavior of the
aforementioned odd number of attempt.
Expected results:
The macOS detects the iOS device and connects to it happily.
Additional info:
It seems that this bug has been first identified as in
https://bugs.freedesktop.org/show_bug.cgi?id=100149, for a Samsung Android
device, which the developers of SPICE applied a hotfix in
https://gitlab.freedesktop.org/spice/usbredir/-/blob/master/usbredirhost/usbredirhost.c#L147.
However, there were no settings available for users to fix it.
A similar bug that also consists of a macOS guest/iOS device pair, but
instead of being usbredir, is usb-host, has been identified and patched in
https://github.com/qemu/qemu/commit/ba4c735b4fc74e309ce4b2551d258e442ef513a5,
which is further modified into
https://github.com/qemu/qemu/blame/146aa0f104bb3bf88e43c4082a0bfc4bbda4fbd8/hw/usb/host-libusb.c#L1486.
Following such patch, I have attempted to apply such patch at host-side in
https://github.com/michaellee8/qemu/blob/master/hw/usb/redirect.c (not
correctly formatted currently, pls ignore it atm), however I discovered
that this is not enough since it is also a SPICE issue, which resolves to
virt-manager/virt-viewer.
This is probably a cross-project issue between qemu, spice (usbredir) and
virt-manager/virt-viewer, which would some effort to coordinate a solution.
However a working solution for this problem would probably benefits a lot
of users whom relies on connecting a mobile device into a VM, for purposes
like easier mobile development. Considering the report for the Samsung
Android Device on a PC use case, such issue is probably
cross-OS/cross-device.

cross-references:
- https://bugzilla.redhat.com/show_bug.cgi?id=1821518
- https://bugzilla.redhat.com/show_bug.cgi?id=1821517
- https://gitlab.freedesktop.org/spice/usbredir/-/issues/10

--00000000000045ed3205a2a966aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Description of problem:<br>Currently, when a iOS device is=
 redirected to a macOS VM, it falls into a reset-not-found loop.<br>Version=
-Release number of selected component (if applicable):<br>latest<br>How rep=
roducible:<br>100%<br>Steps to Reproduce:<br><ol><li>Connect an iOS device =
to Ubuntu 18.04.2 LTS (I believe it is the same for any distro.)</li><li>Co=
nnect virt-manager/virt-viewer to a macOS VM through SPICE (I am using OSX =
10.15 Catalina)</li><li>Attempt to redirect the iOS device (iPad in my case=
) to the VM through usb redirection.</li></ol><br><br>Actual results:<br>Fo=
r any odd number of attempt, the guest macOS will send a reset to the iOS d=
evice which causes the host to reset the USB connection in the host side. I=
n the UI, it will be displayed as a successful connection for a few seconds=
 before it disconnects. After this, the iOS device will reconnect itself, b=
ut via a different device name /dev/bus/usb/x/y+1.<br>For any even number o=
f attempt, when I select the iOS device in the virt-manager/virt-viewer UI,=
 the connection will not success and instead a LIBUSB_ERROR_NOT_FOUND error=
 will be provided. Then the UI will reload and get the new device name of t=
he iOS device, falling into the behavior of the aforementioned odd number o=
f attempt.<br>Expected results:<br>The macOS detects the iOS device and con=
nects to it happily.<br>Additional info:<br>It seems that this bug has been=
 first identified as in <a href=3D"https://bugs.freedesktop.org/show_bug.cg=
i?id=3D100149">https://bugs.freedesktop.org/show_bug.cgi?id=3D100149</a>, f=
or a Samsung Android device, which the developers of SPICE applied a hotfix=
 in <a href=3D"https://gitlab.freedesktop.org/spice/usbredir/-/blob/master/=
usbredirhost/usbredirhost.c#L147">https://gitlab.freedesktop.org/spice/usbr=
edir/-/blob/master/usbredirhost/usbredirhost.c#L147</a>. However, there wer=
e no settings available for users to fix it.<br>A similar bug that also con=
sists of a macOS guest/iOS device pair, but instead of being usbredir, is u=
sb-host, has been identified and patched in <a href=3D"https://github.com/q=
emu/qemu/commit/ba4c735b4fc74e309ce4b2551d258e442ef513a5">https://github.co=
m/qemu/qemu/commit/ba4c735b4fc74e309ce4b2551d258e442ef513a5</a>, which is f=
urther modified into <a href=3D"https://github.com/qemu/qemu/blame/146aa0f1=
04bb3bf88e43c4082a0bfc4bbda4fbd8/hw/usb/host-libusb.c#L1486">https://github=
.com/qemu/qemu/blame/146aa0f104bb3bf88e43c4082a0bfc4bbda4fbd8/hw/usb/host-l=
ibusb.c#L1486</a>. Following such patch, I have attempted to apply such pat=
ch at host-side in <a href=3D"https://github.com/michaellee8/qemu/blob/mast=
er/hw/usb/redirect.c">https://github.com/michaellee8/qemu/blob/master/hw/us=
b/redirect.c</a> (not correctly formatted currently, pls ignore it atm), ho=
wever I discovered that this is not enough since it is also a SPICE issue, =
which resolves to virt-manager/virt-viewer.<br>This is probably a cross-pro=
ject issue between qemu, spice (usbredir) and virt-manager/virt-viewer, whi=
ch would some effort to coordinate a solution. However a working solution f=
or this problem would probably benefits a lot of users whom relies on conne=
cting a mobile device into a VM, for purposes like easier mobile developmen=
t. Considering the report for the Samsung Android Device on a PC use case, =
such issue is probably cross-OS/cross-device.<br><br>cross-references:<br>-=
 <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1821518">https://=
bugzilla.redhat.com/show_bug.cgi?id=3D1821518</a><br>- <a href=3D"https://b=
ugzilla.redhat.com/show_bug.cgi?id=3D1821517">https://bugzilla.redhat.com/s=
how_bug.cgi?id=3D1821517</a><br>- <a href=3D"https://gitlab.freedesktop.org=
/spice/usbredir/-/issues/10">https://gitlab.freedesktop.org/spice/usbredir/=
-/issues/10</a><br></div>

--00000000000045ed3205a2a966aa--

