Received: from eggs.gnu.org ([209.51.188.92]:53418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2Cdg-0002Kj-3Y
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:22:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1h2Cdf-00005p-7e
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:22:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1h2Cde-0008W7-Va
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:22:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7DE759461
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 10:22:01 +0000 (UTC)
Date: Fri, 8 Mar 2019 10:21:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190308102158.GE12318@stefanha-x1.localdomain>
References: <20190306115532.23025-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline
In-Reply-To: <20190306115532.23025-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/5] iothread: create gcontext
 unconditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 07:55:27PM +0800, Peter Xu wrote:
> v2:
> - add comment in patch 4
> - add another patch to comment why we need explicit aio_poll() in
>   iothread_run loop
>=20
> When I first read the iothread code, the gcontext confused me for
> quite a while.  Meanwhile, I've been tackling with some races due to
> this complexity as well.  How much we'll pay for creating the gcontext
> unconditionally?  Do we really need this flexibitily (or is it really
> a flexibility after all)?  I don't see much gain of existing code, but
> I might be wrong.  Anyway, I wrote this patchset to see how the list
> would think about it.
>=20
> This series directly originates from previous discussion with
> Marc-Andre where there's a slightly hacky way to try to acquire the
> gcontext:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05460.html
>=20
> Now with this series logically above patch is not needed any more.
> Please read patch 4 for more information.
>=20
> And if this patchset can survive... how about running gcontext
> directly in iothread_run()?  I believe there could be a bit more
> things to clean but I'll see.
>=20
> Make check passes for me.
>=20
> Comments welcomed.  Thanks,
>=20
> Peter Xu (5):
>   iothread: replace init_done_cond with a semaphore
>   iothread: create the gcontext unconditionally
>   iothread: create main loop unconditionally
>   iothread: push gcontext earlier in the thread_fn
>   iothread: document about why we need explicit aio_poll()
>=20
>  include/sysemu/iothread.h |  5 +--
>  iothread.c                | 91 +++++++++++++++++++--------------------
>  2 files changed, 46 insertions(+), 50 deletions(-)
>=20
> --=20
> 2.17.1
>=20

I made the comment tweak discussed in this thread.

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgkJGAAoJEJykq7OBq3PIP1YH/RJfKG2siiPbW3g8Kf9tGzOP
O+R4QpVk/iDcyOlxAGckZR5MlQ8+Hal7bH4iRXSlTbqDOPdBjQNiGibESjKYbgRz
bwdIqrgHOB5kh23+nWoZSBKxbhYOz3JWbYA8O0cLJZdiHWr9S8bk+oQZoam1mPKK
ftTLRu0PehSCT/GUD8IMIrNqPik7fejxpeOcXjgu63+jGwbIfN49SvmIoGfMKbdx
xMQs4/DUgoAYAAFl1IVYDT59G7xQCWF7aWOnxLbogdRvk40hnOKo8v6mOEsXyRzJ
wCmObnWGi3ZHy7JrvBY21e8v0Plm2v3CPrtqWcpYKiQW1xhzMb2Y8gyXLw8LIX0=
=WTyv
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--
