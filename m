Received: from eggs.gnu.org ([209.51.188.92]:49161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hAtVT-0004ZD-5I
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hAtVS-0007q1-0f
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:45:31 -0400
Date: Mon, 1 Apr 2019 10:39:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190401093932.GC3524@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190401082655.8272-1-aruna.15@cse.mrt.ac.lk>
	<20190401082655.8272-2-aruna.15@cse.mrt.ac.lk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190401082655.8272-2-aruna.15@cse.mrt.ac.lk>
Subject: Re: [Qemu-devel] [PATCH 2/2] Header cleanups- Tabs replaced with
 spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Mon, Apr 01, 2019 at 01:56:55PM +0530, Aruna Jayasena wrote:
> Declarations were moved out of qemu-common.h for functions declared in utils/ files.
> This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
> 
> Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> 
> ---
>  include/qemu/id.h       | 4 ++--
>  include/qemu/readline.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/qemu/id.h b/include/qemu/id.h
> index 3a651fb9d2..f3451344e2 100644
> --- a/include/qemu/id.h
> +++ b/include/qemu/id.h
> @@ -1,8 +1,8 @@
>  #ifndef QEMU_ID_H
>  #define QEMU_ID_H
>  
> -#define qemu_isalnum(c)		isalnum((unsigned char)(c))
> -#define qemu_isalpha(c)		isalpha((unsigned char)(c))
> +#define qemu_isalnum(c)    isalnum((unsigned char)(c))
> +#define qemu_isalpha(c)    isalpha((unsigned char)(c))
>  
>  typedef enum IdSubSystems {
>      ID_QDEV,
> diff --git a/include/qemu/readline.h b/include/qemu/readline.h
> index 4cbf7ead5a..67859a3028 100644
> --- a/include/qemu/readline.h
> +++ b/include/qemu/readline.h
> @@ -1,7 +1,7 @@
>  #ifndef READLINE_H
>  #define READLINE_H
>  
> -#define qemu_isspace(c)		isspace((unsigned char)(c))
> +#define qemu_isspace(c)    isspace((unsigned char)(c))
>  
>  #define READLINE_CMD_BUF_SIZE 4095
>  #define READLINE_MAX_CMDS 64

This should just be fixed when moving the macros out of qemu-common.h

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
