Received: from eggs.gnu.org ([2001:4830:134:3::10]:36048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT77t-0001xu-TC
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:15:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cT77p-0004Sh-U4
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:15:09 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cT77p-0004SR-NJ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 08:15:05 -0500
Received: by mail-wm0-x241.google.com with SMTP id d140so14350389wmd.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 05:15:05 -0800 (PST)
Date: Mon, 16 Jan 2017 13:15:00 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170116131500.GA14681@stefanha-x1.localdomain>
References: <CA+scX6=rRiGHsOj8oxjTe4KqEF7S_GUao3k=TUQeE7FpyT_K8w@mail.gmail.com>
	<20170103155047.GE14707@stefanha-x1.localdomain>
	<CA+scX6mCDjnZdEMemuDerPxR2L4w12PyyvH==tW_PdW6Kqe7+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <CA+scX6mCDjnZdEMemuDerPxR2L4w12PyyvH==tW_PdW6Kqe7+A@mail.gmail.com>
Subject: Re: [Qemu-devel] Performance about x-data-plane
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Weiwei Jia <harrynjit@gmail.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, libvir-list <libvir-list@redhat.com>, krister@redhat.com


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2017 at 12:02:14PM -0500, Weiwei Jia wrote:
> > The expensive part is the virtqueue kick.  Recently we tried polling the
> > virtqueue instead of waiting for the ioeventfd file descriptor and got
> > double-digit performance improvements:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00148.html
> >
> > If you want to understand the performance of your benchmark you'll have
> > compare host/guest disk stats (e.g. request lifetime, disk utilization,
> > queue depth, average request size) to check that the bare metal and
> > guest workloads are really sending comparable I/O patterns to the
> > physical disk.
> >
> > Then you using Linux and/or QEMU tracing to analyze the request latency
> > by looking at interesting points in the request lifecycle like virtqueue
> > kick, host Linux AIO io_submit(2), etc.
> >
>=20
> Thank you. I will look into "polling the virtqueue" as you said above.
> Currently, I just use blktrace to see disk stats and add logs in the
> I/O workload to see the time latency for each request. What kind of
> tools are you using to analyze request lifecycle like virtqueue kick,
> host Linux AIO iosubmit, etc.
>=20
> Do you trace the lifecycle like this
> (http://www.linux-kvm.org/page/Virtio/Block/Latency#Performance_data)
> but it seems to be out of date. Does it
> (http://repo.or.cz/qemu-kvm/stefanha.git/shortlog/refs/heads/tracing-dev-=
0.12.4)
> still work on QEMU 2.4.1?

The details are out of date but the general approach to tracing the I/O
request lifecycle still apply.

There are multiple tracing tools that can do what you need.  I've CCed
Karl Rister who did the latest virtio-blk dataplane tracing.

"perf record -a -e kvm:\*" is a good start.  You can use "perf probe" to
trace QEMU's trace events (recent versions have sdt support, which means
SystemTap tracepoints work) and also trace any function in QEMU:
http://blog.vmsplice.net/2011/03/how-to-use-perf-probe.html

Stefan

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYfMdUAAoJEJykq7OBq3PIJPEH/RSqNmURS5asAKUENdhE6w4s
hko2SVeJXlUU0M6wO7KpY8B/g1Y8AteyL9tElGeR8BfvzsRFlPjIAEOo9x8y2Hr1
oug9kZW+nLkdFyt4fBo7ZXpDntndWgDgcLpcY1zV6d5MP5UGuTpzxDhqCw7oum1L
0lRQg/bAML1/DkHN8kYxZj/FJgZJvOBOll9RKW70wKCHq923fMfKK+b6HMvb2OAL
MhjSOurb8UmpgoqgaP11HYUZz8PPS/AEW3BWnQ9EKxanTOc0myBftIlqfDubq6cW
DFDb5RkPnxGFPdJxLwfRVfW11ptXY38t7tRiz6yp94zpbAUeZQ4qAMLhqLY5IW0=
=tFSX
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
