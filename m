Received: from eggs.gnu.org ([209.51.188.92]:40551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2w8i-0007x7-Me
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 06:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h2w8h-0004oB-VD
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 06:57:08 -0400
References: <20190309181920.30553-1-philmd@redhat.com>
	<20190309181920.30553-3-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f5c474da-1a8c-6b8d-0027-cff9c7bf974f@vivier.eu>
Date: Sun, 10 Mar 2019 11:56:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190309181920.30553-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] hw/nvram/fw_cfg: Use the ldst API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>, qemu-arm@nongnu.org

On 09/03/2019 19:19, Philippe Mathieu-Daudé wrote:
> The load/store API eases code review.
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 7fdf04adc9..3d8859e333 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -85,7 +85,7 @@ static char *read_splashfile(char *filename, gsize *file_sizep,
>      }
>  
>      /* check magic ID */
> -    filehead = ((content[0] & 0xff) + (content[1] << 8)) & 0xffff;
> +    filehead = lduw_le_p(content);
>      if (filehead == 0xd8ff) {
>          file_type = JPG_FILE;
>      } else if (filehead == 0x4d42) {
> @@ -96,7 +96,7 @@ static char *read_splashfile(char *filename, gsize *file_sizep,
>  
>      /* check BMP bpp */
>      if (file_type == BMP_FILE) {
> -        bmp_bpp = (content[28] + (content[29] << 8)) & 0xffff;
> +        bmp_bpp = lduw_le_p(&content[28]);
>          if (bmp_bpp != 24) {
>              goto error;
>          }
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
