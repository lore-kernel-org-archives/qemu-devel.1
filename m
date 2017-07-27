Received: from eggs.gnu.org ([2001:4830:134:3::10]:54882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dagAi-0004EO-EW
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dagAh-0001Go-N0
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:37:36 -0400
MIME-Version: 1.0
From: Sam <batmanustc@gmail.com>
Date: Thu, 27 Jul 2017 18:37:32 +0800
Message-ID: <CAOE=1Z0VzZv5bstq+bZpnLMZx5sj-KUQMO3hQjM=R+17TiUOBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] For unix domain socket,
 will only one client could connect to this socket?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-discuss@nongnu.org

Hi all,

I'm working on qemu-qga, and I want to send qmp command from this unix
socket, but it hanged there(no response), I don't know if it's connect
failed or something?

[root@yf-mos-test-net09 ~]# socat
> /opt/cloud/workspace/servers/f6fdd093-383b-444e-9bcf-dfa81794d465/qga.sock
> readline
> {"execute": "guest-execute", "session": "4768", "arguments": {"commands":
> [{"command": "/bin/sh", "arguments": ["sh", "-c", "ping -c 1
> 172.16.0.1"]}]}}


My question is, for tcp or udp socket, many client could connect to one
server, is unix socket the same? Thank you~
