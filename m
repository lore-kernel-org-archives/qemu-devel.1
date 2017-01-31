Received: from eggs.gnu.org ([2001:4830:134:3::10]:41708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cYZ9L-0004zd-Sk
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cYZ9H-0005A4-6X
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:11:11 -0500
Received: from mail-yb0-x243.google.com ([2607:f8b0:4002:c09::243]:33227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cYZ9H-0005A0-09
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:11:07 -0500
Received: by mail-yb0-x243.google.com with SMTP id 123so29861359ybe.0
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 06:11:06 -0800 (PST)
MIME-Version: 1.0
References: <1485868446-10587-1-git-send-email-mst@redhat.com>
	<CAFEAcA-UMXm1PSr46uUY1-RScww_QgZgKt5mZwTd_VH6Btj30g@mail.gmail.com>
In-Reply-To: <CAFEAcA-UMXm1PSr46uUY1-RScww_QgZgKt5mZwTd_VH6Btj30g@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Jan 2017 14:10:54 +0000
Message-ID: <CAJ+F1CKjQcVYNFVZsA54t+_PN6qCYmeG3Wx8321fCtfDon0JSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Hi Michael

On Tue, Jan 31, 2017 at 6:06 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 31 January 2017 at 13:14, Michael S. Tsirkin <mst@redhat.com> wrote:
> > The following changes since commit
> ae5045ae5b2bbd8ce1335d1b05f9ecacca83a6cf:
> >
> >   Merge remote-tracking branch 'remotes/rth/tags/pull-nios-20170124'
> into staging (2017-01-25 13:30:23 +0000)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to b16127353f6b5ccdbe1e61e48848a83a6d30e640=
:
> >
> >   arm: add trailing ; after MISMATCH_CHECK (2017-01-31 15:11:35 +0200)
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
>
> Fails to build:
>
> /home/petmay01/linaro/qemu-for-merges/net/vhost-user.c: In function
> =E2=80=98vhost_user_cleanup=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/net/vhost-user.c:154:9: error:
> unknown type name =E2=80=98CharDriverSt
> ate=E2=80=99
>          CharDriverState *chr =3D qemu_chr_fe_get_driver(&s->chr);
>

Sorry about that , all you need is to change the type to "Chardev".

thanks

         ^
> /home/petmay01/linaro/qemu-for-merges/net/vhost-user.c:154:32: error:
> initialization from incompatible pointer type
> [-Werror=3Dincompatible-pointer-types]
>          CharDriverState *chr =3D qemu_chr_fe_get_driver(&s->chr);
>                                 ^
> /home/petmay01/linaro/qemu-for-merges/net/vhost-user.c:157:25: error:
> passing argument 1 of =E2=80=98qemu_chr_delete=E2=80=99 from incompatible=
 pointer type
> [-Werror=3Dincompatible-pointer-types]
>          qemu_chr_delete(chr);
>                          ^
> In file included from
> /home/petmay01/linaro/qemu-for-merges/net/vhost-user.c:15:0:
> /home/petmay01/linaro/qemu-for-merges/include/sysemu/char.h:185:6:
> note: expected =E2=80=98Chardev * {aka struct Chardev *}=E2=80=99 but arg=
ument is of
> type =E2=80=98int *=E2=80=99
>  void qemu_chr_delete(Chardev *chr);
>       ^
>
> Looks like something in your tree is semantically conflicting
> with the char device QOMification that landed via Paolo's
> tree yesterday. Can you rebase/fix/drop patches as appropriate,
> please?
>
> thanks
> -- PMM
>
> --
Marc-Andr=C3=A9 Lureau
