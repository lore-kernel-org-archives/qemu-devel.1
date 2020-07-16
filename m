Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654BDC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 390EE207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 05:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390EE207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvwBG-0005V4-HB
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 01:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jvwAU-00055E-OT
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 01:10:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:49208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jvwAS-0001mS-C3
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 01:10:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jvwAQ-00058J-7c
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 05:10:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1861C2E80ED
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 05:10:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2020 05:04:29 -0000
From: InfoLibre <1887745@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: david-vantyghem
X-Launchpad-Bug-Reporter: InfoLibre (david-vantyghem)
X-Launchpad-Bug-Modifier: InfoLibre (david-vantyghem)
Message-Id: <159487586988.12480.12060842561755598907.malonedeb@gac.canonical.com>
Subject: [Bug 1887745] [NEW] call-method block-size failed with error ffffffdf
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a49cd9f73470aac8e17ac9f00504fd963e4bf99c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 01:10:46
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
Reply-To: Bug 1887745 <1887745@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I start Debian 10 PowerPC version in QEMU with this command :

/usr/bin/qemu-system-ppc -monitor stdio -M mac99 -k fr -machine
accel=3Dtcg -m 512 -cdrom /home/david/Bureau/debian-10.0.0-powerpc-
NETINST-1.iso -hda /home/david/Documents/Informatique et
t=C3=A9l=C3=A9phone/Documentation informatique/Macintosh/Debian_10_LXDE -vi=
rtfs
local,id=3Dshared_folder_dev_0,path=3D/home/david/Bureau,security_model=3Dn=
one,mount_tag=3Dshared0
-boot order=3Ddc,menu=3Don -net nic,macaddr=3D00:a2:6d:80:10:8f,model=3Drtl=
8139
-net user -net user,smb=3D/home/david/Bureau -rtc base=3Dlocaltime -name
"Debian + LXDE sur iMac G3" -M mac99

GRUB menu appears. Then, I choose "Default install", the screen is
cleaned and "Loading..." appears. But after, nothing happens and I've
got this error message :

C>> annot manage 'undefined' PCI device type '<NULL>':
>>  1af4 1009 (0 2 0)

>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> OpenBIOS 1.1 [Mar 12 2020 14:02]
>> Configuration device id QEMU version 1 machine id 1
>> CPUs: 1
>> Memory: 512M
>> UUID: 00000000-0000-0000-0000-000000000000
>> CPU type PowerPC,G4
milliseconds isn't unique.
>> switching to new context:
>> call-method block-size failed with error ffffffdf
>> call-method block-size failed with error ffffffdf

I found this post, I don't know if it could help... :
https://lists.gnu.org/archive/html/grub-devel/2014-05/msg00001.html

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  I start Debian 10 PowerPC version in QEMU with this command :
  =

  /usr/bin/qemu-system-ppc -monitor stdio -M mac99 -k fr -machine
  accel=3Dtcg -m 512 -cdrom /home/david/Bureau/debian-10.0.0-powerpc-
  NETINST-1.iso -hda /home/david/Documents/Informatique et
  t=C3=A9l=C3=A9phone/Documentation informatique/Macintosh/Debian_10_LXDE -=
virtfs
  local,id=3Dshared_folder_dev_0,path=3D/home/david/Bureau,security_model=
=3Dnone,mount_tag=3Dshared0
  -boot order=3Ddc,menu=3Don -net nic,macaddr=3D00:a2:6d:80:10:8f,model=3Dr=
tl8139
  -net user -net user,smb=3D/home/david/Bureau -rtc base=3Dlocaltime -name
  "Debian + LXDE sur iMac G3" -M mac99
  =

  GRUB menu appears. Then, I choose "Default install", the screen is
  cleaned and "Loading..." appears. But after, nothing happens and I've
  got this error message :
  =

  C>> annot manage 'undefined' PCI device type '<NULL>':
  >>  1af4 1009 (0 2 0)
  =

  >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  >> OpenBIOS 1.1 [Mar 12 2020 14:02]
  >> Configuration device id QEMU version 1 machine id 1
  >> CPUs: 1
  >> Memory: 512M
  >> UUID: 00000000-0000-0000-0000-000000000000
  >> CPU type PowerPC,G4
  milliseconds isn't unique.
  >> switching to new context:
  >> call-method block-size failed with error ffffffdf
  >> call-method block-size failed with error ffffffdf
  =

- =

- I found this post, I don't know if it could help... : https://lists.gnu.o=
rg/archive/html/grub ... 00001.html
+ I found this post, I don't know if it could help... :
+ https://lists.gnu.org/archive/html/grub-devel/2014-05/msg00001.html

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1887745

Title:
  call-method block-size failed with error ffffffdf

Status in QEMU:
  New

Bug description:
  I start Debian 10 PowerPC version in QEMU with this command :

  /usr/bin/qemu-system-ppc -monitor stdio -M mac99 -k fr -machine
  accel=3Dtcg -m 512 -cdrom /home/david/Bureau/debian-10.0.0-powerpc-
  NETINST-1.iso -hda /home/david/Documents/Informatique et
  t=C3=A9l=C3=A9phone/Documentation informatique/Macintosh/Debian_10_LXDE -=
virtfs
  local,id=3Dshared_folder_dev_0,path=3D/home/david/Bureau,security_model=
=3Dnone,mount_tag=3Dshared0
  -boot order=3Ddc,menu=3Don -net
  nic,macaddr=3D00:a2:6d:80:10:8f,model=3Drtl8139 -net user -net
  user,smb=3D/home/david/Bureau -rtc base=3Dlocaltime -name "Debian + LXDE
  sur iMac G3" -M mac99

  GRUB menu appears. Then, I choose "Default install", the screen is
  cleaned and "Loading..." appears. But after, nothing happens and I've
  got this error message :

  C>> annot manage 'undefined' PCI device type '<NULL>':
  >>  1af4 1009 (0 2 0)

  >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  >> OpenBIOS 1.1 [Mar 12 2020 14:02]
  >> Configuration device id QEMU version 1 machine id 1
  >> CPUs: 1
  >> Memory: 512M
  >> UUID: 00000000-0000-0000-0000-000000000000
  >> CPU type PowerPC,G4
  milliseconds isn't unique.
  >> switching to new context:
  >> call-method block-size failed with error ffffffdf
  >> call-method block-size failed with error ffffffdf

  I found this post, I don't know if it could help... :
  https://lists.gnu.org/archive/html/grub-devel/2014-05/msg00001.html

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1887745/+subscriptions

