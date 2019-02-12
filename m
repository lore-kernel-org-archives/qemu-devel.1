Received: from eggs.gnu.org ([209.51.188.92]:45977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gtbZH-000103-6D
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gtbZE-0008R3-Rd
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:09:59 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:42829)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gtbZE-0008OV-Fw
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 12:09:56 -0500
References: <mvmimxprmn8.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <0115d826-3e42-5821-15f8-77841fc851a8@vivier.eu>
Date: Tue, 12 Feb 2019 18:09:43 +0100
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
