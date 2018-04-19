Received: from eggs.gnu.org ([2001:4830:134:3::10]:50702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9FO2-0001EK-4I
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9FNx-0006NQ-Md
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:38:30 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:40612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9FNx-0006M9-DY
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 15:38:25 -0400
Received: by mail-pl0-x241.google.com with SMTP id t22-v6so3836782plo.7
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 12:38:25 -0700 (PDT)
References: <20180419164642.9536-1-f4bug@amsat.org>
	<20180419164642.9536-7-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <deab5c4f-6ae8-f446-ea25-06b30f9efb70@linaro.org>
Date: Thu, 19 Apr 2018 09:38:18 -1000
MIME-Version: 1.0
In-Reply-To: <20180419164642.9536-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 6/7] avocado: Add a test parsing Linux
 kernel booting console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Alistair Francis <alistair23@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On 04/19/2018 06:46 AM, Philippe Mathieu-Daudé wrote:
> Booting an Alpha DP264 machine.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/avocado/test_linux-boot-console.py      | 88 +++++++++++++++++++
>  .../parameters.yaml                           |  3 +
>  2 files changed, 91 insertions(+)
>  create mode 100644 tests/avocado/test_linux-boot-console.py
>  create mode 100644 tests/avocado/test_linux-boot-console.py.data/parameters.yaml
> 
> diff --git a/tests/avocado/test_linux-boot-console.py b/tests/avocado/test_linux-boot-console.py
> new file mode 100644
> index 0000000000..f54d10dd79
> --- /dev/null
> +++ b/tests/avocado/test_linux-boot-console.py
> @@ -0,0 +1,88 @@
> +# -*- coding: utf-8 -*-
> +#
> +# Boot a Linux kernel on the Malta board and check the serial console output

Not a malta.  ;-)
Otherwise

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~
