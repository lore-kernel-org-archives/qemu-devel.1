Received: from eggs.gnu.org ([2001:4830:134:3::10]:39385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTtOv-0006hH-T7
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 14:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTtOr-0000PS-OW
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 14:24:45 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:43589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTtOr-0000PI-IG
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 14:24:41 -0400
Received: by mail-pf0-x244.google.com with SMTP id y8-v6so5242597pfm.10
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 11:24:41 -0700 (PDT)
References: <20180615062547.4798-1-richard.henderson@linaro.org>
	<5351959f-75d4-014f-409e-d8a2a89bc433@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fc01b15d-538d-208a-7492-64f564bc2587@linaro.org>
Date: Fri, 15 Jun 2018 08:24:33 -1000
MIME-Version: 1.0
In-Reply-To: <5351959f-75d4-014f-409e-d8a2a89bc433@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Reduce max TB opcode count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Jason@zx2c4.com, sstabellini@kernel.org, pmatouse@redhat.com, mst@redhat.com, sw@weilnetz.de, crosthwaite.peter@gmail.com, mdroth@linux.vnet.ibm.com, pbonzini@redhat.com, pjp@redhat.com

On 06/15/2018 03:58 AM, Philippe Mathieu-Daudé wrote:
> On 06/15/2018 03:25 AM, Richard Henderson wrote:
>> Also, assert that we don't overflow any of two different offsets into
>> the TB. Both unwind and goto_tb both record a uint16_t for later use.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> This fixes an arm-softmmu test case forwarded to me by Michael Tsirkin.
>>
>> There is a TB generated from that test case that runs to 7800 opcodes,
>> and compiles to 96k on an x64 host.  This overflows the 16-bit offset
>> in which we record the goto_tb reset offset.  Because of that overflow,
>> we install a jump destination that goes to neverland.  Boom.
>>
>> With this reduced op count, the same TB compiles to about 48k for
>> both x64 and ppc64le hosts, and neither assertion fires.
> 
> Why not keep that comment in the git history, to follow the 8k -> 4k change?
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Will do, thanks.


r~
