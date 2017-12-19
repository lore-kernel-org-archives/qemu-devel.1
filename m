Received: from eggs.gnu.org ([2001:4830:134:3::10]:35342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRK84-0003QQ-N8
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:48:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eRK83-0000fF-Ut
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:48:28 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:41345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eRK83-0000f8-Nu
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 10:48:27 -0500
Received: by mail-wr0-x242.google.com with SMTP id p69so10867994wrb.8
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 07:48:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171215150659.1811-5-marcandre.lureau@redhat.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-5-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Dec 2017 16:48:25 +0100
Message-ID: <CAJ+F1CLxk6vC+ZB09BUBMnJj12RuaeYS=S5KwcBGhoHiYbCd5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/13] build-sys: add AddressSanitizer
 when --enable-debug if possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

Hi

On Fri, Dec 15, 2017 at 4:06 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Enable ASAN by default if the compiler supports it.
>
> If necessary, we could consider a seperate configure option, although
> I like the idea to have it enabled by default with --enable-debug.

Peter, Paolo, Fam, any thoughts about having ASAN enabled by default
with --enable-debug? (when available)

Slow down is not really noticeable to me when running make check, but
I can do some measurements if that helps.

thanks


> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  configure | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/configure b/configure
> index 2b8c71f522..52d9fd71e5 100755
> --- a/configure
> +++ b/configure
> @@ -5129,6 +5129,11 @@ elif test "$fortify_source" =3D "yes" ; then
>    CFLAGS=3D"-O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 $CFLAGS"
>  elif test "$debug" =3D "no"; then
>    CFLAGS=3D"-O2 $CFLAGS"
> +elif test "$debug" =3D "yes"; then
> +    write_c_skeleton;
> +    if compile_prog "-fsanitize=3Daddress" ""; then
> +        CFLAGS=3D"-fsanitize=3Daddress $CFLAGS"
> +    fi
>  fi
>
>  ##########################################
> --
> 2.15.1.355.g36791d7216
>
>



--=20
Marc-Andr=C3=A9 Lureau
