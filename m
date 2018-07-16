Received: from eggs.gnu.org ([2001:4830:134:3::10]:46059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <victortoso@redhat.com>) id 1ff1Ez-0006Km-G2
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <victortoso@redhat.com>) id 1ff1Eu-0007Zl-W0
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:00:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <victortoso@redhat.com>)
	id 1ff1Eu-0007Z7-PK
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:00:24 -0400
Date: Mon, 16 Jul 2018 13:00:17 +0200
From: Victor Toso <victortoso@redhat.com>
Message-ID: <20180716110017.5ydbphj4csrjedla@wingsuit>
References: <20180712121243.bl722zui72mycxlr@wingsuit>
	<20180712155056.d7vyxjkueskkni2q@wingsuit>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="27gubq7yvo6n75sk"
Content-Disposition: inline
In-Reply-To: <20180712155056.d7vyxjkueskkni2q@wingsuit>
Subject: Re: [Qemu-devel] [Spice-devel] Ongoing migration: gitlab.com/spice
 -> gitlab.freedesktop.org/spice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: spice-devel@lists.freedesktop.org
Cc: devel@ovirt.org, qemu-devel@nongnu.org, virt-tools-list@redhat.com


--27gubq7yvo6n75sk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 12, 2018 at 05:50:56PM +0200, Victor Toso wrote:
> Hi,
>=20
> JFYI, CC'ing:
>=20
> * qemu-devel
> * virt-tools-list
> * devel@ovirt.org
>=20
> If nobody complains, I'll finish whatever is pending next Monday
> morning (GMT+2).

Migration is done. All Spice related components can be seen at
https://gitlab.freedesktop.org/spice.

A read-only mirror is being kept at https://gitlab.com/spice.

Cheers,
        toso

>=20
> Cheers,
>         toso
>=20
> On Thu, Jul 12, 2018 at 02:12:43PM +0200, Victor Toso wrote:
> > Hi,
> >=20
> > The official repository for Spice components should stay in
> > gitlab.freedesktop.org/spice - As suggested in the previous
> > thread [0], instead of closing gitlab.com/spice we can keep it
> > read-only mirror from Freedesktop's gitlab instance.
> >=20
> > [0] https://lists.freedesktop.org/archives/spice-devel/2018-July/044664=
=2Ehtml
> >=20
> > Please, read the email below to see what's going on :)
> >=20
> > At this moment, I've only changed components that were already a
> > mirror of gitlab.freedesktop.org, the first part of this email is
> > about the projects that are not a mirror.
> >=20
> > This email's intent is to inform, discuss and give some time to
> > let contributors know about the change. People CC'ed are to be
> > affected.
> >=20
> > [*] Components to be created in gitlab.freedesktop.org/spice and
> >     mirrored from there.
> >=20
> > * https://gitlab.com/spice/x11spice
> > * https://gitlab.com/spice/spice-space
> > * https://gitlab.com/spice/spice-space-pages
> > * https://gitlab.com/spice/spice-streaming-agent
> >=20
> > * https://gitlab.com/spice/virtio-gpu-wddm/virtio-gpu-wddm-dod
> > - Taking the opportunity, should we move this under win32
> >   subgroup or create the virtio-gpu-wddm subgroup once more?
> > - Migrate issue #1
> >=20
> > * https://gitlab.com/spice/qxl-wddm-dod
> > - Update and mirror from https://gitlab.freedesktop.org/spice/win32/qxl=
-wddm-dod
> > - The mirrored in gitlab will also be moved into win32 subgroup
> >=20
> > * https://gitlab.com/spice/spice-nsis
> > - Update and mirror from https://gitlab.freedesktop.org/spice/spice-nsis
> > - Should we also include under win32 subgroup or stay outside?
> >=20
> > [*] Components I'm ignoring on this mirroring due too old or
> >     untouched or unrelated (qemu?) code
> >=20
> > * win32/usbclerk
> > * win32/vdi_port
> > * qemu=20
> > * slirp
> > * spicec
> > * vdesktop
> >=20
> >=20
> > [*] Components that are already mirrored, some updates around
> >     them below:
> >=20
> > * The mirrored components will be always overwritten when
> >   branches diverge, please don't push to gitlab.com - about
> >   read-only option:
> >   - https://gitlab.com/gitlab-org/gitlab-ce/issues/40891
> >=20
> > * Added common description: "Read only repository, mirror from
> >   Freedesktop's instance of Gitlab"
> >=20
> > * General permissions
> >  - Visibility: Public
> >  - Issues, Merge request, Wiki, etc: Disabled
> >=20
> > No problems seen:
> > * spice [ https://gitlab.com/spice/spice ]
> > * spice-protocol [ https://gitlab.com/spice/spice-protocol ]
> > * spice-common [ https://gitlab.com/spice/spice-common ]
> > * usbredir [ https://gitlab.com/spice/usbredir ]
> > * spice-jhbuild [ https://gitlab.com/spice/spice-jhbuild ]
> > * spice-html5 [ https://gitlab.com/spice/spice-html5 ]
> > * libcacard [ https://gitlab.com/spice/libcacard ]
> >=20
> > Small problem but fixed:
> > * Spice-gtk [ https://gitlab.com/spice/spice-gtk ]
> >   - I had to delete and mirror again due some ongoing failure to
> >     pull from freedesktop.org
> >=20
> > * linux/vd_agent [ https://gitlab.com/spice/linux/vd_agent ]
> >   - I had to create the linux subgroup and clone a new instance
> >   - removed spice/vdagent one (previous)
> >=20
> > * win32/vd_agent [ https://gitlab.com/spice/win32/vd_agent ]
> >   - I had to create the win32 subgroup and clone a new instance
> >   - removed spice/vdagent-win (previous)
> >=20
> > * win32/usbdk [ https://gitlab.com/spice/win32/usbdk ]
> >   - Moved to win32 subgroup (delete + clone again)
> >   - removed spice/usbdk (previous)
> >=20
> > * win32/qxl [ https://gitlab.com/spice/win32/qxl ]
> >   - Moved to win32 subgroup (delete + clone again)
> >   - removed spice/qxl-win (previous)
> >=20
> > I hope all is good to have everything migrated early next week :)
> > PS: Let me know if I forgot something.
> >=20
> > Cheers,
> >         toso
>=20
>=20
>=20
> > _______________________________________________
> > Spice-devel mailing list
> > Spice-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/spice-devel
>=20



> _______________________________________________
> Spice-devel mailing list
> Spice-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/spice-devel


--27gubq7yvo6n75sk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEIG07NS9WbzsOZXLpl9kSPeN6SE8FAltMesAACgkQl9kSPeN6
SE869BAAk53OMr/pHuzXQhQ3/eK+h4QFtIOxM2k8UmYfpi/ykuf+6Zs+CqndKLKz
alGHcpSv6qTiuCnclF/K9nvDbGh1Ysb4WvzrDpjwlO2oTBb1t2YtBipf1Tg6g2tm
bQwKDfgF8N8GFOOTMLXS39iH8chWczCQiSNMuAl+myc81CvImBv7DL+K9ochkLga
3rBNXSaQyfUJm7FCJ6chCg5dIa8ROziZImT4XeBRXWQGQRnZ+ynrFjqbn4CgO0oN
xIPgiEc4PwRTJdCiJXu67xod+XE173YDVsOrnNNPZiShX0JLN1MdPzLXfh9dzkgG
YmaxdkV6ryOt8YJhAqC6h9ZO4vNLhBLQNQcrK7XknVS6+CMxTtcTj+Z+hGaqTcez
cBdKi6GPRb2AkeISLEaa827JMwYS+NDwVoEb+6OyJTSPd7hQyDCuKKOVL7RXUCof
Tu5uQD+6+iJgQ0CFwXvgpeKuG08ZL80DZyMQ5bFF0xKWwrkYsiUHm8jkUFix4u3Y
ykWWnpwlhbBsT3ZiqZ7TjapWvuMF0y3LkrANpVZe6VOqslJB2LMjJN0rFV0VQ/UQ
HXcWsvxBXXnYo1y2rbJPl/E3O3Pq8YX1oYl8gZRCJtcIxHUPrNtTmqrQmf11XY/n
bDfZOiZdVog2WV64xv1FA/S8E2kCZFuB696fmU/hsgLnx0BU5SI=
=KJJ+
-----END PGP SIGNATURE-----

--27gubq7yvo6n75sk--
