Received: from eggs.gnu.org ([2001:4830:134:3::10]:44168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eFH8y-0000nt-60
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eFH8x-0007Xa-4f
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:11:36 -0500
Date: Thu, 16 Nov 2017 10:11:22 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171116101122.GF2450@redhat.com>
References: <CAJH6TXhBAaBE9gBSxksWZqNywWmencRaGyeY-oN3jbKdgUettQ@mail.gmail.com>
	<0e6cc220-814a-17fd-4fd7-7b0665d34e81@redhat.com>
	<CAJH6TXh2v-F=yqxQbUUawk_Ctq-sgFefGp1XvMsC=syX_5jEqA@mail.gmail.com>
	<30b54865-2255-d13d-a054-afcf5bbd06b2@redhat.com>
	<20171115202440.GJ19514@redhat.com>
	<7b11bb2b-b93d-e8ff-f396-703c93549d0d@redhat.com>
	<20171115202938.GN2787@redhat.com>
	<CAJH6TXiPuLu62-+o2+PrUGpstrks_5pLotFEe1bAOmsbn20otw@mail.gmail.com>
	<20171116100102.GE2450@redhat.com>
	<CAJH6TXiVz1Xu94mFSaeSesLBZ_jViS9WL6B7T3T8ufF1nXxtfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJH6TXiVz1Xu94mFSaeSesLBZ_jViS9WL6B7T3T8ufF1nXxtfQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [Libguestfs] [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>, Max Reitz <mreitz@redhat.com>

On Thu, Nov 16, 2017 at 11:07:10AM +0100, Gandalf Corvotempesta wrote:
> 2017-11-16 11:01 GMT+01:00 Richard W.M. Jones <rjones@redhat.com>:
> > As mentioned before you can use this to do a qemu-img convert using
> > captive nbdkit:
> >
> >   $ nbdkit -U - \
> >       perl script=./xva-reader.pl file=./debian8cloud.xva size=4294967296 \
> >       --run 'qemu-img convert -f raw $nbd -O qcow2 /var/tmp/output.qcow2 -p'
> 
> 
> What if XVA is hosting 2 or more partitions ? Which partition are you
> converting with this command ?

See "XXX" comments in the code, left as an exercise to the reader :-)

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/
