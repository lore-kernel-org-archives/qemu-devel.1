Received: from eggs.gnu.org ([2001:4830:134:3::10]:50946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXG2N-0005wk-5l
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXG2K-0004p0-U7
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:06:51 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:34823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXG2K-0004og-OU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:06:48 -0400
Received: by mail-qt0-x22a.google.com with SMTP id b40so4037042qtb.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:06:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
	<1500235468-15341-31-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f0525885-943e-3ea3-f3b1-e04a93861ab4@twiddle.net>
Date: Mon, 17 Jul 2017 14:06:43 -1000
MIME-Version: 1.0
In-Reply-To: <1500235468-15341-31-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 30/45] translate-all: report correct avg
 host TB size
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
> Since commit 6e3b2bfd6 ("tcg: allocate TB structs before the
> corresponding translated code") we are not fully utilizing
> code_gen_buffer for translated code, and therefore are
> incorrectly reporting the amount of translated code as well as
> the average host TB size. Address this by:
> 
> - Making the conscious choice of misreporting the total translated code;
>    doing otherwise would mislead users into thinking "-tb-size" is not
>    honoured.
> 
> - Expanding tb_tree_stats to accurately count the bytes of translated code on
>    the host, and using this for reporting the average tb host size,
>    as well as the expansion ratio.
> 
> In the future we might want to consider reporting the accurate numbers for
> the total translated code, together with a "bookkeeping/overhead" field to
> account for the TB structs.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   accel/tcg/translate-all.c | 32 +++++++++++++++++++++++---------
>   1 file changed, 23 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
