Received: from eggs.gnu.org ([209.51.188.92]:35774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEv3O-00016Q-VZ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:13:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEv3N-0003BH-Pa
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:13:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hEv3M-0003Ax-Oz
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:13:09 -0400
References: <87d0mwatbu.fsf@dusky.pond.sub.org>
	<CAAdtpL6VCiXLbTWyJo4cbCNLjOCPr6KrH8KTqEq1V=CTMYKubQ@mail.gmail.com>
	<6fe1a987-c3c5-3af5-74a4-fc4cd08d2380@redhat.com>
	<2056cff2-78f8-1079-8d05-e758971d73ec@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <045d5528-116e-c71d-c29b-c070b7f660e3@redhat.com>
Date: Fri, 12 Apr 2019 14:12:34 +0200
MIME-Version: 1.0
In-Reply-To: <2056cff2-78f8-1079-8d05-e758971d73ec@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>
Cc: Paul Burton <pburton@wavecomp.com>, Chris Wulff <crwulff@gmail.com>, Jan Kiszka <jan.kiszka@web.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>, Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Jia Liu <proljc@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Antony Pavlov <antonynpavlov@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, David Gibson <david@gibson.dropbear.id.au>, Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Alistair Francis <alistair@alistair23.me>, Fabien Chouteau <chouteau@adacore.com>, Beniamino Galvani <b.galvani@gmail.com>, Paul Durrant <paul.durrant@citrix.com>, Peter Chubb <peter.chubb@nicta.com.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Stafford Horne <shorne@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Richard Henderson <rth@twiddle.net>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Cornelia Huck <cohuck@redhat.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Michael Walle <michael@walle.cc>, Thomas Huth <huth@tuxfamily.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 12/04/2019 13.28, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/12/19 1:11 PM, Thomas Huth wrote:
>> On 13/03/2019 02.06, Philippe Mathieu-Daud=C3=A9 wrote:
>>> '
>>> On Tue, Mar 12, 2019 at 6:44 PM Markus Armbruster <armbru@redhat.com>=
 wrote:
>> [...]
>>>>     =3D hw/arm/nseries.c =3D
>>>>     Andrzej Zaborowski <balrogg@gmail.com> (odd fixer:nSeries)
>>>>     Peter Maydell <peter.maydell@linaro.org> (odd fixer:nSeries)
>>>>     qemu-arm@nongnu.org (open list:nSeries)
>>>
>>> images:
>>> http://stskeeps.subnetmask.net/meego-n8x0/
>>>
>>> $ qemu-system-arm -M n810 -kernel
>>> meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0
>>> -append "root=3D/dev/mmcblk0p1 console=3DttyS0 printk.time=3D0 rootwa=
it" -m
>>> 130 -sd meego-arm-n8x0-1.0.80.20100712.1431-sda.raw -serial stdio
>>
>> That does not work for me - I only get a white screen that turns to
>> black after half a second, and no output (also not on the serial
>> console). Does it still work for you with the latest QEMU master branc=
h?
>=20
> It is broken since a long time. I guess rememember some irc chat about
> it previous to v2.9.0, then I added this line to my TODO "this command
> used to work, see what's wrong here". I never bisected to figure out
> since when it got bitroted.

Ok, thanks, good to know. I was just thinking about deprecating this
machine, since it uses the already deprecated bluetooth subsystem, and
we likely can not remove bluetooth without removing this machine, too.
So if it is already broken, that's another reason for really deprecating
this machine now.

 Thomas
