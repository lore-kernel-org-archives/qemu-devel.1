Received: from eggs.gnu.org ([2001:4830:134:3::10]:49712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g0BIS-0004sK-T2
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 15:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g0BIN-00040M-Qf
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 15:59:32 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:44446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g0BIN-000407-1a
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 15:59:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id ba4-v6so1471813plb.11
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 12:59:26 -0700 (PDT)
References: <20180830193019.20104-1-jancraig@amazon.com>
	<20180830193019.20104-2-jancraig@amazon.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7bd83ad3-0286-3207-4e4d-de4f390ca43a@linaro.org>
Date: Wed, 12 Sep 2018 12:59:22 -0700
MIME-Version: 1.0
In-Reply-To: <20180830193019.20104-2-jancraig@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/9] target/mips: Introduce MXU registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Craig Janeczek <jancraig@amazon.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com

On 08/30/2018 12:30 PM, Craig Janeczek via Qemu-devel wrote:
> +static const char * const mxuregnames[] = {
> +    "XR1", "XR2",  "XR3",  "XR4",  "XR5",  "XR6",  "XR7",  "XR8",
> +    "XR9", "XR10", "XR11", "XR12", "XR13", "XR14", "XR15", "XR16",
> +};

XR16 is unused.  Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
