Received: from eggs.gnu.org ([2001:4830:134:3::10]:34252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYwq7-00034Q-Kq
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYwq6-00063a-Pd
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:33:27 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:38019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eYwq6-00062k-KR
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:33:26 -0500
Received: by mail-pf0-x243.google.com with SMTP id k19so1857830pfj.5
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 08:33:26 -0800 (PST)
References: <20180108172904.8772-1-f4bug@amsat.org>
	<20180108172904.8772-5-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5d8097eb-3300-56b5-adc4-94fb8de9c0ba@linaro.org>
Date: Tue, 9 Jan 2018 08:33:22 -0800
MIME-Version: 1.0
In-Reply-To: <20180108172904.8772-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/12] slirp: add in6_multicast() and use
 it instead of IN6_IS_ADDR_MULTICAST()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On 01/08/2018 09:28 AM, Philippe Mathieu-Daudé wrote:
> Host: Mac OS 10.12.5
> Compiler: Apple LLVM version 8.1.0 (clang-802.0.42)
> 
>   slirp/ip6_icmp.c:79:32: warning: taking address of packed member 'ip_src' of class or
>         structure 'ip6' may result in an unaligned pointer value
>         [-Waddress-of-packed-member]
>       if (IN6_IS_ADDR_MULTICAST(&ip->ip_src) ||
>                                  ^~~~~~~~~~
>   /usr/include/netinet6/in6.h:299:36: note: expanded from macro 'IN6_IS_ADDR_MULTICAST'
>   #define IN6_IS_ADDR_MULTICAST(a)        ((a)->s6_addr[0] == 0xff)

The fact that you replace a macro with a function of exactly the same code in
order to avoid a diagnostic sure looks like a compiler bug to me.


r~
