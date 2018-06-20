Received: from eggs.gnu.org ([2001:4830:134:3::10]:56395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVd7P-0003tj-Jh
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVd7O-0004kP-PU
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:25:51 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:39360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVd7O-0004kI-B4
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:25:50 -0400
Received: by mail-ot0-x242.google.com with SMTP id l15-v6so3670981oth.6
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 06:25:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180618214604.6777-1-jusual@mail.ru>
References: <20180618214604.6777-1-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 14:25:29 +0100
Message-ID: <CAFEAcA_xqRp+2uM9irvztTPEbM0CXuBL_=96_UK35-jVYDuK1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Minor cleanup for ARMv6-M
 32-bit instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Richard Henderson <richard.henderson@linaro.org>

On 18 June 2018 at 22:46, Julia Suvorova <jusual@mail.ru> wrote:
> The arrays were made static, "if" was simplified because V7M and V8M
> define V6 feature.
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  target/arm/translate.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)



Applied to target-arm.next, thanks.

-- PMM
