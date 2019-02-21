Received: from eggs.gnu.org ([209.51.188.92]:59550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gwca3-0001Sr-P1
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:51:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gwca1-0004io-Q9
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:51:15 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:39715)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gwcZz-0004Xm-SO
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 19:51:12 -0500
Date: Thu, 21 Feb 2019 01:50:59 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.9999.1902202345230.9479@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.9999.1902210138340.95753@zero.eik.bme.hu>
References: <20190211040434.1C98674569F@zero.eik.bme.hu>
	<8962bd1d-267d-2edf-b5ce-9b67896a2b2e@redhat.com>
	<alpine.BSF.2.21.9999.1902122354210.68636@zero.eik.bme.hu>
	<CAFEAcA84=uU8XTy=4jXdM80XBnn3CS0gJxspakhZpdxWnvo_+A@mail.gmail.com>
	<alpine.BSF.2.21.9999.1902202345230.9479@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, 21 Feb 2019, BALATON Zoltan wrote:
> On Tue, 19 Feb 2019, Peter Maydell wrote:
>> On Tue, 12 Feb 2019 at 23:59, BALATON Zoltan <balaton@eik.bme.hu> wrot=
e:
>>> On Tue, 12 Feb 2019, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> I'd have use a pair of extract32/deposit32 but this is probably easi=
er

By the way, should these lines in include/qemu/bitops.h have 1ULL instead=
 of 1UL?

22 #define BIT(nr)                 (1UL << (nr))
23 #define BIT_MASK(nr)            (1UL << ((nr) % BITS_PER_LONG))

Regards,
BALATON Zoltan
