Received: from eggs.gnu.org ([2001:4830:134:3::10]:39088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3iC-0005w5-4z
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG3i7-0002De-LD
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:07:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG3i5-00029G-Em
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:07:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id u1-v6so1740525wrn.0
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:07:33 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-30-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <74c0c4a9-f074-896d-d37e-d61472a97924@linaro.org>
Date: Fri, 26 Oct 2018 16:07:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-30-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 30/71] cpu: define cpu_interrupt_request
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 10/25/18 3:46 PM, Emilio G. Cota wrote:
> Add a comment about how atomic_read works here. The comment refers to
> a "BQL-less CPU loop", which will materialize toward the end
> of this series.
> 
> Note that the modifications to cpu_reset_interrupt are there to
> avoid deadlock during the CPU lock transition; once that is complete,
> cpu_interrupt_request will be simple again.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  include/qom/cpu.h | 37 +++++++++++++++++++++++++++++++++++++
>  qom/cpu.c         | 27 +++++++++++++++++++++------
>  2 files changed, 58 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
