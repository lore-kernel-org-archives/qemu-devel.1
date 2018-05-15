Received: from eggs.gnu.org ([2001:4830:134:3::10]:43938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIaqq-0008TV-Tx
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fIaqm-0003Zb-T3
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:22:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fIaqm-0003ZT-Od
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:22:48 -0400
Date: Tue, 15 May 2018 16:22:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180515162246.6fd3616e@redhat.com>
In-Reply-To: <7dd6b2d6-73f8-706e-9083-884ce478d784@vivier.eu>
References: <1526383058-49501-1-git-send-email-imammedo@redhat.com>
	<7dd6b2d6-73f8-706e-9083-884ce478d784@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: update comments to point to
 cpu_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, riku.voipio@iki.fi

On Tue, 15 May 2018 13:32:33 +0200
Laurent Vivier <laurent@vivier.eu> wrote:

> Le 15/05/2018 =C3=A0 13:17, Igor Mammedov a =C3=A9crit=C2=A0:
> > cpu_init() was replaced by cpu_create() since 2.12 but comments
> > weren't updated. So update stale comments now.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  bsd-user/main.c   | 2 +-
> >  linux-user/main.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/bsd-user/main.c b/bsd-user/main.c
> > index 283dc6f..a6ef4a7 100644
> > --- a/bsd-user/main.c
> > +++ b/bsd-user/main.c
> > @@ -917,7 +917,7 @@ int main(int argc, char **argv)
> >      envlist_free(envlist);
> > =20
> >      /*
> > -     * Now that page sizes are configured in cpu_init() we can do
> > +     * Now that page sizes are configured in cpu_create() we can do
> >       * proper page alignment for guest_base.
> >       */
> >      guest_base =3D HOST_PAGE_ALIGN(guest_base);
> > diff --git a/linux-user/main.c b/linux-user/main.c
> > index 3234754..27d0b37 100644
> > --- a/linux-user/main.c
> > +++ b/linux-user/main.c
> > @@ -693,7 +693,7 @@ int main(int argc, char **argv, char **envp)
> >      envlist_free(envlist);
> > =20
> >      /*
> > -     * Now that page sizes are configured in cpu_init() we can do
> > +     * Now that page sizes are configured in cpu_create() we can do
> >       * proper page alignment for guest_base.
> >       */
> >      guest_base =3D HOST_PAGE_ALIGN(guest_base);
> >  =20
>=20
> I think page size is now configured in tcg_exec_init() since:
Should we drop this comments altogether?

>=20
>   commit 26a5f13b8eb1281d0552fe323e869806f3cefbfb
>   Author: bellard <bellard@c046a42c-6fe2-441c-8c8c-71466251a162>
>   Date:   Wed May 28 12:30:31 2008 +0000
>=20
>       variable dynamic translation buffer size
>=20
> Strangely comment has been added after this change by:
>=20
>   commit 379f6698d73f476de38682b3ff96ecb226728c43
>   Author: Paul Brook <paul@codesourcery.com>
>   Date:   Fri Jul 17 12:48:08 2009 +0100
>=20
>     Userspace guest address offsetting
>=20
>=20
> Thanks,
> Laurent
