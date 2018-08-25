Received: from eggs.gnu.org ([2001:4830:134:3::10]:55881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ftTIo-00067A-SR
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 03:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ftTIj-000141-Tr
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 03:48:10 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ftTIj-00012T-KI
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 03:48:05 -0400
Received: by mail-wm0-f51.google.com with SMTP id n11-v6so3601475wmc.2
	for <qemu-devel@nongnu.org>; Sat, 25 Aug 2018 00:48:04 -0700 (PDT)
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
	<1534870966-9287-4-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-nN4AD1m1w8Uv=wfvAYbVVrdPAxFKN75maVJe9wi=yDw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dff0cdcb-9c13-1d50-6a87-86a62d043284@redhat.com>
Date: Sat, 25 Aug 2018 09:48:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-nN4AD1m1w8Uv=wfvAYbVVrdPAxFKN75maVJe9wi=yDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 03/74] es1370: simplify MemoryRegionOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24/08/2018 17:04, Peter Maydell wrote:
> because these values aren't contiguous:
> 
> #define ES1370_REG_DAC1_FRAMEADR    0xc30
> #define ES1370_REG_DAC2_FRAMEADR    0xc38
> #define ES1370_REG_ADC_FRAMEADR     0xd30
> 
> so you can't calculate the value of 'd' from the addr
> this way.
> 
> (Similarly for the SCOUNT registers.)

SCOUNT is actually consecutive.  I've sent a patch for the other two.

Paolo
