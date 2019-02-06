Received: from eggs.gnu.org ([209.51.188.92]:51326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grHm8-0004pS-Hx
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 02:37:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grHm7-0005Mu-Uy
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 02:37:40 -0500
Received: from chuckie.co.uk ([82.165.15.123]:40202
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1grHm7-0005MV-OC
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 02:37:39 -0500
References: <20190103154810.GB32032@Red>
	<3a375dc6-f0ba-c3f0-6e86-2fd5cdf3ee35@ilande.co.uk>
	<8c302745-5097-afed-5c7e-9a992da03cf6@ilande.co.uk>
	<20190205091115.GA27918@Red>
	<2a85b239-7117-71aa-b921-86c42a54aeba@ilande.co.uk>
	<20190206072850.GA4295@Red>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <8da59b77-eef2-4897-5254-0f6fb22539a6@ilande.co.uk>
Date: Wed, 6 Feb 2019 07:37:29 +0000
MIME-Version: 1.0
In-Reply-To: <20190206072850.GA4295@Red>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] sparc: crash when using initrd > 5M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: sparclinux@vger.kernel.org, qemu-devel@nongnu.org

On 06/02/2019 07:28, Corentin Labbe wrote:

>>> Hello
>>>
>>> Sorry even with the patch I still hit the issue.
>>>
>>> I have added some debug and at least qemu set initrd_size correctly now.
>>>
>>> I have tried to compile openbios-sparc32 for debugging but fail with
>>> arch/sparc32/context.c:116:5: error: PIC register clobbered by 'l7' in 'asm'
>>>      asm __volatile__ ("\n\tcall __switch_context"
>>>      ^~~
>>> make[1]: *** [rules.mak:219: target/arch/sparc32/context.o] Error 1
>>> (gcc 7.2 and gc 6.4 with binutils 2.30)
>>
>> Hmmm. One other thing I've noticed is that newer kernels tend need a minimum of 256M
>> RAM to start up - does it work if you add -m 256 to your command line?
>>
>>
> 
> I have already set 256M of RAM. (and tried 512)

I wonder then if this is being triggered by a recent kernel change? I tend to test
using the latest Debian ports ISOs which are currently running 4.9 and that booted
fine when I was testing the patches above.

Can you try with a few older kernels to see if this is the case?


ATB,

Mark.
