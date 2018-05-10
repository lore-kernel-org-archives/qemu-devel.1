Received: from eggs.gnu.org ([2001:4830:134:3::10]:53515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fGciS-0003b1-RZ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 23:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fGciS-00023J-5S
	for qemu-devel@nongnu.org; Wed, 09 May 2018 23:58:04 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:41007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fGciR-000237-Vi
	for qemu-devel@nongnu.org; Wed, 09 May 2018 23:58:04 -0400
Received: by mail-yw0-x241.google.com with SMTP id q125-v6so196497ywc.8
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 20:58:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509231123.20864-4-laurent@vivier.eu>
References: <20180509231123.20864-1-laurent@vivier.eu>
	<20180509231123.20864-4-laurent@vivier.eu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 9 May 2018 20:58:02 -0700
Message-ID: <CAMo8BfLOTn7rhNhkOknKL_hOME3Xp9VH7O4eBuZRY1TtyY7nzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/6] linux-user: update
 sparc/syscall_nr.h to linux header 4.16
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
> And kill sys_aplib, add sys_sync_file_range:
> on sparc, since linux 2.6.17, aplib syscall has been replaced
>  by sync_file_range syscall.
> (289eee6fa78e ["SPARC]: Wire up sys_sync_file_range() into syscall tables.")
> The syscall has been removed in linux v2.5.71
> (6196166fad "[SPARC64]: Kill sys_aplib.")
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/sparc/syscall_nr.h   | 32 +++++++++++++++++++++++++++++++-
>  linux-user/sparc64/syscall_nr.h | 20 ++++++++++++--------
>  2 files changed, 43 insertions(+), 9 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
