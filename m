Received: from eggs.gnu.org ([2001:4830:134:3::10]:55604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eiLmg-00049D-Lm
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 10:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eiLmf-0002Ho-Vc
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 10:00:46 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:41295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eiLmf-0002HY-Pv
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 10:00:45 -0500
Received: by mail-ot0-x241.google.com with SMTP id r23so23209182ote.8
	for <qemu-devel@nongnu.org>; Sun, 04 Feb 2018 07:00:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 4 Feb 2018 15:00:24 +0000
Message-ID: <CAFEAcA8+zNg8S=sFuUwPKjzzJZFUYDZFU11nH+_M60wuXRAVrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/24] re-factor and add fp16 using glibc
 soft-fp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "Emilio G. Cota" <cota@braap.org>, hsp.cat7@gmail.com

On 4 February 2018 at 04:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Or there's the code from glibc.  I know Peter didn't like the idea;
> debugging this code is fairly painful -- the massive preprocessor
> macros mean that you can't step through anything.  But at least we
> have a good relationship with glibc, so merging patches back and
> forth should be easy.

Yeah. I didn't like dealing with this code two decades ago
when I first encountered it, and it hasn't improved any.
It's pretty much write-only code, and it isn't going to be
any fun for debugging.

thanks
-- PMM
