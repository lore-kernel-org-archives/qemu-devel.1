Received: from eggs.gnu.org ([2001:4830:134:3::10]:58883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD7i-00026V-16
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD7e-00054o-SY
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:30:58 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:45496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1foD7e-00054L-M2
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:30:54 -0400
Received: by mail-pg1-x543.google.com with SMTP id f1-v6so4825308pgq.12
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:30:54 -0700 (PDT)
References: <20180810185321.20017-1-laurent@vivier.eu>
	<20180810185321.20017-2-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c000bae3-1986-1062-0dbc-a8d2feb0820e@linaro.org>
Date: Fri, 10 Aug 2018 12:30:50 -0700
MIME-Version: 1.0
In-Reply-To: <20180810185321.20017-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: fix 32bit g2h()/h2g()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>

On 08/10/2018 11:53 AM, Laurent Vivier wrote:
> sparc32plus has 64bit long type but only 32bit virtual address space.
> 
> For instance, "apt-get upgrade" failed because of a mmap()/msync()
> sequence.
> 
> mmap() returned 0xff252000 but msync() used g2h(0xffffffffff252000)
> to find the host address. The "(target_ulong)" in g2h() doesn't fix the
> address because it is 64bit long.
> 
> This patch introduces a "target_ptr" that is set to uint32_t
> if the virtual address space is addressed using 32bit in the linux-user
> case. It stays set to target_ulong with softmmu case.

I would prefer the name "abi_ptr", since the full 64-bits of target_ulong are
still used for any actual dereferences.


r~
