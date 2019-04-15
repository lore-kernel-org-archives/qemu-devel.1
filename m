Received: from eggs.gnu.org ([209.51.188.92]:58205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hG0aU-00015k-Po
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hG0aT-0002IE-Qb
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:19:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:40878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hG0aT-0002I2-K1
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:19:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hG0aR-0000fp-UT
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 12:19:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E10052E80D3
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 12:19:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Apr 2019 12:09:47 -0000
From: Robie Basak <1486278@bugs.launchpad.net>
Reply-To: Bug 1486278 <1486278@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150818230718.18792.42543.malonedeb@wampee.canonical.com>
Message-Id: <155533018711.20665.2522013390529921988.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1486278] Re: 'info vnc' monitor command does not
 show websocket information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Thanks! This is presumed fixed in Ubuntu also then, since 18.04 onwards
shipped a qemu version higher than 2.10.0. If this is wrong, please
reopen.

** Changed in: qemu (Ubuntu)
       Status: Confirmed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1486278

Title:
  'info vnc' monitor command does not show websocket information

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released

Bug description:
  Steps to reproduce^
  1. run
   qemu-system-x86_64  -vnc  0.0.0.0:1,websocket=3D5701 -nographic -monitor=
 stdio

  2. then type =

   (qemu) info vnc
  3.  see
       address: 0.0.0.0:5901
          auth: none
  Client: none

  There is no information about websocket parameters, but 'netstat -nltp' s=
hows me:
   ...
  tcp        0      0 0.0.0.0:5701            0.0.0.0:*               LISTE=
N      27073/qemu-system-x
  ....

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1486278/+subscriptions
