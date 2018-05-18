Received: from eggs.gnu.org ([2001:4830:134:3::10]:51858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1fJn24-0000J4-EM
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:35:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1fJn21-0003Z3-AR
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:35:24 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:57154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
	id 1fJn21-0003YD-2E
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:35:21 -0400
References: <cover.1526671191.git.julian@codesourcery.com>
	<845fc301f4a7725c239708c58876e3ae4d858fd9.1526671191.git.julian@codesourcery.com>
	<805fc7b5-03f0-56d4-abfd-ed010d4fa769@denx.de>
	<20180518211928.488214aa@octopus>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <08f92788-6380-35fe-e237-aa80f075519e@codesourcery.com>
Date: Fri, 18 May 2018 15:35:06 -0600
MIME-Version: 1.0
In-Reply-To: <20180518211928.488214aa@octopus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] Add Nios II semihosting support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>, Marek Vasut <marex@denx.de>
Cc: qemu-devel@nongnu.org, Chris Wulff <crwulff@gmail.com>, Andrew Jenner <Andrew_Jenner@mentor.com>

On 05/18/2018 02:19 PM, Julian Brown wrote:
> On Fri, 18 May 2018 21:52:04 +0200
> Marek Vasut <marex@denx.de> wrote:
> 
>> On 05/18/2018 09:23 PM, Julian Brown wrote:
>>> This patch (by Sandra Loosemore, mildly rebased) adds support for
>>> semihosting for Nios II bare-metal emulation.
>>>
>>> Signed-off-by: Julian Brown <julian@codesourcery.com>
>>> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
>>
>> Is there some documentation for this stuff ? It looks interesting, but
>> how can I try it here ?
> 
> There's no documentation AFAIK apart from that the entry points are
> the same as m68k, semihosting is invoked with "break 1", and r4/r5 are
> used for passing arguments. I'm not actually sure how you can try this
> stuff without our startup code or other infrastructure (that I'm pretty
> sure we can't divulge). Sandra, any ideas?

I don't see any reason why we couldn't contribute libgloss support, 
except that I don't have time to write such a BSP right now.  :-(  I 
recently did this for C-SKY, though, and the semihosting parts were just 
a straightforward copy from the m68k port.

FWIW, CodeSourcery's Nios II ELF toolchains have been using this 
semihosting protocol with a different BSP library all along, and Altera 
also supports it in the proprietary simulators they've provided to us 
for testing.

-Sandra
