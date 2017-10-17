Received: from eggs.gnu.org ([2001:4830:134:3::10]:49267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4V4n-0005xa-ND
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4V4j-0005t6-Jl
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:50:45 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:44834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4V4j-0005sw-De
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:50:41 -0400
Received: by mail-pf0-x22e.google.com with SMTP id x7so1768609pfa.1
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 09:50:41 -0700 (PDT)
References: <20171017121714.24714-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1ab4f800-9701-3774-6630-98f549df7a79@linaro.org>
Date: Tue, 17 Oct 2017 09:50:37 -0700
MIME-Version: 1.0
In-Reply-To: <20171017121714.24714-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] watch_mem_write: implement 8-byte accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Andrew.Baumann@microsoft.com, rth@twiddle.net

On 10/17/2017 05:17 AM, Paolo Bonzini wrote:
> Aligned 8-byte memory writes by a 64-bit target on a 64-bit host should
> always turn into atomic 8-byte writes on the host, however a write
> write watchpoint would end up tearing the 8-byte write into two 4-byte
> writes in access_with_adjusted_size().
> 
> Reported-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  exec.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
