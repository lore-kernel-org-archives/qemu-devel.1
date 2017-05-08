Received: from eggs.gnu.org ([2001:4830:134:3::10]:34910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d7qqu-0005sf-6P
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d7qqt-0003pe-5s
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:10:00 -0400
In-Reply-To: <20170508215412.othbbicpjvz5p4fz@aurel32.net>
References: <0F376E9C-2D4B-4D79-B3D4-24F73FD61446@gmail.com>
	<20170508215412.othbbicpjvz5p4fz@aurel32.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <619279EC-F49E-44D2-AAC7-74DB7DEFE0E3@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 8 May 2017 18:09:49 -0400
Subject: Re: [Qemu-devel] Floating point unit bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


On May 8, 2017, at 5:54 PM, Aurelien Jarno wrote:

> On 2017-05-07 17:48, G 3 wrote:
>> I made a diagnostic program for the floating point unit. It will test
>> various PowerPC floating point instructions for compatibility with  
>> the
>> PowerPC G3 processor. It was tested on a PowerPC G3 and G5 system.  
>> The
>> results of the program in qemu-system-ppc were pretty bad. About  
>> every
>> instruction tested is not implemented correctly.
>
> I don't say that qemu-system-ppc is bug free, but this looks  
> suspicious
> that about every instruction is buggy.

I really hope you don't think I'm blaming anyone. I'm only reporting  
the results of the test.

> Have you tried to run your
> program on a real G3 or G5 system?

Yes. I made sure it ran on a real G3 and G5 system without problem  
before testing it on QEMU. I suspect the Motorola designed G4  
processor will not be compatible. I don't have a working G4 system to  
verify this unfortunately.

>
> [ snip ]
>
>>
>> Here is the full test results after running this program in qemu- 
>> system-ppc
>> with a Mac OS 10.4 guest:
>>
>>
>>
>>
>> fadd test failed
>> expected answer: 0x3ff3333333333334
>>   actual answer: 0x8200400000000024
>> expected fpscr: 0x82064000
>>   actual fpscr: 0x82004000
>
> This looks highly suspicious that the actual answer match the expected
> answer.

You can use this web page to find the decimal value: http:// 
www6.uniovi.es/~antonio/uned/ieee754/IEEE-754hex64.html

0x3ff3333333333334 = 1.2000000000000002
0x8200400000000024 = -4.8529708162167760e-299

The expected answer and actual answer are very far from each other.
