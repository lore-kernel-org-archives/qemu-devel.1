Received: from eggs.gnu.org ([2001:4830:134:3::10]:48144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dI3ya-00027R-Ii
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:12:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dI3yX-0001To-6o
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:12:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dI3yW-0001So-To
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:12:05 -0400
Date: Tue, 6 Jun 2017 10:11:56 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170606021156.GL4056@pxdev.xzpeter.org>
References: <20170601130325.6433-1-marcandre.lureau@redhat.com>
	<20170601130325.6433-2-marcandre.lureau@redhat.com>
	<465a7b69-a3c0-1492-8e30-c562a76cd65a@redhat.com>
	<0a434f41-1131-713d-1fc9-a9edba425f7a@redhat.com>
	<CAJ+F1CKL6OXetG6Liwf3NrpNv3K8PR6_SQ5=rfjyRwa3pJ7nuA@mail.gmail.com>
	<20170605072438.qvxosyib2vpwl3a7@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170605072438.qvxosyib2vpwl3a7@kamzik.brq.redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] dump: add DumpInfo structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Wen Congyang <wency@cn.fujitsu.com>, anderson@redhat.com

On Mon, Jun 05, 2017 at 09:24:38AM +0200, Andrew Jones wrote:
> On Fri, Jun 02, 2017 at 09:46:35AM +0000, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >=20
> > On Thu, Jun 1, 2017 at 10:19 PM Eric Blake <eblake@redhat.com> wrote:
> >=20
> > > On 06/01/2017 01:06 PM, Laszlo Ersek wrote:
> > > > On 06/01/17 15:03, Marc-Andr=C3=A9 Lureau wrote:
> > > >> One way or another, the guest could communicate various dump inf=
o (via
> > > >> guest agent or vmcoreinfo device) and populate that structure. I=
t can
> > > >> then be used to augment the dump with various details, as done i=
n the
> > > >> following patch.
> > > >>
> > > >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.c=
om>
> > > >> ---
> > > >>  include/sysemu/dump-info.h | 18 ++++++++++++++++++
> > > >>  dump.c                     |  3 +++
> > > >>  2 files changed, 21 insertions(+)
> > > >>  create mode 100644 include/sysemu/dump-info.h
> > > >>
> > > >> diff --git a/include/sysemu/dump-info.h b/include/sysemu/dump-in=
fo.h
> > > >> new file mode 100644
> > > >> index 0000000000..d2378e15e2
> > > >> --- /dev/null
> > > >> +++ b/include/sysemu/dump-info.h
> > > >> @@ -0,0 +1,18 @@
> > > >> +#ifndef DUMP_INFO_H
> > > >> +#define DUMP_INFO_H
> > >
> > > >>
> > > >
> > > > Can you please spell out, in the commit message, the reason for
> > > > introducing a new header file? (I suspect your reason, but it sho=
uld be
> > > > documented explicitly.)
> > >
> > > Also, should you have a copyright header in the new file?  And does
> > > MAINTAINERS cover it?
> > >
> >=20
> > None of the dump support is covered. Based on commit history, I can s=
uggest
> > Wen Congyang, as original author.
> > Sadly, Qiao Nuohan cannot be reached with his mail today (anyone know=
s if
> > he is still contributing?). Laszlo has done significant changes and r=
eviews
> > too. I can also propose myself to help with reviews.
> >=20
> > Wen or Laszla, do you want to be the main maintainer?
>=20
> What about Peter Xu (CC'ed)? He'll have to state whether he has time an=
d
> interest, but I see he's contributed quite a bit to dump.c.

I believe those were the first commits of mine when working on
detached dump, after that I didn't really work on it anymore. So I
guess I may not be the best candidate.

Also, I admit my bandwidth is limited as well recently. Thanks Drew
for mentioning me anyway. :-)

--=20
Peter Xu
