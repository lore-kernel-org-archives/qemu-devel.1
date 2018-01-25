Received: from eggs.gnu.org ([2001:4830:134:3::10]:53696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eefpy-0005VU-HM
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eefpx-0007h7-LY
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:36:58 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eefpx-0007gp-H8
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:36:57 -0500
Received: by mail-oi0-x244.google.com with SMTP id b11so5021547oif.2
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 03:36:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <29c39a6f9ce3734bf693581348ed78f4bff3e0ef.1516746211.git.alistair.francis@xilinx.com>
References: <cover.1516746211.git.alistair.francis@xilinx.com>
	<29c39a6f9ce3734bf693581348ed78f4bff3e0ef.1516746211.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 11:36:36 +0000
Message-ID: <CAFEAcA-eOMvYYv--wjs+i1wGG3AN1VueqZjtnE5vpBH=UavkfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/3] xlnx-zynqmp-rtc: Add basic time
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 23 January 2018 at 22:24, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> Allow the guest to determine the time set from the QEMU command line.
>
> This includes adding a trace event to debug the new time.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>  static const VMStateDescription vmstate_rtc = {
>      .name = TYPE_XLNX_ZYNQMP_RTC,
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .post_load = rtc_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPRTC, XLNX_ZYNQMP_RTC_R_MAX),
> +        VMSTATE_INT32(current_tm.tm_sec, XlnxZynqMPRTC),
> +        VMSTATE_INT32(current_tm.tm_min, XlnxZynqMPRTC),
> +        VMSTATE_INT32(current_tm.tm_hour, XlnxZynqMPRTC),
> +        VMSTATE_INT32(current_tm.tm_wday, XlnxZynqMPRTC),
> +        VMSTATE_INT32(current_tm.tm_mday, XlnxZynqMPRTC),
> +        VMSTATE_INT32(current_tm.tm_mon, XlnxZynqMPRTC),
> +        VMSTATE_INT32(current_tm.tm_year, XlnxZynqMPRTC),

I'm still not sure about having the current_tm struct fields
here rather than whatever the hardware's natural representation
of the current time is. Can you explain why you think this
is the best approach?

thanks
-- PMM
