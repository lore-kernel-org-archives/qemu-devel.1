Received: from eggs.gnu.org ([2001:4830:134:3::10]:50160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fGcGp-0000hn-RE
	for qemu-devel@nongnu.org; Wed, 09 May 2018 23:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fGcGp-0006JA-0U
	for qemu-devel@nongnu.org; Wed, 09 May 2018 23:29:31 -0400
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:43550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fGcGo-0006J0-SF
	for qemu-devel@nongnu.org; Wed, 09 May 2018 23:29:30 -0400
Received: by mail-yw0-x243.google.com with SMTP id r202-v6so181415ywg.10
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 20:29:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509231123.20864-6-laurent@vivier.eu>
References: <20180509231123.20864-1-laurent@vivier.eu>
	<20180509231123.20864-6-laurent@vivier.eu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 9 May 2018 20:29:29 -0700
Message-ID: <CAMo8BfLyFA_-5NhSAXN1FOb6VSmHTwzrbhbnSWqsQKYwp9bFHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 5/6] linux-user: add sparc/sparc64
 specific errno
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Eric Blake <eblake@redhat.com>

On Wed, May 9, 2018 at 4:11 PM, Laurent Vivier <laurent@vivier.eu> wrote:
> Copied from linux/arch/sparc/include/uapi/asm/errno.h
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>
> Notes:
>     v2:
>       - move sparc errno definitions to linux-user/sparc/target_errno.h
>
>  linux-user/sparc/target_errno.h     | 207 ++++++++++++++++++++++++++++++++++++
>  linux-user/sparc/target_syscall.h   |   2 +
>  linux-user/sparc64/target_syscall.h |   3 +-
>  3 files changed, 211 insertions(+), 1 deletion(-)
>  create mode 100644 linux-user/sparc/target_errno.h

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
