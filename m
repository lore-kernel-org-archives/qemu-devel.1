Received: from eggs.gnu.org ([2001:4830:134:3::10]:38976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dE8mh-0005At-2C
	for qemu-devel@nongnu.org; Fri, 26 May 2017 02:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dE8mg-00062t-13
	for qemu-devel@nongnu.org; Fri, 26 May 2017 02:31:39 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dE8mf-00062Q-Pp
	for qemu-devel@nongnu.org; Fri, 26 May 2017 02:31:37 -0400
Received: by mail-lf0-x244.google.com with SMTP id m18so160775lfj.0
	for <qemu-devel@nongnu.org>; Thu, 25 May 2017 23:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20170513004616.25749-1-n54@gmx.com>
	<20170526054013.299-1-n54@gmx.com>
In-Reply-To: <20170526054013.299-1-n54@gmx.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 May 2017 06:31:25 +0000
Message-ID: <CAJ+F1CJBQuKFK=6m1_1BEoKJmyvUPU_U4ai1xExxVjFnXT1g1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: ivshmem-clean: Install
 only when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, armbru@redhat.com, f4bug@amsat.org

Hi

On Fri, May 26, 2017 at 9:49 AM Kamil Rytarowski <n54@gmx.com> wrote:

> Currently ivshmem requires eventfd() which is Linux specific.
> Do not and build it unconditionally on every Linux/BSD/Solaris.
>
>
I think it should be able to use pipe fallback from event_notifier_init() .


> This patch indirectly fixes build failure on NetBSD, where these tools
> additionally require -lrl for shm_open(3). In future there should be
> added support for NetBSD and the linking addressed appropriately.
>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
>
---
>  configure | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configure b/configure
> index 1a5ee4b909..84d8660354 100755
> --- a/configure
> +++ b/configure
> @@ -4928,6 +4928,8 @@ if test "$want_tools" =3D "yes" ; then
>    tools=3D"qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
>    if [ "$linux" =3D "yes" -o "$bsd" =3D "yes" -o "$solaris" =3D "yes" ] =
; then
>      tools=3D"qemu-nbd\$(EXESUF) $tools"
> +  fi
> +  if [ "$eventfd" !=3D "no" ]; then
>      tools=3D"ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
>    fi
>  fi
> --
> 2.13.0
>
>
> --
Marc-Andr=C3=A9 Lureau
