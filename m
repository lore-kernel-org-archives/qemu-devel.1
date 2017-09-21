Received: from eggs.gnu.org ([2001:4830:134:3::10]:56137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duszY-00067v-Ta
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 00:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duszV-0007m2-Ot
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 00:21:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duszV-0007lO-JD
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 00:21:33 -0400
Date: Thu, 21 Sep 2017 12:21:24 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170921042124.GE30661@pxdev.xzpeter.org>
References: <20170920104639.2335-1-quintela@redhat.com>
	<87o9q5k348.fsf@secure.laptop>
	<CAFEAcA_t3iBPr862YAv_Hp=_mESoqLJ07QFKp6QwKJ8P=tS+1Q@mail.gmail.com>
	<20170921041039.GD30661@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170921041039.GD30661@pxdev.xzpeter.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/16] Migration PULL request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Sep 21, 2017 at 12:10:39PM +0800, Peter Xu wrote:
> On Wed, Sep 20, 2017 at 08:32:46PM +0100, Peter Maydell wrote:
> > On 20 September 2017 at 12:42, Juan Quintela <quintela@redhat.com> wr=
ote:
> > > Juan Quintela <quintela@redhat.com> wrote:
> > >> Hi
> > >>
> > >> To make merges easier, this includes:
> > >> - Peter Xu reviewed patches from Postocpy recovery (3)
> > >> - Alexey reviewed pages from block postcopy (4)
> > >
> > > I meaned here to include Vladimir series.  This is incomplete.
> > >
> > > Nacked myself.
> >=20
> > It also fails to build on ppc64 and s390x (so probably
> > all bigendian hosts):
> >=20
> > /home/pm215/qemu/util/bitmap.c: In function =E2=80=98bitmap_to_from_l=
e=E2=80=99:
> > /home/pm215/qemu/util/bitmap.c:383:6: error: "__WORD_SIZE" is not
> > defined [-Werror=3Dundef]
> >  # if __WORD_SIZE =3D=3D 64
> >       ^
>=20
> I'll look into this.  Thanks,

Oops... I think it should be __WORDSIZE (no "_" between "WORD" and
"SIZE").  Sorry.

Juan, do you want me to repost or you'd like to fix it directly?

--=20
Peter Xu
