Received: from eggs.gnu.org ([2001:4830:134:3::10]:57659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gZgJx-0003ek-Ot
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:11:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gZgJs-0001li-QF
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:11:49 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:19957)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gZgJq-0001ep-KF
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:11:44 -0500
Date: Wed, 19 Dec 2018 19:11:34 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20181219095342.GA20465@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1812191904120.37705@zero.eik.bme.hu>
References: <alpine.BSF.2.21.1803202324320.13789@zero.eik.bme.hu>
	<20180321140654.7h3nkkdlztu6mtrq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1803211803590.78606@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1812171549220.8888@zero.eik.bme.hu>
	<f3d7a0ed-785d-4176-147d-26a4d58d1a36@ilande.co.uk>
	<20181218111603.GE22638@redhat.com>
	<alpine.BSF.2.21.9999.1812181242560.99784@zero.eik.bme.hu>
	<20181218132722.GF22638@redhat.com>
	<alpine.BSF.2.21.9999.1812182000520.1576@zero.eik.bme.hu>
	<20181219095342.GA20465@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Gerd Hoffmann <kraxel@redhat.com>, Howard Spoelstra <hsp.cat7@gmail.com>, qemu-devel@nongnu.org

On Wed, 19 Dec 2018, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Dec 18, 2018 at 08:05:59PM +0100, BALATON Zoltan wrote:
>> On Tue, 18 Dec 2018, Daniel P. Berrang=C3=A9 wrote:
>>> I don't see any difference depending on whether I use Ctrl-Alt-3 befo=
re
>>> or after the yellow screen - both work as expected. The fact that you
>>> see a difference though does suggest that there's something odd being
>>> done in the ppc emulation that is in turn doing something bad to SDLs
>>> rendering with your graphics setup. I don't know what it could be tho=
ugh.
>>
>> OK thanks for checking this, at least it seems this is something that =
not
>> reproduces elsewhere so it's probably something specific to my setup. =
I may
>> try to debug this further when I'll have time.
>
> I think there's a good chance that this is still a bug in QEMU, so
> definitely still worth trying to debug what in your setup triggers
> it.

Looks like Howard (cc'd) also has similar issue on Fedora 29 with NVidia=20
vendor driver although newer version than mine so the proprietary NVidia=20
driver seems to be a common point here. The difference is that for him th=
e=20
monitor window seems to hijack the guest screen not the serial screen lik=
e=20
for me but this could be the same bug. I can't easily test with nouveau=20
driver now so that's all we could find out so far. Also having some outpu=
t=20
on serial window seems to be relevant as this works before client starts=20
if I start with qemu-system-ppc -S but breaks after continue in monitor=20
window. qemu-system-x86_64 also does not show the problem but maybe=20
because there's no content in serial window there?

Regards,
BALATON Zoltan
