Received: from eggs.gnu.org ([2001:4830:134:3::10]:56777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dahQj-0000qX-9h
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dahQd-0006E0-T6
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:58:08 -0400
MIME-Version: 1.0
In-Reply-To: <20170727104705.GJ2555@redhat.com>
References: <CAOE=1Z0VzZv5bstq+bZpnLMZx5sj-KUQMO3hQjM=R+17TiUOBA@mail.gmail.com>
	<20170727104705.GJ2555@redhat.com>
From: Sam <batmanustc@gmail.com>
Date: Thu, 27 Jul 2017 19:58:06 +0800
Message-ID: <CAOE=1Z02yvArAxqtPoTHgLu01xS+K7ZPCXvwA8SG2hYVb7rA1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] For unix domain socket,
 will only one client could connect to this socket?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-discuss@nongnu.org

Thank you, I think another process connect this socket, so I hanged here.

2017-07-27 18:47 GMT+08:00 Daniel P. Berrange <berrange@redhat.com>:

> On Thu, Jul 27, 2017 at 06:37:32PM +0800, Sam wrote:
> > Hi all,
> >
> > I'm working on qemu-qga, and I want to send qmp command from this unix
> > socket, but it hanged there(no response), I don't know if it's connect
> > failed or something?
> >
> > [root@yf-mos-test-net09 ~]# socat
> > > /opt/cloud/workspace/servers/f6fdd093-383b-444e-9bcf-
> dfa81794d465/qga.sock
> > > readline
> > > {"execute": "guest-execute", "session": "4768", "arguments":
> {"commands":
> > > [{"command": "/bin/sh", "arguments": ["sh", "-c", "ping -c 1
> > > 172.16.0.1"]}]}}
>
> Pointless use of shell there. Just directly run ping
>
>   {"command": "/bin/ping", "arguments": ["-c", "1", "172.16.0.1"]}
>
> >
> >
> > My question is, for tcp or udp socket, many client could connect to one
> > server, is unix socket the same? Thank you~
>
> You can only ever have a single client connected, even with tcp/unix
> sockets backends.
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/
> dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/
> dberrange :|
>
