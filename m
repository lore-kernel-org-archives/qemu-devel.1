Received: from eggs.gnu.org ([209.51.188.92]:54848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDKE-0001pE-9n
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:28:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDFT-0001Io-Ii
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:24:04 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:57653)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1guDFT-0001H9-9S
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:24:03 -0500
References: <mvmimxprmn8.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c5b35121-6712-b6b4-026a-43d5555d1f8b@vivier.eu>
Date: Thu, 14 Feb 2019 10:23:51 +0100
MIME-Version: 1.0
In-Reply-To: <mvmimxprmn8.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix recvmsg emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 12/02/2019 17:34, Andreas Schwab wrote:
> Set msg_flags in the returned struct msghdr.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  linux-user/syscall.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 90bfda3563..b6b566a6fa 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -2797,6 +2797,7 @@ static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
>              }
>              if (!is_error(ret)) {
>                  msgp->msg_namelen = tswap32(msg.msg_namelen);
> +                msgp->msg_flags = tswap32(msg.msg_flags);
>                  if (msg.msg_name != NULL && msg.msg_name != (void *)-1) {
>                      ret = host_to_target_sockaddr(tswapal(msgp->msg_name),
>                                      msg.msg_name, msg.msg_namelen);
> 

Applied to my linux-user branch.

Thanks,
Laurent
