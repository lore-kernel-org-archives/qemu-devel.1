Received: from eggs.gnu.org ([2001:4830:134:3::10]:57685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fcxIu-000148-C5
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fcxIr-00017l-72
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:24:00 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<20180710160013.26559-3-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5582b918-6583-30f3-fa84-2b03353a2f09@twiddle.net>
Date: Tue, 10 Jul 2018 11:23:53 -0700
MIME-Version: 1.0
In-Reply-To: <20180710160013.26559-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/6] accel/tcg: Handle get_page_addr_code()
 returning -1 in hashtable lookups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>

On 07/10/2018 09:00 AM, Peter Maydell wrote:
> When we support execution from non-RAM MMIO regions, get_page_addr_code()
> will return -1 to indicate that there is no RAM at the requested address.
> Handle this in the cpu-exec TB hashtable lookup code, treating it as
> "no match found".
> 
> Note that the call to get_page_addr_code() in tb_lookup_cmp() needs
> no changes -- a return of -1 will already correctly result in the
> function returning false.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  accel/tcg/cpu-exec.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
