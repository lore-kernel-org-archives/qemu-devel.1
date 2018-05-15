Received: from eggs.gnu.org ([2001:4830:134:3::10]:39117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIfYU-000285-RP
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIfYR-0008Ge-Gh
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:24:14 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIfYR-0008GF-9b
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:24:11 -0400
Received: by mail-wr0-x243.google.com with SMTP id h5-v6so1300226wrm.4
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 12:24:11 -0700 (PDT)
References: <20180515182700.31736-1-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180515182700.31736-1-peter.maydell@linaro.org>
Date: Tue, 15 May 2018 20:24:08 +0100
Message-ID: <871secg1t3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] exec.c: Initialize sa_flags passed to
 sigaction()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, patches@linaro.org


Peter Maydell <peter.maydell@linaro.org> writes:

> Coverity points out that in the user-only version of cpu_abort() we
> call sigaction() with a partially initialized struct sigaction
> (CID 1005351). Correct the omission.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  exec.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/exec.c b/exec.c
> index ffa1099547..bd8833fc9d 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1124,6 +1124,7 @@ void cpu_abort(CPUState *cpu, const char *fmt, ...)
>          struct sigaction act;
>          sigfillset(&act.sa_mask);
>          act.sa_handler =3D SIG_DFL;
> +        act.sa_flags =3D 0;
>          sigaction(SIGABRT, &act, NULL);
>      }
>  #endif


--
Alex Benn=C3=A9e
