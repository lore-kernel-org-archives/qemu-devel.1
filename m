Received: from eggs.gnu.org ([2001:4830:134:3::10]:46839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8SCE-0000h9-V9
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e8SCD-0005XL-VU
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:34:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:59276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e8SCD-0005Wu-PI
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 10:34:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e8SCB-0003YX-PP
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 14:34:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B7B792E80C8
	for <qemu-devel@nongnu.org>; Sat, 28 Oct 2017 14:34:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Oct 2017 14:24:57 -0000
From: Thomas Huth <1239008@bugs.launchpad.net>
Reply-To: Bug 1239008 <1239008@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131011233333.16273.25871.malonedeb@soybean.canonical.com>
Message-Id: <150920069772.4275.5721803270866306869.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1239008] Re: qemu fails to scroll screen on
 ^Vidmem output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1239008

Title:
  qemu fails to scroll screen on ^Vidmem output

Status in QEMU:
  Incomplete
Status in qemu package in Ubuntu:
  Incomplete

Bug description:
  Pascal uses ^Vidmem for B800 console output. The terminal does not
  oblige the Pascal OS code to scroll the output. Virtualbox emulation
  works, so this must be a qemu bug. Using QEMU in KVM mode as Ubuntu
  LTS.

  Source line to trip bug(in theory pushes VideoMem up one line):

  procedure Scroll;
  //this is whats causing crashes. FIXME:Virtualbox not affected.QEMU BUG?
  begin
    if scrolldisabled then exit;
        if (CursorPosY >=3D 24) then begin  //in case called before end of =
screen
      blank:=3D $20 or (TextAttr shl 8);
      Move((VidMem+(2*80))^,VidMem^,24*(2*80));
      // Empty last line
      FillWord((VidMem+(24*2*80))^,80,Blank);
      CursorPosX:=3D1;
      CursorPosY:=3D23;
      update_cursor;
    end;
  end;

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1239008/+subscriptions
