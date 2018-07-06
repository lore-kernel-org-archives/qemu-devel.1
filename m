Received: from eggs.gnu.org ([2001:4830:134:3::10]:36718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbTIO-0001S2-P3
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbTIN-0001Pa-Rr
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:09:20 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbTIN-0001P3-Ml
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:09:19 -0400
Received: by mail-oi0-x242.google.com with SMTP id i12-v6so24413372oik.2
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 09:09:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180706155127.7483-3-f4bug@amsat.org>
References: <20180706155127.7483-1-f4bug@amsat.org>
	<20180706155127.7483-3-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 17:08:58 +0100
Message-ID: <CAFEAcA_rKe5MrPt36EAYjxB5TDREb9Ea+vj8u4kVPgamLDFiog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.0 2/3] linux-user: Do not report
 "syscall not implemented" by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, QEMU Trivial <qemu-trivial@nongnu.org>

On 6 July 2018 at 16:51, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> This can still be reported using the "-d unimp" command line option.
>
> Code change produced with:
>
>   git ls-files linux-user | \
>   xargs sed -i -E 's/fprintf\(stderr,\s?(".*not implemented\\n")\);/qemu_=
log_mask(LOG_UNIMP, \1);/g'
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  linux-user/cris/signal.c       | 4 ++--
>  linux-user/microblaze/signal.c | 4 ++--
>  linux-user/nios2/signal.c      | 2 +-
>  linux-user/sparc/signal.c      | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/linux-user/cris/signal.c b/linux-user/cris/signal.c
> index 0b405247cf..1e02194377 100644
> --- a/linux-user/cris/signal.c
> +++ b/linux-user/cris/signal.c
> @@ -146,7 +146,7 @@ void setup_rt_frame(int sig, struct target_sigaction =
*ka,
>                      target_siginfo_t *info,
>                       target_sigset_t *set, CPUCRISState *env)
>  {
> -    fprintf(stderr, "CRIS setup_rt_frame: not implemented\n");
> +    qemu_log_mask(LOG_UNIMP, "setup_rt_frame: not implemented\n");

Your regex seems to have gone a bit awry here, because it's lost
the "CRIS" part of the string (similarly below).

thanks
-- PMM
