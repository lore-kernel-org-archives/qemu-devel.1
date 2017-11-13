Received: from eggs.gnu.org ([2001:4830:134:3::10]:60219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eECzL-00059m-R8
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eECzI-0000nB-OU
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:33:15 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:54298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eECzI-0000mt-IA
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 06:33:12 -0500
Received: by mail-wm0-x232.google.com with SMTP id r68so14510004wmr.3
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 03:33:12 -0800 (PST)
References: <20171004184325.24157-1-richard.henderson@linaro.org>
	<20171004184325.24157-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20171004184325.24157-2-richard.henderson@linaro.org>
Date: Mon, 13 Nov 2017 11:33:10 +0000
Message-ID: <87ineetnux.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v1 01/12] HACK: use objdump disas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> ---
>  disas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/disas.c b/disas.c
> index d6a1eb9c8e..69069a85ca 100644
> --- a/disas.c
> +++ b/disas.c
> @@ -231,7 +231,7 @@ void target_disas(FILE *out, CPUState *cpu, target_ul=
ong code,
>      s.info.disassembler_options =3D (char *)"any";
>      s.info.print_insn =3D print_insn_ppc;
>  #endif
> -    if (s.info.print_insn =3D=3D NULL) {
> +    if (1 || s.info.print_insn =3D=3D NULL) {
>          s.info.print_insn =3D print_insn_od_target;
>      }

Because? Is this being droppped now for capstone?

--
Alex Benn=C3=A9e
