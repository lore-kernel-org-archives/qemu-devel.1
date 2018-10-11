Received: from eggs.gnu.org ([2001:4830:134:3::10]:37378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAeZU-0004Qj-7H
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAeZM-0007bN-R1
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:16:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAeZK-0007Xx-Pw
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 13:16:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id n11-v6so10462236wru.13
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 10:16:12 -0700 (PDT)
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
	<08d9d1e0-3c37-4b69-bb68-bf993b91289a@redhat.com>
	<2dddf6d3-4362-9ed1-18b5-f927e850c10f@greensocs.com>
	<CAFEAcA-mv2k=fe_QoBpdow4afm6QR2BPAAaD+aC3hdxEfvcPAw@mail.gmail.com>
	<8bee981b-298c-10ab-7f0d-4d0c2d2c8e02@redhat.com>
	<CAFEAcA8y0X-7njxMj5j6q4v7UGP0FVsn0Gy1oty2e95xa22-xw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1e386a7d-b383-6a28-8c14-24045be3b4f7@redhat.com>
Date: Thu, 11 Oct 2018 19:16:08 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8y0X-7njxMj5j6q4v7UGP0FVsn0Gy1oty2e95xa22-xw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Damien Hedde <damien.hedde@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>, Mark Burton <mark.burton@greensocs.com>, Sai Pavan Boddu <saipava@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, konrad@adacore.com, Luc Michel <luc.michel@greensocs.com>

On 11/10/2018 19:12, Peter Maydell wrote:
> On 11 October 2018 at 18:00, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> On 11/10/2018 18:23, Peter Maydell wrote:
>>> How many devices have a clock and nothing else that would cause
>>> them to be non-user-creatable (ie no GPIOs, no IRQ lines, no
>>> memory-mapped memory regions) ?
>>
>> I'm not sure I understood your question.
> 
> Sorry, let me try rephrasing.
> 
> We started with the question of whether devices with clocks should be
> marked not user creatable. It's already the case that devices with any
> of IRQs, GPIOs or memory-mapped registers can't be user created.
> (In particular, any sysbus device is not user-creatable by default.)
> So the question was intended to ask how often it matters whether
> we can't wire up devices with clocks on the command line.
> Are there any devices which would have clocks, but aren't *already*
> ruled out of being user creatable for other reasons? If there
> aren't any, it doesn't really matter much that we don't have
> a mechanism for command line clock wiring.

Thank you for clearing this out.

> 
> So I think the answer is:
>  * almost all users of this API framework are going to be
>    sysbus devices; those are already not user-creatable

Yes.

>  * any device that uses this framework, and which is not
>    a sysbus device (but instead a plain old qdev device)
>    will need to mark itself as not-user-creatable by hand,
>    the same as if it uses the qdev gpio APIs

OK, you answered my first question, it is now clearer to me :)

Thank you!

Phil.
