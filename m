Received: from eggs.gnu.org ([2001:4830:134:3::10]:50785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1frUvi-0006jE-Tg
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 17:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1frUvi-0001cA-1W
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 17:08:10 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1frUvh-0001VB-SL
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 17:08:09 -0400
Date: Sun, 19 Aug 2018 23:07:45 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20180819210745.GA31328@aurel32.net>
References: <20180811082328.11268-1-laurent@vivier.eu>
	<7195617a-1f47-00e1-638f-50d20c21ba9e@linaro.org>
	<7cd759fa-8d2b-f63b-3bd9-75fe528373a8@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7cd759fa-8d2b-f63b-3bd9-75fe528373a8@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v2] sh4: fix use_icount with linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Riku Voipio <riku.voipio@iki.fi>

On 2018-08-16 20:58, Laurent Vivier wrote:
> Le 11/08/2018 =E0 17:26, Richard Henderson a =E9crit=A0:
> > On 08/11/2018 01:23 AM, Laurent Vivier wrote:
> >> This fixes java in a linux-user chroot:
> >>   $ java --version
> >>   qemu-sh4: .../accel/tcg/cpu-exec.c:634: cpu_loop_exec_tb: Assertion =
`use_icount' failed.
> >>   qemu: uncaught target signal 6 (Aborted) - core dumped
> >>   Aborted (core dumped)
> >>
> >> In gen_conditional_jump() in the GUSA_EXCLUSIVE part, we must reset
> >> base.is_jmp to DISAS_NEXT after the gen_goto_tb() as it is done in
> >> gen_delayed_conditional_jump() after the gen_jump().
> >>
> >> Bug: https://bugs.launchpad.net/qemu/+bug/1768246
> >> Fixes: 4834871bc95b67343248100e2a75ae0d287bc08b
> >>        ("target/sh4: Convert to DisasJumpType")
> >> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> >> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> >> ---
> >>
> >> Notes:
> >>     v2:
> >>       don't revert the part of the original patch,
> >>       but fixes the state problem in gen_conditional_jump()
> >=20
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>

> Aur=E9lien,
>=20
> do you agree if I push this patch through a linux-user pull request?

Yes, that's fine with me.

Thanks,
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
