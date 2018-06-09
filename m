Received: from eggs.gnu.org ([2001:4830:134:3::10]:60913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fRij0-0006fk-F8
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 14:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fRiiz-0005ti-L0
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 14:36:30 -0400
References: <20180608200558.386-1-laurent@vivier.eu>
	<20180608200558.386-13-laurent@vivier.eu>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <33f76aa1-ffc7-efef-6b5b-df7a59406343@tuxfamily.org>
Date: Sat, 9 Jun 2018 20:36:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180608200558.386-13-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 12/13] dp8393x: put DMA temp buffer in the
 state, not in the stack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 08.06.2018 22:05, Laurent Vivier wrote:
> It's only 32 bytes, and this simplifies the dp8393x_get()/
> dp8393x_put() interface.

Maybe not worth the effort ... or do you need this in a later patch,
too? If so, please mention it in the patch description here.

> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  hw/net/dp8393x.c | 107 ++++++++++++++++++++++++++-----------------------------
>  1 file changed, 51 insertions(+), 56 deletions(-)
> 
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index 5061474e6b..40e5f8257b 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -168,6 +168,7 @@ typedef struct dp8393xState {
>  
>      /* Temporaries */
>      uint8_t tx_buffer[0x10000];
> +    uint16_t data[16];

Why 16? The biggest array that you replaced has only 12 entries...

Also, while you're at it, maybe change the name of the variable
("dma_data"?) or add a comment with a short explanation ?

 Thomas
