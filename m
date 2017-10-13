Received: from eggs.gnu.org ([2001:4830:134:3::10]:40377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e36C5-0007Dd-TF
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e36C2-0008Kc-Q3
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:04:29 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:55389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e36C2-0008JD-Jl
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 16:04:26 -0400
Received: by mail-pf0-x22c.google.com with SMTP id 17so11180829pfn.12
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 13:04:26 -0700 (PDT)
References: <20171013181913.7556-1-Andrew.Baumann@microsoft.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <669d753c-fa83-8f0a-c366-37f468e9e502@linaro.org>
Date: Fri, 13 Oct 2017 13:04:22 -0700
MIME-Version: 1.0
In-Reply-To: <20171013181913.7556-1-Andrew.Baumann@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] notdirty_mem_write: implement 8-byte
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On 10/13/2017 11:19 AM, Andrew Baumann wrote:
> Aligned 8-byte memory writes by a 64-bit target on a 64-bit host should
> always turn into atomic 8-byte writes on the host, however if we missed
> in the softmmu, and the TLB line was marked as not dirty, then we
> would end up tearing the 8-byte write into two 4-byte writes in
> access_with_adjusted_size().
> 
> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> ---
> This manifested as a race in lock-free synchronisation with an aarch64
> Windows guest on an x86-64 host (with multithreaded TCG).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
