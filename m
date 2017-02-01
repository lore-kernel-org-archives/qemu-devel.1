Received: from eggs.gnu.org ([2001:4830:134:3::10]:46989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cYpac-0001rK-Qa
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 02:44:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cYpaZ-0000l0-L0
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 02:44:26 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38843)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cYpaZ-0000kn-F1
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 02:44:23 -0500
Received: by mail-wm0-x230.google.com with SMTP id r141so25230609wmg.1
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 23:44:23 -0800 (PST)
References: <20170127103922.19658-1-alex.bennee@linaro.org>
	<20170127103922.19658-26-alex.bennee@linaro.org>
	<f15d91cd-e5b9-3dda-7afa-5b2a91b9e9d0@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <f15d91cd-e5b9-3dda-7afa-5b2a91b9e9d0@twiddle.net>
Date: Wed, 01 Feb 2017 07:44:23 +0000
Message-ID: <87h94e4ap4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Richard Henderson <rth@twiddle.net>
Cc: mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, "open list:ARM" <qemu-arm@nongnu.org>


Richard Henderson <rth@twiddle.net> writes:

> On 01/27/2017 02:39 AM, Alex Bennée wrote:
>> +/* This defines the natural memory order supported by this
>> + * architecture before guarantees made by various barrier
>> + * instructions.
>> + *
>> + * The x86 has a pretty strong memory ordering which only really
>> + * allows for some stores to be re-ordered after loads.
>> + */
>> +#include "tcg-mo.h"
>> +
>> +static inline int get_tcg_target_mo(void)
>> +{
>> +    return TCG_MO_ALL & ~TCG_MO_LD_ST;
>> +}
>> +
>> +#define TCG_TARGET_DEFAULT_MO get_tcg_target_mo()
>> +
>
> Why the inline function?  The expression in the define would seem sufficient.
> Otherwise,

Good point. It was just to get around the definition at pre-processor and
compile time.

>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
>
>
> r~


--
Alex Bennée
