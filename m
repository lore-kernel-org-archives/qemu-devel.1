Received: from eggs.gnu.org ([2001:4830:134:3::10]:47969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHtrQ-0000UL-F7
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHtrP-0007rn-Lw
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:51:48 -0500
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:35156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHtrP-0007rS-8v
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:51:47 -0500
Received: by mail-ua0-x235.google.com with SMTP id 12so40112129uas.2
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 06:51:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1480003738-8754-4-git-send-email-Lena.Djokic@rt-rk.com>
References: <1480003738-8754-1-git-send-email-Lena.Djokic@rt-rk.com>
	<1480003738-8754-4-git-send-email-Lena.Djokic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 14:51:26 +0000
Message-ID: <CAFEAcA-HnaeUvS0Lv943ANtVVJ6rXNAXbupNjGgCr=XcThfCaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 3/7] linux-user: Fix flock definition
 for mips64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lena Djokic <Lena.Djokic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 24 November 2016 at 16:08, Lena Djokic <Lena.Djokic@rt-rk.com> wrote:
> Mips64 uses generic flock structure.
> See /arch/mips/include/uapi/asm/fcntl.h#L63 for reference.
>
> Signed-off-by: Lena Djokic <Lena.Djokic@rt-rk.com>
> ---
>  linux-user/syscall_defs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 0b15466..099fd0e 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2363,7 +2363,7 @@ struct target_flock {
>      short l_whence;
>      abi_long l_start;
>      abi_long l_len;
> -#if defined(TARGET_MIPS)
> +#if defined(TARGET_MIPS) && (TARGET_ABI_BITS == 32)
>      abi_long l_sysid;
>  #endif
>      int l_pid;

Does the #if around the 'pad' field of this struct need adjusting too ?

thanks
-- PMM
