Received: from eggs.gnu.org ([2001:4830:134:3::10]:41621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dTQrV-0007sJ-Lt
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dTQrR-0004mF-89
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:51:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dTQrR-0004lU-1H
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:51:45 -0400
Date: Fri, 7 Jul 2017 11:51:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170707105132.GD2101@work-vm>
References: <20170628190047.26159-1-dgilbert@redhat.com>
	<20170629185525.GC2399@work-vm>
	<CAJ+F1CKEEaRTfNiGU3cDYedqRYD9a+teG7t-F1YhGte3J-EbfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKEEaRTfNiGU3cDYedqRYD9a+teG7t-F1YhGte3J-EbfA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 00/29] postcopy+vhost-user/shared ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, a.perevalov@samsung.com, maxime.coquelin@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, aarcange@redhat.com

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Thu, Jun 29, 2017 at 8:56 PM Dr. David Alan Gilbert <dgilbert@redhat=
.com>
> wrote:
>=20
> > * Dr. David Alan Gilbert (git) (dgilbert@redhat.com) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >
> > > Hi,
> > >   This is a RFC/WIP series that enables postcopy migration
> > > with shared memory to a vhost-user process.
> > > It's based off current-head + Juan's load_cleanup series, and
> > > Alexey's bitmap series (v4).  It's very lightly tested and seems
> > > to work, but it's quite rough.
> >
> > Marc-Andr=E9 asked if I had a git with it all applied; so here we are=
:
> > https://github.com/dagrh/qemu/commits/vhost
> > git@github.com:dagrh/qemu.git on the vhost branch
> >
> >
> I started looking at the series, but I am not familiar with ufd/postcop=
y.
> Could you update vhost-user.txt to describe the new messages? Otherwise=
,
> make check hangs in /x86_64/vhost-user/connect-fail (might be an unrela=
ted
> regression?) Thanks

OK, figured that one out;  it was a cleanup path for the postcopy
notifier trying to remove the notifier when because we were testing a
failure path the notifier hadn't been added in the first place.

(That was really nasty to find, for some reason those tests refuse to
generate core dumps; I ended up with a while loop doing gdb --pid
$(pgrep....) to nail the qemu that was about to seg)

Dave

> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
