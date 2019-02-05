Received: from eggs.gnu.org ([209.51.188.92]:40011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr5P1-0001LE-6C
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:25:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr5Oz-0002FG-W5
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:24:59 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr5Oz-0002Ex-OZ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:24:57 -0500
Received: by mail-ot1-x343.google.com with SMTP id 81so7440522otj.2
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20190205165927.26599-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190205165927.26599-1-samuel.thibault@ens-lyon.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 18:24:45 +0000
Message-ID: <CAFEAcA8SsXDG7+vw63tYDjOvGsL+L5m9P9UhvHuttdS7kSJwdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULLv2 00/32] More work towards libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On Tue, 5 Feb 2019 at 16:59, Samuel Thibault
<samuel.thibault@ens-lyon.org> wrote:
>
> The following changes since commit 01a9a51ffaf4699827ea6425cb2b834a356e15=
9d:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190205-pull-requ=
est' into staging (2019-02-05 14:01:29 +0000)
>
> are available in the Git repository at:
>
>   https://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
>
> for you to fetch changes up to cf20be34d44a953c9b52a4d5cf6f4232968e6f3c:
>
>   slirp: API is extern C (2019-02-05 18:56:17 +0200)
>
> ----------------------------------------------------------------
> More work towards libslirp

Fails to build, ppc64, x86-64, aarch32, s390x, etc:

/home/pm215/qemu/slirp/misc.c: In function =E2=80=98g_spawn_async_with_fds_=
slirp=E2=80=99:
/home/pm215/qemu/slirp/misc.c:166:5: error: unknown type name =E2=80=98Qemu=
GSpawnFds=E2=80=99
     QemuGSpawnFds setup =3D {
     ^
/home/pm215/qemu/slirp/misc.c:167:9: error: field name not in record
or union initializer
         .child_setup =3D child_setup,
         ^
/home/pm215/qemu/slirp/misc.c:167:9: error: (near initialization for =E2=80=
=98setup=E2=80=99)
/home/pm215/qemu/slirp/misc.c:167:9: error: initialization makes
integer from pointer without a cast [-Werror]
/home/pm215/qemu/slirp/misc.c:167:9: error: (near initialization for
=E2=80=98setup=E2=80=99) [-Werror]
/home/pm215/qemu/slirp/misc.c:168:9: error: field name not in record
or union initializer
         .user_data =3D user_data,
         ^
/home/pm215/qemu/slirp/misc.c:168:9: error: (near initialization for =E2=80=
=98setup=E2=80=99)
/home/pm215/qemu/slirp/misc.c:168:9: error: excess elements in scalar
initializer [-Werror]
/home/pm215/qemu/slirp/misc.c:168:9: error: (near initialization for
=E2=80=98setup=E2=80=99) [-Werror]
/home/pm215/qemu/slirp/misc.c:169:9: error: field name not in record
or union initializer
         .stdin_fd =3D stdin_fd,
         ^
/home/pm215/qemu/slirp/misc.c:169:9: error: (near initialization for =E2=80=
=98setup=E2=80=99)
/home/pm215/qemu/slirp/misc.c:169:9: error: excess elements in scalar
initializer [-Werror]
/home/pm215/qemu/slirp/misc.c:169:9: error: (near initialization for
=E2=80=98setup=E2=80=99) [-Werror]
/home/pm215/qemu/slirp/misc.c:170:9: error: field name not in record
or union initializer
         .stdout_fd =3D stdout_fd,
         ^
/home/pm215/qemu/slirp/misc.c:170:9: error: (near initialization for =E2=80=
=98setup=E2=80=99)
/home/pm215/qemu/slirp/misc.c:170:9: error: excess elements in scalar
initializer [-Werror]
/home/pm215/qemu/slirp/misc.c:170:9: error: (near initialization for
=E2=80=98setup=E2=80=99) [-Werror]
/home/pm215/qemu/slirp/misc.c:171:9: error: field name not in record
or union initializer
         .stderr_fd =3D stderr_fd,
         ^
/home/pm215/qemu/slirp/misc.c:171:9: error: (near initialization for =E2=80=
=98setup=E2=80=99)
/home/pm215/qemu/slirp/misc.c:171:9: error: excess elements in scalar
initializer [-Werror]
/home/pm215/qemu/slirp/misc.c:171:9: error: (near initialization for
=E2=80=98setup=E2=80=99) [-Werror]
cc1: all warnings being treated as errors

FreeBSD fails in a slightly different way:

slirp/misc.c:166:5: error: use of undeclared identifier 'QemuGSpawnFds'
    QemuGSpawnFds setup =3D {
    ^
slirp/misc.c:175:51: error: use of undeclared identifier 'setup'
                         slirp_gspawn_fds_setup, &setup,
                                                  ^
2 errors generated.

thanks
-- PMM
