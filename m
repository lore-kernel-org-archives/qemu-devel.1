Received: from eggs.gnu.org ([2001:4830:134:3::10]:58618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dHmNd-0005q5-Ty
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 03:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dHmNa-00029F-MX
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 03:24:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1dHmNa-00025S-Fl
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 03:24:46 -0400
Date: Mon, 5 Jun 2017 09:24:38 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170605072438.qvxosyib2vpwl3a7@kamzik.brq.redhat.com>
References: <20170601130325.6433-1-marcandre.lureau@redhat.com>
	<20170601130325.6433-2-marcandre.lureau@redhat.com>
	<465a7b69-a3c0-1492-8e30-c562a76cd65a@redhat.com>
	<0a434f41-1131-713d-1fc9-a9edba425f7a@redhat.com>
	<CAJ+F1CKL6OXetG6Liwf3NrpNv3K8PR6_SQ5=rfjyRwa3pJ7nuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKL6OXetG6Liwf3NrpNv3K8PR6_SQ5=rfjyRwa3pJ7nuA@mail.gmail.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Wen Congyang <wency@cn.fujitsu.com>, anderson@redhat.com, peterx@redhat.com

On Fri, Jun 02, 2017 at 09:46:35AM +0000, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Thu, Jun 1, 2017 at 10:19 PM Eric Blake <eblake@redhat.com> wrote:
>=20
> > On 06/01/2017 01:06 PM, Laszlo Ersek wrote:
> > > On 06/01/17 15:03, Marc-Andr=E9 Lureau wrote:
> > >> One way or another, the guest could communicate various dump info =
(via
> > >> guest agent or vmcoreinfo device) and populate that structure. It =
can
> > >> then be used to augment the dump with various details, as done in =
the
> > >> following patch.
> > >>
> > >> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > >> ---
> > >>  include/sysemu/dump-info.h | 18 ++++++++++++++++++
> > >>  dump.c                     |  3 +++
> > >>  2 files changed, 21 insertions(+)
> > >>  create mode 100644 include/sysemu/dump-info.h
> > >>
> > >> diff --git a/include/sysemu/dump-info.h b/include/sysemu/dump-info=
.h
> > >> new file mode 100644
> > >> index 0000000000..d2378e15e2
> > >> --- /dev/null
> > >> +++ b/include/sysemu/dump-info.h
> > >> @@ -0,0 +1,18 @@
> > >> +#ifndef DUMP_INFO_H
> > >> +#define DUMP_INFO_H
> >
> > >>
> > >
> > > Can you please spell out, in the commit message, the reason for
> > > introducing a new header file? (I suspect your reason, but it shoul=
d be
> > > documented explicitly.)
> >
> > Also, should you have a copyright header in the new file?  And does
> > MAINTAINERS cover it?
> >
>=20
> None of the dump support is covered. Based on commit history, I can sug=
gest
> Wen Congyang, as original author.
> Sadly, Qiao Nuohan cannot be reached with his mail today (anyone knows =
if
> he is still contributing?). Laszlo has done significant changes and rev=
iews
> too. I can also propose myself to help with reviews.
>=20
> Wen or Laszla, do you want to be the main maintainer?

What about Peter Xu (CC'ed)? He'll have to state whether he has time and
interest, but I see he's contributed quite a bit to dump.c.

Thanks,
drew
