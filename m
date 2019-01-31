Received: from eggs.gnu.org ([209.51.188.92]:47807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpK74-0001HG-Rf
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gpK74-0003Nq-0d
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:43:10 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gpK73-0003Mw-9a
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:43:09 -0500
Received: by mail-pl1-x644.google.com with SMTP id y1so2070487plp.9
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 13:43:08 -0800 (PST)
References: <1548838794-23757-1-git-send-email-catherine.hecx@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1a825a83-3140-0723-74ee-6b74149e4325@linaro.org>
Date: Thu, 31 Jan 2019 13:43:04 -0800
MIME-Version: 1.0
In-Reply-To: <1548838794-23757-1-git-send-email-catherine.hecx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg: add early clober modifier in
 atomic16_cmpxchg on aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Catherine Ho <catherine.hecx@gmail.com>, "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 1/30/19 12:59 AM, Catherine Ho wrote:
> Without this patch, gcc might up the Input/Output registers and
> cause unpredictable error.
> 
> Fixes: 1ec182c33379 ("target/arm: Convert to HAVE_CMPXCHG128")
> 
> Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>

Queued, thanks.


r~
