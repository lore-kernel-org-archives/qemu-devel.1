Received: from eggs.gnu.org ([2001:4830:134:3::10]:44637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGRSP-0006q0-07
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGRSL-0003aS-QU
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:52:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dGRSL-0003aC-KD
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:52:09 -0400
Date: Thu, 1 Jun 2017 17:52:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170601175107-mutt-send-email-mst@kernel.org>
References: <20170529151047.85390-1-ben@skyportsystems.com>
	<CAJ+F1C+QFS5YDw7He-p0eEObYbGcq6ra3wwVMVdEu88C0tRqQQ@mail.gmail.com>
	<20170601172020-mutt-send-email-mst@kernel.org>
	<A14BEB28-9F8C-4E37-BCB1-EC7ED7FFB8E6@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A14BEB28-9F8C-4E37-BCB1-EC7ED7FFB8E6@skyportsystems.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: Add unit tests for the VM
 Generation ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, qemu devel list <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On Thu, Jun 01, 2017 at 07:46:24AM -0700, Ben Warren wrote:
>=20
> > On Jun 1, 2017, at 7:21 AM, Michael S. Tsirkin <mst@redhat.com> wrote=
:
> >=20
> > On Thu, Jun 01, 2017 at 08:10:27AM +0000, Marc-Andr=C3=A9 Lureau wrot=
e:
> >> Hi
> >>=20
> >> On Mon, May 29, 2017 at 7:18 PM Ben Warren via Qemu-devel <
> >> qemu-devel@nongnu.org> wrote:
> >>=20
> >>    From: Ben Warren <ben@skyportsystems.com>
> >>=20
> >>    The following tests are implemented:
> >>    * test that a GUID passed in by command line is propagated to the=
 guest.
> >>      Read the GUID from guest memory
> >>    * test that the "auto" argument to the GUID generates a valid GUI=
D, as
> >>      seen by the guest.
> >>    * test that a GUID passed in can be queried from the monitor
> >>=20
> >>      This patch is loosely based on a previous patch from:
> >>      Gal Hammer <ghammer@redhat.com>  and Igor Mammedov <imammedo@re=
dhat.com>
> >>=20
> >>    Signed-off-by: Ben Warren <ben@skyportsystems.com>
> >>    Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> >>    ---
> >=20
> > What happened to indentation here?
> >=20
> I don=E2=80=99t know, this is unchanged from the patch that passed thro=
ugh the gauntlet earlier this year, other than rebasing.  If you can plea=
se clarify exactly what you see that is wrong, that=E2=80=99ll be helpful=
.

That question is directed to Marc-Andr=C3=A9 - when he replied to your pa=
tch
he has corrupted the indentation.

> >>    +             * in order to implement the "OVMF SDT Header probe
> >>    suppressor"
> >>    +             * see docs/specs/vmgenid.txt for more details
> >>    +             */
> >>    +            return vgid_table.vgia_val + VMGENID_GUID_OFFSET;
> >>    +        }
> >>=20
> >>=20
> >> It leaks tables
> >> =20
> >> Other than that:
> >> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >=20
> > Ben, are you going to post a version that doesn't leak?
> Yes, I=E2=80=99ll try to get to it today.
>=20
> =E2=80=94Ben
