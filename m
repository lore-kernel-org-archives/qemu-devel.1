Received: from eggs.gnu.org ([2001:4830:134:3::10]:41374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzNaN-0005Wx-F8
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dzNaH-0006ad-W7
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:50:11 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:44785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dzNaH-0006aE-Og
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:50:05 -0400
Received: by mail-wr0-x236.google.com with SMTP id l24so3448665wre.1
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 06:50:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506441116-16627-1-git-send-email-thuth@redhat.com>
References: <1506441116-16627-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Oct 2017 14:49:16 +0100
Message-ID: <CAFEAcA-V5QRwBCCEvekUvTcVtt58y=1McU41LY0z3XP-JyQsXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/xlnx-zynqmp: Mark the "xlnx,
 zynqmp" device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 26 September 2017 at 16:51, Thomas Huth <thuth@redhat.com> wrote:
> The device uses serial_hds in its realize function and thus can't be
> used twice. Apart from that, the comma in its name makes it quite hard
> to use for the user anyway, since a comma is normally used to separate
> the device name from its properties when using the "-device" parameter
> or the "device_add" HMP command.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/xlnx-zynqmp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 2b27daf..d4b6560 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -440,6 +440,8 @@ static void xlnx_zynqmp_class_init(ObjectClass *oc, void *data)
>
>      dc->props = xlnx_zynqmp_props;
>      dc->realize = xlnx_zynqmp_realize;
> +    /* Reason: Uses serial_hds in realize function, thus can't be used twice */
> +    dc->user_creatable = false;
>  }
>
>  static const TypeInfo xlnx_zynqmp_type_info = {



Applied to target-arm.next, thanks.

-- PMM
