Received: from eggs.gnu.org ([2001:4830:134:3::10]:50174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dgJFT-00062N-TN
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 19:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dgJFS-00012W-S1
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 19:21:47 -0400
MIME-Version: 1.0
In-Reply-To: <cover.1502488636.git.alistair.francis@xilinx.com>
References: <cover.1502488636.git.alistair.francis@xilinx.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Aug 2017 16:21:14 -0700
Message-ID: <CAKmqyKPe8_205KZ5x++cdZ0BR950tQiaQvPstRzcKrwArgpMOw@mail.gmail.com>
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Edgar Iglesias <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On Fri, Aug 11, 2017 at 3:17 PM, Alistair Francis
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

After working with the internal fuzzy testing team I have a test case
where exclusive operations are failing on master but working on top of
this patch series.

Thanks,
Alistair

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
>
> --
> 2.11.0
>
