Received: from eggs.gnu.org ([2001:4830:134:3::10]:55685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbDxq-0007et-Hh
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:10:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbDxp-0007WQ-LE
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 17:10:18 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1486454676-29112-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1486454676-29112-3-git-send-email-bharata@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6dac1bb1-bb4c-9dc5-ff6e-020db8a4bcd5@twiddle.net>
Date: Tue, 7 Feb 2017 14:10:04 -0800
MIME-Version: 1.0
In-Reply-To: <1486454676-29112-3-git-send-email-bharata@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 2/2] softfloat: Add
 float128_to_uint32_round_to_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, nikunj@linux.vnet.ibm.com, peter.maydell@linaro.org

On 02/07/2017 12:04 AM, Bharata B Rao wrote:
> +    int64_t v;
> +    uint32_t res;
> +    int old_exc_flags = get_float_exception_flags(status);
> +
> +    v = float128_to_uint64_round_to_zero(a, status);
> +    if (v > 0xffffffff) {

v should be uint64_t.


r~
