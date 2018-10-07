Received: from eggs.gnu.org ([2001:4830:134:3::10]:60212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1g95Ny-0006QR-PL
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 05:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1g95Ny-000164-2c
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 05:30:02 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1g95Nx-00015W-Nr
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 05:30:02 -0400
Received: by mail-ed1-x543.google.com with SMTP id x31-v6so353334edd.8
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 02:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538652143.git.tgolembi@redhat.com>
	<73a25549dfd4206b53f5fd8e98f789b20ac861a4.1538652143.git.tgolembi@redhat.com>
	<CAMxuvayFfxDdQfH6-FakGu+Jnyk__A0QKwGUyk_+xyC9gUaM5g@mail.gmail.com>
In-Reply-To: <CAMxuvayFfxDdQfH6-FakGu+Jnyk__A0QKwGUyk_+xyC9gUaM5g@mail.gmail.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Sun, 7 Oct 2018 12:29:49 +0300
Message-ID: <CAKPgXcFkbJJz12j1GofZjev_=G6A-vuk8Gd-gQwEdmWo2Gz3nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 03/11] build: rename CONFIG_QGA_NTDDDISK
 to CONFIG_QGA_NTDDSCSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com
Cc: tgolembi@redhat.com, Sameeh Jubran <sjubran@redhat.com>, okrishtal@virtuozzo.com, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Reviewed-by: Sameeh Jubran <sjubran@redhat.com>
On Thu, Oct 4, 2018 at 4:23 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Thu, Oct 4, 2018 at 3:22 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolemb=
i@redhat.com> wrote:
> >
> > There was inconsistency between commits:
> >
> >   50cbebb9a3 configure: add configure check for ntdddisk.h
> >   a3ef3b2272 qga: added bus type and disk location path
> >
> > The first commit added #define CONFIG_QGA_NTDDDISK but the second commi=
t
> > expected the name to be CONFIG_QGA_NTDDSCSI. As a result the code in
> > second patch was never used.
> >
> > Renaming the option to CONFIG_QGA_NTDDSCSI to match the name of header
> > file that is being checked for.
> >
> > Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> > ---
> >  configure | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/configure b/configure
> > index 58862d2ae8..0f168607e8 100755
> > --- a/configure
> > +++ b/configure
> > @@ -6201,7 +6201,7 @@ if test "$mingw32" =3D "yes" ; then
> >      echo "WIN_SDK=3D\"$win_sdk\"" >> $config_host_mak
> >    fi
> >    if test "$guest_agent_ntddscsi" =3D "yes" ; then
> > -    echo "CONFIG_QGA_NTDDDISK=3Dy" >> $config_host_mak
> > +    echo "CONFIG_QGA_NTDDSCSI=3Dy" >> $config_host_mak
> >    fi
> >    if test "$guest_agent_msi" =3D "yes"; then
> >      echo "QEMU_GA_MSI_ENABLED=3Dyes" >> $config_host_mak
> > --
> > 2.19.0
> >
>


--=20
Respectfully,
Sameeh Jubran
Linkedin
Software Engineer @ Daynix.
