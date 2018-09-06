Received: from eggs.gnu.org ([2001:4830:134:3::10]:46489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eager@eagerm.com>) id 1fxvsf-0004nS-Rh
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eager@eagerm.com>) id 1fxvsb-0000VT-Ow
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:07:37 -0400
Received: from resqmta-po-03v.sys.comcast.net
	([2001:558:fe16:19:96:114:154:162]:39092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eager@eagerm.com>) id 1fxvsb-0000Ix-IA
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 11:07:33 -0400
References: <f38111ad-3fbb-210e-e7ec-49ae675ea65e@eagerm.com>
	<a57fdd27-7a86-3f31-341c-e98101d17b9a@eagerm.com>
	<61c2239b-f8db-6648-ba1b-203309d876eb@eagerm.com>
From: Michael Eager <eager@eagerm.com>
Message-ID: <f741c912-c37b-34a6-89a3-96577d186adc@eagerm.com>
Date: Thu, 6 Sep 2018 08:07:25 -0700
MIME-Version: 1.0
In-Reply-To: <61c2239b-f8db-6648-ba1b-203309d876eb@eagerm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] RISC-V - Dynamic parameterization of
 RISC-V memory map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Any comments?

On 08/30/2018 09:22 AM, Michael Eager wrote:
> Corrected patch attached.
> 
> On 08/29/2018 05:48 PM, Michael Eager wrote:
>> Whoops.  I just noticed that this patch is against the riscv-qemu
>> repo on github, not the qemu.org repo.  I will rework it for the 
>> qemu.org repo.  Meanwhile, I welcome any comments.
>>
>> On 08/29/2018 05:21 PM, Michael Eager wrote:
>>> Memory parameters for RISC-V boards can be read from a configuration
>>> file using the -readconfig command line option.  The configuration file
>>> should have a section for the board and memory.  The configuration for
>>> the VirtIO board has the following configuration variables:
>>> [riscv-virt-mem]
>>>    debug-base   = "0x0"
>>>    debug-size   = "0x100"
>>>    mrom-base    = "0x1000"
>>>    mrom-size    = "0x11000"
>>>    test-base    = "0x100000"
>>>    test-size    = "0x1000"
>>>    clint-base   = "0x2000000"
>>>    clint-size   = "0x10000"
>>>    plic-base    = "0xc000000"
>>>    plic-size    = "0x4000000"
>>>    uart0-base   = "0x10000000"
>>>    uart0-size   = "0x100"
>>>    virtio-base  = "0x10001000"
>>>    virtio-size  = "0x1000"
>>>    dram-base    = "0x80000000"
>>>    dram-size    = "0x0"
>>>
>>> Values must be enclosed within quotes.
>>>
>>> Signed-off-by: Michael Eager <eager@eagercon.com>
>>>
>>
> 

-- 
Michael Eager    eager@eagerm.com
1960 Park Blvd., Palo Alto, CA 94306
