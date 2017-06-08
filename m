Received: from eggs.gnu.org ([2001:4830:134:3::10]:44490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dIvvx-0007VJ-5e
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dIvvu-0007Y4-4m
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 07:49:01 -0400
References: <1496864204-5954-1-git-send-email-jcmvbkbc@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <3194496c-7365-b402-dbc9-ee3f1aee1265@redhat.com>
Date: Thu, 8 Jun 2017 13:48:54 +0200
MIME-Version: 1.0
In-Reply-To: <1496864204-5954-1-git-send-email-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] target/xtensa: gdbstub:
 drop dead return statement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 07/06/2017 21:36, Max Filippov wrote:
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/gdbstub.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
> index da131ae..d78a1b4 100644
> --- a/target/xtensa/gdbstub.c
> +++ b/target/xtensa/gdbstub.c
> @@ -72,7 +72,6 @@ int xtensa_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
>                        __func__, n, reg->type);
>          memset(mem_buf, 0, reg->size);
>          return reg->size;
> -        return 0;
>      }
>  }
>  
> 
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
