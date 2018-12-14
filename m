Received: from eggs.gnu.org ([2001:4830:134:3::10]:50450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gXrtK-0004fz-J5
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:08:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gXrtG-0003D2-86
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:08:50 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:54563)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gXrtG-0003Bw-0k
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 13:08:46 -0500
Received: by mail-wm1-f53.google.com with SMTP id a62so6535735wmh.4
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 10:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20181214151718.5041-1-alex.bennee@linaro.org>
In-Reply-To: <20181214151718.5041-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Fri, 14 Dec 2018 19:08:32 +0100
Message-ID: <CAP+75-W2-XW-q6BRtzx8qES5cT279KQKcsngVBDta5CDUgoQoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] .shippable.yml: disable the win cross tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

Le ven. 14 d=C3=A9c. 2018 16:17, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
a =C3=A9crit :

> The pkg.mxe.cc package repositories have been down for the last two
> weeks causing the builds to fail when shippable re-builds the
> containers.
>
> This is really just a sticking plaster until we can get our own docker
> hub images properly setup so we can avoid having dependencies on
> external repos.
>

I have few WiP branches on this topic but it is taking time...
Meanwhile:
Acked-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Maybe Peter can directly apply this as a build fix.


> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  .shippable.yml | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/.shippable.yml b/.shippable.yml
> index f74a3de3ff..f2ffef21d1 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -7,10 +7,11 @@ env:
>    matrix:
>      - IMAGE=3Ddebian-amd64
>        TARGET_LIST=3Dx86_64-softmmu,x86_64-linux-user
> -    - IMAGE=3Ddebian-win32-cross
> -      TARGET_LIST=3Darm-softmmu,i386-softmmu,lm32-softmmu
> -    - IMAGE=3Ddebian-win64-cross
> -      TARGET_LIST=3Daarch64-softmmu,sparc64-softmmu,x86_64-softmmu
> +    # currently disabled as the mxe.cc repos are down
> +    # - IMAGE=3Ddebian-win32-cross
> +    #   TARGET_LIST=3Darm-softmmu,i386-softmmu,lm32-softmmu
> +    # - IMAGE=3Ddebian-win64-cross
> +    #   TARGET_LIST=3Daarch64-softmmu,sparc64-softmmu,x86_64-softmmu
>      - IMAGE=3Ddebian-armel-cross
>        TARGET_LIST=3Darm-softmmu,arm-linux-user,armeb-linux-user
>      - IMAGE=3Ddebian-armhf-cross
> --
> 2.17.1
>
>
