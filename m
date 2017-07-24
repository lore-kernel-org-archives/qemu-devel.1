Received: from eggs.gnu.org ([2001:4830:134:3::10]:56152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZiZt-0001Lt-K8
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dZiZp-0005dG-OJ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:59:37 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-25-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c11e0987-f4e7-51f4-40a2-5784091854ee@vivier.eu>
Date: Mon, 24 Jul 2017 20:59:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-25-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 24/35] linux-user/sh4: fix
 incorrect memory write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Le 24/07/2017 à 20:27, Philippe Mathieu-Daudé a écrit :
> not hit since 2009! :)
> 
> linux-user/elfload.c:1102:20: warning: Out of bound memory access (access exceeds upper limit of memory block)
>         (*regs[i]) = tswap32(env->gregs[i]);
>         ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  linux-user/elfload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 2a902f7806..79062882ba 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1099,7 +1099,7 @@ static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
>      int i;
>  
>      for (i = 0; i < 16; i++) {
> -        (*regs[i]) = tswapreg(env->gregs[i]);
> +        (*regs)[i] = tswapreg(env->gregs[i]);
>      }
>  
>      (*regs)[TARGET_REG_PC] = tswapreg(env->pc);
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
