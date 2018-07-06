Received: from eggs.gnu.org ([2001:4830:134:3::10]:37272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbTKj-00037i-LW
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbTKi-00060K-Jc
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:11:45 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbTKi-0005yn-F0
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 12:11:44 -0400
Received: by mail-oi0-x242.google.com with SMTP id n84-v6so24412088oib.9
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 09:11:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180706155127.7483-2-f4bug@amsat.org>
References: <20180706155127.7483-1-f4bug@amsat.org>
	<20180706155127.7483-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 17:11:23 +0100
Message-ID: <CAFEAcA8hUPd00KJ=-Njax1UWAGQWVY_NJC1fjq7GjkdgpZPqGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.0 1/3] linux-user: Do not report
 "Unsupported syscall" by default
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
> Fixes: https://bugs.launchpad.net/qemu/+bug/1777226
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  linux-user/syscall.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 5822e03e28..e4b1b7d7da 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12757,7 +12757,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
>
>      default:
>      unimplemented:
> -        gemu_log("qemu: Unsupported syscall: %d\n", num);
> +        qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
>  #if defined(TARGET_NR_setxattr) || defined(TARGET_NR_get_thread_area) ||=
 defined(TARGET_NR_getdomainname) || defined(TARGET_NR_set_robust_list)
>      unimplemented_nowarn:
>  #endif
> --
> 2.18.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
