Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A67EC4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 19:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D7721783
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 19:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D7721783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFkLp-0005xF-Ea
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 15:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iFkKi-0005VY-65
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 15:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iFkKf-0005hJ-8D
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 15:30:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:53154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iFkKe-0005gy-L2
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 15:30:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iFkKd-0003kZ-3P
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 19:30:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 157AF2E806E
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 19:30:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Oct 2019 19:20:46 -0000
From: Rhodus <1846392@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: rhodus
X-Launchpad-Bug-Reporter: Rhodus (rhodus)
X-Launchpad-Bug-Modifier: Rhodus (rhodus)
References: <157004264359.16779.14522562243536509301.malonedeb@gac.canonical.com>
Message-Id: <157004404693.20435.8258561667046421464.launchpad@soybean.canonical.com>
Subject: [Bug 1846392] Re: VCPU shutdown request with HAX
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19066";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ce12351c4234e5f1c0996123cb6d138aaccec3d5
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1846392 <1846392@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Description changed:

  In most scenarios when turning on HAX, QEMU will exit, printing "VCPU
  shutdown request" to the console.
  =

  This is on Windows 8.1 with Intel HAXM 7.5.2.
  QEMU's -version prints v4.1.0-11789-g013a2ecf4f-dirty .
  I've used an installer from qemu.weilnetz.de.
  The host CPU is an IvyBridge i5 (mobile).
  =

  Some notes:
  Win10-1709-PE_Custom.iso is a custom WinPE image I had meant to test usin=
g QEMU. It is likely broken and doesn't boot at all.
  [Stuck, etc.]: I had given that image almost 2h during which the circle o=
f dots continued to spin. I don't know if it or QEMU did anything of intere=
st at all during that period, but this might indicate long-term stability, =
sort of.
  Win10_1709_German_x32.iso: Stock Win10 1709 32bit ISO I got off a German =
tech website. I've waited for the install screen to appear.
  TinyCore_10-1.iso: TinyCore by Core Project. A 18MB graphical Linux distr=
ibution, pretty barren by default. I've generally opened Apps there, the pa=
ckage manager, then shut it down again.
  On the one marked [Fx stable], I've gotten Firefox 60.8.0 ESR and visited=
 a couple of websites. (I don't know of any available program that would tr=
y to execute exotic CPU instructions in weird combinations to do a proper t=
est.)
  Q64 is .\qemu-system-x86_64.exe , substituted for readability (shorter li=
nes).
- =

  =

  First, those that QEMU seemed to handle well:
  Q64 -machine q35 -accel hax
  Q64 -machine q35 -cdrom \!S\Win10-1709-PE_Custom.iso
  Q64 -machine q35 -cdrom \!S\Win10-1709-PE_Custom.iso -m 4096 [Stuck, etc.]
  Q64 -machine q35 -cdrom \!S\Win10_1709_German_x32.iso -m 1920
  Q64 -machine q35 -cdrom \!S\Win10_1709_German_x32.iso -cpu max -m 256 [1]
  Q64 -machine q35 -cdrom \!S\Win10_1709_German_x32.iso -cpu max -m 512
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -cpu max -serial file:\!S\QEMU_TC=
L_BUG.log [2]
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax [Fx stable, s.a.]
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu Skylake-Client-IB=
RS
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu Icelake-Client-v1
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu Cascadelake-Serve=
r-v2
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu Broadwell-v4
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu IvyBridge-IBRS
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu coreduo
- Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu pentium =

+ Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu pentium
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu base [3]
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -cpu base [4]
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -cpu pentium
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu Icelake-Client-v1 [5]
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu Broadwell-v4 [5]
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu IvyBridge-v1 [5]
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu coreduo
- =

  =

  Then, those that made it print "VCPU shutdown request" repeatedly and qui=
t, immediately or after a couple of seconds at most, except where noted. I =
put an indication of the number of messages into curly braces.
  Q64 -machine q35,accel=3Dhax -cpu max  {many}
  Q64 -machine q35,accel=3Dhax -cdrom \!S\Win10-1709-PE_Custom.iso
  Q64 -machine q35 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -accel hax  =
{very many}
  Q64 -machine q35 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -accel hax -=
cpu max  {very many}
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -accel hax  {just two}
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu max  {a couple}
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu Icelake-Client-v1 -a=
ccel hax  {two}
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu IvyBridge-v1 -accel =
hax  {two}
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu pentium -accel hax  =
{three}
- .\qemu-system-x86_64.exe -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu=
 coreduo -accel hax  {a few}
+ Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu coreduo -accel hax  =
{a few}
  =

- =

- (I have rewritten a couple of commandlines to make them more uniform (cha=
nging the placement of parameters and using '-accel hax' instead of '-machi=
ne ...,accel=3Dhax').)
+ (I have rewritten a couple of commandlines to make them more uniform
+ (changing the placement of parameters and using '-accel hax' instead of
+ '-machine ...,accel=3Dhax').)
  =

  [1]: WinPE boot error, not enough RAM.
  [2]: Will cause a kernel BUG: "... \ login[892]: root login on 'tty1' \ B=
UG: unable to handle kernel paging request at 00010ffa \ ...". See attached=
 file.
  [3]: Stuck after "Booting the kernel.", cursor blinks.
  [4]: Stuck at blinking console prompt, no input possible.
  [5]: According to the printout, TCG doesn't support a bunch of those proc=
essor's features that have been requested.
+ =

+ =

+ PS: There should be some note highlighting that there is a strict limit o=
n line length (or at least that's what it looks like).  I can shorten the f=
ile names further to enhance skimmability ... :/
+ Also, let me know if you need anything else.

** Description changed:

  In most scenarios when turning on HAX, QEMU will exit, printing "VCPU
  shutdown request" to the console.
  =

  This is on Windows 8.1 with Intel HAXM 7.5.2.
  QEMU's -version prints v4.1.0-11789-g013a2ecf4f-dirty .
  I've used an installer from qemu.weilnetz.de.
  The host CPU is an IvyBridge i5 (mobile).
  =

- Some notes:
+ Some miscellaneous notes (you can skip them first):
  Win10-1709-PE_Custom.iso is a custom WinPE image I had meant to test usin=
g QEMU. It is likely broken and doesn't boot at all.
  [Stuck, etc.]: I had given that image almost 2h during which the circle o=
f dots continued to spin. I don't know if it or QEMU did anything of intere=
st at all during that period, but this might indicate long-term stability, =
sort of.
  Win10_1709_German_x32.iso: Stock Win10 1709 32bit ISO I got off a German =
tech website. I've waited for the install screen to appear.
  TinyCore_10-1.iso: TinyCore by Core Project. A 18MB graphical Linux distr=
ibution, pretty barren by default. I've generally opened Apps there, the pa=
ckage manager, then shut it down again.
  On the one marked [Fx stable], I've gotten Firefox 60.8.0 ESR and visited=
 a couple of websites. (I don't know of any available program that would tr=
y to execute exotic CPU instructions in weird combinations to do a proper t=
est.)
  Q64 is .\qemu-system-x86_64.exe , substituted for readability (shorter li=
nes).
  =

- First, those that QEMU seemed to handle well:
+ =

+ Invocations that QEMU seemed to handle well (without the headline error):
  Q64 -machine q35 -accel hax
  Q64 -machine q35 -cdrom \!S\Win10-1709-PE_Custom.iso
  Q64 -machine q35 -cdrom \!S\Win10-1709-PE_Custom.iso -m 4096 [Stuck, etc.]
  Q64 -machine q35 -cdrom \!S\Win10_1709_German_x32.iso -m 1920
  Q64 -machine q35 -cdrom \!S\Win10_1709_German_x32.iso -cpu max -m 256 [1]
  Q64 -machine q35 -cdrom \!S\Win10_1709_German_x32.iso -cpu max -m 512
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -cpu max -serial file:\!S\QEMU_TC=
L_BUG.log [2]
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax [Fx stable, s.a.]
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu Skylake-Client-IB=
RS
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu Icelake-Client-v1
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu Cascadelake-Serve=
r-v2
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu Broadwell-v4
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu IvyBridge-IBRS
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu coreduo
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu pentium
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu base [3]
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -cpu base [4]
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -cpu pentium
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu Icelake-Client-v1 [5]
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu Broadwell-v4 [5]
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu IvyBridge-v1 [5]
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu coreduo
  =

+ =

  Then, those that made it print "VCPU shutdown request" repeatedly and qui=
t, immediately or after a couple of seconds at most, except where noted. I =
put an indication of the number of messages into curly braces.
  Q64 -machine q35,accel=3Dhax -cpu max  {many}
  Q64 -machine q35,accel=3Dhax -cdrom \!S\Win10-1709-PE_Custom.iso
  Q64 -machine q35 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -accel hax  =
{very many}
  Q64 -machine q35 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -accel hax -=
cpu max  {very many}
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -accel hax  {just two}
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu max  {a couple}
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu Icelake-Client-v1 -a=
ccel hax  {two}
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu IvyBridge-v1 -accel =
hax  {two}
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu pentium -accel hax  =
{three}
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu coreduo -accel hax  =
{a few}
  =

+ =

  (I have rewritten a couple of commandlines to make them more uniform
  (changing the placement of parameters and using '-accel hax' instead of
  '-machine ...,accel=3Dhax').)
  =

  [1]: WinPE boot error, not enough RAM.
  [2]: Will cause a kernel BUG: "... \ login[892]: root login on 'tty1' \ B=
UG: unable to handle kernel paging request at 00010ffa \ ...". See attached=
 file.
  [3]: Stuck after "Booting the kernel.", cursor blinks.
  [4]: Stuck at blinking console prompt, no input possible.
  [5]: According to the printout, TCG doesn't support a bunch of those proc=
essor's features that have been requested.
  =

- =

  PS: There should be some note highlighting that there is a strict limit o=
n line length (or at least that's what it looks like).  I can shorten the f=
ile names further to enhance skimmability ... :/
  Also, let me know if you need anything else.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1846392

Title:
  VCPU shutdown request with HAX

Status in QEMU:
  New

Bug description:
  In most scenarios when turning on HAX, QEMU will exit, printing "VCPU
  shutdown request" to the console.

  This is on Windows 8.1 with Intel HAXM 7.5.2.
  QEMU's -version prints v4.1.0-11789-g013a2ecf4f-dirty .
  I've used an installer from qemu.weilnetz.de.
  The host CPU is an IvyBridge i5 (mobile).

  Some miscellaneous notes (you can skip them first):
  Win10-1709-PE_Custom.iso is a custom WinPE image I had meant to test usin=
g QEMU. It is likely broken and doesn't boot at all.
  [Stuck, etc.]: I had given that image almost 2h during which the circle o=
f dots continued to spin. I don't know if it or QEMU did anything of intere=
st at all during that period, but this might indicate long-term stability, =
sort of.
  Win10_1709_German_x32.iso: Stock Win10 1709 32bit ISO I got off a German =
tech website. I've waited for the install screen to appear.
  TinyCore_10-1.iso: TinyCore by Core Project. A 18MB graphical Linux distr=
ibution, pretty barren by default. I've generally opened Apps there, the pa=
ckage manager, then shut it down again.
  On the one marked [Fx stable], I've gotten Firefox 60.8.0 ESR and visited=
 a couple of websites. (I don't know of any available program that would tr=
y to execute exotic CPU instructions in weird combinations to do a proper t=
est.)
  Q64 is .\qemu-system-x86_64.exe , substituted for readability (shorter li=
nes).

  =

  Invocations that QEMU seemed to handle well (without the headline error):
  Q64 -machine q35 -accel hax
  Q64 -machine q35 -cdrom \!S\Win10-1709-PE_Custom.iso
  Q64 -machine q35 -cdrom \!S\Win10-1709-PE_Custom.iso -m 4096 [Stuck, etc.]
  Q64 -machine q35 -cdrom \!S\Win10_1709_German_x32.iso -m 1920
  Q64 -machine q35 -cdrom \!S\Win10_1709_German_x32.iso -cpu max -m 256 [1]
  Q64 -machine q35 -cdrom \!S\Win10_1709_German_x32.iso -cpu max -m 512
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -cpu max -serial file:\!S\QEMU_TC=
L_BUG.log [2]
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax [Fx stable, s.a.]
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu Skylake-Client-IB=
RS
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu Icelake-Client-v1
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu Cascadelake-Serve=
r-v2
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu Broadwell-v4
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu IvyBridge-IBRS
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu coreduo
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu pentium
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu base [3]
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -cpu base [4]
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -cpu pentium
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu Icelake-Client-v1 [5]
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu Broadwell-v4 [5]
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu IvyBridge-v1 [5]
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu coreduo

  =

  Then, those that made it print "VCPU shutdown request" repeatedly and qui=
t, immediately or after a couple of seconds at most, except where noted. I =
put an indication of the number of messages into curly braces.
  Q64 -machine q35,accel=3Dhax -cpu max  {many}
  Q64 -machine q35,accel=3Dhax -cdrom \!S\Win10-1709-PE_Custom.iso
  Q64 -machine q35 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -accel hax  =
{very many}
  Q64 -machine q35 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -accel hax -=
cpu max  {very many}
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -accel hax  {just two}
  Q64 -cdrom \!S\TinyCore_10-1.iso -m 512 -accel hax -cpu max  {a couple}
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu Icelake-Client-v1 -a=
ccel hax  {two}
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu IvyBridge-v1 -accel =
hax  {two}
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu pentium -accel hax  =
{three}
  Q64 -cdrom \!S\Win10_1709_German_x32.iso -m 512 -cpu coreduo -accel hax  =
{a few}


  (I have rewritten a couple of commandlines to make them more uniform
  (changing the placement of parameters and using '-accel hax' instead
  of '-machine ...,accel=3Dhax').)

  [1]: WinPE boot error, not enough RAM.
  [2]: Will cause a kernel BUG: "... \ login[892]: root login on 'tty1' \ B=
UG: unable to handle kernel paging request at 00010ffa \ ...". See attached=
 file.
  [3]: Stuck after "Booting the kernel.", cursor blinks.
  [4]: Stuck at blinking console prompt, no input possible.
  [5]: According to the printout, TCG doesn't support a bunch of those proc=
essor's features that have been requested.

  PS: There should be some note highlighting that there is a strict limit o=
n line length (or at least that's what it looks like).  I can shorten the f=
ile names further to enhance skimmability ... :/
  Also, let me know if you need anything else.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1846392/+subscriptions

