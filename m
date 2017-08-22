Received: from eggs.gnu.org ([2001:4830:134:3::10]:52791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkDZ4-0006le-RC
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:06:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkDZ3-0008Gv-VU
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:06:10 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dkDZ3-0008GU-O3
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:06:09 -0400
Received: by mail-wr0-x22b.google.com with SMTP id f8so93694553wrf.3
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 11:06:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOH8G1LzLHksfuxQLBskFB0KsCy7zP5pPtbtvUmQcZORQ@mail.gmail.com>
References: <cover.1502993370.git.alistair.francis@xilinx.com>
	<20170822172438.GF3205@toto>
	<CAKmqyKOH8G1LzLHksfuxQLBskFB0KsCy7zP5pPtbtvUmQcZORQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 19:05:48 +0100
Message-ID: <CAFEAcA9RXagwj4fvpy=bFahoZ95Or83PiozJmLwYmobxRkVTvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Expose the secure property to the
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@gmail.com>

On 22 August 2017 at 18:57, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Tue, Aug 22, 2017 at 10:24 AM, Edgar E. Iglesias
> <edgar.iglesias@xilinx.com> wrote:
>> On Thu, Aug 17, 2017 at 11:51:59AM -0700, Alistair Francis wrote:
>>> The EL2 and EL3 work is working well now and interanlly we now have
>>> tests that expect to start in EL3 and transition through EL2 to EL1. To
>>> make this easy to run let's expose the secure property to the machine
>>> and then use that to enable EL2.
>>>
>>> This series also does some machine/name tidying up and makes the first
>>> move to deprecating the EP108 machine, which was just an early access
>>> development board.
>>
>> Hi Alistair,
>>
>> Reconsidering this, I tend to agree that we're probably better off with
>> EL2/no-GICv2-virt compared to the possible confusiong of having EL2
>> without GICv2-virt..
>>
>> But I wonder if we should have similar options as the virt machine?
>> I.e, a virtualization option to enable EL2.
>
> That's fine with me.
>
> Just to clarify do you think we should keep the secure option for EL3
> and add a virt option for EL2?

I think unless you have a really strong reason to be different
(eg back-compat with existing guests) then following what
the 'virt' board does for machine options is probably going
to be least confusing. NB that that does include letting you
specify some combos that don't work, like gicv2 + virt...

(We should really get round to implementing virt support in
the GICv2, though.)

thanks
-- PMM
