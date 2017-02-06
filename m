Received: from eggs.gnu.org ([2001:4830:134:3::10]:57034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1camAW-0007ua-Iu
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:29:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1camAS-0003GI-1f
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:29:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1camAR-0003Ef-TB
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:29:28 -0500
Date: Mon, 6 Feb 2017 16:29:24 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20170206162924.GF15182@redhat.com>
References: <20170204100317.32425-1-rjones@redhat.com>
	<20170204100317.32425-2-rjones@redhat.com>
	<ec715a97-ad0e-b8e9-3db7-0bd50a1b7060@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec715a97-ad0e-b8e9-3db7-0bd50a1b7060@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, den@openvz.org, rkagan@virtuozzo.com, dplotnikov@virtuozzo.com, berrange@redhat.com, stefanha@gmail.com, armbru@redhat.com

On Mon, Feb 06, 2017 at 05:10:13PM +0100, Paolo Bonzini wrote:
> Queued, thanks.

Could you change this comment s/!_WIN32/_WIN32/, or do you
want me to submit another patch?

> > +#else /* !_WIN32 */
> > +static unsigned int check_socket_activation(void)
> > +{
> > +    return 0;
> > +}
> > +#endif
> > +

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
