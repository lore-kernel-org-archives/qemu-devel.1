Received: from eggs.gnu.org ([2001:4830:134:3::10]:47408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLAUO-0005cV-1B
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dLAUJ-0004SG-Vf
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:45:48 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dLAUJ-0004S8-R4
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 11:45:43 -0400
Received: by mail-qt0-x241.google.com with SMTP id s33so642114qtg.3
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 08:45:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170614140209.29847-1-alex.bennee@linaro.org>
	<20170614140209.29847-4-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <09a35585-d876-6c9e-7045-8cda418455e0@twiddle.net>
Date: Wed, 14 Jun 2017 08:45:40 -0700
MIME-Version: 1.0
In-Reply-To: <20170614140209.29847-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 3/3] tcg-runtime: short-circuit
 lookup_tb_ptr on IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, pbonzini@redhat.com, cota@braap.org
Cc: qemu-devel@nongnu.org

On 06/14/2017 07:02 AM, Alex Bennée wrote:
> While the next TB would detect the exit flag has been set there is no
> point if we can exit sooner. We also check cpu->interrupt_request as
> some front-ends can set it rather than using the cpu_interrupt() API
> call and would normally be expecting the IRQ to get picked up on the
> previously fairly regular exits from the run loop.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   tcg-runtime.c | 47 +++++++++++++++++++++++++++--------------------
>   1 file changed, 27 insertions(+), 20 deletions(-)

I can confirm this fixes the Alpha hang as well.


r~
