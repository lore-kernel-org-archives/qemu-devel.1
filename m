Received: from eggs.gnu.org ([2001:4830:134:3::10]:52205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1cTGkJ-0008JZ-2S
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Sandra_Loosemore@mentor.com>) id 1cTGkF-0000td-QM
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:31:27 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:59592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
	id 1cTGkF-0000t4-Gu
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 18:31:23 -0500
References: <20161231132226.9595-1-marex@denx.de>
	<20161231132226.9595-2-marex@denx.de>
	<37102228-c1e5-e8e5-c4a5-5c9ae186202b@suse.de>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <587D57C1.2090005@codesourcery.com>
Date: Mon, 16 Jan 2017 16:31:13 -0700
MIME-Version: 1.0
In-Reply-To: <37102228-c1e5-e8e5-c4a5-5c9ae186202b@suse.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V8 2/7] nios2: Add architecture emulation
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, Marek Vasut <marex@denx.de>, qemu-devel@nongnu.org
Cc: Jeff Da Silva <jdasilva@altera.com>, Chris Wulff <crwulff@gmail.com>, Yves Vandervennet <yvanderv@altera.com>, Ley Foon Tan <lftan@altera.com>

On 01/16/2017 03:21 PM, Alexander Graf wrote:

>> +static void nios2_cpu_disas_set_info(CPUState *cpu, disassemble_info
>> *info)
>> +{
>> +    /* NOTE: NiosII R2 is not supported yet. */
>> +    info->mach = bfd_arch_nios2;
>> +#ifdef TARGET_WORDS_BIGENDIAN
>> +    info->print_insn = print_insn_big_nios2;
>> +#else
>> +    info->print_insn = print_insn_little_nios2;
>> +#endif
>
> I take it there is no runtime switch for endianness? Most architectures
> eventually got one and moved to a single default endianness for softmmu
> with swizzling for the "other" one (LE for ARM, BE for ppc).

Maybe QEMU should just error out if configured for big-endianness on 
this target.  Per the published Nios II Processor Reference Handbook, 
"The Nios II architecture uses little-endian byte ordering."  When I was 
working on preparing the nios2 binutils patches for submission, Altera 
asked me to retain the big-endian hooks because they didn't want to rule 
out officially supporting that feature.  I had no way to test anything 
big-endian, of course.

-Sandra
