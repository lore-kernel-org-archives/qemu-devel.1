Received: from eggs.gnu.org ([2001:4830:134:3::10]:58305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eDITh-0006nr-QG
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 18:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eDITg-0005Kv-Su
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 18:12:49 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171110202345.GU3111@localhost.localdomain>
References: <1510343626-25861-1-git-send-email-cota@braap.org>
	<1510343626-25861-2-git-send-email-cota@braap.org>
	<20171110202345.GU3111@localhost.localdomain>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 10 Nov 2017 15:12:17 -0800
Message-ID: <CAKmqyKOZtd7JGDHV8YF+9G-8Ke8BO9o5yc1ZuEwA3H7DGuxeVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 2.11 1/5] qom: move
 CPUClass.tcg_initialize to a global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Emilio G. Cota" <cota@braap.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

On Fri, Nov 10, 2017 at 12:23 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Fri, Nov 10, 2017 at 02:53:42PM -0500, Emilio G. Cota wrote:
>> 55c3cee ("qom: Introduce CPUClass.tcg_initialize", 2017-10-24)
>> introduces a per-CPUClass bool that we check so that the target CPU
>> is initialized for TCG only once. This works well except when
>> we end up creating more than one CPUClass, in which case we end
>> up incorrectly initializing TCG more than once, i.e. once for
>> each CPUClass.
>>
>> This can be replicated with:
>>   $ aarch64-softmmu/qemu-system-aarch64 -machine xlnx-zcu102 -smp 6 \
>>       -global driver=xlnx,,zynqmp,property=has_rpu,value=on
>> In this case the class name of the "RPUs" is prefixed by "cortex-r5-",
>> whereas the "regular" CPUs are prefixed by "cortex-a53-". This
>> results in two CPUClass instances being created.
>>
>> Fix it by introducing a static variable, so that only the first
>> target CPU being initialized will initialize the target-dependent
>> part of TCG, regardless of CPUClass instances.
>>
>> Fixes: 55c3ceef61fcf06fc98ddc752b7cce788ce7680b
>> Signed-off-by: Emilio G. Cota <cota@braap.org>
>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Tested-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

>
> --
> Eduardo
>
