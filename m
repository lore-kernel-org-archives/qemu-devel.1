Received: from eggs.gnu.org ([2001:4830:134:3::10]:35274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cTc35-0000ou-FH
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 17:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1cTc34-0005DP-Kj
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 17:16:15 -0500
MIME-Version: 1.0
In-Reply-To: <20161228131452.jt37cfqteqkhb6hn@kamzik.brq.redhat.com>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
	<1481625384-15077-24-git-send-email-peter.maydell@linaro.org>
	<20161228131452.jt37cfqteqkhb6hn@kamzik.brq.redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 17 Jan 2017 14:15:41 -0800
Message-ID: <CAKmqyKMEVtSBg7GuB1qzexkcSxrxW-xqmBPe=-zXcUkbpuapxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 23/23] hw/arm/virt: Add board property to
 enable EL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, Patch Tracking <patches@linaro.org>

On Wed, Dec 28, 2016 at 5:14 AM, Andrew Jones <drjones@redhat.com> wrote:
> On Tue, Dec 13, 2016 at 10:36:24AM +0000, Peter Maydell wrote:
>> Add a board level property to the virt board which will
>> enable EL2 on the CPU if the user asks for it. The
>> default is not to provide EL2. If EL2 is enabled then
>> we will use SMC as our PSCI conduit, and report the
>> virtualization support in the GICv3 device tree node.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,

Alistair

>> ---
>>  hw/arm/virt.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 43 insertions(+), 2 deletions(-)
>>
>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
>
