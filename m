Received: from eggs.gnu.org ([2001:4830:134:3::10]:33057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fWOOa-0005jh-6d
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fWOOZ-0007AB-FW
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:54:44 -0400
Received: from mail-yb0-x241.google.com ([2607:f8b0:4002:c09::241]:38410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fWOOZ-00079r-A4
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 11:54:43 -0400
Received: by mail-yb0-x241.google.com with SMTP id q62-v6so2710286ybg.5
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 08:54:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622140223.26056-1-f4bug@amsat.org>
References: <20180622140223.26056-1-f4bug@amsat.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 22 Jun 2018 08:54:42 -0700
Message-ID: <CAMo8Bf+_bSYrz_grbvHgpFsNmA7pJDOzjLUhLq2YfmV8FdoXkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] docker: Add fedora-xtensa-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Fri, Jun 22, 2018 at 7:02 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> As of this commit:
>
>   $ xtensa-linux-gnu-as -v
>   GNU assembler version 2.29.1 (xtensa-linux-gnu) using BFD version versi=
on 2.29.1-1.fc27
>
>   $ xtensa-linux-gnu-gcc -v
>   Target: xtensa-linux-gnu
>   gcc version 7.2.1 20170915 (Red Hat Cross 7.2.1-1) (GCC)
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/docker/dockerfiles/fedora-xtensa-cross.docker | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/fedora-xtensa-cross.docker
>
> diff --git a/tests/docker/dockerfiles/fedora-xtensa-cross.docker b/tests/=
docker/dockerfiles/fedora-xtensa-cross.docker
> new file mode 100644
> index 0000000000..6f9521520c
> --- /dev/null
> +++ b/tests/docker/dockerfiles/fedora-xtensa-cross.docker
> @@ -0,0 +1,7 @@
> +FROM fedora:latest
> +ENV PACKAGES \
> +    binutils-xtensa-linux-gnu \
> +    gcc-xtensa-linux-gnu

Generic binutils and gcc for xtensa only (partially) make sense for
build testing.
Built binaries will not work.

--=20
Thanks.
-- Max
