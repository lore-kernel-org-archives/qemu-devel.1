Received: from eggs.gnu.org ([2001:4830:134:3::10]:38742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1ck9wk-00020j-PN
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 08:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1ck9wk-0003SV-20
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 08:42:06 -0500
MIME-Version: 1.0
In-Reply-To: <03c6d1af-266e-3bed-4475-683200d238e8@twiddle.net>
References: <1488524289-5305-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1488524289-5305-3-git-send-email-nikunj@linux.vnet.ibm.com>
	<03c6d1af-266e-3bed-4475-683200d238e8@twiddle.net>
From: Nikunj Dadhania <nikunj.dadhania@gmail.com>
Date: Sat, 4 Mar 2017 19:12:02 +0530
Message-ID: <CALAZu38RkE2hLXfLLZzzpVZVfn51_b4+jjs29wyEa6ax1Ept9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/3] target/ppc: fmadd: add
 macro for updating flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel qemu-devel <qemu-devel@nongnu.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>

On 4 March 2017 at 00:45, Richard Henderson <rth@twiddle.net> wrote:
> On 03/03/2017 05:58 PM, Nikunj A Dadhania wrote:
>>
>> +#define FPU_MADDSUB_UPDATE(name, tp)                                    \
>> +static void name(CPUPPCState *env, float64 arg1,                        \
>> +                 float64 arg2, float64 arg3,                            \
>> +                 unsigned int madd_flags)                               \
>
>
> Use ALL CAPS for macro arguments which you paste.

Sure.

> You forgot to use TP for arg{1,2,3}.

Right, will correct it.

Regards
Nikunj
