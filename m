Received: from eggs.gnu.org ([2001:4830:134:3::10]:56862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cXUGZ-0004Jg-9D
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 09:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cXUGY-0007jf-Ie
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 09:46:11 -0500
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:36749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cXUGY-0007jR-Ce
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 09:46:10 -0500
Received: by mail-ua0-x229.google.com with SMTP id 96so224018774uaq.3
	for <qemu-devel@nongnu.org>; Sat, 28 Jan 2017 06:46:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170128131607.26951.44105.malonedeb@wampee.canonical.com>
References: <20170128131607.26951.44105.malonedeb@wampee.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 28 Jan 2017 14:45:49 +0000
Message-ID: <CAFEAcA_Kz5UEjJRbaipPzPD9hJuQRMwJZNQvmb1sUNDTnzi6Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1660035] [NEW] hw/timer/altera_timer.c:207:
 bad size in memset ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1660035 <1660035@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Chris Wulff <crwulff@gmail.com>

On 28 January 2017 at 13:16, dcb <1660035@bugs.launchpad.net> wrote:
> Public bug reported:
>
> hw/timer/altera_timer.c:207:5: warning: =E2=80=98memset=E2=80=99 used wit=
h length equal
> to number of elements without multiplication by element size [-Wmemset-
> elt-size]
>
> Source code is
>
>      memset(t->regs, 0, ARRAY_SIZE(t->regs));
>
> Maybe better code
>
>      memset(t->regs, 0, R_MAX * sizeof( uint32_t));

Better still -- just memset(t->regs, 0, sizeof(t->regs));

Chris, could you send a patch to fix this, please?

thanks
-- PMM
