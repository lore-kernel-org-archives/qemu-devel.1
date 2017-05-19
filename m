Received: from eggs.gnu.org ([2001:4830:134:3::10]:56875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1dBi30-0000n9-Ea
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voipio@kos.to>) id 1dBi2x-0000jb-CU
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:34:26 -0400
Received: from jessie.kos.to ([212.47.231.226]:40382 helo=pilvi.kos.to)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <voipio@kos.to>) id 1dBi2x-0000jX-6c
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:34:23 -0400
Date: Fri, 19 May 2017 13:34:17 +0000
From: Riku Voipio <riku.voipio@iki.fi>
Message-ID: <20170519133417.GA18402@kos.to>
References: <20170301093748.28033-1-laurent@vivier.eu>
	<260f8cca-719e-dc31-12cf-507e01270c53@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <260f8cca-719e-dc31-12cf-507e01270c53@vivier.eu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user: fix eventfd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org

On Tue, Apr 25, 2017 at 06:32:30PM +0200, Laurent Vivier wrote:
> Ping?

Applied, thanks.=20

> Laurent
>=20
> Le 01/03/2017 =C3=A0 10:37, Laurent Vivier a =C3=A9crit :
> > This patch series byte-swap the uint64_t data stream
> > of a file-descriptor opened with eventfd().
> >=20
> > It allows to pass more LTP test cases:
> >=20
> > eventfd01    1  TPASS  :  counter value matches required
> > eventfd01    2  TPASS  :  read failed with EAGAIN as expected
> > eventfd01    3  TPASS  :  counter value matches required
> > eventfd01    4  TPASS  :  write failed with EAGAIN as expected
> > eventfd01    5  TPASS  :  read failed with EINVAL as expected
> > eventfd01    6  TPASS  :  write failed with EINVAL as expected
> > eventfd01    7  TPASS  :  write failed with EINVAL as expected
> > eventfd01    8  TPASS  :  fd is set in readfds
> > eventfd01    9  TPASS  :  fd is not set in readfds
> > eventfd01   10  TPASS  :  fd is set in writefds
> > eventfd01   11  TPASS  :  fd is not set in writefds
> > eventfd01    1  TPASS  :  counter value matches required
> > eventfd01    2  TPASS  :  read failed with EAGAIN as expected
> > eventfd01    3  TPASS  :  counter value matches required
> > eventfd01    4  TPASS  :  write failed with EAGAIN as expected
> > eventfd01    5  TPASS  :  read failed with EINVAL as expected
> > eventfd01    6  TPASS  :  write failed with EINVAL as expected
> > eventfd01    7  TPASS  :  write failed with EINVAL as expected
> > eventfd01    8  TPASS  :  fd is set in readfds
> > eventfd01    9  TPASS  :  fd is not set in readfds
> > eventfd01   10  TPASS  :  fd is set in writefds
> > eventfd01   11  TPASS  :  fd is not set in writefds
> > eventfd01   12  TPASS  :  counter value write from child successful
> > eventfd01   13  TCONF  :  eventfd01.c:642: eventfd support is not ava=
ilable in AIO subsystem
> > eventfd01   14  TCONF  :  eventfd01.c:647: eventfd support is not ava=
ilable in AIO subsystem
> > eventfd01   15  TCONF  :  eventfd01.c:652: eventfd support is not ava=
ilable in AIO subsystem
> >=20
> > Laurent Vivier (2):
> >   linux-user: call fd_trans_target_to_host_data() for write()
> >   linux-user: fix eventfd
> >=20
> >  linux-user/syscall.c | 38 +++++++++++++++++++++++++++++++++++---
> >  1 file changed, 35 insertions(+), 3 deletions(-)
> >=20
>=20
