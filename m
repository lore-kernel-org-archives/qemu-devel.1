Received: from eggs.gnu.org ([2001:4830:134:3::10]:49991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fGcFh-0007ll-SB
	for qemu-devel@nongnu.org; Wed, 09 May 2018 23:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fGcFg-0005ro-Up
	for qemu-devel@nongnu.org; Wed, 09 May 2018 23:28:21 -0400
Received: from mail-yb0-x242.google.com ([2607:f8b0:4002:c09::242]:33995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fGcFg-0005rW-PD
	for qemu-devel@nongnu.org; Wed, 09 May 2018 23:28:20 -0400
Received: by mail-yb0-x242.google.com with SMTP id b14-v6so227832ybk.1
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 20:28:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509231123.20864-5-laurent@vivier.eu>
References: <20180509231123.20864-1-laurent@vivier.eu>
	<20180509231123.20864-5-laurent@vivier.eu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 9 May 2018 20:28:19 -0700
Message-ID: <CAMo8BfJSJNe1GTtMX4vO6vCaSFkopcA=PnxDjEv88ZDWkz0QuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 4/6] linux-user: fix conversion of
 flock/flock64 l_type field
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
> As l_type values (F_RDLCK, F_WRLCK, F_UNLCK, F_EXLCK, F_SHLCK)
> are not bitmasks, we can't use target_to_host_bitmask() and
> host_to_target_bitmask() to convert them.
>
> Introduce target_to_host_flock() and host_to_target_flock()
> to convert values between host and target.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>
> Notes:
>     v2:
>       - add common switch macro to convert to/from target to/from host
>       - return -TARGET_EINVAL is l_type cannot be converted
>
>  linux-user/syscall.c | 66 ++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 48 insertions(+), 18 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
