Received: from eggs.gnu.org ([2001:4830:134:3::10]:59811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1czLLu-0003kO-5E
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 06:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1czLLr-000271-1o
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 06:54:50 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1czLLq-00026s-RR
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 06:54:46 -0400
Received: by mail-wr0-x242.google.com with SMTP id o21so14985482wrb.3
	for <qemu-devel@nongnu.org>; Sat, 15 Apr 2017 03:54:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1491381329-3995-4-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f56ec3d4-236e-2082-db5a-8402eb050503@twiddle.net>
Date: Sat, 15 Apr 2017 03:54:38 -0700
MIME-Version: 1.0
In-Reply-To: <1491381329-3995-4-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/14] cg3: remove unused width and height
 variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, kraxel@redhat.com, qemu-devel@nongnu.org

On 04/05/2017 01:35 AM, Mark Cave-Ayland wrote:
> These aren't required since we can use the display width and height directly.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/display/cg3.c |   15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/hw/display/cg3.c b/hw/display/cg3.c
> index b42f60e..178a6dd 100644
> --- a/hw/display/cg3.c
> +++ b/hw/display/cg3.c
> @@ -93,14 +93,11 @@ static void cg3_update_display(void *opaque)
>      uint32_t *data;
>      uint32_t dval;
>      int x, y, y_start;
> -    unsigned int width, height;
>      ram_addr_t page, page_min, page_max;
>
>      if (surface_bits_per_pixel(surface) != 32) {
>          return;
>      }
> -    width = s->width;
> -    height = s->height;
>
>      y_start = -1;
>      page_min = -1;
> @@ -110,11 +107,11 @@ static void cg3_update_display(void *opaque)
>      data = (uint32_t *)surface_data(surface);
>
>      memory_region_sync_dirty_bitmap(&s->vram_mem);
> -    for (y = 0; y < height; y++) {
> +    for (y = 0; y < s->height; y++) {

I suspect the generated code is much worse, since the compiler can no longer 
tell that the loop bounds are constant.

You probably do want to keep width and height in local variables across this 
function.


r~
