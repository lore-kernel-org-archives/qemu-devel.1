Received: from eggs.gnu.org ([2001:4830:134:3::10]:52049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY6Bf-0008LT-RC
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dY6Bb-00074M-Vr
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:47:55 -0400
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233]:38308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dY6Bb-00074A-RL
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 03:47:51 -0400
Received: by mail-qk0-x233.google.com with SMTP id g6so10475011qkf.5
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 00:47:51 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
	<1500520169-23367-37-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <301b117a-fca2-9f37-b98b-38adfeb8e62f@twiddle.net>
Date: Wed, 19 Jul 2017 21:47:44 -1000
MIME-Version: 1.0
In-Reply-To: <1500520169-23367-37-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 36/43] tcg: introduce **tcg_ctxs to keep
 track of all TCGContext's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/19/2017 05:09 PM, Emilio G. Cota wrote:
> Groundwork for supporting multiple TCG contexts.
> 
> Note that having n_tcg_ctxs is unnecessary. However, it is
> convenient to have it, since it will simplify iterating over the
> array: we'll have just a for loop instead of having to iterate
> over a NULL-terminated array (which would require n+1 elems)
> or having to check with ifdef's for usermode/softmmu.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   tcg/tcg.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
