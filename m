Received: from eggs.gnu.org ([2001:4830:134:3::10]:33492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eZ0G2-0003MA-Kh
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eZ0Fz-0007EC-TG
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:12:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eZ0Fz-0007Da-MX
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 15:12:23 -0500
Date: Tue, 9 Jan 2018 18:12:18 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180109201218.GF18022@localhost.localdomain>
References: <20171023141815.17709-1-marcandre.lureau@redhat.com>
	<CAJ+F1CJOkEJMizL3EAVVyW16L5ucW2gU+4U2BKHw7OFzfOpWag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJOkEJMizL3EAVVyW16L5ucW2gU+4U2BKHw7OFzfOpWag@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 0/9] Add memfd memory backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

On Fri, Dec 22, 2017 at 07:48:43PM +0100, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Mon, Oct 23, 2017 at 4:18 PM, Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> > Add a new Linux-specific memory backend, similar to hostmem-file,
> > except that it doesn't need file path. It also try to enforce memory
> > sealing if available. It is thus slightly easier and secure, and is
> > compatible with transparent huge-pages since Linux 4.8.
> >
> > Since Linux 4.14, memfd supports explicit hugetlb, however without
> > sealing.
>=20
> A little update here, 4.16 is likely to support sealing with hugetlb
> too (patches are in -mm tree). This should make memfd the prefered
> backend for sharing memory with a vhost-user backend.
>=20
> please review.
> thanks

I've queued patches 1-2 on machine-next.  I plan to review the
rest soon.  Sorry for the long delay.

--=20
Eduardo
