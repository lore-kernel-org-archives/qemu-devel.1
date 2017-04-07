Received: from eggs.gnu.org ([2001:4830:134:3::10]:41904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cwYUP-0005W3-Hy
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 14:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cwYUO-0000Dh-SI
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 14:20:05 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<20170406102249.20383-4-nikunj@linux.vnet.ibm.com>
	<2f858a60-0824-96c1-8248-49325fac2721@twiddle.net>
	<87zifsrdxb.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b202b111-2960-9868-452e-6cb0c1a14844@twiddle.net>
Date: Fri, 7 Apr 2017 11:19:59 -0700
MIME-Version: 1.0
In-Reply-To: <87zifsrdxb.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v1 3/3] target/ppc: Generate fence
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, programmingkidx@gmail.com, bharata@linux.vnet.ibm.com

On 04/06/2017 10:21 PM, Nikunj A Dadhania wrote:
> We do that in the macro:
>
>       if (len > 1) {                                          \
>           gen_check_align(ctx, t0, (len) - 1);                \
>       }                                                       \
>
> Would we still need a barrier before the alignment check?

Ah, that's where it's been placed.

So, the MO_ALIGN flag to tcg_gen_atomic_* takes care of the alignment check 
too.  So we could move this down into the failure path.


r~
