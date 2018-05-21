Received: from eggs.gnu.org ([2001:4830:134:3::10]:44273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fKqlc-0002mP-Bb
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fKqlX-00080i-Bb
	for qemu-devel@nongnu.org; Mon, 21 May 2018 15:46:46 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-2-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7c621d84-8909-5a23-2fad-9e5bf8915a8e@twiddle.net>
Date: Mon, 21 May 2018 12:46:34 -0700
MIME-Version: 1.0
In-Reply-To: <20180521140402.23318-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/27] memory.h: Improve IOMMU related
 documentation
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
> Add more detail to the documentation for memory_region_init_iommu()
> and other IOMMU-related functions and data structures.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v2->v3 changes:
>  * minor wording tweaks per Eric's review
>  * moved the bit about requirements to notify out from the translate
>    method docs to the top level class doc comment
>  * added description of flags argument and in particular that it's
>    just an optimization and callers can pass IOMMU_NONE to get the
>    full permissions
> v1 -> v2 changes:
>  * documented replay method
>  * added note about wanting RCU or big qemu lock while calling
>    translate
> ---
>  include/exec/memory.h | 105 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 95 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
