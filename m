Received: from eggs.gnu.org ([2001:4830:134:3::10]:50966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fGcOB-0002gf-9u
	for qemu-devel@nongnu.org; Wed, 09 May 2018 23:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fGcOA-0001KW-Ko
	for qemu-devel@nongnu.org; Wed, 09 May 2018 23:37:07 -0400
Received: from mail-yb0-x241.google.com ([2607:f8b0:4002:c09::241]:45037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fGcOA-0001KA-Ev
	for qemu-devel@nongnu.org; Wed, 09 May 2018 23:37:06 -0400
Received: by mail-yb0-x241.google.com with SMTP id m127-v6so221361ybm.11
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 20:37:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509231123.20864-7-laurent@vivier.eu>
References: <20180509231123.20864-1-laurent@vivier.eu>
	<20180509231123.20864-7-laurent@vivier.eu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 9 May 2018 20:37:05 -0700
Message-ID: <CAMo8BfJ+5w6p3E2BPspo8crm5qH03VaammVCh_-nG+o8xCjXcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 6/6] linux-user: fix UNAME_MACHINE for
 sparc/sparc64
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
> "sun4" is not recognized by config.guess.
> linux defines sparc and sparc64 in arch/sparc/Makefile.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/sparc/target_syscall.h   | 2 +-
>  linux-user/sparc64/target_syscall.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
