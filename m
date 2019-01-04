Received: from eggs.gnu.org ([208.118.235.92]:50819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gfS9H-0001SJ-UB
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gfS9D-00012X-0A
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:16:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gfS9C-00011U-LX
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:16:34 -0500
Date: Fri, 4 Jan 2019 14:16:31 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190104161631.GG4157@habkost.net>
References: <20181221090410.27250-1-marcandre.lureau@redhat.com>
	<CAJ+F1CKwA3hL4xA5De8VEqaOXqgN5LNouxj727q4WVaTUUt3Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKwA3hL4xA5De8VEqaOXqgN5LNouxj727q4WVaTUUt3Gg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 00/28] Generalize machine compatibility
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>

On Fri, Jan 04, 2019 at 03:42:08PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Fri, Dec 21, 2018 at 1:04 PM Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Hi,
> >
> > During "[PATCH v2 05/10] qom/globals: generalize
> > object_property_set_globals()" review, Eduardo suggested to rework th=
e
> > GlobalProperty handling, so that -global is limited to QDev only and
> > we avoid mixing the machine compats and the user-provided -global
> > properties (instead of generalizing -global to various object kinds,
> > like I proposed in v2).
> >
> > "qdev: do not mix compat props with global props" patch decouples a
> > bit user-provided -global from machine compat properties. This allows
> > to get rid of "user_provided" and "errp" fields in following patches.
> >
> > A new compat property "x-use-canonical-path-for-ramblock-id" is added
> > to hostmem for legacy canonical path names, set to true for -file and
> > -memfd with qemu < 4.0.
> >
> > (this series was initially titled "[PATCH v2 00/10] hostmem: use
> > object "id" for memory region name with >=3D 3.1", but its focus is m=
ore
> > in refactoring the global and compatilibity properties handling now)
> >
>=20
> Beside the rebase conflicts, and added comment in patch 25, all
> patches have been reviewed-by. I have pushed the rebased version on
> github: https://github.com/elmarco/qemu/tree/props
>=20
> Eduardo, Igor, who is making the pullreq? I could also send it, if you =
are okay.

I was planning to merge this next week, but if you are willing to
send the pull request, that's even better.  Thanks!

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
