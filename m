Received: from eggs.gnu.org ([2001:4830:134:3::10]:46808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9J3O-0006hG-9R
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9J3N-0000sS-E3
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:28:54 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:32959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d9J3N-0000rN-9k
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:28:53 -0400
Received: by mail-qk0-x242.google.com with SMTP id o85so9676492qkh.0
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 15:28:53 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170510182636.17791-1-aurelien@aurel32.net>
	<20170510182636.17791-16-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6fb9f90d-779a-2671-9ae7-e21ee280894d@twiddle.net>
Date: Fri, 12 May 2017 15:28:49 -0700
MIME-Version: 1.0
In-Reply-To: <20170510182636.17791-16-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 15/15] target/sh4: use
 cpu_loop_exit_restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/10/2017 11:26 AM, Aurelien Jarno wrote:
> Use cpu_loop_exit_restore when using cpu_restore_state and cpu_loop_exit
> together.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/op_helper.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
