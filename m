Received: from eggs.gnu.org ([2001:4830:134:3::10]:50873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fONGs-0003Xc-FU
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fONGn-0000yD-Gi
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:05:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:57764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fONGn-0000xM-3o
	for qemu-devel@nongnu.org; Thu, 31 May 2018 09:05:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fONGm-0007jB-7y
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 13:05:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3704D2E80C7
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 13:05:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 31 May 2018 12:57:51 -0000
From: Andreas Gustafsson <gson@gson.org>
Reply-To: Bug 1774412 <1774412@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152777147120.26392.10770421701015705321.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1774412] [NEW] -icount sleep=on|off documentation
 is confusing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

The documentation for the -icount option in the qemu man page says:

"When the virtual cpu is sleeping, the virtual time will advance at
default speed unless sleep=3Don|off is specified. With sleep=3Don|off, the
virtual time will jump to the next timer deadline instantly whenever the
virtual cpu goes to sleep mode and will not advance if no timer is
enabled."

Taking this literally and specifying "sleep=3Don|off" on the command line d=
oes not work, so presumably the two instances of "sleep=3Don|off" should be=
 either "sleep=3Don" or "sleep=3Doff",
whichever is correct :)

Also, the synopsis line "-icount
[shift=3DN|auto][,rr=3Drecord|replay,rrfile=3Dfilename,rrsnapshot=3Dsnapsho=
t"
fails to mention the sleep keyword at all.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1774412

Title:
  -icount sleep=3Don|off documentation is confusing

Status in QEMU:
  New

Bug description:
  The documentation for the -icount option in the qemu man page says:

  "When the virtual cpu is sleeping, the virtual time will advance at
  default speed unless sleep=3Don|off is specified. With sleep=3Don|off, the
  virtual time will jump to the next timer deadline instantly whenever
  the virtual cpu goes to sleep mode and will not advance if no timer is
  enabled."

  Taking this literally and specifying "sleep=3Don|off" on the command line=
 does not work, so presumably the two instances of "sleep=3Don|off" should =
be either "sleep=3Don" or "sleep=3Doff",
  whichever is correct :)

  Also, the synopsis line "-icount
  [shift=3DN|auto][,rr=3Drecord|replay,rrfile=3Dfilename,rrsnapshot=3Dsnaps=
hot"
  fails to mention the sleep keyword at all.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1774412/+subscriptions
