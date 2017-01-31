Received: from eggs.gnu.org ([2001:4830:134:3::10]:33648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYhzO-0002XL-9I
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:37:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYhzN-0004BW-Hr
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:37:30 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170127103922.19658-1-alex.bennee@linaro.org>
	<20170127103922.19658-25-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d929bbf5-3dbf-0816-9a45-8b0203689a96@twiddle.net>
Date: Tue, 31 Jan 2017 15:37:24 -0800
MIME-Version: 1.0
In-Reply-To: <20170127103922.19658-25-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 24/25] target-arm: ensure all cross
 vCPUs TLB flushes complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, "open list:ARM" <qemu-arm@nongnu.org>

On 01/27/2017 02:39 AM, Alex Bennée wrote:
> Previously flushes on other vCPUs would only get serviced when they
> exited their TranslationBlocks. While this isn't overly problematic it
> violates the semantics of TLB flush from the point of view of source
> vCPU.
>
> To solve this we call the cputlb *_all_cpus() functions to do the
> flushes and ask it to ensure all flushes are completed before we start
> the next instruction. As this involves exiting the cpu_loop we need to
> ensure the PC is saved before the tlb helper functions are called.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
