Received: from eggs.gnu.org ([2001:4830:134:3::10]:53171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGmBo-0008LE-Sz
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGmBl-000319-O2
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:28:12 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cGmBl-0002wD-IP
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:28:09 -0500
Received: by mail-vk0-f52.google.com with SMTP id p9so58527110vkd.3
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 04:27:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <04ae30ed8ee1758cd2d2af880da4d28f74c67738.1481132150.git.alistair.francis@xilinx.com>
References: <04ae30ed8ee1758cd2d2af880da4d28f74c67738.1481132150.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Dec 2016 12:26:25 +0000
Message-ID: <CAFEAcA8mWr0tRHqLqPuSptUKFDOmXnmKfEffMK8EfJaFFSQ5kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for 2.8 v4 1/1] cadence_uart: Check baud
 rate generator and divider values on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Huawei PSIRT <psirt@huawei.com>

On 7 December 2016 at 17:53, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> The Cadence UART device emulator calculates speed by dividing the
> baud rate by a 'baud rate generator' & 'baud rate divider' value.
> The device specification defines these register values to be
> non-zero and within certain limits. Checks were recently added when
> writing to these registers but not when restoring from migration.
>
> This patch adds checks when restoring from migration to avoid divide by
> zero errors.
>
> Reported-by: Huawei PSIRT <psirt@huawei.com>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>



Applied to target-arm.next for 2.9, thanks.

-- PMM
