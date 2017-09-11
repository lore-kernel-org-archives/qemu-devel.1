Received: from eggs.gnu.org ([2001:4830:134:3::10]:41764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drJ9p-0007fL-DN
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drJ9m-0004ds-Am
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:29:25 -0400
Date: Mon, 11 Sep 2017 09:29:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170911092911.27e0886e.cohuck@redhat.com>
In-Reply-To: <9058bb80-4e5c-3316-576f-1c21924a8a07@redhat.com>
References: <1504100343-26607-1-git-send-email-thuth@redhat.com>
	<b98a4c56-f386-f827-5aa7-9a00e6fdf790@amsat.org>
	<CAFEAcA8O5T5cX8XqBVZqXLt5MPvF7qEcJK8Az2GBei07P0dZGQ@mail.gmail.com>
	<20170910032413.GB2735@umbus.fritz.box>
	<9058bb80-4e5c-3316-576f-1c21924a8a07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/misc/ivshmem: Fix
 ivshmem_recv_msg() to also work on big endian systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>

On Mon, 11 Sep 2017 04:35:08 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 10.09.2017 05:24, David Gibson wrote:
> > On Wed, Aug 30, 2017 at 03:59:07PM +0100, Peter Maydell wrote: =20
> >> On 30 August 2017 at 15:53, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote: =20
> >>> On 08/30/2017 10:39 AM, Thomas Huth wrote: =20
> >>>> The problem is that the server side code in ivshmem_server_send_one_=
msg()
> >>>> correctly translates all messages IDs into little endian 64-bit valu=
es,
> >>>> but the client side code in the ivshmem_recv_msg() function does not=
 swap
> >>>> the byte order back. Fix it by passing the value through le64_to_cpu=
(). =20
> >>>
> >>>
> >>> Yes, we lack BE testing :( =20
> >>
> >> My pre-pull-request test set includes s390 and ppc64 bigendian.
> >> This one was just missed because the 'slow' tests aren't in
> >> 'make check'. =20
> >=20
> > I'm not what makes sense for staging this fix.  I could take it
> > through my tree, but it's not an obvious match, since this isn't
> > really related to ppc at all. =20
>=20
> There does not seem to be maintainer for ivshmem, as far as I can see,
> so I'd say any tree that is distantly related is fine. So I think you
> could either take it through your ppc tree (since the bug affects big
> endian ppc machines), or maybe Cornelia could take it through the s390x
> tree (since we've seen the problem on the big endian s390x machines,
> too). Otherwise I have to wait and see whether it goes through misc or
> trivial, I guess...

I'll queue it; and whoever sends the first pull request, 'wins' :)
