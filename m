Received: from eggs.gnu.org ([2001:4830:134:3::10]:36272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRFQH-0003IO-4F
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRFQ9-0006Nw-Qb
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:51:27 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gRFQ8-0006MB-JU
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:51:21 -0500
Received: by mail-wr1-x442.google.com with SMTP id j2so18596246wrw.1
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 03:51:20 -0800 (PST)
References: <1543226303-5260-1-git-send-email-liq3ea@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1543226303-5260-1-git-send-email-liq3ea@gmail.com>
Date: Mon, 26 Nov 2018 11:51:17 +0000
Message-ID: <87mupw3vm2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target: hax: fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, laurent@vivier.eu, qemu-trivial@nongnu.org, Li Qiang <liq3ea@gmail.com>


Li Qiang <liq3ea@gmail.com> writes:

> Cc: qemu-trivial@nongnu.org
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/i386/hax-all.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index 502ce6f0af..464744a406 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
> @@ -205,7 +205,7 @@ int hax_vcpu_destroy(CPUState *cpu)
>      }
>
>      /*
> -     * 1. The hax_tunnel is also destroied when vcpu destroy
> +     * 1. The hax_tunnel is also destroyed when vcpu destroy
>       * 2. close fd will cause hax module vcpu be cleaned
>       */
>      hax_close_fd(vcpu->fd);


--
Alex Benn=C3=A9e
