Received: from eggs.gnu.org ([2001:4830:134:3::10]:50580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dPbcH-0004RO-Uc
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 17:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dPbcH-0006hf-1q
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 17:32:17 -0400
References: <1479133935-63848-1-git-send-email-agraf@suse.de>
	<1479133935-63848-3-git-send-email-agraf@suse.de>
	<CAFEAcA9yW+pOcdE6d6-FUxtVZtEcEXZyEkjwACZa89CbnJ9Y8w@mail.gmail.com>
	<20170626150334.fba6stzqzto4nvcb@kamzik.brq.redhat.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <afd9127e-1b06-cced-714f-f55ab8dffdad@suse.de>
Date: Mon, 26 Jun 2017 23:32:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170626150334.fba6stzqzto4nvcb@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 2/2] ARM: KVM: Enable in-kernel
 timers with user space gic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, kvm-devel <kvm@vger.kernel.org>, cdall@linaro.org

On 06/26/2017 05:03 PM, Andrew Jones wrote:
> On Tue, Dec 13, 2016 at 01:20:50PM +0000, Peter Maydell wrote:
>> On 14 November 2016 at 14:32, Alexander Graf <agraf@suse.de> wrote:
>>> When running with KVM enabled, you can choose between emulating the
>>> gic in kernel or user space. If the kernel supports in-kernel virtualization
>>> of the interrupt controller, it will default to that. If not, if will
>>> default to user space emulation.
>>>
>>> Unfortunately when running in user mode gic emulation, we miss out on
>>> timer events which are only available from kernel space. This patch leverages
>>> the new kernel/user space pending line synchronization for those timer events.
>>>
>>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
> Hi everyone,
>
> I probably missed a refresh of this patch, but as I didn't see anything,
> I picked this one up today in order to test the KVM support recently
> merged. Tweaking this patch a bit to fit the new ABI allowed me to
> instantiate a KVM guest without the in-kernel irqchip (tested on a
> mustang). So, FWIW, this is report of a successful test. Is there a
> refreshed version of this patch someone can point me to, which I should
> test instead?

Sorry, this did fall the cracks way too many times now. I've sent a 
respin that hopefully is slightly more future proof than this RFC :)

If your tests passed with this patch, please extend them to also cover 
SMP support, as that was broken with this RFC.


Alex
