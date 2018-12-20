Received: from eggs.gnu.org ([2001:4830:134:3::10]:38047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gZwM4-000201-4f
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 06:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gZwLz-0006Z3-3d
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 06:19:04 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:44919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gZwLx-0006SJ-U4
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 06:18:58 -0500
Date: Thu, 20 Dec 2018 12:18:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20181220054238.imanfs5rsidtghja@sirius.home.kraxel.org>
Message-ID: <alpine.BSF.2.21.9999.1812201216160.64898@zero.eik.bme.hu>
References: <20180321140654.7h3nkkdlztu6mtrq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1803211803590.78606@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1812171549220.8888@zero.eik.bme.hu>
	<f3d7a0ed-785d-4176-147d-26a4d58d1a36@ilande.co.uk>
	<20181218111603.GE22638@redhat.com>
	<alpine.BSF.2.21.9999.1812181242560.99784@zero.eik.bme.hu>
	<20181218132722.GF22638@redhat.com>
	<alpine.BSF.2.21.9999.1812182000520.1576@zero.eik.bme.hu>
	<20181219095342.GA20465@redhat.com>
	<alpine.BSF.2.21.9999.1812191904120.37705@zero.eik.bme.hu>
	<20181220054238.imanfs5rsidtghja@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Monitor and serial output window broken with SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Howard Spoelstra <hsp.cat7@gmail.com>, qemu-devel@nongnu.org

On Thu, 20 Dec 2018, Gerd Hoffmann wrote:
> On Wed, Dec 19, 2018 at 07:11:34PM +0100, BALATON Zoltan wrote:
>> On Wed, 19 Dec 2018, Daniel P. Berrang=E9 wrote:
>>> On Tue, Dec 18, 2018 at 08:05:59PM +0100, BALATON Zoltan wrote:
>>>> On Tue, 18 Dec 2018, Daniel P. Berrang=E9 wrote:
>>>>> I don't see any difference depending on whether I use Ctrl-Alt-3 be=
fore
>>>>> or after the yellow screen - both work as expected. The fact that y=
ou
>>>>> see a difference though does suggest that there's something odd bei=
ng
>>>>> done in the ppc emulation that is in turn doing something bad to SD=
Ls
>>>>> rendering with your graphics setup. I don't know what it could be t=
hough.
>>>>
>>>> OK thanks for checking this, at least it seems this is something tha=
t not
>>>> reproduces elsewhere so it's probably something specific to my setup=
. I may
>>>> try to debug this further when I'll have time.
>>>
>>> I think there's a good chance that this is still a bug in QEMU, so
>>> definitely still worth trying to debug what in your setup triggers
>>> it.
>>
>> Looks like Howard (cc'd) also has similar issue on Fedora 29 with NVid=
ia
>> vendor driver although newer version than mine so the proprietary NVid=
ia
>> driver seems to be a common point here. The difference is that for him=
 the
>> monitor window seems to hijack the guest screen not the serial screen =
like
>> for me but this could be the same bug. I can't easily test with nouvea=
u
>> driver now so that's all we could find out so far. Also having some ou=
tput
>> on serial window seems to be relevant as this works before client star=
ts if
>> I start with qemu-system-ppc -S but breaks after continue in monitor w=
indow.
>> qemu-system-x86_64 also does not show the problem but maybe because th=
ere's
>> no content in serial window there?
>
> qemu-system-x86_64 -machine graphics=3Doff will make seabios print stuf=
f
> to the serial line.

And with that it also shows the same problem so looks like this happens=20
when something is output to serial and maybe with the NVidia vendor=20
drivers on SDL2. I can't debug this more at the moment.

Regards,
BALATON Zoltan
