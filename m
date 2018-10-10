Received: from eggs.gnu.org ([2001:4830:134:3::10]:52419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAFRQ-0006cE-OR
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAFRN-0008MP-KW
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:26:24 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAFRN-0008Lh-D6
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 10:26:21 -0400
Received: by mail-pl1-x644.google.com with SMTP id q17-v6so2625488plr.8
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 07:26:20 -0700 (PDT)
References: <20181009181612.10633-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <03960e60-6441-ddec-c849-ed17442f1fea@linaro.org>
Date: Wed, 10 Oct 2018 07:26:16 -0700
MIME-Version: 1.0
In-Reply-To: <20181009181612.10633-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] coccinelle: new inplace-byteswaps.cocci to
 remove inplace-byteswapping calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 10/9/18 11:16 AM, Peter Maydell wrote:
> Add a new Coccinelle script which replaces uses of the inplace
> byteswapping functions *_to_cpus() and cpu_to_*s() with their
> not-in-place equivalents. This is useful for where the swapping
> is done on members of a packed struct -- taking the address
> of the member to pass it to an inplace function is undefined
> behaviour in C.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Richard asked for a coccinelle script in the scripts/coccinelle
> directory, so here's a patch to add it.
> 
>  scripts/coccinelle/inplace-byteswaps.cocci | 65 ++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 scripts/coccinelle/inplace-byteswaps.cocci

Thanks,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
