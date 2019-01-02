Received: from eggs.gnu.org ([208.118.235.92]:33303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1gecDv-0007QU-H8
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 03:50:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1gecDs-0003l0-DY
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 03:49:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 02 Jan 2019 16:49:30 +0800
From: yuchenlin <yuchenlin@synology.com>
In-Reply-To: <20181228145055.18039-1-jcfaracco@gmail.com>
References: <20181228145055.18039-1-jcfaracco@gmail.com>
Message-ID: <ed671ae893c52d3ff94c849ab18f2857@synology.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] dmg: Fixing wrong dmg block
 type value for block terminator.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julio Faracco <jcfaracco@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com, mreitz@redhat.com, Qemu-block <qemu-block-bounces+yuchenlin=synology.com@nongnu.org>

On 2018-12-28 22:50, Julio Faracco wrote:
> This is a trivial patch to fix a wrong value for block terminator.
> The old value was 0x7fffffff which is wrong. It was not affecting the
> code because QEMU dmg block is not handling block terminator right now.
> Neverthless, it should be fixed.
> 
> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>

Reviewed-by: yuchenlin <yuchenlin@synology.com>

> ---
>  block/dmg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/dmg.c b/block/dmg.c
> index 50e91aef6d..2c806e3389 100644
> --- a/block/dmg.c
> +++ b/block/dmg.c
> @@ -54,7 +54,7 @@ enum {
>      UDBZ,
>      ULFO,
>      UDCM = 0x7ffffffe, /* Comments */
> -    UDLE               /* Last Entry */
> +    UDLE = 0xffffffff  /* Last Entry */
>  };
> 
>  static int dmg_probe(const uint8_t *buf, int buf_size, const char 
> *filename)
