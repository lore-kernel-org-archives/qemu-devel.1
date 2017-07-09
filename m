Received: from eggs.gnu.org ([2001:4830:134:3::10]:58269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJ96-00009g-4s
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJ93-0004mR-38
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:49:36 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUJ92-0004mG-Si
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:49:33 -0400
Received: by mail-pf0-f169.google.com with SMTP id c73so39822631pfk.2
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 13:49:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-20-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <87ce6f03-0895-a2a8-eba2-573145507c07@twiddle.net>
Date: Sun, 9 Jul 2017 10:48:27 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-20-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/22] tcg: introduce tcg_context_clone
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> @@ -409,6 +411,18 @@ void tcg_context_init(TCGContext *s)
>   }
>   
>   /*
> + * Clone the initial TCGContext. Used by TCG threads to copy the TCGContext
> + * set up by their parent thread via tcg_context_init().
> + */
> +void tcg_context_clone(TCGContext *s)
> +{
> +    if (unlikely(tcg_init_ctx == NULL || tcg_init_ctx == s)) {
> +        tcg_abort();
> +    }
> +    memcpy(s, tcg_init_ctx, sizeof(*s));
> +}

Under what conditions will this be called?  How much of this might you need to 
zero out again after the fact?


r~
