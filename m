Received: from eggs.gnu.org ([2001:4830:134:3::10]:56999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQNKX-0001L8-OO
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 20:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQNKX-0007i7-5E
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 20:01:25 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1513465066.git.balaton@eik.bme.hu>
	<4a19707d5b6554dda851b5da07e0276634b50900.1513465066.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aa2dc73d-7475-a886-fc82-016fde4e4417@amsat.org>
Date: Sat, 16 Dec 2017 22:01:15 -0300
MIME-Version: 1.0
In-Reply-To: <4a19707d5b6554dda851b5da07e0276634b50900.1513465066.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 1/2] sm501: Add panel
 hardware cursor registers also to read function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

On 12/16/2017 07:57 PM, BALATON Zoltan wrote:
> These were forgotten when adding panel layer support.

 ... in ffd39257018.

> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

with reference to commit:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/display/sm501.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 7f18224..b9b6111 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -956,6 +956,19 @@ static uint64_t sm501_disp_ctrl_read(void *opaque, hwaddr addr,
>          ret = s->dc_panel_v_sync;
>          break;
>  
> +    case SM501_DC_PANEL_HWC_ADDR:
> +        ret = s->dc_panel_hwc_addr;
> +        break;
> +    case SM501_DC_PANEL_HWC_LOC:
> +        ret = s->dc_panel_hwc_location;
> +        break;
> +    case SM501_DC_PANEL_HWC_COLOR_1_2:
> +        ret = s->dc_panel_hwc_color_1_2;
> +        break;
> +    case SM501_DC_PANEL_HWC_COLOR_3:
> +        ret = s->dc_panel_hwc_color_3;
> +        break;
> +
>      case SM501_DC_VIDEO_CONTROL:
>          ret = s->dc_video_control;
>          break;
> 
