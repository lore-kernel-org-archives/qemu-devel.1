Received: from eggs.gnu.org ([2001:4830:134:3::10]:56609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gSzvU-0001CU-AY
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 02:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gSzvT-0003DW-CX
	for qemu-devel@nongnu.org; Sat, 01 Dec 2018 02:42:56 -0500
Date: Sat, 1 Dec 2018 07:42:45 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181201074244.GF27120@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130220344.3350618-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0 00/14] nbd: add qemu-nbd --list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, nsoffer@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

On Fri, Nov 30, 2018 at 04:03:29PM -0600, Eric Blake wrote:
> I note that upstream NBD has 'nbd-client -l $host' for querying
> just export names (with no quoting, so you have to know that
> a blank line means the default export), but it wasn't powerful
> enough, so I implemented 'qemu-nbd -L' to document everything.
> Upstream NBD has separate 'nbd-client' and 'nbd-server' binaries,
> while we only have 'qemu-nbd' (which is normally just a server,
> but 'qemu-nbd -c' also operates a second thread as a client).
> Our other uses of qemu as NBD client are for consuming a block
> device (as in qemu-io, qemu-img, or a drive to qemu) - but those
> binaries are less suited to something so specific to the NBD
> protocol.

I tried it against nbdkit and it works (obviously):

$ ./qemu-nbd -L 
exports available: 1
 export: ''
  size:  67108864
  flags: 0x61 ( trim zeroes )

What I couldn't work out is how to connect to other hosts.  It's
possible to add -p or -k to change the localhost port number or to use
a Unix domain socket (and I checked both work).  However can we
connect to remote hosts?

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
