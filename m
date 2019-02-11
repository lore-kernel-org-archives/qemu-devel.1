Received: from eggs.gnu.org ([209.51.188.92]:47835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtEbb-00076k-F9
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:38:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtEbX-0006re-E2
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:38:51 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtEbW-0006f0-Lg
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:38:46 -0500
Received: by mail-pl1-x644.google.com with SMTP id s1so5528931plp.9
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 08:38:32 -0800 (PST)
References: <1548985244-24523-1-git-send-email-catherine.hecx@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eeb0f275-b262-25db-337a-b6c78b29c124@linaro.org>
Date: Mon, 11 Feb 2019 08:11:00 -0800
MIME-Version: 1.0
In-Reply-To: <1548985244-24523-1-git-send-email-catherine.hecx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] target/arm: Fix int128_make128 lo,
 hi order in paired_cmpxchg64_be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Catherine Ho <catherine.hecx@gmail.com>, "Emilio G. Cota" <cota@braap.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 1/31/19 5:40 PM, Catherine Ho wrote:
> The lo,hi order is different from the comments. And in commit
> 1ec182c33379 ("target/arm: Convert to HAVE_CMPXCHG128"), it changes
> the original code logic. So just restore the old code logic before this 
> commit:
> do_paired_cmpxchg64_be():
>     cmpv = int128_make128(env->exclusive_high, env->exclusive_val);
>     newv = int128_make128(new_hi, new_lo);
> 
> Fixes: 1ec182c33379 ("target/arm: Convert to HAVE_CMPXCHG128")
> 
> Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> ---


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
