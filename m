Received: from eggs.gnu.org ([2001:4830:134:3::10]:45854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fNeNC-0006ki-Ey
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fNeN8-0004P6-Fk
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:09:10 -0400
Date: Tue, 29 May 2018 07:09:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180529070900.29a95fb7@w520.home>
In-Reply-To: <3602923c-42ad-750f-aced-ed758441d501@redhat.com>
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-2-f4bug@amsat.org>
	<20180528174805.7a56a4b8@w520.home>
	<20180529030540-mutt-send-email-mst@kernel.org>
	<ba9292ae-5bf3-54af-fefc-66336f83afd6@amsat.org>
	<20180529115312.5fb8ad16.cohuck@redhat.com>
	<3602923c-42ad-750f-aced-ed758441d501@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/21] vfio: Include
 "exec/address-spaces.h" directly in the source file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?= =?UTF-8?B?w6k=?= <f4bug@amsat.org>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "open list:S390" <qemu-s390x@nongnu.org>

On Tue, 29 May 2018 12:45:28 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 29/05/2018 11:53, Cornelia Huck wrote:
> > On Mon, 28 May 2018 21:36:31 -0300
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >  =20
> >> On 05/28/2018 09:06 PM, Michael S. Tsirkin wrote: =20
> >>> On Mon, May 28, 2018 at 05:48:05PM -0600, Alex Williamson wrote:   =20
> >>>> On Mon, 28 May 2018 20:26:59 -0300
> >>>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >>>>
> >>>> -ENOCOMMITLOG   =20
> >>
> >> Oops sorry Alex, I meant to add some, but missed this while rebasing.
> >> =20
> >>>> Why?  Tangible benefit.  Looks like noise.  Thanks,
> >>>>   =20
> >>> I agree it should have a commit log, but .c files
> >>> should be self-sufficient not rely on .h files
> >>> pulling in headers for symbols the .h does not use
> >>> itself.   =20
> >>
> >> I meant:
> >>
> >>   No declaration of "hw/vfio/vfio-common.h" directly requires to inclu=
de
> >>   the "exec/address-spaces.h" header.  To simplify dependencies and
> >>   ease following cleanup of "exec/address-spaces.h", directly include
> >>   it in the source file where the declaration are used.
> >> =20
> >>> This is better because it makes refactoring easier.
> >>>    =20
> >>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>>>> ---
> >>>>>  include/hw/vfio/vfio-common.h | 1 -
> >>>>>  hw/vfio/ccw.c                 | 1 +
> >>>>>  hw/vfio/platform.c            | 1 +
> >>>>>  3 files changed, 2 insertions(+), 1 deletion(-) =20
> >=20
> > With the description added:
> >=20
> > Acked-by: Cornelia Huck <cohuck@redhat.com>
> >  =20
>=20
> Alex, is the description okay with you too?

Yes, if someone wants to roll this on on commit,

Acked-by: Alex Williamson <alex.williamson@redhat.com>
