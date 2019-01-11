Received: from eggs.gnu.org ([209.51.188.92]:47827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gi3oQ-0001vu-K2
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 15:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gi3oP-0005hX-Qr
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 15:53:54 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:38569)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gi3oP-0005go-BF
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 15:53:53 -0500
Received: by mail-pl1-x633.google.com with SMTP id e5so7265337plb.5
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 12:53:52 -0800 (PST)
References: <20190111114918.27893-1-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c75e59c4-7602-a737-16bb-8e5c4d0a6085@linaro.org>
Date: Sat, 12 Jan 2019 07:53:44 +1100
MIME-Version: 1.0
In-Reply-To: <20190111114918.27893-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: rework zero overhead loops
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org

On 1/11/19 10:49 PM, Max Filippov wrote:
> +#define LINKABLE_BITS 12
> +#define LINKABLE_SIZE (1u << LINKABLE_BITS)
> +#define LINKABLE_MASK (-LINKABLE_SIZE)

What is this for?  It seems to be replicating TARGET_PAGE_BITS.


r~
