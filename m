Received: from eggs.gnu.org ([2001:4830:134:3::10]:55772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cc56T-0008Lh-Dc
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 01:54:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cc56Q-0001PF-Bg
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 01:54:45 -0500
Received: from greensocs.com ([193.104.36.180]:48498)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cc56P-0001P7-WF
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 01:54:42 -0500
References: <1486666321-21536-1-git-send-email-juro.bystricky@intel.com>
	<028b23eb-64a0-9e29-0940-629f0d33a364@denx.de>
	<6E51916E4A1F32428260031F4C7CD2B6118FBFA6@ORSMSX112.amr.corp.intel.com>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <3270cd0f-3e99-2086-c4df-705aad4808fb@greensocs.com>
Date: Fri, 10 Feb 2017 07:54:39 +0100
MIME-Version: 1.0
In-Reply-To: <6E51916E4A1F32428260031F4C7CD2B6118FBFA6@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] nios2: Add Altera JTAG UART emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Bystricky, Juro" <juro.bystricky@intel.com>
Cc: Marek Vasut <marex@denx.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jurobystricky@hotmail.com" <jurobystricky@hotmail.com>, "crwulff@gmail.com" <crwulff@gmail.com>

On 02/09/2017 09:53 PM, Bystricky, Juro wrote:
> 
> 
>> On 02/09/2017 07:52 PM, Juro Bystricky wrote:
>>> JTAG UART core eliminates the need for a separate RS-232 serial
>>> connection to a host PC for character I/O.
>>
>> And how does this describe the content of this patch ? This patch adds a
>> model of JTAG UART , it doesn't eliminate anything ...
>>
> 
> The commit message explicitly says:
> "Add Altera JTAG UART emulation."
> 
> But I will amend the message with more details.
> 
>>> Hardware emulation based on:
>>> https://www.altera.com/en_US/pdfs/literature/ug/ug_embedded_ip.pdf
>>> (Please see "Register Map" on page 65)
>>>
>>> Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
>>> ---
>>
>> Changelog is missing ...
> 
> I modelled this patch based on other nios2 patches, none of them contained 
> Changelog. So please elaborate.

Things after "---" disappear when commited in the git.

Thanks,
Fred

> 
> 
>>> +    /*
>>> +     * FIFO size can be set from 8 to 32,768 bytes.
>>> +     * Only powers of two are allowed.
>>> +     */
>>> +    fifo_size_ok = false;
>>> +    for (size = 8; size <= 32768; size *= 2) {
>>> +        if (size == fifo_size) {
>>> +            fifo_size_ok = true;
>>> +            break;
>>> +        }
>>> +    }
>>
>> Isn't that like
>>
>> if (size < 8 || size > 32768 || (size & ~(1 << ffs(size))))
>>   error()
>>
> 
> possibly, however ffs is rejected by checkpatch as non-portable
> libc call. 
> 
> 
>>> +#define DEFAULT_FIFO_SIZE 64
>>
>> This is still not QOM property , why ?
>>
> 
> Not sure what you mean, the code has:
> 
> DEFINE_PROP_UINT32("fifo-size", AlteraJUARTState, rx_fifo_size, DEFAULT_FIFO_SIZE),
> 
> 
> Thanks
> 
> Juro
> 
> 
