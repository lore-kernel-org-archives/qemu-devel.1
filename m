Received: from eggs.gnu.org ([2001:4830:134:3::10]:55666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dajDn-0004zp-TW
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dajDk-0004hC-Pb
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 09:52:59 -0400
Date: Thu, 27 Jul 2017 14:52:51 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170727135251.GN2555@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAOE=1Z0VzZv5bstq+bZpnLMZx5sj-KUQMO3hQjM=R+17TiUOBA@mail.gmail.com>
	<20170727104705.GJ2555@redhat.com>
	<CAOE=1Z02yvArAxqtPoTHgLu01xS+K7ZPCXvwA8SG2hYVb7rA1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOE=1Z02yvArAxqtPoTHgLu01xS+K7ZPCXvwA8SG2hYVb7rA1w@mail.gmail.com>
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
To: Sam <batmanustc@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-discuss@nongnu.org

On Thu, Jul 27, 2017 at 07:58:06PM +0800, Sam wrote:
> Thank you, I think another process connect this socket, so I hanged here.

Yes, if another process has it open, you would see a hang if you tried
to connect to it, because the kernel will have queued the incoming
connection, but QEMU will not call accept() on it until the first client
has gone.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
