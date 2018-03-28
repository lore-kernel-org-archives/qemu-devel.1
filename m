Received: from eggs.gnu.org ([2001:4830:134:3::10]:33802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1DSd-0006IN-Ur
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:58:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f1DSa-0002ZO-Tn
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:58:04 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:56197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f1DSa-0002Yt-Me
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:58:00 -0400
Received: by mail-wm0-x22f.google.com with SMTP id b127so5043144wmf.5
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 08:58:00 -0700 (PDT)
References: <1519709965-29833-1-git-send-email-cota@braap.org>
	<1519709965-29833-14-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1519709965-29833-14-git-send-email-cota@braap.org>
Date: Wed, 28 Mar 2018 16:57:58 +0100
Message-ID: <878tac8a61.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/16] translate-all: protect TB jumps with
 a per-destination-TB lock
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

> This applies to both user-mode and !user-mode emulation.
>
<snip>
> @@ -2124,7 +2148,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t reta=
ddr)
>      /* Adjust the execution state of the next TB.  */
>      cpu->cflags_next_tb =3D curr_cflags() | CF_LAST_IO | n;
>
> -    if (tb->cflags & CF_NOCACHE) {
> +    if (tb_cflags(tb) & CF_NOCACHE) {
>          if (tb->orig_tb) {
>              /* Invalidate original TB if this TB was generated in
>               * cpu_exec_nocache() */

Heads up, this fails to apply on master, most likely due to
87f963be66a32453e001d1052b000f1653605caa

--
Alex Benn=C3=A9e
