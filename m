Received: from eggs.gnu.org ([209.51.188.92]:37540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtchD-0007PO-NI
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtchC-0000BY-UL
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:22:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtchC-0000AS-OK
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:22:14 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so4114915wmj.1
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 10:22:14 -0800 (PST)
References: <mvmimxprmn8.fsf@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2d8b7d53-c384-4a8a-f7c7-23a66134ffce@redhat.com>
Date: Tue, 12 Feb 2019 19:22:12 +0100
MIME-Version: 1.0
In-Reply-To: <mvmimxprmn8.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 2/12/19 5:34 PM, Andreas Schwab wrote:
> Set msg_flags in the returned struct msghdr.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
