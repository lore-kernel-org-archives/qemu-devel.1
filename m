Received: from eggs.gnu.org ([2001:4830:134:3::10]:33396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1drcdw-0001Qz-Vb
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1drcdt-0007NB-RN
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:17:48 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:33311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1drcdt-0007MW-Lc
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:17:45 -0400
Received: by mail-pg0-x22d.google.com with SMTP id u18so2621197pgo.0
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 21:17:44 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170911204936.5020-1-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6caf4eee-33e6-1022-a05a-23257ecf596f@twiddle.net>
Date: Mon, 11 Sep 2017 21:17:39 -0700
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
> this fixes building for ppc64 on ppc32 (changed in 5964fca8a12c):
> 
>   qemu/tcg/ppc/tcg-target.inc.c: In function 'tb_target_set_jmp_target':
>   qemu/include/qemu/compiler.h:86:30: error: static assertion failed: "not expecting: sizeof(*(uint64_t *)jmp_addr) > ATOMIC_REG_SIZE"
>        QEMU_BUILD_BUG_ON(sizeof(*ptr) > ATOMIC_REG_SIZE); \
>        ^
>   qemu/tcg/ppc/tcg-target.inc.c:1377:9: note: in expansion of macro 'atomic_set'
>            atomic_set((uint64_t *)jmp_addr, pair);
>            ^
> 
> Suggested-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> This fixes Shippable builds, see:
> https://app.shippable.com/github/qemu/qemu/runs/434/10/console

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
