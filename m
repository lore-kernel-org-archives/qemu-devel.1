Received: from eggs.gnu.org ([2001:4830:134:3::10]:43797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciO75-00086x-Qz
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciO74-0005Iz-SQ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:27 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciO74-0005Ih-Kv
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:25:26 -0500
Received: by mail-wr0-x235.google.com with SMTP id g10so55811111wrg.2
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 08:25:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170227160118.3557-1-shah.suramya@gmail.com>
References: <20170227160118.3557-1-shah.suramya@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 16:25:04 +0000
Message-ID: <CAFEAcA-txbw4jQb8+eo=A8AdQveLkQVN7qeh2StLsDveX6PSmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [[PATCH-2]] Removed support for DEPTH!=32 in
 sm501.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suramya Shah <shah.suramya@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 27 February 2017 at 16:01, Suramya Shah <shah.suramya@gmail.com> wrote:
> Signed-off-by: Suramya Shah <shah.suramya@gmail.com>
> ---
>  hw/display/sm501.c | 17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 040a0b9..faca906 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -1173,23 +1173,6 @@ typedef void draw_line_func(uint8_t *d, const uint8_t *s,
>  typedef void draw_hwc_line_func(SM501State * s, int crt, uint8_t * palette,
>                                  int c_y, uint8_t *d, int width);
>
> -#define DEPTH 8
> -#include "sm501_template.h"
> -
> -#define DEPTH 15
> -#include "sm501_template.h"
> -
> -#define BGR_FORMAT
> -#define DEPTH 15
> -#include "sm501_template.h"
> -
> -#define DEPTH 16
> -#include "sm501_template.h"
> -
> -#define BGR_FORMAT
> -#define DEPTH 16
> -#include "sm501_template.h"
> -
>  #define DEPTH 32
>  #include "sm501_template.h"

Surely this code can't compile either? You've removed the definitions
of the draw_line8_8, draw_line8_15, etc functions but not their uses
later in this file.

I think you need to make sure that you have a setup that is compiling
the code changes that you make. Check that if you put an obvious
syntax error into the sm501.c file that it causes the build to fail.
(If it doesn't then you've probably not passed arguments to configure
to enable the sh4 target that uses this device.)

thanks
-- PMM
