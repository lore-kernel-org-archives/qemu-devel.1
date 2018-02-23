Received: from eggs.gnu.org ([2001:4830:134:3::10]:55246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epHiM-0004Ot-0d
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epHiK-0004qZ-Sz
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:04:57 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:38037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epHiK-0004ph-MY
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:04:56 -0500
Received: by mail-pg0-x244.google.com with SMTP id l24so3643432pgc.5
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:04:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223112933.4135-1-mark.cave-ayland@ilande.co.uk>
References: <20180223112933.4135-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 18:04:35 +0000
Message-ID: <CAFEAcA-6KuJe17cHNVUzaKT30uv7bBS52ctoNxS0u9Mfp_HtXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] loader: don't perform overlapping address
 check for memory region ROM images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 23 February 2018 at 11:29, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> All memory region ROM images have a base address of 0 which causes the overlapping
> address check to fail if more than one memory region ROM image is present, or an
> existing ROM image is loaded at address 0.
>
> Make sure that we ignore the overlapping address check in
> rom_check_and_register_reset() if this is a memory region ROM image. In particular
> this fixes the "rom: requested regions overlap" error on startup when trying to
> run qemu-system-sparc with a -kernel image since commit 7497638642: "tcx: switch to
> load_image_mr() and remove prom_addr hack".
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Do you want to take this via your sparc tree?

thanks
-- PMM
