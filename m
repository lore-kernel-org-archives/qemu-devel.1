Received: from eggs.gnu.org ([2001:4830:134:3::10]:49146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dkual-0006Ou-9h
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dkuaf-0000Oy-PG
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:02:47 -0400
MIME-Version: 1.0
In-Reply-To: <20170824155849.30799-1-bobby.prani@gmail.com>
References: <20170824155849.30799-1-bobby.prani@gmail.com>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 24 Aug 2017 12:02:10 -0400
Message-ID: <CAJhHMCArPfB_5kraiW=Z047ppFuMsVqxYftNpsZp7Q2KPd49=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 PATCH] tcg/softmmu: Increase size of TLB
 caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, "open list:Overall" <qemu-devel@nongnu.org>, "open list:AArch64 target" <qemu-arm@nongnu.org>

On Thu, Aug 24, 2017 at 11:58 AM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> This patch increases the number of entries cached in the TLB. I went
> over a few architectures to see if increasing it is problematic. Only
> armv6 seems to have a limitation that only 8 bits can be used for
> indexing these entries. For other architectures, the number of TLB
> entries is increased to a 4K-sized cache. The patch also doubles the
> number of victim TLB entries.
>
> A few statistics collected from a build benchmark for various cache
> sizes is below:
>
> | TLB bits\vTLB entires |             8 |            16  |            32 |
> |                     8 | 952.94(+0.0%) | 929.99(+2.4%)  | 919.02(+3.6%) |
> |                    10 | 898.92(+5.6%) | 886.13(+7.0%)  | 887.03(+6.9%) |
> |                    12 | 878.56(+7.8%) | 873.53(+8.3%)* | 875.34(+8.1%) |
>
> The best combination for this workload came out to be 12 bits for the
> TLB and a 16 entry vTLB cache.

You can find the raw data here: http://paste.ubuntu.com/25383585/

Thanks,
-- 
Pranith
