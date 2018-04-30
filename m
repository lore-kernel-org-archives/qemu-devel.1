Received: from eggs.gnu.org ([2001:4830:134:3::10]:35487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDCYq-0008SB-PF
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDCYp-0007nm-Vp
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:26:00 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:42480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fDCYp-0007nY-RD
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:25:59 -0400
Received: by mail-ot0-x241.google.com with SMTP id l13-v6so10317222otk.9
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 10:25:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180430170156.1860-2-laurent@vivier.eu>
References: <20180430170156.1860-1-laurent@vivier.eu>
	<20180430170156.1860-2-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 18:25:38 +0100
Message-ID: <CAFEAcA9q5fVc1W7Xhv8h8Ap-JezGqJ_gD0d-t3gDj0abA7NKZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/2] m68k: remove dead code (Coverity
 CID1390617)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 April 2018 at 18:01, Laurent Vivier <laurent@vivier.eu> wrote:
> floatx80_sin() and floatx80_cos() are derived from one
> sincos() function. They have both unused code coming from
> their common origin. Remove it.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/softfloat.c | 43 ++++++++++++++-----------------------------
>  1 file changed, 14 insertions(+), 29 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
