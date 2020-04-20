Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1904FC54FCC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 23:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFFCB206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 23:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFFCB206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=email.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQfQ4-0004im-41
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 19:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jQfPR-0004HZ-8w
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 19:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jQfPQ-00080t-3I
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 19:01:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:37656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jQfPP-00080g-Kz
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 19:00:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jQfPO-0007de-6H
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 23:00:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1ED102E8106
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 23:00:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2020 22:52:53 -0000
From: ruthan <ruthan@email.cz>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jnsnow ruthan
X-Launchpad-Bug-Reporter: ruthan (ruthan)
X-Launchpad-Bug-Modifier: ruthan (ruthan)
References: <158706562034.6027.11807874678540403888.malonedeb@chaenomeles.canonical.com>
Message-Id: <158742317355.19116.18196195509506144913.malone@gac.canonical.com>
Subject: [Bug 1873338] Re: Dos on the fly CD image replacement is not Working
 with DOS
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ab5b998ac3b1ce32fac221c876a695b6bc46a82a
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 19:00:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1873338 <1873338@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Host: I tried both Windows (10 64bit 19.09) and Linux host (Mint 19.3
64bit, kernel 5.40) system it really doesnt matters.

Guest: Windows 98 - has integrated MS-DOS 7.1 you can boot into it through =
boot menu, which could be set by meditation of MSDOS.SYS, but you can insta=
ll MS-DOS 7.1 Standalone too, without Windows, its the same.
 https://winworldpc.com/product/ms-dos/7x
 What DOS is after set up through Autoexec.bat and config.sys files. =

 Using DOS 7.1 make sense, because its most modern and supporting FAT32 fil=
e system.

 There is Qemu starting line i doubt that it will help, you can simulate pr=
oblem with any DOS machine.
qemu-system-i386.exe ^
-m 64 ^
-hda HDDs\MS-DOS-Systen-5G.vmdk ^
-hdb HDDs\DosData20G.vmdk ^
-vga cirrus ^ =

-soundhw sb16,adlib,pcspk ^
-net nic,model=3Drtl8139 ^
-net tap,ifname=3DTAP ^
-cdrom Isos\dos71cd.iso ^
-k en-us

 With Windows 98 - i run just commands in monitor.. open my computer and
open cd drive - content of cd is changed.. its the same as in all later
OSes XP- to Win10. Its working as expected.

 DOS - i boot into dos with cd drive driver enabled (lest say MSCDEX).. i r=
un monitor, change cd image.. a trying to access it lets say that is drive =
E.. So i write "E:" <ENTER> to command line. I get error that drive is not =
accessible.. (command line should be switched to E:\ and here i should be a=
ble use "dir" to get list of files) but when i reboot machine, i see new ex=
change cd content.. so its at least somehow working.
  Problem is that some games and programs require change cd on the fly, so =
reboot is not solution.
  =

   You can simulate right behavior with Vmware or Virtualbox machine.

   Is you are not familar with MS-DOS, here are command to autoexec and con=
fig for enable use of cd-rom drive:
https://superuser.com/questions/778716/install-a-cd-rom-driver-on-ms-dos

  Problem is probably that present version of cd exchange simulation
code is not good enough / compatible for MSCDEX or SHSUCDX DOS CD-ROM
drivers.. to make same action as is exchange cd on physical computer.

  Windows 98 and later are using other drivers for it of course..

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1873338

Title:
  Dos on the fly CD image replacement is not Working with DOS

Status in QEMU:
  Incomplete

Bug description:
  Im not able to exchange CD image on the fly (needed for some games). I
  messed with command like - in console(ATL+CRTL+2) eject ide1-cd0 and
  change ide-cd0 D:/Games/!Emulators/Dos-QEMU/ISOs/TestChangeISO.iso ,
  but system so never able to find new CD data.. simply drive so empty..
  but when i reboot virtual machine, new change image is now working.

    Qemu 4.2.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1873338/+subscriptions

