Received: from eggs.gnu.org ([2001:4830:134:3::10]:50471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgWww-0004xg-VB
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgWww-0008Uu-1J
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:04:06 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fgWwv-0008Um-QG
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 11:04:05 -0400
Received: by mail-oi0-x244.google.com with SMTP id n84-v6so21844183oib.9
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 08:04:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1532006134-7701-1-git-send-email-thuth@redhat.com>
References: <1532006134-7701-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jul 2018 16:03:44 +0100
Message-ID: <CAFEAcA9K90g83RDbdf7-nJwkGRShCrg66sx9RniR90r91+Ck8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/spitz: Move problematic nand_init()
 code to realize function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Andrzej Zaborowski <balrogg@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On 19 July 2018 at 14:15, Thomas Huth <thuth@redhat.com> wrote:
> nand_init() does not only create the NAND device, it also realizes
> the device with qdev_init_nofail() already. So we must not call
> nand_init() from an instance_init function like sl_nand_init(),
> otherwise we get superfluous NAND devices in the QOM tree after
> introspecting the 'sl-nand' device. So move the nand_init() to the
> realize function of 'sl-nand' instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/spitz.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>



Applied to target-arm.next, thanks.

-- PMM
