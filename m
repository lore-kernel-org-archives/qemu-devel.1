Received: from eggs.gnu.org ([2001:4830:134:3::10]:40646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHt89-0004wl-18
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gHt88-00070t-5k
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:14:04 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gHt87-000702-QS
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:14:03 -0400
Received: by mail-wr1-x42b.google.com with SMTP id d17-v6so16822461wre.11
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 09:14:03 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-27-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025144644.15464-27-cota@braap.org>
Date: Wed, 31 Oct 2018 16:14:00 +0000
Message-ID: <87y3ae6qlz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 27/71] gdbstub: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index c8478de8f5..a5ff50d9e7 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1305,7 +1305,7 @@ static int gdb_handle_packet(GDBState *s, const cha=
r *line_buf)
>                  /* memtohex() doubles the required space */
>                  len =3D snprintf((char *)mem_buf, sizeof(buf) / 2,
>                                 "CPU#%d [%s]", cpu->cpu_index,
> -                               cpu->halted ? "halted " : "running");
> +                               cpu_halted(cpu) ? "halted " : "running");
>                  trace_gdbstub_op_extra_info((char *)mem_buf);
>                  memtohex(buf, mem_buf, len);
>                  put_packet(s, buf);


--
Alex Benn=C3=A9e
