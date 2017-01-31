Received: from eggs.gnu.org ([2001:4830:134:3::10]:40215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cYZ0a-0005cd-4b
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cYZ0X-0002t5-2W
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:02:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cYZ0W-0002sz-T7
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:02:05 -0500
Date: Tue, 31 Jan 2017 16:01:59 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170131155906-mutt-send-email-mst@kernel.org>
References: <1485868446-10587-1-git-send-email-mst@redhat.com>
	<CAFEAcA-UMXm1PSr46uUY1-RScww_QgZgKt5mZwTd_VH6Btj30g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-UMXm1PSr46uUY1-RScww_QgZgKt5mZwTd_VH6Btj30g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/21] virtio, vhost, pci: fixes, features
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

On Tue, Jan 31, 2017 at 01:24:30PM +0000, Peter Maydell wrote:
> On 31 January 2017 at 13:14, Michael S. Tsirkin <mst@redhat.com> wrote:
> > The following changes since commit ae5045ae5b2bbd8ce1335d1b05f9ecacca=
83a6cf:
> >
> >   Merge remote-tracking branch 'remotes/rth/tags/pull-nios-20170124' =
into staging (2017-01-25 13:30:23 +0000)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstrea=
m
> >
> > for you to fetch changes up to b16127353f6b5ccdbe1e61e48848a83a6d30e6=
40:
> >
> >   arm: add trailing ; after MISMATCH_CHECK (2017-01-31 15:11:35 +0200=
)
> >
> > ----------------------------------------------------------------
> > virtio, vhost, pci: fixes, features
> >
> > generic pci root port support
> > disable shpc by default
> > safer version of ARRAY_SIZE and QEMU_BUILD_BUG_ON
> > fixes and cleanups all over the place
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
>=20
> Fails to build:
>=20
> /home/petmay01/linaro/qemu-for-merges/net/vhost-user.c: In function
> =E2=80=98vhost_user_cleanup=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/net/vhost-user.c:154:9: error:
> unknown type name =E2=80=98CharDriverSt
> ate=E2=80=99
>          CharDriverState *chr =3D qemu_chr_fe_get_driver(&s->chr);
>          ^
> /home/petmay01/linaro/qemu-for-merges/net/vhost-user.c:154:32: error:
> initialization from incompatible pointer type
> [-Werror=3Dincompatible-pointer-types]
>          CharDriverState *chr =3D qemu_chr_fe_get_driver(&s->chr);
>                                 ^
> /home/petmay01/linaro/qemu-for-merges/net/vhost-user.c:157:25: error:
> passing argument 1 of =E2=80=98qemu_chr_delete=E2=80=99 from incompatib=
le pointer type
> [-Werror=3Dincompatible-pointer-types]
>          qemu_chr_delete(chr);
>                          ^
> In file included from
> /home/petmay01/linaro/qemu-for-merges/net/vhost-user.c:15:0:
> /home/petmay01/linaro/qemu-for-merges/include/sysemu/char.h:185:6:
> note: expected =E2=80=98Chardev * {aka struct Chardev *}=E2=80=99 but a=
rgument is of
> type =E2=80=98int *=E2=80=99
>  void qemu_chr_delete(Chardev *chr);
>       ^
>=20
> Looks like something in your tree is semantically conflicting
> with the char device QOMification that landed via Paolo's
> tree yesterday. Can you rebase/fix/drop patches as appropriate,
> please?
>=20
> thanks
> -- PMM

Right it's a trivial conflict. I'll rebase and resend
with minimal testing.

--=20
MST
