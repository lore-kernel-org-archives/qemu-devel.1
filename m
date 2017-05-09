Received: from eggs.gnu.org ([2001:4830:134:3::10]:48897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CA7-0001n7-SG
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8CA6-0003wN-Vo
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:55:15 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d8CA6-0003wI-RL
	for qemu-devel@nongnu.org; Tue, 09 May 2017 16:55:14 -0400
Received: by mail-qt0-x244.google.com with SMTP id r58so1596901qtb.2
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 13:55:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-2-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e14cae88-b420-b0df-3878-45b2fe996e4a@twiddle.net>
Date: Tue, 9 May 2017 13:55:10 -0700
MIME-Version: 1.0
In-Reply-To: <20170506111431.12548-2-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/14] target/sh4: split ctx->flags into
 ctx->tbflags and ctx->envflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/06/2017 04:14 AM, Aurelien Jarno wrote:
> There is a confusion (and not only in the SH4 target) between tb->flags,
> env->flags and ctx->flags. To avoid it, split ctx->flags into
> ctx->tbflags and ctx->envflags. ctx->tbflags stays unchanged during the
> whole TB translation, while ctx->envflags evolves and is kept in sync
> with env->flags using TCG instructions. ctx->envflags now only contains
> the part that of env->flags that is contained in the TB state, i.e. the
> DELAY_SLOT* flags.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/translate.c | 161 +++++++++++++++++++++++++------------------------
>   1 file changed, 82 insertions(+), 79 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
