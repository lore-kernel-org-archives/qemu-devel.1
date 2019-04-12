Received: from eggs.gnu.org ([209.51.188.92]:56063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEuM7-0001rM-AS
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEuM6-0005v8-6A
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:28:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEuM5-0005uA-Tb
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:28:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so11445027wrn.11
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 04:28:24 -0700 (PDT)
References: <87d0mwatbu.fsf@dusky.pond.sub.org>
	<CAAdtpL6VCiXLbTWyJo4cbCNLjOCPr6KrH8KTqEq1V=CTMYKubQ@mail.gmail.com>
	<6fe1a987-c3c5-3af5-74a4-fc4cd08d2380@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2056cff2-78f8-1079-8d05-e758971d73ec@redhat.com>
Date: Fri, 12 Apr 2019 13:28:14 +0200
MIME-Version: 1.0
In-Reply-To: <6fe1a987-c3c5-3af5-74a4-fc4cd08d2380@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Maintainers,
 please tell us how to boot your machines!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>
Cc: Paul Burton <pburton@wavecomp.com>, Chris Wulff <crwulff@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Jia Liu <proljc@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Antony Pavlov <antonynpavlov@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Alistair Francis <alistair@alistair23.me>, Fabien Chouteau <chouteau@adacore.com>, Beniamino Galvani <b.galvani@gmail.com>, Paul Durrant <paul.durrant@citrix.com>, Peter Chubb <peter.chubb@nicta.com.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Stafford Horne <shorne@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Richard Henderson <rth@twiddle.net>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Cornelia Huck <cohuck@redhat.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Michael Walle <michael@walle.cc>, Thomas Huth <huth@tuxfamily.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 4/12/19 1:11 PM, Thomas Huth wrote:
> On 13/03/2019 02.06, Philippe Mathieu-Daudé wrote:
>> '
>> On Tue, Mar 12, 2019 at 6:44 PM Markus Armbruster <armbru@redhat.com> wrote:
> [...]
>>>     = hw/arm/nseries.c =
>>>     Andrzej Zaborowski <balrogg@gmail.com> (odd fixer:nSeries)
>>>     Peter Maydell <peter.maydell@linaro.org> (odd fixer:nSeries)
>>>     qemu-arm@nongnu.org (open list:nSeries)
>>
>> images:
>> http://stskeeps.subnetmask.net/meego-n8x0/
>>
>> $ qemu-system-arm -M n810 -kernel
>> meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0
>> -append "root=/dev/mmcblk0p1 console=ttyS0 printk.time=0 rootwait" -m
>> 130 -sd meego-arm-n8x0-1.0.80.20100712.1431-sda.raw -serial stdio
> 
> That does not work for me - I only get a white screen that turns to
> black after half a second, and no output (also not on the serial
> console). Does it still work for you with the latest QEMU master branch?

It is broken since a long time. I guess rememember some irc chat about
it previous to v2.9.0, then I added this line to my TODO "this command
used to work, see what's wrong here". I never bisected to figure out
since when it got bitroted.
