Received: from eggs.gnu.org ([2001:4830:134:3::10]:38901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXUoc-0000BE-QS
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXUoc-00073A-5K
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:58:10 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:42185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXUoc-00072u-0D
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:58:10 -0400
Received: by mail-oi0-x231.google.com with SMTP id n84-v6so5549889oib.9
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:58:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621015359.12018-15-richard.henderson@linaro.org>
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 17:57:48 +0100
Message-ID: <CAFEAcA9geF6VOCGnb5D0935UP1WwbBHXWKrmY379ztPJsoBRiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 14/35] target/arm: Implement SVE
 first-fault gather loads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 June 2018 at 02:53, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-sve.h    |  67 ++++++++++++++++++++
>  target/arm/sve_helper.c    |  88 ++++++++++++++++++++++++++
>  target/arm/translate-sve.c | 126 ++++++++++++++++++++++++-------------
>  3 files changed, 236 insertions(+), 45 deletions(-)

...ah, I see the answer about FF loads is "in the next patch"...


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
