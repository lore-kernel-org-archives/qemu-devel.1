Received: from eggs.gnu.org ([2001:4830:134:3::10]:35649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gZGMr-0000aS-RK
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gZGMl-0000mB-P5
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:29:05 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:37609)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gZGMl-0000j4-Cu
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:28:59 -0500
Date: Tue, 18 Dec 2018 14:11:35 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20181218111603.GE22638@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1812181242560.99784@zero.eik.bme.hu>
References: <alpine.BSF.2.21.1803202324320.13789@zero.eik.bme.hu>
	<20180321140654.7h3nkkdlztu6mtrq@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1803211803590.78606@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1812171549220.8888@zero.eik.bme.hu>
	<f3d7a0ed-785d-4176-147d-26a4d58d1a36@ilande.co.uk>
	<20181218111603.GE22638@redhat.com>
MIME-Version: 1.0
Content-ID: <alpine.BSF.2.21.9999.1812181356350.21201@zero.eik.bme.hu>
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Tue, 18 Dec 2018, Daniel P. Berrang=E9 wrote:
> On Tue, Dec 18, 2018 at 10:54:06AM +0000, Mark Cave-Ayland wrote:
>> On 17/12/2018 14:56, BALATON Zoltan wrote:
>>
>>> I still have this problem after updating everything on my machine, la=
test QEMU and
>>> SDL 2.0.9 so it's not likely to be a bug in some external component. =
If I just start
>>> qemu-system-ppc (compiled with --disable-gtk) and try to open monitor=
 console with
>>> Ctrl-Alt-2 I see QEMU monitor but when I type in this window the seri=
al output window
>>> contents flash in this window. At the same time the window that opens=
 for Ctrl-Alt-3
>>> which should have the serial output is empty. It looks like an index =
may be off
>>> somewhere or window contents are not associated with the right window=
 but I have no
>>> idea where to look for it. Can you reproduce it now and do you have a=
ny idea what
>>> could cause this?
>>
>> Are you using Fedora Core 29 at all? I know Howard has been experienci=
ng redraw
>> issues since upgrading from FC 28 to FC 29. A couple of other things t=
o check:
>
> There is no "Fedora Core" since Fedora Core 6, just Fedora :-P
>
> But seriously, I teted on Fedora 29 and didn't see any problem, so ther=
e
> must be some more specific scenario that is hurting it.
>
>> 1) Does QEMU 3.0 work correctly? If so, a bisection would help.
>> 2) Are you using an Nvidia graphics card with the nouveau driver?
>
> This second point is a good idea to consider.

How is graphics card relevant for this? I do use NVidia but not nouveau=20
but vendor drivers (version 390.87) on Mageia 6 (which is a bit like=20
Fedora but may have differences). I have this problem for a while so I=20
don't think it's a recent regression. It only seems to affect=20
qemu-system-ppc, qemu-system-x86_64 does open serial console all right=20
but could be I was using different configure options for these.

With qemu-system-ppc when I press Ctrl-Alt-3 an empty window opens and th=
e=20
content that should be in this window appears in the monitor window that=20
opens for Ctrl-Alt-2 but behind the normal monitor output, only visible=20
when I type in that window. My configure options are:

./configure --disable-gtk --disable-tpm \
--audio-drv-list=3Dalsa \
--target-list=3Dppc-softmmu \
--disable-libssh2 --disable-libusb --disable-guest-agent \
--enable-debug

Parallel console for Ctrl-Alt-4 seems to work all right but that has no=20
content. I'm not sure if it's relevant to have output in the serial=20
window. For qemu-system-ppc OpenBIOS has some serial output. Now that I'v=
e=20
tried it does seem to be relevant: if I press Ctrl-Alt-3 right after QEMU=
=20
starts when the main screen still says "guest has not initialised" then i=
t=20
works but if I wait until OpenBIOS starts with yellow screen (and some=20
output on serial) and then press Ctrl-Alt-3 then empty window opens so=20
maybe it's related to have some content on serial when window first opens=
?

Regards,
BALATON Zoltan
