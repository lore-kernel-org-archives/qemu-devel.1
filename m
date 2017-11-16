Received: from eggs.gnu.org ([2001:4830:134:3::10]:42734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eFOTI-0000Xj-NI
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eFOTC-000462-TV
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:01:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1eFOTC-00043c-My
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:00:58 -0500
Date: Thu, 16 Nov 2017 18:00:54 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171116180054.GZ2787@redhat.com>
References: <20171115115246.GA1955@redhat.com>
	<20171116144746.GE29106@stefanha-x1.localdomain>
	<20171116151031.GV2787@redhat.com>
	<CAJSP0QWop2Xvjp5bObJ0yRoJ=W-6cH84fGHXj5b93Qb6TxCxDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QWop2Xvjp5bObJ0yRoJ=W-6cH84fGHXj5b93Qb6TxCxDA@mail.gmail.com>
Subject: Re: [Qemu-devel] Effect of qemu-img convert -m and -W options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: libguestfs@redhat.com, Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>

On Thu, Nov 16, 2017 at 05:30:48PM +0000, Stefan Hajnoczi wrote:
> On Thu, Nov 16, 2017 at 3:10 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
> > Both local filesystems, but on different SATA devices.
> 
> Okay.  I'm curious what the strace -f output looks like (only the
> preadv(2)/pwritev(2) syscalls are interesting at the moment).

Here's the full strace from one run:

  http://oirase.annexia.org/tmp/strace.xz

The command is (with the output.qcow2 file created in a previous run):

  $ strace -o /tmp/strace -f -s 1024 qemu-img convert -f raw fedora-27.img -O qcow2 /var/tmp/output.qcow2 -m 8 -W -n

The version of qemu is: qemu-2.10.0-7.fc28.x86_64

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
