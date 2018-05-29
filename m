Received: from eggs.gnu.org ([2001:4830:134:3::10]:43560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNg48-0006nt-2W
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNg47-0000gu-Bk
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:57:36 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNg47-0000gI-6k
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:57:35 -0400
Received: by mail-oi0-x243.google.com with SMTP id t133-v6so9707775oif.10
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 07:57:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180528184859.3530-1-frasse.iglesias@gmail.com>
References: <20180528184859.3530-1-frasse.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 May 2018 15:57:14 +0100
Message-ID: <CAFEAcA9Te-rwZYN5wZTaey5qT9Tt-19tOk8ubPNHTRJnSG3Rug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1] xlnx-zdma: Correct mem leaks and memset
 to zero on desc unaligned errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Alistair Francis <alistair@alistair23.me>, Alistair Francis <alistair23@gmail.com>, Francisco Iglesias <francisco.iglesias@feimtech.se>

On 28 May 2018 at 19:48, Francisco Iglesias <frasse.iglesias@gmail.com> wrote:
> Coverity found that the string return by 'object_get_canonical_path' was not
> being freed at two locations in the model (CID 1391294 and CID 1391293) and
> also that a memset was being called with a value greater than the max of a byte
> on the second argument (CID 1391286). This patch corrects this by adding the
> freeing of the strings and also changing to memset to zero instead on
> descriptor unaligned errors.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
> ---
>  hw/dma/xlnx-zdma.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)



Applied to target-arm.next, thanks.

-- PMM
