Received: from eggs.gnu.org ([2001:4830:134:3::10]:47607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds2Yn-00036v-NH
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds2Yj-0007cG-5j
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:58:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ds2Yi-0007bO-Ul
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:58:09 -0400
Date: Wed, 13 Sep 2017 09:58:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913095804.4871ffc9.cohuck@redhat.com>
In-Reply-To: <CAJ+F1CLYrsOXO74nV4zpKffJgMkSPmBi84ARs22EJGAe0xTC0A@mail.gmail.com>
References: <20170911132627.9505-1-cohuck@redhat.com>
	<20170912033333.GA29091@pxdev.xzpeter.org>
	<CAJ+F1CLYrsOXO74nV4zpKffJgMkSPmBi84ARs22EJGAe0xTC0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] dump: do not dump non-existent guest memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, 12 Sep 2017 12:17:51 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi Peter
>=20
> On Tue, Sep 12, 2017 at 5:33 AM, Peter Xu <peterx@redhat.com> wrote:
> > On Mon, Sep 11, 2017 at 03:26:27PM +0200, Cornelia Huck wrote: =20
> >> It does not really make sense to dump memory that is not there.
> >>
> >> Moreover, that fixes a segmentation fault when calling dump-guest-memo=
ry
> >> with no filter for a machine with no memory defined.
> >>
> >> New behaviour is:
> >>
> >> (qemu) dump-guest-memory /dev/null
> >> dump: no guest memory to dump
> >> (qemu) dump-guest-memory /dev/null 0 4096
> >> dump: no guest memory to dump
> >>
> >> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >> ---
> >>
> >> Another unmaintained file. Joy. cc:ing some more-or-less random folks.=
 =20
> >
> > I thought Marc-Andr=C3=A9 had proposed to be the maintainer? But indeed=
 I
> > didn't see the line in maintainer file.
> >
> > Anyway, if anyone think I am ok to maintain this single file
> > (considering that I haven't posted patches on it for 2 years, and I
> > haven't been working on any kind of maintainer job), please let me
> > know. I'm glad to start with it (or with Marc-Andr=C3=A9).
> > =20
>=20
> That would be great!
> thanks

Now on to the most important question: Will you merge this patch? :)

(It should probably go together with "tests/hmp: test "none" machine
with memory".)
