Received: from eggs.gnu.org ([2001:4830:134:3::10]:36922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gQEpi-0006yA-BX
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 12:01:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gQEpd-0004yW-VP
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 12:01:34 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:36129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gQEpd-0004xT-OJ
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 12:01:29 -0500
Received: by mail-wm1-x331.google.com with SMTP id s11so12636060wmh.1
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 09:01:29 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-21-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-21-cota@braap.org>
Date: Fri, 23 Nov 2018 17:01:27 +0000
Message-ID: <87pnuvhgns.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 20/48] *-user: notify plugin of exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  bsd-user/syscall.c | 3 +++
>  linux-user/exit.c  | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
> index 66492aaf5d..b7818af450 100644
> --- a/bsd-user/syscall.c
> +++ b/bsd-user/syscall.c
> @@ -332,6 +332,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
>          _mcleanup();
>  #endif
>          gdb_exit(cpu_env, arg1);
> +        qemu_plugin_atexit_cb();
>          /* XXX: should free thread stack and CPU env */
>          _exit(arg1);
>          ret =3D 0; /* avoid warning */
> @@ -430,6 +431,7 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, ab=
i_long arg1,
>          _mcleanup();
>  #endif
>          gdb_exit(cpu_env, arg1);
> +        qemu_plugin_atexit_cb();
>          /* XXX: should free thread stack and CPU env */
>          _exit(arg1);
>          ret =3D 0; /* avoid warning */
> @@ -505,6 +507,7 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
>          _mcleanup();
>  #endif
>          gdb_exit(cpu_env, arg1);
> +        qemu_plugin_atexit_cb();
>          /* XXX: should free thread stack and CPU env */
>          _exit(arg1);
>          ret =3D 0; /* avoid warning */
> diff --git a/linux-user/exit.c b/linux-user/exit.c
> index 14e94e28fa..768856483a 100644
> --- a/linux-user/exit.c
> +++ b/linux-user/exit.c
> @@ -32,4 +32,5 @@ void preexit_cleanup(CPUArchState *env, int code)
>          __gcov_dump();
>  #endif
>          gdb_exit(env, code);
> +        qemu_plugin_atexit_cb();
>  }


--
Alex Benn=C3=A9e
