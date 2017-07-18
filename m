Received: from eggs.gnu.org ([2001:4830:134:3::10]:52037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXG4f-00089P-Bb
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXG4b-0005ws-FT
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:09:13 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:34244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXG4b-0005wX-AC
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:09:09 -0400
Received: by mail-qt0-x231.google.com with SMTP id 32so4135607qtv.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:09:09 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-35-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <331bf783-3426-e28b-3c18-31a8a47238d4@twiddle.net>
Date: Mon, 17 Jul 2017 14:09:04 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-35-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 34/45] tcg: define tcg_init_ctx and make
 tcg_ctx a pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/16/2017 10:04 AM, Emilio G. Cota wrote:
> Groundwork for supporting multiple TCG contexts.
> 
> The core of this patch is this change to tcg/tcg.h:
> 
>> -extern TCGContext tcg_ctx;
>> +extern TCGContext tcg_init_ctx;
>> +extern TCGContext *tcg_ctx;
> Note that for now we set *tcg_ctx to whatever TCGContext is passed
> to tcg_context_init -- in this case &tcg_init_ctx.
> 
> To avoid diff churn we could do something like
>> TCGContext *tcg_ctx_ptr;
>> #define tcg_ctx (*tcg_ctx_ptr)
> as Richard suggested during review, but sooner or later
> we'd end up doing the conversion anyway, so do it now.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---

That is indeed fewer instances than I would have guessed.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
