Received: from eggs.gnu.org ([2001:4830:134:3::10]:45128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gJxS4-0004ot-6R
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:15:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gJxRy-0003f3-Hs
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:15:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1gJxRy-0003eE-BJ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 04:15:06 -0500
Date: Tue, 6 Nov 2018 09:14:57 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181106091457.GC4080@redhat.com>
References: <ae2d0fbd-5198-47e8-9ad2-40a85f0b3576@default>
	<bd913c1b-fcbe-b198-3955-4b4b2e33757a@redhat.com>
	<fef3b167-0d69-d61d-418b-535fb6d36dfc@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fef3b167-0d69-d61d-418b-535fb6d36dfc@oracle.com>
Subject: Re: [Qemu-devel] [Libguestfs] How to emulate block I/O timeout on
 qemu side?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Eric Blake <eblake@redhat.com>, jsnow@redhat.com, qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>

On Tue, Nov 06, 2018 at 02:17:46PM +0800, Dongli Zhang wrote:
> On 11/06/2018 01:49 AM, Eric Blake wrote:
> > On 11/2/18 3:11 AM, Dongli Zhang wrote:
> >> Hi,
> >>
> >> Is there any way to emulate I/O timeout on qemu side (not fault
> >> injection in VM kernel) without modifying qemu source code?
> >
> > You may be interested in Rich's work on nbdkit.  If you don't mind
> > the overhead of the host connecting through NBD, then you can use
> > nbdkit's delay and fault-injection filters for inserting delays or
> > even run-time-controllable failures to investigate how the guest
> > reacts to those situations
> >
> Thank you all very much for the suggestions. I will take a look on nbdkit.

These links should help:

  https://rwmj.wordpress.com/2018/09/04/nbdkit-for-loopback-pt-2-injecting-errors/
  https://rwmj.wordpress.com/2018/09/06/nbdkit-for-loopback-pt-7-a-slow-disk/

This link shows how to combine delay and error filters together:

  https://rwmj.wordpress.com/2018/11/04/nbd-graphical-viewer/

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
