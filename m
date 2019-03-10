Received: from eggs.gnu.org ([209.51.188.92]:58443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h2sB2-0002Yd-Nw
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 01:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h2sB1-0003yt-Rx
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 01:43:16 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:38014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h2sB1-0003yb-KK
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 01:43:15 -0500
Received: by mail-pf1-x431.google.com with SMTP id n125so1294460pfn.5
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 22:43:15 -0800 (PST)
References: <20190307144126.31847-1-richard.henderson@linaro.org>
	<20190307144126.31847-4-richard.henderson@linaro.org>
	<CAL1e-=iVz3aKwz6-DxjWgLxhx32_PdA45Kk6Uh7f1ezatv6SdQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <09ea64b5-ed4e-0047-7578-1db9c9ec469b@linaro.org>
Date: Sat, 9 Mar 2019 22:43:10 -0800
MIME-Version: 1.0
In-Reply-To: <CAL1e-=iVz3aKwz6-DxjWgLxhx32_PdA45Kk6Uh7f1ezatv6SdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/9] tcg: Use extract2 in tcg_gen_shifti_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "david@redhat.com" <david@redhat.com>

On 3/9/19 12:30 PM, Aleksandar Markovic wrote:
> 
> 
> On Thursday, March 7, 2019, Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     Signed-off-by: Richard Henderson <richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>>
>     ---
>      tcg/tcg-op.c | 47 ++++++++++++++++++++++++-----------------------
>      1 file changed, 24 insertions(+), 23 deletions(-)
> 
> 
> Extract2 is not a good name for this new function, IMHO.

If you're going to bike shed the name, you should suggest something else.

But I think it's a pretty good name, since it extracts one register output out
of two register inputs.


r~
