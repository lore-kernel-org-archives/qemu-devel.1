Received: from eggs.gnu.org ([2001:4830:134:3::10]:37794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnKNK-0005qz-SN
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnKNG-0004fY-1l
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:58:54 -0400
References: <1504099475-241036-1-git-send-email-imammedo@redhat.com>
	<1504099475-241036-9-git-send-email-imammedo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6d03941e-d54e-dc80-4ba3-7c591b7fcddb@redhat.com>
Date: Thu, 31 Aug 2017 09:58:45 +0200
MIME-Version: 1.0
In-Reply-To: <1504099475-241036-9-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 8/8] ppc: remove non
 implemented cpu models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 30.08.2017 15:24, Igor Mammedov wrote:
> Remove cpu models that aren't implemented and are not
> compiled/tested since they are under TODO ifdef
> which isn't defined in sources.
> 
> If someone really needs a removed model he/she should add
> as regular one with corresponding implementation.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  target/ppc/cpu-models.c | 459 ------------------------------------------------
>  1 file changed, 459 deletions(-)
> 
> diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> index cf878a9..611fc1b 100644
> --- a/target/ppc/cpu-models.c
> +++ b/target/ppc/cpu-models.c
[...]
> -#endif
>  #if defined(TODO_USER_ONLY)
>      POWERPC_DEF("440sp",         CPU_POWERPC_440SP,                  440EP,
>                  "PowerPC 440 SP")
> @@ -396,20 +207,6 @@
>      POWERPC_DEF("440spe",        CPU_POWERPC_440SPE,                 440EP,
>                  "PowerPC 440 SPE")
>  #endif
> -    /* PowerPC 460 family                                                    */
> -#if defined(TODO)
> -    POWERPC_DEF("464",           CPU_POWERPC_464,                    460,
> -                "Generic PowerPC 464")
> -#endif
> -    /* PowerPC 464 microcontrollers                                          */
> -#if defined(TODO)
> -    POWERPC_DEF("464h90",        CPU_POWERPC_464H90,                 460,
> -                "PowerPC 464H90")
> -#endif
> -#if defined(TODO)
> -    POWERPC_DEF("464h90f",       CPU_POWERPC_464H90F,                460F,
> -                "PowerPC 464H90F")
> -#endif

By the way, I guess you could also remove the 460 stuff from
translate_init.c since there are no 460 CPUs defined in QEMU
(but I guess that should go into a separate patch instead).

 Thomas
