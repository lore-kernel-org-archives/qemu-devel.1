Received: from eggs.gnu.org ([208.118.235.92]:39817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gc3Ok-0000mg-Gu
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 02:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gc3Og-0003XP-EM
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 02:14:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gc3Og-0003Vp-5y
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 02:14:30 -0500
References: <b0d70556767952dc739454d074bdab52@grossmann-venter.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <665ec250-c4a5-18ba-ad71-90966a1b9e12@redhat.com>
Date: Wed, 26 Dec 2018 08:14:26 +0100
MIME-Version: 1.0
In-Reply-To: <b0d70556767952dc739454d074bdab52@grossmann-venter.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Qemu the right way.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liebrecht@grossmann-venter.com, qemu-devel@nongnu.org

On 2018-12-25 23:46, liebrecht@grossmann-venter.com wrote:
> I have been using Qemu in the past about 8 years ago or so to run legac=
y
> windows software.
>=20
> I installed the latest qemu and noticed a lot changed and cant find
> conclusive answers online.
>=20
> I am writing this post to find what is the right way to start to set up
> qemu with a windows 7 pro guest. I want to try and eliminate the
> iterations and find out what is really possible for the guest.
>=20
> Hardware used"
> 24 Core AMD rackserver.
> Host OS Debian 9 Stretch
> Guest Windows 7 Pro 32 bit
>=20
> Requirements:
> 1) I need to be able to run at least 4 processors in the guest. Is this
> possible with qemu as hosts ?

Try to run QEMU with "-smp 4".

> 2) I need to at least have sound working from applications in the guest
> with pulseaudio on the Debian host. Is it=C2=A0 possible ?

Should be possible. Run the configure script before compiling with

 --audio-drv-list=3Dpa

and then make sure to give a soundcard to the guest (e.g. with the
-soundhw option).

> 3) USB, what is the level of support 2.0 3.0 ?
> ( However windo$ 7 cannot really do USB3. so usb-3 is moot anyway)

QEMU supports both, e.g. with "-device usb-ehci" for a USB 2.0
controller or with "-device nec-usb-xhci" for a USB 3.0 controller.

> 4) What kind of devices can be run through usb ?

Do you mean emulated devices? You can get a list with:

 qemu-system-x86_64 -device help | grep usb

Or do you want to pass-through a real device from the host?

> The answers to 1-4 will be really helpful to decide if I should even be
> using it. The documentation is schetchy about all this.
> I tried Virtualbox, but it is just a nice looking empty promisebox
> yielding nothing. Since Qemu helped me a lot in the past I will have
> better chances here.
>=20
> 5) I am currently installing win7pro guest with command
> $] qemu-system-x86_64 -boot c -cdrom /dev/cdrom -m 2048M
>=20
> and left out all the network card and sound driver switches as I have n=
o
> clue what I should choose.
> Can they be configured afterwards ?

I don't have much clue about Windows, but I think you can change it
afterwards - it's like you're changing PCI cards of a real system in
that case.

 HTH,
  Thomas
