Received: from eggs.gnu.org ([2001:4830:134:3::10]:49893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8MR6-0003nn-RK
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f8MR1-0007to-5Q
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:58:00 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:44009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f8MR1-0007sL-0n
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 04:57:55 -0400
Received: by mail-ot0-x232.google.com with SMTP id d9-v6so20557326oth.10
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 01:57:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180416135442.30606-1-alex.bennee@linaro.org>
References: <20180416135442.30606-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Apr 2018 09:57:33 +0100
Message-ID: <CAFEAcA8SO4ZRptoTvqXuG=fidkG-ibJjmeSNLOTmk_M51icBPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fpu/softfloat: check for Inf / x or 0 / x
 before /0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Aurelien Jarno <aurelien@aurel32.net>

On 16 April 2018 at 14:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The re-factoring of div_floats changed the order of checking meaning
> an operation like -inf/0 erroneously raises the divbyzero flag.
> IEEE-754 (2008) specifies this should only occur for operations on
> finite operands.
>
> We fix this by moving the check on the dividend being Inf/0 to before
> the divisor is zero check.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Applied, thanks.

-- PMM
