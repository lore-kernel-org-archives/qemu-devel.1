Received: from eggs.gnu.org ([209.51.188.92]:43947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gs9Oc-0007BK-1j
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:52:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gs9Ob-0003Fw-7K
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:52:57 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gs9Oa-0003Et-GM
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 11:52:57 -0500
Received: by mail-pl1-x644.google.com with SMTP id s1so1933435plp.9
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 08:52:55 -0800 (PST)
References: <20190208035551.3036-1-richard.henderson@linaro.org>
	<9fb2cbe0-40ae-5734-56af-99765a59d0ec@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cc2d9846-354d-aa86-a245-6cd9f6e5aa56@linaro.org>
Date: Fri, 8 Feb 2019 08:52:51 -0800
MIME-Version: 1.0
In-Reply-To: <9fb2cbe0-40ae-5734-56af-99765a59d0ec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Diagnose referenced labels that have
 not been emitted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org

On 2/8/19 2:41 AM, Philippe Mathieu-Daudé wrote:
> Not related to this patch content, but I'm wondering why, TCGLabels
> never get freed?

They are allocated with tcg_malloc, which is a pool allocator.  The entire pool
is freed after each TB is compiled.


r~
