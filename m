Received: from eggs.gnu.org ([2001:4830:134:3::10]:35822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dpjZT-00062U-Ms
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 19:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dpjZS-0002RV-Rg
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 19:17:23 -0400
MIME-Version: 1.0
In-Reply-To: <a0cce589-b6e1-d17e-34df-f8232c64e5fa@linaro.org>
References: <1504626814-23124-1-git-send-email-peter.maydell@linaro.org>
	<1504626814-23124-2-git-send-email-peter.maydell@linaro.org>
	<a0cce589-b6e1-d17e-34df-f8232c64e5fa@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Sep 2017 16:16:44 -0700
Message-ID: <CAKmqyKPy=Vja7Bq6KTWKh8mrHyJht8rHxcRzC+vHY5DknXjC=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] boards.h: Define new flag
 ignore_memory_transaction_failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On Tue, Sep 5, 2017 at 9:03 AM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 09/05/2017 08:53 AM, Peter Maydell wrote:
>> Define a new MachineClass field ignore_memory_transaction_failures.
>> If this is flag is true then the CPU will ignore memory transaction
>> failures which should cause the CPU to take an exception due to an
>> access to an unassigned physical address; the transaction will
>> instead return zero (for a read) or be ignored (for a write).  This
>> should be set only by legacy board models which rely on the old
>> RAZ/WI behaviour for handling devices that QEMU does not yet model.
>> New board models should instead use "unimplemented-device" for all
>> memory ranges where the guest will attempt to probe for a device that
>> QEMU doesn't implement and a stub device is required.
>>
>> We need this for ARM boards, where we're about to implement support for
>> generating external aborts on memory transaction failures. Too many
>> of our legacy board models rely on the RAZ/WI behaviour and we
>> would break currently working guests when their "probe for device"
>> code provoked an external abort rather than a RAZ.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  include/hw/boards.h | 11 +++++++++++
>>  include/qom/cpu.h   |  7 ++++++-
>>  qom/cpu.c           | 16 ++++++++++++++++
>>  3 files changed, 33 insertions(+), 1 deletion(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

>
>
> r~
>
