Received: from eggs.gnu.org ([2001:4830:134:3::10]:33669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMxXj-0002Ew-Od
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMxXU-0002oA-Pr
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:57:19 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gMxXU-0002ng-L3
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:57:12 -0500
Received: by mail-yb1-f196.google.com with SMTP id o204-v6so7061573yba.9
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 07:57:12 -0800 (PST)
MIME-Version: 1.0
References: <1542135956-3780-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<CAAdtpL4cd2i0ZgL_hyPc9wgp5-=v5qeExmAnpdr0XZ97_5cwjg@mail.gmail.com>
	<CAAdtpL7JsA90236QX5vCLeE1ma0hZ75-BLwwC=+Nc2Di9utDSg@mail.gmail.com>
	<20181114153046.GA2359@sx9>
In-Reply-To: <20181114153046.GA2359@sx9>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 14 Nov 2018 16:56:59 +0100
Message-ID: <CAAdtpL6A-9Yj7WWZsTjTsSJgqF+__NXEQ3OykRqkfAgzeS+dSA@mail.gmail.com>
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
To: Fredrik Noring <noring@nocrew.org>, Richard Henderson <rth@twiddle.net>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, "Maciej W. Rozycki" <macro@linux-mips.org>, =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>

Hi Fredrik,

On Wed, Nov 14, 2018 at 4:31 PM Fredrik Noring <noring@nocrew.org> wrote:
> On Tue, Nov 13, 2018 at 11:51:54PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
[...]
> > At some point while reading your reviews, I understood the R5900
> > patches introduced incorrect behaviors for the non-R5900 cpus. In this
> > case this patch wouldn't suffice.
>
> No, that was never the case and I'm not aware of any such problems.
> However, there is a refactoring series, and we have observed preexisting
> bugs in the MIPS emulation, unrelated to the R5900. The opcode decoder
> could also be improved, such as in asserting reserved instructions in
> more cases where opcodes are invalid, etc.

Yes, we figure that out with Richard Henderson while playing with the
decodetree script.

> > Hoping I misinterpreted your reviews, then this patch is OK.
> > With one of the suggested comments:
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >
> > Then we will fix this for the 4.0 release.
>
> What exactly needs to be fixed regarding the psABI? The relevant opcodes
> would need to stay, and not be prohibited and removed as Aleksandar has
> suggested, since such opcode removal breaks the psABI requirements.
>
> Finally, as Maciej explained in some detail, the document that Aleksandar
> just recently requested is known to not exist, for any MIPS implementatio=
n,
> so we are not going to make any progress on that either.

I think this was just bad timing with the QEMU release cycles, which
stressed Aleksandar which is the only MIPS maintainer.

Since the R5900 User is a new feature, no downstream distributions
ship it, so it is safer for the community to disable/delay it,
this means we have now 3 months to improve this code, while being more rela=
xed.

The QEMU community is big, we have different cultures, live in many
timezones, speak different languages, and beside all we are humans
with our daily lives :)
I guess we all sometime stress out, that's why I think, even if
disabling this feature is technically not required (as you seem to
suggest), it is sane to disable it and get back on track together.

I believe Aleksandar is paid to maintain the MIPS TCG/KVM codebase,
and the Malta/Boston boards, all code used by his employer, which is a
huge quantity of C code.
Now the project is community based, and I understand this as it is
open as contributions like yours, or boards not backed by the MIPS
shareholders/company.
The TCG maintenance is shared with Richard, but I think the rest is
too much for a single maintainer.
Somehow the community is failing here, putting too much pressure on Aleksan=
dar.

Let's see how we can improve that during the next merge window,
hopefully the R5900 will be fixed, and eventually his little sister
R3900 will be joining too!

Regards,

Phil.
