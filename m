Received: from eggs.gnu.org ([2001:4830:134:3::10]:35346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dYVVs-0005p7-Uy
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dYVVp-0005IR-TK
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:50:29 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:63204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1dYVVp-00058z-IT
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 06:50:25 -0400
Date: Fri, 21 Jul 2017 12:50:10 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20170721114623.57b3be1d@nial.brq.redhat.com>
Message-ID: <alpine.BSF.2.21.1707211235480.66319@zero.eik.bme.hu>
References: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
	<CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<20170721092026.GD17693@redhat.com>
	<20170721114623.57b3be1d@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] Commit 77af8a2b95b79699de650965d5228772743efe84
 breaks Windows 2000 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Phil Dennis-Jordan <lists@philjordan.eu>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, 21 Jul 2017, Igor Mammedov wrote:
> On Fri, 21 Jul 2017 10:20:26 +0100
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
>> On Thu, Jul 20, 2017 at 09:29:33PM +0200, Phil Dennis-Jordan wrote:
>>> On Thu, Jul 20, 2017 at 6:40 PM, Programmingkid
>>> <programmingkidx@gmail.com> wrote:
>>>> I noticed that Windows 2000 does not boot up in QEMU recently. After bisecting the issue I found the offending commit:
>>>
>>> Ouch. I reckon we have 2 options for fixing this:
>>>
>>> 1. Export two FADTs, one ACPI 1.0, one ACPI 2.0. The latter would need
>>> to be pointed to by an XSDT, which Qemu currently doesn't implement at
>>> all as far as I'm aware. Any ideas on how SeaBIOS or OVMF would handle
>>> this? Any likely other OS regressions?
>>>
>>> 2. Select FADT version with an option. This one is definitely safe,
>>> but adds yet another option.
>>>
>>> Thoughts?
>>
>> The original comit below claims the change does not impact guest ABI
>> compatibility, so do we understand why Windows broke ?
> Author made a reasonable effort to test with variety of guest OSes upto
> vanilla WinXP, we can't blame ourselves for not testing OS that's is not
> available.
>
> Well we don't know why w2k breaks, only that it bisects to this commit.

I don't know if this helps but I've found that this same commit also broke 
booting OS X on q35 with OVMF and Clover (some old versions I had and 
worked before this commit). See here:
http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg04306.html

Maybe it's simpler to debug as these are open source but it's still not 
very clear why they fail because it starts to boot OS X but hangs during 
kernel init (and maybe Win2K fails to boot because of something else). I 
think I've seen this with OVMF 58f025afd and Clover 3354 (or around that, 
not completely sure about these versions).

Regards,
BALATON Zoltan
