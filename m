Received: from eggs.gnu.org ([2001:4830:134:3::10]:39844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQxIW-0006Wv-Qk
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dQxIW-0001UQ-3Q
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 10:53:28 -0400
References: <1498830944-26857-1-git-send-email-edgar.iglesias@gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <b6f56809-e405-5b92-83ef-485906ad382a@adacore.com>
Date: Fri, 30 Jun 2017 16:53:15 +0200
MIME-Version: 1.0
In-Reply-To: <1498830944-26857-1-git-send-email-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] xilinx-dp: Add support for the yuy2
 video format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com, qemu-arm@nongnu.org, alistai@xilinx.com


On 06/30/2017 03:55 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add support for the yuy2 video format.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Acked-by: Sai Pavan Boddu <saipava@xilinx.com>
> ---
>   hw/display/xlnx_dp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index f7b7b80..a77d7db 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -624,6 +624,9 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s)
>       case 0:
>           s->v_plane.format = PIXMAN_x8b8g8r8;
>           break;
> +    case DP_NL_VID_Y0_CB_Y1_CR:
> +        s->v_plane.format = PIXMAN_yuy2;
> +        break;
>       case DP_NL_VID_RGBA8880:
>           s->v_plane.format = PIXMAN_x8b8g8r8;
>           break;
> 

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

Fred
