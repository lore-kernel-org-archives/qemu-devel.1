Received: from eggs.gnu.org ([2001:4830:134:3::10]:40325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5J6B-0004N0-3f
	for qemu-devel@nongnu.org; Mon, 01 May 2017 17:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5J68-0004DQ-1N
	for qemu-devel@nongnu.org; Mon, 01 May 2017 17:43:15 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5J67-0004DI-TF
	for qemu-devel@nongnu.org; Mon, 01 May 2017 17:43:11 -0400
Received: by mail-qk0-x244.google.com with SMTP id o4so430056qkb.3
	for <qemu-devel@nongnu.org>; Mon, 01 May 2017 14:43:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1493624375-12707-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1493624375-12707-3-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c6e1bc74-f671-2ab5-ec66-f26f70967fb9@amsat.org>
Date: Mon, 1 May 2017 18:43:02 -0300
MIME-Version: 1.0
In-Reply-To: <1493624375-12707-3-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/2] cg3: add explicit ram_addr_t cast to
 scanline page variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, peter.maydell@linaro.org, kraxel@redhat.com

On 05/01/2017 04:39 AM, Mark Cave-Ayland wrote:
> Coverity warns that multiplying two 32-bit values gives a 32-bit result which
> is assigned to a 64-bit variable. Add an explicit ram_addr_t cast to silence
> the warning.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/display/cg3.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/display/cg3.c b/hw/display/cg3.c
> index 03d9197..7ef8a96 100644
> --- a/hw/display/cg3.c
> +++ b/hw/display/cg3.c
> @@ -113,7 +113,7 @@ static void cg3_update_display(void *opaque)
>      for (y = 0; y < height; y++) {
>          int update = s->full_update;
>
> -        page = y * width;
> +        page = (ram_addr_t)y * width;
>          update |= memory_region_get_dirty(&s->vram_mem, page, width,
>                                            DIRTY_MEMORY_VGA);
>          if (update) {
>
