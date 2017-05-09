Received: from eggs.gnu.org ([2001:4830:134:3::10]:53690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CRR-00054k-Na
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CRQ-0000as-W4
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:13:09 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:34144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8CRQ-0000ao-Rs
	for qemu-devel@nongnu.org; Tue, 09 May 2017 17:13:08 -0400
Received: by mail-qt0-x234.google.com with SMTP id j29so12069162qtj.1
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 14:13:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-15-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2d3e6a02-940b-c985-d191-02a68f57667a@twiddle.net>
Date: Tue, 9 May 2017 14:13:05 -0700
MIME-Version: 1.0
In-Reply-To: <20170506111431.12548-15-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 14/14] target/sh4: trap unaligned
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/06/2017 04:14 AM, Aurelien Jarno wrote:
> +void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> +                                    MMUAccessType access_type,
> +                                    int mmu_idx, uintptr_t retaddr)
> +{
> +    if (retaddr) {
> +        cpu_restore_state(cs, retaddr);
> +    }
...
> +    cpu_loop_exit(cs);
> +}
> +

cpu_loop_exit_restore?

Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
