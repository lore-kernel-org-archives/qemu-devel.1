Received: from eggs.gnu.org ([2001:4830:134:3::10]:39781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWJ1l-0005j7-6H
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:10:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWJ1k-0002aX-CV
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:10:49 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:42587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWJ1k-0002aR-7g
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:10:48 -0400
Received: by mail-ot0-x244.google.com with SMTP id 92-v6so6902611otw.9
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 03:10:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622080138.17702-1-jusual@mail.ru>
References: <20180622080138.17702-1-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 11:10:27 +0100
Message-ID: <CAFEAcA8qGeXOtCfa=G8zDyJ5XxGR5Y+bQzPduPQJjcR9bK1sXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Strict alignment for ARMv6-M and
 ARMv8-M Baseline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 22 June 2018 at 09:01, Julia Suvorova <jusual@mail.ru> wrote:
> v2:
>     * Added feature bit for the Main Extention
>     * Alignment patch is modified to use ARM_FEATURE_M_MAIN
>
> Julia Suvorova (2):
>   target/arm: Introduce ARM_FEATURE_M_MAIN
>   target/arm: Strict alignment for ARMv6-M and ARMv8-M Baseline
>
>  target/arm/cpu.c       |  3 +++
>  target/arm/cpu.h       |  1 +
>  target/arm/translate.c | 18 ++++++++++++++++--
>  3 files changed, 20 insertions(+), 2 deletions(-)



Applied to target-arm.next, thanks.

-- PMM
