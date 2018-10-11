Received: from eggs.gnu.org ([2001:4830:134:3::10]:60831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAeKF-0006RL-SL
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAeKC-0007Wx-CJ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:00:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAeKC-0007Th-2X
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:00:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id y144-v6so10158428wmd.4
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 10:00:27 -0700 (PDT)
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
	<08d9d1e0-3c37-4b69-bb68-bf993b91289a@redhat.com>
	<2dddf6d3-4362-9ed1-18b5-f927e850c10f@greensocs.com>
	<CAFEAcA-mv2k=fe_QoBpdow4afm6QR2BPAAaD+aC3hdxEfvcPAw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8bee981b-298c-10ab-7f0d-4d0c2d2c8e02@redhat.com>
Date: Thu, 11 Oct 2018 19:00:20 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-mv2k=fe_QoBpdow4afm6QR2BPAAaD+aC3hdxEfvcPAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 0/9] Clock framework API.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Damien Hedde <damien.hedde@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, konrad@adacore.com, Luc Michel <luc.michel@greensocs.com>

On 11/10/2018 18:23, Peter Maydell wrote:
> On 11 October 2018 at 17:20, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> Hi Philippe,
>>
>> On 10/4/18 6:13 PM, Philippe Mathieu-Daudé wrote:
>>> Hi Damien,
>>>
>>> On 02/10/2018 16:24, Damien Hedde wrote:
>>>> This series aims to add a way to model clocks in qemu between devices.
>>>> This allows to model the clock tree of a platform allowing us to inspect clock
>>>> configuration and detect problems such as disabled clock or bad configured
>>>> pll.
>>>>
>>>> [...]
>>>>
>>>> Any comments and suggestion are welcomed.
>>>
>>> How would you instanciate devices and connect their clocks from the
>>> command line (with the -device option)?
>> I didn't not thought about that. I'm not sure to understand how this is
>> done for a gpio for example. Is this done by setting the link property
>> manually ?
> 
> You can't wire up GPIOs on the command line. I don't think we
> really need to be able to wire up clocks on the command line either,
> do we?

This would be a big mess.

> 
>> Should clocked devices have DeviceClass::user_creatable = false by default?
> 
> How many devices have a clock and nothing else that would cause
> them to be non-user-creatable (ie no GPIOs, no IRQ lines, no
> memory-mapped memory regions) ?

I'm not sure I understood your question.

But I understand than as devices consuming GPIO/IRQ, clocked device
can't be instantiate from command line, and I am happy with that.
