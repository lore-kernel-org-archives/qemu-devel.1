Received: from eggs.gnu.org ([209.51.188.92]:54717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hMTWS-0000NG-HP
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hMTWR-00062f-Mv
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:26:24 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:34636
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hMTWP-00061V-R0
	for qemu-devel@nongnu.org; Fri, 03 May 2019 04:26:23 -0400
References: <1556194715-24427-1-git-send-email-frederic.konrad@adacore.com>
	<1556194715-24427-2-git-send-email-frederic.konrad@adacore.com>
	<c1ba4bd6-0790-9d41-eb6b-4a21fa17ec10@ilande.co.uk>
	<05b496be-408a-50b5-7b38-c402b172c962@ilande.co.uk>
	<8ebd3335-188d-a5ff-e15e-cdf22b955660@adacore.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <e9a62641-0a35-5adb-f305-178ff93db3f9@ilande.co.uk>
Date: Fri, 3 May 2019 09:24:07 +0100
MIME-Version: 1.0
In-Reply-To: <8ebd3335-188d-a5ff-e15e-cdf22b955660@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] leon3: add a little bootloader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@redhat.com, atar4qemu@gmail.com, chouteau@adacore.com

On 03/05/2019 09:18, KONRAD Frederic wrote:

> Hi Mark,
> 
>>>>       }
>>>
>>> I think this patch is basically okay, however if you don't supply both a kernel and
>>> bios then you get the slightly enigmatic message below:
>>>
>>> $ ./qemu-system-sparc -M leon3_generic
>>> qemu-system-sparc: Can't read bios image (null)
>>>
>>> Perhaps add a define for LEON3_BIOS_FILENAME and return that if filename == NULL to
>>> give a better error message?
>>
>> Okay I see there is already a PROM_FILENAME that exists and can be used here.
> 
> I think we already have this behavior without this patch. Should this be fixed
> in an other patch?

Hi Frederic,

Yes, that probably makes sense here since it will make rebases slightly easier, plus
gives people the option to backport if required.


ATB,

Mark.
