Received: from eggs.gnu.org ([2001:4830:134:3::10]:48082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dKOLH-0000qz-41
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dKOLG-0002EP-5Z
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 08:21:10 -0400
MIME-Version: 1.0
From: Sam <batmanustc@gmail.com>
Date: Mon, 12 Jun 2017 20:21:07 +0800
Message-ID: <CAOE=1Z1H-7DQtcUsKt7P2fhYQ2fBVp7R9KJwPki5wH9KvhbxBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Is there more trace-events in vhost module?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-discuss@nongnu.org

hi all=EF=BC=8C

I'm debuging ovs-2.6.0, dpdk-2.2.0 and qemu-2.6.0. And I run such command:

QEMU_CMD -D qemu-log.log -trace events=3Dqemu-events ...

I want to trace vhost-user protocol process between QEMU and ovs-dpdk.
Ovs-dpdk's log shows lots of infomations of vhost-user protocol, but QEMU's
log shows only a little.

As in qemu-events, there is only 'vhost_user_event' event I could use. Is
there more events or some other method to debug vhost related module in
QEMU?
