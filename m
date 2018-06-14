Received: from eggs.gnu.org ([2001:4830:134:3::10]:59700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fTZjg-0002Ty-Lv
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fTZjd-0006Gu-Gi
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:24:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fTZjd-0006FI-9w
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:24:49 -0400
References: <20180614180119.1704-1-f4bug@amsat.org>
	<20180614180119.1704-2-f4bug@amsat.org>
	<bafda81a-a33b-6137-b30a-1cf98ab8393b@redhat.com>
	<eeeb48f8-b89e-5675-047b-fa838ae8dac5@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <831880a1-e584-690b-ec6b-1371926f5581@redhat.com>
Date: Thu, 14 Jun 2018 23:24:40 +0200
MIME-Version: 1.0
In-Reply-To: <eeeb48f8-b89e-5675-047b-fa838ae8dac5@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] hw/isa/smc37c669-superio: Basic
 'Config Registers' implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Emilio G . Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org

On 14/06/2018 23:14, Richard Henderson wrote:
> On 06/14/2018 08:19 AM, Paolo Bonzini wrote:
>> But why isn't the parallel port at 0x378?  That's the expected place on
>> PC (the second parallel port is at 0x278 and the third is at 0x3bc), and
>> I would expect other SuperIO chips to have it there too.  That would be
>> a one line fix.
> 
> Agreed.

FWIW the datasheet says that the base parallel port address is
configurable using the config registers, and can be placed between 0x100
(inclusive) and 0x400 (exclusive), in 4-bytes increments if EPP is
disabled and in 8-byte increments if it is enabled.  Therefore, 0x378
sounds like something that PALcode would probably use.

Paolo
