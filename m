Received: from eggs.gnu.org ([2001:4830:134:3::10]:55239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e2gUH-0003Am-NR
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1e2gUH-0005Re-03
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 12:37:33 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <1507814267-21400-1-git-send-email-peter.maydell@linaro.org>
References: <1507814267-21400-1-git-send-email-peter.maydell@linaro.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 12 Oct 2017 09:36:59 -0700
Message-ID: <CAKmqyKN56URJjH06gyOJA3HS86N8ap4WkRCL97RHN7Y-P7bBXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] include/hw/or-irq.h: Drop unused in_irqs
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Patch Tracking <patches@linaro.org>

On Thu, Oct 12, 2017 at 6:17 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> The struct OrIRQState has an unused member field in_irqs.
> This is a legacy of earlier versions of the patch; the
> code that used it was dropped from the final version of
> the code that went into master, but we forgot to delete
> the no-longer-used struct field. Do so now.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Good catch.

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  include/hw/or-irq.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/hw/or-irq.h b/include/hw/or-irq.h
> index d400a81..fd900fc 100644
> --- a/include/hw/or-irq.h
> +++ b/include/hw/or-irq.h
> @@ -38,7 +38,6 @@ struct OrIRQState {
>      DeviceState parent_obj;
>
>      qemu_irq out_irq;
> -    qemu_irq *in_irqs;
>      bool levels[MAX_OR_LINES];
>      uint16_t num_lines;
>  };
> --
> 2.7.4
>
>
