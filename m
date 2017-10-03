Received: from eggs.gnu.org ([2001:4830:134:3::10]:40821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dzKOt-0001V1-SJ
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dzKOt-0003z4-09
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 06:26:07 -0400
References: <1507024644-14853-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <56ac2027-6aa5-6dc9-f2e3-3de54fe8f230@redhat.com>
Date: Tue, 3 Oct 2017 12:25:54 +0200
MIME-Version: 1.0
In-Reply-To: <1507024644-14853-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] hw/block/onenand: Remove
 dead code block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 03/10/2017 11:57, Thomas Huth wrote:
> The condition of the for-loop makes sure that b is always smaller
> than s->blocks, so the "if (b >= s->blocks)" statement is completely
> superfluous here.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1715007
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/block/onenand.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/block/onenand.c b/hw/block/onenand.c
> index 30e40f3..de65c9e 100644
> --- a/hw/block/onenand.c
> +++ b/hw/block/onenand.c
> @@ -520,10 +520,6 @@ static void onenand_command(OneNANDState *s)
>          s->intstatus |= ONEN_INT;
>  
>          for (b = 0; b < s->blocks; b ++) {
> -            if (b >= s->blocks) {
> -                s->status |= ONEN_ERR_CMD;
> -                break;
> -            }
>              if (s->blockwp[b] == ONEN_LOCK_LOCKTIGHTEN)
>                  break;
>  
> 

Looks like a bad cut'n'paste from case 0x23.

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
