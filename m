Received: from eggs.gnu.org ([2001:4830:134:3::10]:56017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciNJT-0006Dj-AB
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciNJS-0004FN-7H
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:34:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ciNJS-0004F9-1J
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:34:10 -0500
Date: Mon, 27 Feb 2017 15:34:05 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170227153405.GP18219@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170227133531.31874-1-berrange@redhat.com>
	<CAFEAcA-BMy5nu1yUTRu0uZYuZSzH_Ri8YFkhNRbmFo9KEtAZRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-BMy5nu1yUTRu0uZYuZSzH_Ri8YFkhNRbmFo9KEtAZRg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v1 0/3] Merge qio 2017/02/27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, Feb 27, 2017 at 03:33:02PM +0000, Peter Maydell wrote:
> On 27 February 2017 at 13:35, Daniel P. Berrange <berrange@redhat.com> =
wrote:
> > The following changes since commit d992f2f1368ceb92e6bfd8efece174110f=
4236ff:
> >
> >   Merge remote-tracking branch 'remotes/artyom/tags/pull-sun4v-201702=
26' into staging (2017-02-26 22:40:23 +0000)
> >
> > are available in the git repository at:
> >
> >   git://github.com/berrange/qemu tags/pull-qio-2017-02-27-1
> >
> > for you to fetch changes up to acd22400d1dce27bffc94be7663e1ff1c716ab=
e8:
> >
> >   tests: fix leaks in test-io-channel-command (2017-02-27 12:42:21 +0=
000)
> >
> > ----------------------------------------------------------------
> > Merge qio 2017/02/27 v1
> >
> > ----------------------------------------------------------------
>=20
> Fails to build, w32:
>=20
> /home/petmay01/linaro/qemu-for-merges/io/channel-websock.c: In
> function =E2=80=98qio_channel_websock_handshake_entry=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/io/channel-websock.c:118:13:
> error: implicit declaration of function =E2=80=98strcasestr=E2=80=99
> [-Werror=3Dimplicit-function-declaration]
>      begin =3D strcasestr(handshake, line);
>              ^
> /home/petmay01/linaro/qemu-for-merges/io/channel-websock.c:118:5:
> error: nested extern declaration of =E2=80=98strcasestr=E2=80=99
> [-Werror=3Dnested-externs]
>      begin =3D strcasestr(handshake, line);
>      ^
> /home/petmay01/linaro/qemu-for-merges/io/channel-websock.c:118:11:
> error: assignment makes pointer from integer without a cast
> [-Werror=3Dint-conversion]
>      begin =3D strcasestr(handshake, line);
>            ^
> cc1: all warnings being treated as errors
>=20
> mingw doesn't have strcasestr(), I think.

Yep, man page marks it as a gnu extension too

Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
