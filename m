Received: from eggs.gnu.org ([2001:4830:134:3::10]:60199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fheWl-00058C-Ea
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fheWg-0005W9-Ez
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:21:43 -0400
Received: from mail-cys01nam02on0125.outbound.protection.outlook.com
	([104.47.37.125]:56477
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fheWg-0005Vq-3W
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:21:38 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 23 Jul 2018 17:21:34 +0000
Message-ID: <BN7PR08MB48689BF3C94BE2A7C03CC527C6560@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-24-git-send-email-stefan.markovic@rt-rk.com>,
	<b2be38da-84b6-904c-a826-1c86fed7e03c@linaro.org>
In-Reply-To: <b2be38da-84b6-904c-a826-1c86fed7e03c@linaro.org>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 23/40] target/mips: Implement emulation
 of nanoMIPS LLWP/SCWP pair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> From: Richard Henderson <richard.henderson@linaro.org>
> Sent: Saturday, July 21, 2018 8:15 PM
> On 07/19/2018 05:54 AM, Stefan Markovic wrote:
> > From: Yongbok Kim <yongbok.kim@mips.com>
> >
> > Implement nanoMIPS LLWP and SCWP instruction pair.
> >
> > Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> > ---
> >  linux-user/mips/cpu_loop.c |  25 ++++++++---
> >  target/mips/cpu.h          |   2 +
> >  target/mips/helper.h       |   2 +
> >  target/mips/op_helper.c    |  35 +++++++++++++++
> >  target/mips/translate.c    | 107 +++++++++++++++++++++++++++++++++++++=
++++++++
> >  5 files changed, 166 insertions(+), 5 deletions(-)
>
> Hmm.  Well, it's ok as far as it goes, but I'd really really like to see
> target/mips to be updated to use actual atomic operations.  Otherwise
> mips*-linux-user will never be reliable and mips*-softmmu cannot run SMP =
in
> multi-threaded mode.
>
> While converting the rest of target/mips to atomic operations is perhaps =
out of
> scope for this patch set, there's really no reason not to do these two
> instructions correctly from the start.  It'll save the trouble of rewriti=
ng
> them from scratch later.
>
> Please see target/arm/translate.c, gen_load_exclusive and gen_store_exclu=
sive,
> for the size =3D=3D 3 case.  That is arm32 doing a 64-bit "paired" atomic
> operation, just like you are attempting here.
>
> Note that single-copy atomic semantics apply in both cases, so LLWP must
> perform one 64-bit load, not two 32-bit loads.  The store in SCWP must ha=
ppen
> with a 64-bit atomic cmpxchg operation.
>
>
> r~

Hi, Richard.

The improved version of this patch, that addresses the concerns you mention=
ed, may be included in the next version of this series, which is scheduled =
to be sent in next few days.

The reason we are a little sluggish with response to your reviews is that w=
e are still completing functionality (mostly linux-user-related). However, =
we'll focus on the interaction with reviewers as soon as we are out of that=
 phase.

Regards,
Aleksandar
