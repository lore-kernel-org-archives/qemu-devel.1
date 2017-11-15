Received: from eggs.gnu.org ([2001:4830:134:3::10]:56518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eF4Et-0006ZW-E8
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 15:24:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eF4Es-0003l0-IK
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 15:24:51 -0500
Date: Wed, 15 Nov 2017 20:24:40 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171115202440.GJ19514@redhat.com>
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
	<c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
	<CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
	<0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
	<CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
	<30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
Subject: Re: [Qemu-devel] [Libguestfs]  [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>

On Wed, Nov 15, 2017 at 09:07:12PM +0100, Max Reitz wrote:
> On 2017-11-15 21:06, Gandalf Corvotempesta wrote:
> > 2017-11-15 20:59 GMT+01:00 Max Reitz <mreitz@redhat.com>:
> >> Well, you can't just add support to qemu-img alone either.  Every image
> >> format supported by qemu-img is one supported by qemu as a whole and
> >> thus needs a proper block driver that needs to support random accesses
> >> as well.
> > 
> > I was talking about qemu-img convert, just to convert an XVA image to
> > something different, in a single pass, without having to extract the
> > tar.
> 
> I know, but that doesn't work.  qemu-img convert uses the normal
> general-purpose block drivers for that.

In any case there's no need as qemu/qemu-img can already access files
inside an uncompressed tarball using the offset/size support added to
the raw driver exactly for this purpose:

https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg03945.html

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
