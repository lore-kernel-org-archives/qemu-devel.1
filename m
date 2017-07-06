Received: from eggs.gnu.org ([2001:4830:134:3::10]:60503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dT8es-0006R7-4g
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dT8eo-0006iu-Nq
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:25:33 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dT8eo-0006hu-J9
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 11:25:30 -0400
Received: by mail-qk0-x244.google.com with SMTP id v143so737307qkb.3
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 08:25:30 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
References: <20170706002401.10507-1-rth@twiddle.net>
	<20170706002401.10507-2-rth@twiddle.net>
Message-ID: <47498ffb-b255-c189-2385-63c2bdb5e6f2@twiddle.net>
Date: Thu, 6 Jul 2017 05:25:21 -1000
MIME-Version: 1.0
In-Reply-To: <20170706002401.10507-2-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/11] target/sh4: Use cmpxchg for movco
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: bruno@clisp.org, aurelien@aurel32.net

On 07/05/2017 02:23 PM, Richard Henderson wrote:
> As for other targets, cmpxchg isn't quite right for ll/sc,
> suffering from an ABA race, but is sufficient to implement
> portable atomic operations.
> 
> Signed-off-by: Richard Henderson<rth@twiddle.net>
> ---
>   target/sh4/cpu.h       |  3 ++-
>   target/sh4/translate.c | 56 +++++++++++++++++++++++++++++++++-----------------
>   2 files changed, 39 insertions(+), 20 deletions(-)

Note to self: missing reset of lock_addr across interrupt and priv change 
boundaries.


r~
