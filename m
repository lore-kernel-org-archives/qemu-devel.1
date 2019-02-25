Received: from eggs.gnu.org ([209.51.188.92]:55181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gyIze-0007Ea-H8
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1gyIzc-0000wl-JC
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:20:38 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:38895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1gyIza-0000v9-MN
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:20:36 -0500
Received: by mail-pf1-x42d.google.com with SMTP id n125so4728133pfn.5
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 08:20:33 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190225154204.26751-1-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <dbf52f31-42fe-341e-0466-6636ab51e13f@twiddle.net>
Date: Mon, 25 Feb 2019 08:20:29 -0800
MIME-Version: 1.0
In-Reply-To: <20190225154204.26751-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] tcg: Implement tcg_gen_shri2_i64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org

On 2/25/19 7:42 AM, David Hildenbrand wrote:
> Will be helpful for s390x. Input 128 bit and output 64 bit only, which
> is sufficient for now.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v1 -> v2:
> - Use one output (lower part) only
> - Shield off big shifts by an assert
> 
>  tcg/tcg-op.c | 15 +++++++++++++++
>  tcg/tcg-op.h |  1 +
>  2 files changed, 16 insertions(+)

Thanks, queued.


r~
