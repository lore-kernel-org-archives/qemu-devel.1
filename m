Received: from [2001:4830:134:3::10] (port=60072 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fpd0P-0005ki-8r
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fpd0G-0002Oo-Hm
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:21:13 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:44158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fpd0G-0002OD-AJ
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 13:21:08 -0400
Received: by mail-pl0-x243.google.com with SMTP id ba4-v6so8573742plb.11
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 10:21:05 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180814171217.14680-1-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <07d0ba1c-f7d9-26e3-6120-3c9693ea339e@twiddle.net>
Date: Tue, 14 Aug 2018 10:21:01 -0700
MIME-Version: 1.0
In-Reply-To: <20180814171217.14680-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix 32bit g2h()/h2g()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>

On 08/14/2018 10:12 AM, Laurent Vivier wrote:
> sparc32plus has 64bit long type but only 32bit virtual address space.
> 
> For instance, "apt-get upgrade" failed because of a mmap()/msync()
> sequence.
> 
> mmap() returned 0xff252000 but msync() used g2h(0xffffffffff252000)
> to find the host address. The "(target_ulong)" in g2h() doesn't fix the
> address because it is 64bit long.
> 
> This patch introduces an "abi_ptr" that is set to uint32_t
> if the virtual address space is addressed using 32bit in the linux-user
> case. It stays set to target_ulong with softmmu case.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     v2: s/target_ptr/abi_ptr/
>         remove strace msync patch from the series

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
