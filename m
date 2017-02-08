Received: from eggs.gnu.org ([2001:4830:134:3::10]:48386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbHlQ-0001Vg-C8
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 21:13:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbHlP-0005Hl-9H
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 21:13:44 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1486360515-22989-1-git-send-email-bharata@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <59baf91a-458a-5160-4849-1dbc142d1efd@twiddle.net>
Date: Tue, 7 Feb 2017 18:13:28 -0800
MIME-Version: 1.0
In-Reply-To: <1486360515-22989-1-git-send-email-bharata@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] softfloat: Add round-to-odd rounding
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nikunj@linux.vnet.ibm.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 02/05/2017 09:55 PM, Bharata B Rao wrote:
> Power ISA 3.0 introduces a few quadruple precision floating point
> instructions that support round-to-odd rounding mode. The
> round-to-odd mode is explained as under:
>
> Let Z be the intermediate arithmetic result or the operand of a convert
> operation. If Z can be represented exactly in the target format, the
> result is Z. Otherwise the result is either Z1 or Z2 whichever is odd.
> Here Z1 and Z2 are the next larger and smaller numbers representable
> in the target format respectively.
>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Tested the corner cases for round-to-odd and the default round-to-nearest-even
> by comparing the results of QEMU with a known good implementation of
> PowerPC ISA 3.0 for the following instructions: xsaddqp[o], xsdivqp[o],
> xsmulqp[o] and xscvqpdp[o].
>
> Changes in v3:
>
> - Limited the recalculation of roundIncrement in 64bit rounding only
>   to round-to-odd case and hence dropped the separate patch which
>   did this for all rounding modes earlier. (Peter Maydell)
> - Resorted to QEMU codying style in softfloat.c

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
