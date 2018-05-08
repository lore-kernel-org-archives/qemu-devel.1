Received: from eggs.gnu.org ([2001:4830:134:3::10]:50928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fG98K-0000h6-7i
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fG98J-0000nd-DQ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:22:48 -0400
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:46923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fG98J-0000nT-8j
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:22:47 -0400
Received: by mail-yb0-x244.google.com with SMTP id f3-v6so3198759ybg.13
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 13:22:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508194026.1281-6-laurent@vivier.eu>
References: <20180508194026.1281-1-laurent@vivier.eu>
	<20180508194026.1281-6-laurent@vivier.eu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 8 May 2018 13:22:46 -0700
Message-ID: <CAMo8BfJv_Sg8EhjrUcS-wjbwwiLgv2kY4-GaxtXTygs19hUMqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 5/5] linux-user: add sparc/sparc64 specific
 errno
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
> Copied from linux/arch/sparc/include/uapi/asm/errno.h
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/sparc/target_syscall.h   | 203 ++++++++++++++++++++++++++++++++++++
>  linux-user/sparc64/target_syscall.h | 203 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 406 insertions(+)

The changes are coming from single file, why duplicating them?
Could they go into e.g. linux-user/sparc/target_errno.h, and get
#included by both linux-user/sparc/target_syscall.h and
linux-user/sparc64/target_syscall.h?

-- 
Thanks.
-- Max
