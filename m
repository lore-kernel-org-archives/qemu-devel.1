Received: from eggs.gnu.org ([2001:4830:134:3::10]:33861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAfML-0001AR-H6
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 13:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAfMK-0001dH-7o
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 13:34:37 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:35945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fAfMK-0001cd-1x
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 13:34:36 -0400
Received: by mail-pf0-x22b.google.com with SMTP id g14so9890734pfh.3
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 10:34:35 -0700 (PDT)
References: <20180423162523.6392-1-f4bug@amsat.org>
	<20180423162523.6392-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <756704ca-f41d-d0ec-fb57-cd844b6164e6@linaro.org>
Date: Mon, 23 Apr 2018 07:34:30 -1000
MIME-Version: 1.0
In-Reply-To: <20180423162523.6392-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] loader: Fix 64-bit misaligned
 member access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paul Burton <paul.burton@mips.com>, qemu-devel@nongnu.org

On 04/23/2018 06:25 AM, Philippe Mathieu-Daudé wrote:
> Assuming the base of the fdt is aligned, a 32-bit property returns
> a 32-bit aligned pointer...
...
>      case 4:
> -        *addr = fdt32_to_cpu(*(fdt32_t *)prop);
> +        *addr = fdt32_to_cpu(ldl_he_p(prop));
>          return 0;

So why are you changing the 32-bit case?


r~
