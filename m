Received: from eggs.gnu.org ([2001:4830:134:3::10]:58397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUPq5-0001OD-PS
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eUPq1-0001qa-RS
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:59618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eUPq1-0001po-Kc
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 23:30:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eUPq0-0007mt-EP
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 04:30:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6BCA82E80C7
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 04:30:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 Dec 2017 04:17:28 -0000
From: Launchpad Bug Tracker <1239008@bugs.launchpad.net>
Reply-To: Bug 1239008 <1239008@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20131011233333.16273.25871.malonedeb@soybean.canonical.com>
Message-Id: <151443464899.28609.7223389676104693051.malone@loganberry.canonical.com>
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

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1239008

Title:
  qemu fails to scroll screen on ^Vidmem output

Status in QEMU:
  Expired
Status in qemu package in Ubuntu:
  Expired

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
