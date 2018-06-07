Received: from eggs.gnu.org ([2001:4830:134:3::10]:40837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fQxHP-0007Xx-UB
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fQxHL-0006sm-18
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:56:52 -0400
Received: from mail-pl0-x22c.google.com ([2607:f8b0:400e:c01::22c]:45983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1fQxHK-0006rx-Qy
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 11:56:46 -0400
Received: by mail-pl0-x22c.google.com with SMTP id c23-v6so6399244plz.12
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 08:56:46 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CALAE4RoMmLDrSkvBUPhp-pCddbb-j1unXee3vPcUzbT1_q_G-A@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5185f351-8f1d-bc81-9806-a5e412cfebb0@twiddle.net>
Date: Thu, 7 Jun 2018 08:56:42 -0700
MIME-Version: 1.0
In-Reply-To: <CALAE4RoMmLDrSkvBUPhp-pCddbb-j1unXee3vPcUzbT1_q_G-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [OpenRISC] OpenRISC: SMP support for more than 2
 cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Davidson Francis <davidsondfgl@gmail.com>, QEMU Development <qemu-devel@nongnu.org>, Openrisc <openrisc@lists.librecores.org>

On 06/07/2018 06:27 AM, Davidson Francis wrote:
> Dear all,
> 
> Currently Qemu supports only 2 cores when SMP enabled for or1k architecure, so
> I would like to know if there is a quick way to increase the number of cores by
> changing a few lines of code or to accomplish this, will requires significant
> changes in the source code?

Probably not significant changes.
The limit of 2 seems to be the way the interrupts are wired up.
That can probably be extended relatively easily.


r~
