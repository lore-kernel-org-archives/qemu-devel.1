Received: from eggs.gnu.org ([2001:4830:134:3::10]:40458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL0EF-0000D6-VE
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dL0EF-0004yA-Av
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:48:27 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170609170100.3599-1-alex.bennee@linaro.org>
	<20170609170100.3599-4-alex.bennee@linaro.org>
	<fc351edb-7c08-c341-d8ee-85f6768e4931@twiddle.net>
	<87vao4b4z5.fsf@linaro.org>
	<9776b437-90b4-f2c2-4a0c-c1c6585379bf@twiddle.net>
	<20170611050730.GA12317@flamenco> <20170613225352.GA26288@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <db800d74-7cfa-d9e3-60d7-3e7b19565b9b@twiddle.net>
Date: Tue, 13 Jun 2017 21:48:17 -0700
MIME-Version: 1.0
In-Reply-To: <20170613225352.GA26288@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/aarch64: exit to main loop after
 handling MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, edgar.iglesias@xilinx.com, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>

On 06/13/2017 03:53 PM, Emilio G. Cota wrote:
> The appended fixes it for me. Can you please test?
> [ apply with `git am --scissors' ]
> 
> Thanks,
> 
> 		Emilio
> 
> ---- 8< ----
> 
> Commit e75449a3 ("target/aarch64: optimize indirect branches") causes
> a regression by which aarch64 guests freeze under TCG with -smp > 1,
> even with `-accel accel=tcg,thread=single' (i.e. MTTCG disabled).
> 
> I isolated the problem to the MSR handler. This patch forces an exit
> after the handler is executed, which fixes the regression.

Why would that be?  The cpu_get_tb_cpu_state within helper_lookup_tb_ptr is 
supposed to read the new state that the msr handler would have installed.


r~
