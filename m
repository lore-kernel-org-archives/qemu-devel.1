Received: from eggs.gnu.org ([2001:4830:134:3::10]:34026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pGC-0000VF-5M
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pG9-0007pR-3S
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:48:08 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:51999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e6pG8-0007pL-VO
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 22:48:05 -0400
Received: by mail-qt0-x230.google.com with SMTP id h4so28710720qtk.8
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 19:48:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
	<20171020232023.15010-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1641896e-b9b4-f663-0e4b-da363fa8c608@amsat.org>
Date: Mon, 23 Oct 2017 23:47:57 -0300
MIME-Version: 1.0
In-Reply-To: <20171020232023.15010-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 08/52] tcg: Introduce temp_arg,
 export temp_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>

On 10/20/2017 08:19 PM, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
> 
> At the same time, adrop the TCGContext argument and use tcg_ctx instead.
> 
> Reviewed-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tcg/tcg.h | 12 ++++++++++++
>  tcg/tcg.c | 19 ++++++-------------
>  2 files changed, 18 insertions(+), 13 deletions(-)
