Received: from eggs.gnu.org ([2001:4830:134:3::10]:55303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1erQPh-0007Zp-AD
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1erQPg-0004en-CG
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:46:33 -0500
Date: Thu, 1 Mar 2018 15:46:03 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180301154603.GJ2787@redhat.com>
References: <20180301135856.22698-1-rjones@redhat.com>
	<20180301135856.22698-2-rjones@redhat.com>
	<CAMr-obsJtVe9h5CjQ1PkjBdrQhKBRP0RUAA2f3cQ7p_-2MG-EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMr-obsJtVe9h5CjQ1PkjBdrQhKBRP0RUAA2f3cQ7p_-2MG-EA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block: curl: Allow arbitrary HTTP
 request headers to be set.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>
Cc: jcody@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, armbru@redhat.com, mreitz@redhat.com, "derez@redhat.com" <derez@redhat.com>

On Thu, Mar 01, 2018 at 03:24:48PM +0000, Nir Soffer wrote:
> Other issue that you need to consider is that you cannot
> create images via the http. Images are created only via
> engine API/UI.

We've got a separate bit of Python creating the image so I think we're
ok here.

> What ovirt-imageio give you is a way to
> read and write data to existing image. The url you get is
> mostly like an open file descriptor you can use with read()
> and write().

OK.

In fact in my experiment with oVirt 4.2 it *did* work without the
Authorization header, but we believed that was a bug in oVirt, we
didn't know it was designed to do that, thanks for clarifying it.

In any case I'm pretty sure we do need ca.pem (second patch).

> Note that you cannot access yet a chain of image via a url, since
> ovirt generate a random url per image in a chain. For example,
> if you have this chain:
> 
> base-img <- top-image (top)

I think we're OK for what virt-v2v is doing.

Thanks,

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
