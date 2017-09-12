Received: from eggs.gnu.org ([2001:4830:134:3::10]:41948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1droYm-0003Hn-N8
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 13:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1droYk-0006al-57
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 13:01:16 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:34437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1droYk-0006aR-08
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 13:01:14 -0400
Received: by mail-pf0-x235.google.com with SMTP id e1so19583087pfk.1
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 10:01:13 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170911204936.5020-1-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e4be431e-0c31-baf7-7e0b-8419fa507478@twiddle.net>
Date: Tue, 12 Sep 2017 10:01:09 -0700
MIME-Version: 1.0
In-Reply-To: <20170911204936.5020-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg/ppc: disable atomic write check on
 ppc32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On 09/11/2017 01:49 PM, Philippe Mathieu-Daudé wrote:
> -        atomic_set((uint64_t *)jmp_addr, pair);
> +        atomic_set__nocheck((uint64_t *)jmp_addr, pair);
>          flush_icache_range(jmp_addr, jmp_addr + 8);
>      } else {
>          intptr_t diff = addr - jmp_addr;
> 

Queued, thanks.


r~
