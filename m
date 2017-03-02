Received: from eggs.gnu.org ([2001:4830:134:3::10]:49225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjXlF-0003Hl-L2
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjXlC-0000UJ-KF
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 15:55:41 -0500
Date: Thu, 2 Mar 2017 21:55:36 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA9PDjSN7pKVde9raHZH3ExWdSNWN82ST4AJLPahWNcKNQ@mail.gmail.com>
Message-ID: <alpine.BSF.2.20.1703022152170.83701@zero.eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<869a8c5b526be9eb1316c9e7c7442bdd1c88c4b2.1488068248.git.balaton@eik.bme.hu>
	<CAFEAcA9zswu1H-66avnAxWdq8QvCWpi1NTbcaGqDE=c=OOHcAw@mail.gmail.com>
	<alpine.BSF.2.20.1703022115320.83701@zero.eik.bme.hu>
	<CAFEAcA9PDjSN7pKVde9raHZH3ExWdSNWN82ST4AJLPahWNcKNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 13/14] sm501: Add reset function and
 vmstate descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On Thu, 2 Mar 2017, Peter Maydell wrote:
> On 2 March 2017 at 20:18, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Thu, 2 Mar 2017, Peter Maydell wrote:
>>>
>>> Don't use qemu_register_reset(). Set the appropriate dc->reset
>>> function pointers instead.
>>
>>
>> Any reason for that? This way I could save two more boilerplate functions
>> because I could define reset function once, otherwise I'd need two versions
>> taking sysbus and pci states just to extract the SM501State function and
>> call this function. Do you still think I should do that instead?
>
> qemu_register_reset is a pre-QOM method for doing reset;
> the standard QOM way of saying "my device has some reset
> behaviour" is to set its reset method pointer.
> Code calling qemu_register_reset() is generally either (a) doing
> something kind of weird or (b) old device code that hasn't yet
> been converted to QOM.

Hmm, does having a device with both sysbus and pci versions qualify as 
weird? Does adding a comment saying that this way we don't need two more 
reset functions just to call the registered one justifies using 
qemu_register_reset() or this function is deprecated and should not be 
used and should go with the separate reset functions instead?

>> So should it be 4 patches: reset for pci, reset for sysbus, vmstate for pci,
>> vmstate for sysbus or 2 patches: reset for both, vmstate for both?
>
> I think I'd go with 2 patches, since the two are going to
> share the bulk of the implementation in each case.

OK, thanks for the explanation in previous reply as well, I'll do this 
then.
