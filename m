Received: from eggs.gnu.org ([2001:4830:134:3::10]:38279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esrp3-00063E-KH
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1esrp2-0008IO-L6
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:14:41 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:39724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1esrp2-0008I9-Fn
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:14:40 -0500
Received: by mail-ot0-x242.google.com with SMTP id h8so15197922oti.6
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 07:14:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cover.1520018138.git.alistair.francis@xilinx.com>
References: <cover.1520018138.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 15:14:19 +0000
Message-ID: <CAFEAcA_7SjTtXTUuLLpdE8UShPDnom2+Ka-w0RhcbPx0D0OdRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Add a property to set the ARM CPU
 core count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On 2 March 2018 at 19:15, Alistair Francis <alistair.francis@xilinx.com> wrote:
>
> Add an ARM CPU property which allows us to set the ARM CPU core count.
> V3:
>  - Fix Linux user mode compile failure
>
> V2:
>  - Fix commit message and title.
>  - Move the core_count default setting logic to the arm_cpu_realize()
>    function.
>
>
> Alistair Francis (2):
>   target/arm: Add a core count property
>   hw/arm: Set the core count for Xilinx's ZynqMP
>
>  target/arm/cpu.h     | 5 +++++
>  hw/arm/xlnx-zynqmp.c | 2 ++
>  target/arm/cpu.c     | 6 ++++++
>  target/arm/cpu64.c   | 6 ++++--
>  4 files changed, 17 insertions(+), 2 deletions(-)
>
> --
> 2.14.1



Applied to target-arm.next, thanks.

-- PMM
