Received: from eggs.gnu.org ([2001:4830:134:3::10]:54575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGmFf-0002sP-8n
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGmFZ-0004Lg-NN
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:32:11 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cGmFZ-0004LS-JW
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:32:05 -0500
Received: by mail-vk0-f46.google.com with SMTP id p9so58677178vkd.3
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 04:32:05 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Dec 2016 12:30:44 +0000
Message-ID: <CAFEAcA_D9wx=EZWE_ypAFPkQcYBhM+7NJaOt7rg=ed-0fExo8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] cadence_uart: Check if
 receiver timeout counter is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Gacek <andrew.gacek@gmail.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Laurent Vivier <lvivier@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On 8 December 2016 at 11:21, Andrew Gacek <andrew.gacek@gmail.com> wrote:
> When register Rcvr_timeout_reg0 (R_RTOR in cadence_uart.c) is set to
> 0, the receiver timeout counter should be disabled. See page 1801 of
> "Zynq-7000 AP SoC Technical Reference Manual". This commit adds a
> such a check before setting the receive timeout interrupt.
>
> Signed-off-by: Andrew Gacek <andrew.gacek@gmail.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  hw/char/cadence_uart.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Thanks; I've applied this to the target-arm.next queue for 2.9.

For future patches, if you send a revised version of a patch it's
best to send it as a standalone new thread (with a subject that
says "[PATCH v2]"), not as a reply to the thread that started with
the original patch. Otherwise our automated scripts and tooling
for handling patch emails tend not to notice it.

thanks
-- PMM
