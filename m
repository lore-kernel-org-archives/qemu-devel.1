Received: from eggs.gnu.org ([2001:4830:134:3::10]:43682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dgTbB-0003FC-Og
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 06:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dgTbA-00062p-Hf
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 06:24:53 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dgTbA-000629-Af
	for qemu-devel@nongnu.org; Sat, 12 Aug 2017 06:24:52 -0400
Received: by mail-wr0-x22a.google.com with SMTP id y43so20626871wrd.3
	for <qemu-devel@nongnu.org>; Sat, 12 Aug 2017 03:24:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1502488636.git.alistair.francis@xilinx.com>
References: <cover.1502488636.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 12 Aug 2017 11:24:30 +0100
Message-ID: <CAFEAcA_GsfrueJQYbL6dzNBnLwMWHd3fv24CMRczuf_TxYo6NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/3] Fixup exclusive store logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On 11 August 2017 at 23:17, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> I found some issues with the way exclusive store was working. This patch
> series seems to fix the test cases that were failing for me.
>
> The first patch is just a simple adjustment.
>
> The third patch fixes the main bug I was seeing.
>
> The second patch is left over from the RFC that seems like it is still a
> good idea.
>
> Changes from RFC:
>  - Rewrite the third patch to correctly fix the issue.
>
> Alistair Francis (3):
>   target/arm: Update the memops for exclusive load
>   tcg/tcg-op: Expose the tcg_gen_ext_i* functions
>   target/arm: Correct exclusive store cmpxchg memop mask
>
>  target/arm/translate-a64.c | 4 ++--
>  tcg/tcg-op.c               | 4 ++--
>  tcg/tcg-op.h               | 2 ++
>  3 files changed, 6 insertions(+), 4 deletions(-)

Is this series (or at least patches 1 and 3) worth putting
into 2.10 ?

thanks
-- PMM
