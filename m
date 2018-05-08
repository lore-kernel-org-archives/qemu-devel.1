Received: from eggs.gnu.org ([2001:4830:134:3::10]:48637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fG8uM-0003FL-6x
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fG8uL-0004h9-Du
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:08:22 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:40597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fG8uL-0004h3-8U
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:08:21 -0400
Received: by mail-yw0-x241.google.com with SMTP id p144-v6so10049994ywg.7
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 13:08:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508194026.1281-3-laurent@vivier.eu>
References: <20180508194026.1281-1-laurent@vivier.eu>
	<20180508194026.1281-3-laurent@vivier.eu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 8 May 2018 13:08:20 -0700
Message-ID: <CAMo8BfLpnEpFPowLtXwT7N7bfPiv26Ot4Xoryg_+k6Qrs86U4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/5] linux-user: fix flock/flock64 padding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On Tue, May 8, 2018 at 12:40 PM, Laurent Vivier <laurent@vivier.eu> wrote:
> include/uapi/asm-generic/fcntl.h insert a padding macro at
> the end of the structures flock and flock64.
>
> This macro is defined to "short __unused;" on sparc,
> and "long pad[4]" on mips.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall_defs.h | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
