Received: from eggs.gnu.org ([2001:4830:134:3::10]:36128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS65m-0004zn-FB
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS65l-0007nM-0D
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:56:46 -0500
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:35629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cS65k-0007nD-T6
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 12:56:44 -0500
Received: by mail-yw0-x244.google.com with SMTP id 17so4256536ywk.2
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 09:56:44 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484311923-28637-1-git-send-email-laurent@vivier.eu>
	<1484311923-28637-3-git-send-email-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <bead2465-30b7-b820-c812-08e3ad6d9370@twiddle.net>
Date: Fri, 13 Jan 2017 09:56:41 -0800
MIME-Version: 1.0
In-Reply-To: <1484311923-28637-3-git-send-email-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] target-m68k: fix gen_flush_flags()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/13/2017 04:52 AM, Laurent Vivier wrote:
> gen_flush_flags() is setting unconditionally cc_op_synced to 1
> and s->cc_op to CC_OP_FLAGS, whereas env->cc_op can be set
> to something else by a previous tcg fragment.
> 
> We fix that by not setting cc_op_synced to 1
> (except for gen_helper_flush_flags() that updates env->cc_op)
> 
> FIX: https://github.com/vivier/qemu-m68k/issues/19
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/translate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
