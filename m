Received: from eggs.gnu.org ([2001:4830:134:3::10]:53320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTZZv-0007VR-Sl
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTZZs-0004tF-Oy
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:14:47 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:44989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTZZs-0004so-IE
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:14:44 -0400
Received: by mail-pf0-x22a.google.com with SMTP id h12-v6so3823982pfk.11
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 14:14:44 -0700 (PDT)
References: <20180614180119.1704-1-f4bug@amsat.org>
	<20180614180119.1704-2-f4bug@amsat.org>
	<bafda81a-a33b-6137-b30a-1cf98ab8393b@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eeeb48f8-b89e-5675-047b-fa838ae8dac5@linaro.org>
Date: Thu, 14 Jun 2018 11:14:38 -1000
MIME-Version: 1.0
In-Reply-To: <bafda81a-a33b-6137-b30a-1cf98ab8393b@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Emilio G . Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org

On 06/14/2018 08:19 AM, Paolo Bonzini wrote:
> But why isn't the parallel port at 0x378?  That's the expected place on
> PC (the second parallel port is at 0x278 and the third is at 0x3bc), and
> I would expect other SuperIO chips to have it there too.  That would be
> a one line fix.

Agreed.


r~
