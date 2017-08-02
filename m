Received: from eggs.gnu.org ([2001:4830:134:3::10]:42099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dcv8T-0003nx-HN
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:00:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dcv8P-0004oE-9F
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:00:33 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:38533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dcv8P-0004nv-3N
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 11:00:29 -0400
Received: by mail-pf0-x243.google.com with SMTP id e3so6264088pfc.5
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 08:00:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <cover.7fbcecb0d0061824a32985f26b9c1b7f816203b0.1501667615.git-series.james.hogan@imgtec.com>
	<de6d5c5610c6b5887e72e60a999963c9d414742b.1501667615.git-series.james.hogan@imgtec.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6e162aa0-ab35-157f-2075-887dcf0e0ecf@twiddle.net>
Date: Wed, 2 Aug 2017 08:00:25 -0700
MIME-Version: 1.0
In-Reply-To: <de6d5c5610c6b5887e72e60a999963c9d414742b.1501667615.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 2/3] target/mips: Drop redundant
 gen_io_start/stop()
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
> DMTC0 CP0_Cause does a redundant gen_io_start() and gen_io_end() pair,
> even though this is done for all DMTC0 operations outside of the switch
> statement. Remove these redundant calls.
> 
> Fixes: 5dc5d9f055c5 ("mips: more fixes to the MIPS interrupt glue logic")
> Signed-off-by: James Hogan<james.hogan@imgtec.com>
> Cc: Yongbok Kim<yongbok.kim@imgtec.com>
> Cc: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/mips/translate.c | 8 --------
>   1 file changed, 0 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
