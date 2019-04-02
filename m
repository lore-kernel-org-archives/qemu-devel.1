Received: from eggs.gnu.org ([209.51.188.92]:54360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hBBsb-0002j4-TI
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hBBr1-0006zL-W3
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:21:00 -0400
References: <1553849325-44201-1-git-send-email-like.xu@linux.intel.com>
	<1553849325-44201-5-git-send-email-like.xu@linux.intel.com>
	<87h8bmuj2d.fsf@zen.linaroharston>
	<2546bf3e-2009-5a76-bc63-0ad73d333a78@linux.intel.com>
	<20190401233818.GA22884@habkost.net>
	<965d5d2f-1717-dcd0-8707-f6629f54e504@linux.intel.com>
	<CAFEAcA_i9Te5Gs9GWnqH+JvTPFbp80+n2D=VAoC0e2DS7OfSeg@mail.gmail.com>
From: Like Xu <like.xu@linux.intel.com>
Message-ID: <ca73da94-df07-ac0e-67a4-8c9b18b7dc20@linux.intel.com>
Date: Tue, 2 Apr 2019 13:20:51 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_i9Te5Gs9GWnqH+JvTPFbp80+n2D=VAoC0e2DS7OfSeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/9] cpu/topology: add ARM support for smp
 machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, like.xu@intel.com, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 2019/4/2 12:45, Peter Maydell wrote:
> On Tue, 2 Apr 2019 at 09:46, Like Xu <like.xu@linux.intel.com> wrote:
>>
>> On 2019/4/2 7:38, Eduardo Habkost wrote:
>>> On Mon, Apr 01, 2019 at 10:56:30AM +0800, Like Xu wrote:
>>>> On 2019/3/29 17:27, Alex Bennée wrote:
>>> [...]
>>>>>> @@ -1713,6 +1717,9 @@ static void cortex_a9_initfn(Object *obj)
>>>>>>     #ifndef CONFIG_USER_ONLY
>>>>>>     static uint64_t a15_l2ctlr_read(CPUARMState *env, const ARMCPRegInfo *ri)
>>>>>>     {
>>>>>> +    MachineState *ms = MACHINE(qdev_get_machine());
>>>>>
>>>>> How expensive is qdev_get_machine? This could potentially be a
>>>>> performance issue if this register is read a lot.
>>>>
>>>> It may not bother us cause the MachineState object would be feteched from
>>>> qemu QOM at its first requested time and save it as static variable for
>>>> incoming requests.
>>>
>>> We already have a current_machine variable declared in
>>> include/hw/boards.h.  We normally avoid using it and use
>>> MACHINE(qdev_get_machine()) instead, but I never understood why.
>>>
>> Which one do you prefer to access smp machine properties?
> 
> My suggestion would be that we use qdev_get_machine(). I think
> it would be nice to make the remaining dozen or so uses of
> the global current_machine outside vl.c use qdev_get_machine()
> instead, and then make current_machine local to vl.c instead
> of global.
> 
> thanks
> -- PMM
> 
> 
It looks good to me and I am not sure if this refactoring should be 
added in next patch series or as a separate patch.
