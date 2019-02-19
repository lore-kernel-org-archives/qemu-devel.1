Received: from eggs.gnu.org ([209.51.188.92]:41967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw5zm-0007qB-SJ
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw5zk-0001Po-Ov
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:03:38 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:41824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw5zf-0001OA-Ut
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:03:33 -0500
Received: by mail-ot1-x32a.google.com with SMTP id t7so17869836otk.8
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 06:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-7-armbru@redhat.com>
In-Reply-To: <20190218125615.18970-7-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 14:03:16 +0000
Message-ID: <CAFEAcA_OLYno=YNS6bHOemwEp0gnc3fwRn8Rjvmo9v-i89xrMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 06/10] r2d: Flash memory creation is
 confused about size, mark FIXME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Laszlo Ersek <lersek@redhat.com>

On Mon, 18 Feb 2019 at 13:07, Markus Armbruster <armbru@redhat.com> wrote:
>
> pflash_cfi02_register() takes a size in bytes, a block size in bytes
> and a number of blocks.  r2d_init() passes FLASH_SIZE, 16 * KiB,
> FLASH_SIZE >> 16.  Does not compute: size doesn't match block size *
> number of blocks.  The latter happens to win.  I tried to find
> documentation on the physcial hardware, no luck.
>
> For now, adjust the byte size passed to match the actual size created,
> and add a FIXME comment.

I'm pretty sure that FLASH_SIZE here is supposed to be a
byte count of the size of the pflash. That matches what
Linux has in arch/sh/boards/mach-r2d/setup.c where it
sets up the flash_resource struct.

The r2dplus board is also I think known as RTS7751R2D. That
takes us to https://elinux.org/RTS7751R2D_Handling_Manual
(sadly the link to the "hardware manual" is broken).

No idea what the block size would be.


thanks
-- PMM
