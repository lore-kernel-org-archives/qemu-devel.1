Received: from eggs.gnu.org ([2001:4830:134:3::10]:38869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1eb2do-0003PG-G9
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1eb2dn-00012I-K4
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:09:24 -0500
References: <20180110204327.22510-1-jcd@tribudubois.net>
	<a2aa7ea7-ac15-d69e-82cd-dad6c89c61c7@adacore.com>
	<548464fa8211307b397a5f50122abd3d@tribudubois.net>
	<ea0e6a65-fd7b-e62b-8aa0-2531bbcbf49f@adacore.com>
	<04ce75e9cdb6e001830c720196208e7f@tribudubois.net>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <44e1abb6-88e7-95a0-ff27-fed969eb3a9c@adacore.com>
Date: Mon, 15 Jan 2018 12:09:19 +0100
MIME-Version: 1.0
In-Reply-To: <04ce75e9cdb6e001830c720196208e7f@tribudubois.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] LEON3 IRQMP: Fix IRQ software ack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: Qemu-devel <qemu-devel-bounces+jcd=tribudubois.net@nongnu.org>, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, KONRAD Frederic <frederic.konrad@adacore.com>

On 12/01/2018 15:10, Jean-Christophe Dubois wrote:
> Le 2018-01-12 11:55, Fabien Chouteau a =C3=A9crit :
>> On 11/01/2018 13:35, Jean-Christophe Dubois wrote:
>>> Thanks Fabien,
>>>
>>> Now, as a side question, could you tell me which reference LEON3 plat=
form is implemented by Qemu in leon3_generic?
>>>
>>
>> I think it was the based on the FPGA version of Leon3 I was using at t=
he
>> time. The name leon3_generic comes from my will to make it a
>> configurable board where users could define the number and the locatio=
n
>> of the different peripherals, I never had time to work on this.
>=20
> I see. I am not sure how to bring configurability to Qemu. There is the=
 possibility to describe the hw PTF with DTC/DTB or something similar. I =
think some people were working on it for the ARM Qemu platform (but I am =
not sure what happened to this initiative).
>=20
> Now in the meantime, would it make sense to move leon3_generic to a tsi=
m compatible platform?
>=20

I don't think so, leon3_generic is compatible with a real hardware which
is also interesting for comparison.

> This would allow to validate the same software on the 2 simulators (obv=
iously it would not be compatible with your specific FPGA version for now=
).
>

The Leon3 AMBA bus provides a way to discover the peripherals and their
address, so any system should be capable of supporting different
peripheral layouts.

Here's an example of AMBA discovery code from a very old project of mine
(don't judge me on this :) :
https://github.com/Fabien-Chouteau/kabitbol/blob/master/src/amba.c

There was a couple of patches submitted some times ago to add Leon3 AMBA
support in QEMU, I think it's time to bring them back...
