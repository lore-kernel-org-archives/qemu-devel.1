Received: from eggs.gnu.org ([2001:4830:134:3::10]:42412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dcv9b-0004lH-LA
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dcv9V-0006tE-Ji
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:01:43 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:37025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dcv9V-0006sp-Dv
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:01:37 -0400
Received: by mail-pf0-x241.google.com with SMTP id p13so2782534pfd.4
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 08:01:37 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <cover.7fbcecb0d0061824a32985f26b9c1b7f816203b0.1501667615.git-series.james.hogan@imgtec.com>
	<248e7141b59e3cce8768f8210ade7f19108c92fa.1501667615.git-series.james.hogan@imgtec.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <de83fa91-03b1-19dd-2bb5-679052ad06cf@twiddle.net>
Date: Wed, 2 Aug 2017 08:01:34 -0700
MIME-Version: 1.0
In-Reply-To: <248e7141b59e3cce8768f8210ade7f19108c92fa.1501667615.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 3/3] target/mips: Fix RDHWR CC
 with icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Hogan <james.hogan@imgtec.com>, qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

On 08/02/2017 02:59 AM, James Hogan wrote:
> RDHWR CC reads the CPU timer like MFC0 CP0_Count, so with icount enabled
> it must set can_do_io while it calls the helper to avoid the "Bad icount
> read" error. It should also break out of the translation loop to ensure
> that timer interrupts are immediately handled.
> 
> Fixes: 2e70f6efa8b9 ("Add instruction counter.")
> Signed-off-by: James Hogan<james.hogan@imgtec.com>
> Cc: Aurelien Jarno<aurelien@aurel32.net>
> Cc: Yongbok Kim<yongbok.kim@imgtec.com>
> ---
> I've based this on MFC0 Count, but this instruction is also available to
> usermode (e.g. CONFIG_USER_ONLY), which I presume is still fine.
> ---
>   target/mips/translate.c | 11 +++++++++++
>   1 file changed, 11 insertions(+), 0 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
