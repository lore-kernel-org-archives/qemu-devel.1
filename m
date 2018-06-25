Received: from eggs.gnu.org ([2001:4830:134:3::10]:55336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXPQV-00025i-Bv
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXPQU-0005zl-FP
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:12:55 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXPQU-0005zb-8i
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:12:54 -0400
Received: by mail-oi0-x241.google.com with SMTP id b5-v6so2956431oiy.11
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 04:12:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d3c05355-4eda-f501-8f04-d808f416393a@web.de>
References: <20180619093124.24011-1-luc.michel@greensocs.com>
	<d3c05355-4eda-f501-8f04-d808f416393a@web.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 12:12:33 +0100
Message-ID: <CAFEAcA80O-6ycsVFEkfTSYCakQQZyGy9VV-+2rx6dE3-Ffd-Ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/7] arm_gic: add virtualization
 extensions support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Luc Michel <luc.michel@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>

On 25 June 2018 at 05:55, Jan Kiszka <jan.kiszka@web.de> wrote:
> On 2018-06-19 11:31, luc.michel@greensocs.com wrote:
>> From: Luc MICHEL <luc.michel@greensocs.com>
>>
>> This patch series add support for the virtualization extensions in the
>> ARM GICv2 interrupt controller.
>>
>> The first two commits do some refactoring to prepare for the
>> implementation. Commits 3 and 4 are the actual implementation. The last
>> commit updates the ZynqMP implementation to support virtualization.
>
> Is it enabled for the virt machine as well? Seems we are missing some
> mapping of GICV and GICH there.

I agree that it would be very nice to see this enabled for the
'virt' board; it's a bit tricky for me to test otherwise. It
should just be a matter of mapping in the GICV and GICH,
wiring up the maintenance interrupt, and advertising it
correctly in the DTB and ACPI data...

I'm hoping to get to reviewing this series this afternoon.

thanks
-- PMM
