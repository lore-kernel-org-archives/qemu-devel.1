Received: from eggs.gnu.org ([2001:4830:134:3::10]:49999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eCp2n-0002pK-39
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:47:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eCp2m-0002MY-Et
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 10:47:05 -0500
MIME-Version: 1.0
In-Reply-To: <20171109121903.24510-1-googuy@gmail.com>
References: <20171109121903.24510-1-googuy@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 9 Nov 2017 16:47:02 +0100
Message-ID: <CAJ+F1CKtoqXWP8ORZd52b3EKv=BjFX5DO-xksTkkd_ZNG9fhZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add missing parameters to mon option
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vicente Jimenez Aguilar <googuy@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, qemu trival <qemu-trivial@nongnu.org>

Hi

On Thu, Nov 9, 2017 at 1:19 PM, Vicente Jimenez Aguilar
<googuy@gmail.com> wrote:
> Documentation missed 'mon' option's 'pretty' and 'default' parameters
>
> Signed-off-by: Vicente Jimenez Aguilar <googuy@gmail.com>
> ---
>  qemu-options.hx | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 3728e9b4dd..72cf48a8e5 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3477,9 +3477,9 @@ Like -qmp but uses pretty JSON formatting.
>  ETEXI
>
>  DEF("mon", HAS_ARG, QEMU_OPTION_mon, \
> -    "-mon [chardev=3D]name[,mode=3Dreadline|control]\n", QEMU_ARCH_ALL)
> +    "-mon [chardev=3D]name[,mode=3Dreadline|control][,pretty[=3Don|off]]=
[,default[=3Don|off]]\n", QEMU_ARCH_ALL)
>  STEXI
> -@item -mon [chardev=3D]name[,mode=3Dreadline|control]
> +@item -mon [chardev=3D]name[,mode=3Dreadline|control][,pretty[=3Don|off]=
][,default[=3Don|off]]

"default" is deprecated since commit 06ac27f (2.4.0). It does nothing
anymore, so should probably not be documented.

"pretty" was added in commit 39eaab9ac2a82f. You write some
documentation for it based on the commit message perhaps?

thanks

>  @findex -mon
>  Setup monitor on chardev @var{name}.
>  ETEXI
> --
> 2.14.1
>
>



--=20
Marc-Andr=C3=A9 Lureau
