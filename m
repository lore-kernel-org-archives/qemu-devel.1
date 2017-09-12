Received: from eggs.gnu.org ([2001:4830:134:3::10]:56189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1drhzW-0003mL-45
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1drhzR-000724-Dt
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:00:26 -0400
Date: Tue, 12 Sep 2017 12:00:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170912100008.GD29136@localhost.localdomain>
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<20170809215510.22802-2-pbonzini@redhat.com>
	<eeba95b4-23a2-51da-2c41-be5ee262c965@redhat.com>
	<186485494.2838970.1502318620647.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <186485494.2838970.1502318620647.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/12] qemu-iotests: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 10.08.2017 um 00:43 hat Paolo Bonzini geschrieben:
> 
> 
> ----- Original Message -----
> > From: "Eric Blake" <eblake@redhat.com>
> > To: "Paolo Bonzini" <pbonzini@redhat.com>, qemu-devel@nongnu.org
> > Cc: kwolf@redhat.com, qemu-block@nongnu.org
> > Sent: Thursday, August 10, 2017 12:18:54 AM
> > Subject: Re: [Qemu-devel] [PATCH 01/12] qemu-iotests: remove dead code
> > 
> > On 08/09/2017 04:54 PM, Paolo Bonzini wrote:
> > > This includes shell function, shell variables, command line options
> > > (randomize.awk does not exist) and conditions that can never be true
> > > (./qemu does not exist anymore).
> > 
> > Can we point to a commit id where we stopped making ./qemu?
> 
> commit 9aed1e036dc0de49d08d713f9e5c4655e94acb56
> Author: Anthony Liguori <aliguori@us.ibm.com>
> Date:   Mon Aug 29 09:55:36 2011 -0500
> 
>     Rename qemu -> qemu-system-i386
>     
>     This has been discussed before in the past.  The special casing really makes no
>     sense anymore.  This seems like a good change to make for 1.0.
>     
>     Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

This is not related to ./qemu in the qemu-iotests directory. It's just
the name of the binary that is created in i386-softmmu/, but that has
never been the working directory for qemu-iotests.

> > Is it still worth supporting a local symlink?
> 
> Not sure who would have one...

I have always been using symlinks in the qemu-iotests directory. And, as
you probably expect now, ./qemu does exist in my setup.

Now, I must admit that I haven't actually made real use of it recently
because the symlinks only point to the binaries that qemu-iotests would
pick up anyway. But when running qemu-iotests against a different qemu
version or installed binaries instead of whatever is in the build tree,
I always found the symlinks more convenient that setting up a bunch of
environment variables.

So maybe supporting them isn't completely useless.

Kevin
