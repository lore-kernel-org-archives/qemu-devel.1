Received: from eggs.gnu.org ([2001:4830:134:3::10]:48992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLADi-0006R8-7D
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLADf-0007yv-LI
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:33:06 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-10-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d022028c-624d-ed88-9ba6-d0fe88d8adcf@twiddle.net>
Date: Tue, 22 May 2018 09:33:00 -0700
MIME-Version: 1.0
In-Reply-To: <20180521140402.23318-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/27] Make flatview_access_valid() take a
 MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/21/2018 07:03 AM, Peter Maydell wrote:
> As part of plumbing MemTxAttrs down to the IOMMU translate method,
> add MemTxAttrs as an argument to flatview_access_valid().
> Its callers now all have an attrs value to hand, so we can
> correct our earlier temporary use of MEMTXATTRS_UNSPECIFIED.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

>              /* When our callers all have attrs we'll pass them through here */
> -            if (!memory_region_access_valid(mr, xlat, l, is_write,
> -                                            MEMTXATTRS_UNSPECIFIED)) {
> +            if (!memory_region_access_valid(mr, xlat, l, is_write, attrs)) {

Kill the temporary comment too.


r~
