Received: from eggs.gnu.org ([2001:4830:134:3::10]:49981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dYbYK-00040L-CU
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dYbYH-0002DT-5A
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:17:24 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:22002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1dYbYG-0002C1-PX
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 13:17:21 -0400
Date: Fri, 21 Jul 2017 19:17:17 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAGCz3vu7qdNQKp7aHU35Hj7GxsT_WqGEJbb6XNyaAn=wmHYiZA@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1707211912380.68666@zero.eik.bme.hu>
References: <3E24AFDE-D25A-416B-A600-3C2221C3A9F1@gmail.com>
	<CAGCz3vu5x59+mKg8011=DRyZQKbuBV2F20ZpPnG1TOCxsOb+mQ@mail.gmail.com>
	<20170721092026.GD17693@redhat.com>
	<20170721114623.57b3be1d@nial.brq.redhat.com>
	<alpine.BSF.2.21.1707211235480.66319@zero.eik.bme.hu>
	<CAGCz3vu7qdNQKp7aHU35Hj7GxsT_WqGEJbb6XNyaAn=wmHYiZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
To: Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Igor Mammedov <imammedo@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>, ehabkost@redhat.com, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, 21 Jul 2017, Phil Dennis-Jordan wrote:
> On Fri, Jul 21, 2017 at 12:50 PM, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> I don't know if this helps but I've found that this same commit also broke
>> booting OS X on q35 with OVMF and Clover (some old versions I had and worked
>> before this commit). See here:
>> http://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg04306.html
>>
>> Maybe it's simpler to debug as these are open source but it's still not very
>> clear why they fail because it starts to boot OS X but hangs during kernel
>> init (and maybe Win2K fails to boot because of something else). I think I've
>> seen this with OVMF 58f025afd and Clover 3354 (or around that, not
>> completely sure about these versions).
>
> OVMF had 2 bugs that totally mucked up the ACPI tables if Qemu didn't
> supply its loader commands "just so", and modified ACPI 2.0-5.0 FADTs
> in such a way that they were no longer valid. These are fixed in
> 198a46d and 072060a, which are about a year newer than 58f025afd, so
> it's no surprise this combination doesn't work. I have no idea if
> Clover on top makes any difference.

I've tried with 072060a and with that version OS X boots with same Clover 
so my problem seems to have been too old OVMF version and Clover does not 
make a difference here. So this also likely has nothing do with the Win2k 
problem discussed in this thread so you can disregard my post.

Thank you,
BALATON Zoltan
