Received: from eggs.gnu.org ([2001:4830:134:3::10]:56013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMxD2-00084C-2k
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMxCx-0007g1-EJ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:36:02 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMxCv-0007Z7-Nh
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:35:57 -0500
Received: by mail-yb1-f195.google.com with SMTP id z2-v6so7066578ybj.2
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 07:35:53 -0800 (PST)
MIME-Version: 1.0
References: <1542135956-3780-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAAdtpL4cd2i0ZgL_hyPc9wgp5-=v5qeExmAnpdr0XZ97_5cwjg@mail.gmail.com>
	<CAAdtpL7JsA90236QX5vCLeE1ma0hZ75-BLwwC=+Nc2Di9utDSg@mail.gmail.com>
	<BN6PR2201MB1251910140D2FE6E94E21A03C6C30@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB1251910140D2FE6E94E21A03C6C30@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 14 Nov 2018 16:35:40 +0100
Message-ID: <CAAdtpL5iwnBVQnyhoJbHCYwQm9zXYVMsoCk7P+chVOuSBgzcWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/mips: Disable R5900 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, Stefan Markovic <smarkovic@wavecomp.com>, Fredrik Noring <noring@nocrew.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Wed, Nov 14, 2018 at 3:02 PM Aleksandar Markovic
<amarkovic@wavecomp.com> wrote:
> Philippe Mathieu-Daud=C3=A9 <philippe@mathieu-daude.net> wrote:
>
> > Can you add:
> >
> > This reverts commit ed4f49ba9bb56ebca6987b1083255daf6c89b5de.
> >
> > Or
> >
> > Fixes: ed4f49ba9
> >
> > when applying?
>
> Sure, I'll add something along that line.
>
> > If the issues you mentioned are "the R5900 tcg opcodes are not
> > implemented correctly", then this patch is OK, because no cpu
> > can use the R5900 opcodes.
> >
> > At some point while reading your reviews, I understood the R5900
> > patches introduced incorrect behaviors for the non-R5900 cpus.
> > In this case this patch wouldn't suffice.
>
> This patch will be applied after the patches that Fredrik kindly
> submitted under "Fix decoding..." series. Fredrik's patches will
> remove any doubt about R5900 interfering other architectures, so,
> as a consequence, this patch is sufficient and appropriate for
> disabling R5900 support.

Ah OK, now it makes sens.

> Additional clarification: This patch is to give more time for
> all R5900 issues to be cleared in 3.1+ time frame. If R5900 code
> was left enabled, we could have unpleasant backward compatibility
> issues between R5900 support and different versions of QEMU.
>
> The R5900 support is intended to be enabled again when all issues
> are resolved and agreed upon.

The commit description is clear enough, this is what I understood from it :=
)

Regards,

Phil.
