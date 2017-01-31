Received: from eggs.gnu.org ([2001:4830:134:3::10]:33919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYi1f-0003oV-1U
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYi1e-0005I8-9v
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:39:51 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170127103922.19658-1-alex.bennee@linaro.org>
	<20170127103922.19658-26-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f15d91cd-e5b9-3dda-7afa-5b2a91b9e9d0@twiddle.net>
Date: Tue, 31 Jan 2017 15:39:45 -0800
MIME-Version: 1.0
In-Reply-To: <20170127103922.19658-26-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 25/25] tcg: enable MTTCG by default for
 ARM on x86 hosts
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
> +/* This defines the natural memory order supported by this
> + * architecture before guarantees made by various barrier
> + * instructions.
> + *
> + * The x86 has a pretty strong memory ordering which only really
> + * allows for some stores to be re-ordered after loads.
> + */
> +#include "tcg-mo.h"
> +
> +static inline int get_tcg_target_mo(void)
> +{
> +    return TCG_MO_ALL & ~TCG_MO_LD_ST;
> +}
> +
> +#define TCG_TARGET_DEFAULT_MO get_tcg_target_mo()
> +

Why the inline function?  The expression in the define would seem sufficient. 
Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
