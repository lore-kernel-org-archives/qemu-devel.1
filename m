Received: from eggs.gnu.org ([2001:4830:134:3::10]:43129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTsyJ-0008AK-UT
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTsyJ-00084t-1y
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:20:27 -0500
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:35459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTsyI-00084X-UF
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:20:26 -0500
Received: by mail-ua0-x233.google.com with SMTP id y9so13063996uae.2
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 08:20:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170118150235.23850-1-bobby.prani@gmail.com>
References: <20170118150235.23850-1-bobby.prani@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Jan 2017 16:20:04 +0000
Message-ID: <CAFEAcA8Ag8u0d9h7mEMT6mo8nb3MAbh_yQ=2PhwnTGD-oM=zwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: fix settime old value
 location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 18 January 2017 at 15:02, Pranith Kumar <bobby.prani@gmail.com> wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> old_value is the 4th argument of timer_settime(), not the 2nd.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  linux-user/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 7b77503f94..5bd477a71b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12027,7 +12027,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
>              target_to_host_itimerspec(&hspec_new, arg3);
>              ret =3D get_errno(
>                            timer_settime(htimer, arg2, &hspec_new, &hspec=
_old));
> -            host_to_target_itimerspec(arg2, &hspec_old);
> +            host_to_target_itimerspec(arg4, &hspec_old);
>          }
>          break;
>      }
> --
> 2.11.0

I reviewed this when Marc sent it back in November,
but this resend doesn't seem to have addressed any
of that.

thanks
-- PMM
