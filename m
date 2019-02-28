Received: from eggs.gnu.org ([209.51.188.92]:58062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzE1F-0003Ko-Ml
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gzE1E-0001f5-RO
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:14:05 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gzE1E-0001bv-8x
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:14:04 -0500
Received: by mail-pl1-x643.google.com with SMTP id k2so9143960plt.3
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 21:14:03 -0800 (PST)
References: <20190222055950.17403-1-richard.henderson@linaro.org>
	<a46631f2-fc78-2f06-09f0-25b2563af52d@ilande.co.uk>
	<20190224233142.GC7668@umbus.fritz.box>
	<bf117507-a3da-9dcd-e2c1-031312b7d89e@linaro.org>
	<20190228040157.GD27799@umbus.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dbae6af0-71a3-12b0-5a06-83a0bbb2c68a@linaro.org>
Date: Wed, 27 Feb 2019 21:11:48 -0800
MIME-Version: 1.0
In-Reply-To: <20190228040157.GD27799@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg/ppc: Add vector opcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org

On 2/27/19 8:01 PM, David Gibson wrote:
> On Wed, Feb 27, 2019 at 04:47:30PM -0800, Richard Henderson wrote:
>> On 2/24/19 3:31 PM, David Gibson wrote:
>>> I have access to POWER8 and POWER9 machines, but I haven't worked with
>>> RISU before.  If you can give me a straightforward recipe I can try
>>> running the tests.
>>
>> From
>>
>>   https://git.linaro.org/people/peter.maydell/risu.git
> 
> And I assume build it, at which point I hit this:
> 
> $ make
> gcc  -Wall -D_GNU_SOURCE -DARCH=ppc64 -I /home/dwg/risu/risu -g  -o risu_ppc64.o -c risu_ppc64.c
> risu_ppc64.c: In function ‘advance_pc’:
> risu_ppc64.c:19:25: error: dereferencing pointer to incomplete type ‘struct pt_regs’
>      uc->uc_mcontext.regs->nip += 4;
>                          ^~
> make: *** [Makefile:44: risu_ppc64.o] Error 1

Dunno.  Works for me.

$ uname -a
Linux gcc135.osuosl.org 4.14.0-115.2.2.el7a.ppc64le #1 SMP Wed Nov 28 21:39:33
GMT 2018 ppc64le ppc64le ppc64le GNU/Linux
$ head -2 /etc/os-release
NAME="CentOS Linux"
VERSION="7 (AltArch)"

I guess you'll need to debug this in your environment to find out what's different?


r~
