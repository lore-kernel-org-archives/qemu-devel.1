Received: from eggs.gnu.org ([2001:4830:134:3::10]:42932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d2xNB-0002We-HI
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d2xN7-0003r4-JD
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:07:05 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_PuC_B6GqL0n==SDZooQj9FtviHK3XixHd=m0Twmfp+A@mail.gmail.com>
References: <1491736758-19540-1-git-send-email-sundeep.lkml@gmail.com>
	<1491736758-19540-2-git-send-email-sundeep.lkml@gmail.com>
	<CAKmqyKMW-aTdzvTH5sir1BPx6U9XtgiZZ7TVigooXLFMY=UEQg@mail.gmail.com>
	<CALHRZuroavWhKmiZEC6eCh0KFif0dWuQWi=QprH122QnAGjnpA@mail.gmail.com>
	<CAKmqyKMT9Bn7OPU+h6o2Xj4DZXrVSBHr=jtR6jMSvhph0koegA@mail.gmail.com>
	<CAFEAcA_PuC_B6GqL0n==SDZooQj9FtviHK3XixHd=m0Twmfp+A@mail.gmail.com>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Tue, 25 Apr 2017 15:37:00 +0530
Message-ID: <CALHRZuqSvd2-XH_QwUT9BRkjXnsu6=HoMB3QJZEkS5DRAjVZ-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-devel RFC v2 1/4] msf2: Add Smartfusion2
 System timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Hi Alistair and Peter,

On Mon, Apr 24, 2017 at 11:28 PM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 24 April 2017 at 18:44, Alistair Francis <alistair23@gmail.com> wrote:
>> Basically the simple explanation is that init is called when the
>> object is created and realize is called when the object is realized.
>>
>> Generally for devices it will go something like this:
>>  1. init
>>  2. Set properties
>>  3. Connect things
>>  4. realize
>>  5. Map to memory
>>
>>> Don't we need to use realize function for new models?
>>
>> AFAIK we still put things like: sysbus_init_irq(),
>> memory_region_init_io() and sysbus_init_mmio() in the init function.
>>
>> I don't think we are at a stage yet to not use init functions.
>
> Two-phase init is here to stay -- some things must be done in
> init, some must be done in realize, and some can be done in
> either. Some simple devices may find they can do everything
> in only one function.
>
> Must be done in init:
>  * creating properties (for the cases where that is done "by hand"
>    by calling object_property_add_*())
>  * calling init on child objects which you want to pass through
>    alias properties for
>
> Must be done in realize:
>  * anything that can fail such that we need to report the
>    error and abandon creation of the device
>  * anything which depends on the values of QOM properties that
>    the caller might have set
>
> We should probably sit down and write up some guidelines for
> how we recommend dealing with the various things that could
> be called in either function -- this is basically a code
> style and consistency question.

Thanks for the brief. It makes sense for me now.
I will make changes and send the patches.

Thanks,
Sundeep

>
> thanks
> -- PMM
