Received: from eggs.gnu.org ([2001:4830:134:3::10]:37102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXb9A-0007OW-7C
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXb96-0003du-94
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:16:04 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:40292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXb93-0003J5-8V
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:15:58 -0500
Received: by mail-oi1-x230.google.com with SMTP id t204so3176463oie.7
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 16:15:53 -0800 (PST)
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-9-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <720e0968-0b1c-26ce-ac19-7ba44e2a6f77@linaro.org>
Date: Thu, 13 Dec 2018 17:52:40 -0600
MIME-Version: 1.0
In-Reply-To: <20181209193749.12277-9-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v2 08/38] tcg: drop nargs from
 tcg_op_insert_{before, after}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

On 12/9/18 1:37 PM, Emilio G. Cota wrote:
> It's unused.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  tcg/tcg.h      |  4 ++--
>  tcg/optimize.c |  4 ++--
>  tcg/tcg.c      | 10 ++++------
>  3 files changed, 8 insertions(+), 10 deletions(-)

Cherry-picked this into tcg-next.
The nargs argument is unused since 75e8b9b7aa0b95a761b9add7e2f09248b101a392.


r~
