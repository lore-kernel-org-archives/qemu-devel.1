Received: from eggs.gnu.org ([2001:4830:134:3::10]:53223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davidsondfgl@gmail.com>) id 1fRBCX-0007tw-C6
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davidsondfgl@gmail.com>) id 1fRBCW-0004Hz-Ok
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:48:45 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <davidsondfgl@gmail.com>)
	id 1fRBCW-0004Hn-J9
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:48:44 -0400
Received: by mail-qt0-x243.google.com with SMTP id s9-v6so12474746qtg.2
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 23:48:44 -0700 (PDT)
References: <CALAE4RoMmLDrSkvBUPhp-pCddbb-j1unXee3vPcUzbT1_q_G-A@mail.gmail.com>
	<5185f351-8f1d-bc81-9806-a5e412cfebb0@twiddle.net>
From: Davidson Francis <davidsondfgl@gmail.com>
Message-ID: <7c9a8e94-2f45-aeba-a12b-0c83c70c6f99@gmail.com>
Date: Fri, 8 Jun 2018 03:48:40 -0300
MIME-Version: 1.0
In-Reply-To: <5185f351-8f1d-bc81-9806-a5e412cfebb0@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Richard Henderson <rth@twiddle.net>, QEMU Development <qemu-devel@nongnu.org>, Openrisc <openrisc@lists.librecores.org>

On 07-06-2018 12:56, Richard Henderson wrote:
> On 06/07/2018 06:27 AM, Davidson Francis wrote:
>> Dear all,
>>
>> Currently Qemu supports only 2 cores when SMP enabled for or1k architecure, so
>> I would like to know if there is a quick way to increase the number of cores by
>> changing a few lines of code or to accomplish this, will requires significant
>> changes in the source code?
> 
> Probably not significant changes.
> The limit of 2 seems to be the way the interrupts are wired up.
> That can probably be extended relatively easily.
> 
> 
> r~
> 

Thank you Richard, I will investigate how the interrupts are wired.

Kind regards,
Davidson Francis.
