Received: from eggs.gnu.org ([2001:4830:134:3::10]:53105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1flCU6-0000Fk-Bc
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 08:13:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1flCU5-0000fk-Ay
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 08:13:38 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36378)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1flCU5-0000fA-0n
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 08:13:37 -0400
Received: by mail-oi0-x241.google.com with SMTP id n21-v6so3577157oig.3
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 05:13:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180730173712.GG4987@os.inf.tu-dresden.de>
References: <20180730173712.GG4987@os.inf.tu-dresden.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Aug 2018 13:13:15 +0100
Message-ID: <CAFEAcA8-yawULceZHgy+zToBsRbASL2+ZDsE8C5w--Ronq_NCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] arm: Fix return code of arm_load_elf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Adam Lackorzynski <adam@l4re.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 July 2018 at 18:37, Adam Lackorzynski <adam@l4re.org> wrote:
> Use an int64_t as a return type to restore
> the negative check for arm_load_as.
>
> Signed-off-by: Adam Lackorzynski <adam@l4re.org>
> ---
>  hw/arm/boot.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)


Applied to target-arm.for-3.1, thanks.

-- PMM
