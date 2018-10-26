Received: from eggs.gnu.org ([2001:4830:134:3::10]:54397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4Rx-0004xC-Gd
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gG4Rw-0002NY-5F
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:55:01 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:54163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gG4Rv-0002MD-R9
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:55:00 -0400
Received: by mail-wm1-x336.google.com with SMTP id l26-v6so1989073wmh.3
	for <qemu-devel@nongnu.org>; Fri, 26 Oct 2018 08:54:58 -0700 (PDT)
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-65-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dfedf084-5ab7-e29b-d81a-bb1421c85dde@linaro.org>
Date: Fri, 26 Oct 2018 16:54:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181025144644.15464-65-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 65/71] xtensa: convert to
 cpu_has_work_with_iothread_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>

On 10/25/18 3:46 PM, Emilio G. Cota wrote:
> Soon we will call cpu_has_work without the BQL.
> 
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/xtensa/cpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
