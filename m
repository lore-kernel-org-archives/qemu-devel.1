Received: from eggs.gnu.org ([2001:4830:134:3::10]:40881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83aI-00021E-VP
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1g83ZT-0000Em-0i
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1g83ZQ-0000CA-Sf
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:21:37 -0400
Received: by mail-io1-f66.google.com with SMTP id m16-v6so3653177ioj.4
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 06:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538652143.git.tgolembi@redhat.com>
	<73a25549dfd4206b53f5fd8e98f789b20ac861a4.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <73a25549dfd4206b53f5fd8e98f789b20ac861a4.1538652143.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 4 Oct 2018 17:21:23 +0400
Message-ID: <CAMxuvayFfxDdQfH6-FakGu+Jnyk__A0QKwGUyk_+xyC9gUaM5g@mail.gmail.com>
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
To: Tomas Golembiovsky <tgolembi@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Blake, Eric" <eblake@redhat.com>, sjubran@redhat.com, okrishtal@virtuozzo.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Thu, Oct 4, 2018 at 3:22 PM Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@=
redhat.com> wrote:
>
> There was inconsistency between commits:
>
>   50cbebb9a3 configure: add configure check for ntdddisk.h
>   a3ef3b2272 qga: added bus type and disk location path
>
> The first commit added #define CONFIG_QGA_NTDDDISK but the second commit
> expected the name to be CONFIG_QGA_NTDDSCSI. As a result the code in
> second patch was never used.
>
> Renaming the option to CONFIG_QGA_NTDDSCSI to match the name of header
> file that is being checked for.
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 58862d2ae8..0f168607e8 100755
> --- a/configure
> +++ b/configure
> @@ -6201,7 +6201,7 @@ if test "$mingw32" =3D "yes" ; then
>      echo "WIN_SDK=3D\"$win_sdk\"" >> $config_host_mak
>    fi
>    if test "$guest_agent_ntddscsi" =3D "yes" ; then
> -    echo "CONFIG_QGA_NTDDDISK=3Dy" >> $config_host_mak
> +    echo "CONFIG_QGA_NTDDSCSI=3Dy" >> $config_host_mak
>    fi
>    if test "$guest_agent_msi" =3D "yes"; then
>      echo "QEMU_GA_MSI_ENABLED=3Dyes" >> $config_host_mak
> --
> 2.19.0
>
