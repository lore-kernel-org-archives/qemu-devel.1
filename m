Received: from eggs.gnu.org ([2001:4830:134:3::10]:34576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cbrLU-0006Gt-Gj
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:13:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cbrLP-00088D-Ie
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:13:20 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:47527)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1cbrLP-000887-Ba
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:13:15 -0500
References: <1486595166-34097-1-git-send-email-juro.bystricky@intel.com>
	<1486595166-34097-2-git-send-email-juro.bystricky@intel.com>
	<4c51c959-fe9c-b27f-552a-84d8a2fe68c1@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FB1B4@ORSMSX112.amr.corp.intel.com>
	<ad0b171b-ae9d-11f9-15e8-c500cd4ef5c2@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FB84B@ORSMSX112.amr.corp.intel.com>
	<8a5c3932-5ca6-6127-35b4-b8b8f57d923f@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FBCB0@ORSMSX112.amr.corp.intel.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <55a9d36b-c848-fd5f-623d-0456bfcaae40@denx.de>
Date: Thu, 9 Feb 2017 17:13:10 +0100
MIME-Version: 1.0
In-Reply-To: <6E51916E4A1F32428260031F4C7CD2B6118FBCB0@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] nios2: Add Altera JTAG UART
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Bystricky, Juro" <juro.bystricky@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "crwulff@gmail.com" <crwulff@gmail.com>, "jurobystricky@hotmail.com" <jurobystricky@hotmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>

On 02/09/2017 05:07 PM, Bystricky, Juro wrote:
>>>> [...]
>>>>
>>>>>>> +static uint64_t altera_juart_read(void *opaque, hwaddr addr,
>> unsigned
>>>>>> int size)
>>>>>>> +{
>>>>>>> +    AlteraJUARTState *s = opaque;
>>>>>>> +    uint32_t r;
>>>>>>> +
>>>>>>> +    addr >>= 2;
>>>>>>
>>>>>> Hmmmmm, how will unaligned read from one of these registers be handled
>>>>>> on real HW ? ie. read from address 0x3 ? What about writes ?
>>>>>>
>>>>>
>>>>> there is no reading/writing going on via "addr".
>>>>> This just maps the hw address into register number, where registers are
>>>> at
>>>>> 4 bytes boundaries (so they are aligned as needed) but indexed as
>>>> 1,2,3....
>>>>> (Pretty common code in other drivers.)
>>>>> But will redo the code anyway so there are no shifts.
>>>>
>>>> This doesn't answer my question at all. How does real hardware behave if
>>>> you read from unaligned address in the register space , ie. offset 0x3 ?
>>>>
>>>
>>> Not sure I understand the question here. Which "real hardware" are we
>> talking about?
>>
>> By real hardware I mean real Nios2 system ...
>>
>>> If "real hardware" contains MMU or MPU then an exception is generated on
>> misalign access.
>>
>> Is this handled here or not ?
>>
> 
> Sorry, I am not sure I understand the question.
> Exceptions are handled by interrupt controller.
> This code for JTAG UART does not have any misaligned accesses.
> 
> 
The code running on nios2 can issue unaligned access to the jtag uart
registers, yes ? If that happens, what happens on real HW and how is
this emulated ?

-- 
Best regards,
Marek Vasut
