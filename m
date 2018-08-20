Received: from eggs.gnu.org ([2001:4830:134:3::10]:53909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frh2m-0005sa-Bk
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frgrZ-0008UG-2q
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:52:41 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:41675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frgrY-0008Te-UG
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:52:41 -0400
Received: by mail-oi0-x244.google.com with SMTP id k12-v6so24725193oiw.8
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 02:52:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <516af088-d7e1-969d-420e-610a032a0da0@ilande.co.uk>
References: <20180802180602.22047-1-peter.maydell@linaro.org>
	<516af088-d7e1-969d-420e-610a032a0da0@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 10:52:19 +0100
Message-ID: <CAFEAcA9WF0NbdD8M23FUD0DBGxZi3Wstc_JEoZhCFDdA8vx+GA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/timer/m48t59: Move away from old_mmio
 accessors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 3 August 2018 at 08:22, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 02/08/18 19:06, Peter Maydell wrote:
>
>> Move the m48t59 device away from using old_mmio MemoryRegionOps
>> accessors.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---

>
> Looks good to me after some quick boot tests on SPARC, SPARC64 and 40p, so:
>
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Thanks. I'll put this in via target-arm unless somebody has a
better route for it.

-- PMM
