Received: from eggs.gnu.org ([2001:4830:134:3::10]:59062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewWmw-00023y-Ng
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewWmt-0001Xs-KD
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:35:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:52168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ewWmt-0001WL-DY
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:35:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ewWms-0004dW-Dj
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 17:35:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 55A7A2E8059
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 17:35:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Mar 2018 17:23:05 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1619896 <1619896@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160903112421.26727.12298.malonedeb@gac.canonical.com>
Message-Id: <152113458636.31384.8747510674529541856.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1619896] Re: Unsupported ancillary data: 0/8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Tags added: linux-user

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1619896

Title:
  Unsupported ancillary data: 0/8

Status in QEMU:
  New

Bug description:
  Hello,

  I have the following issue when launching the Teamspeak Server x86
  binary on an arm host.

  Host:
   Linux 4.6.2 (vanilla)
   Ubuntu 14.04.5 LTS
   HW: Cubietruck board, armv7l

  =

  Used SW: Release archive qemu-2.7.0.tar.bz2 and git commit 1dc33ed90bf1fe=
1c2014dffa0d9e863c520d953a
  Configure options:
    ../configure --target-list=3Di386-linux-user =

  I attached the output of the configure script as configure.log

  Testcase:

  1. Download and extract TeamSpeak 3 Server 3.0.13.3 (x86)
    Souce: http://dl.4players.de/ts/releases/3.0.13.3/teamspeak3-server_lin=
ux_x86-3.0.13.3.tar.bz2

  2. Modifiy ts3server_minimal_runscript.sh for ease of use
    - ./ts3server $@
    + /usr/local/bin/qemu-i386 ./ts3server $@

  3. Execute ./ts3server_minimal_runscript.sh

  Wait for 6 Minutes until teamspeak server started. QEMU saturates the
  cpu while Teamspeak is precomputing a puzzle. (Whatever that means)

  After that Teamspeak settles with the following output:
    2016-09-03 10:50:59.555582|INFO    |Query         |   |listening on 0.0=
.0.0:10011, :::10011

  The Qemu process is now idling with ~2% cpu load. This is actually the
  first time for me that QEMU is able to successfully launch the
  Teamspeak server. Kudos!

  4. Connect client 1

  TS Clients can connect, but the following line is printed pretty often:
    Unsupported ancillary data: 0/8

  The line seems to come from qemu (linux-user/syscall.c)

  =

  5. Connect client 2
  When a second client is connected the audio transmission is successful fo=
r a few seconds, but the server drops the connection after that and refuses=
 to take new connections.

  Please let me know, if you need more information. I'll gladly provide
  strace or valgrind logs.

  Best regards,
  Tobias

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1619896/+subscriptions
