Received: from eggs.gnu.org ([209.51.188.92]:57213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1goqwa-0004h2-RE
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1goqwZ-0007zK-TJ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 09:34:24 -0500
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<87o97yi67d.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <300bdcd7-fbde-d7a3-12a0-eafdc0aa58f6@redhat.com>
Date: Wed, 30 Jan 2019 15:33:58 +0100
MIME-Version: 1.0
In-Reply-To: <87o97yi67d.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Configuring pflash devices for OVMF firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, =?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 30/01/19 15:13, Markus Armbruster wrote:
>     -global driver=3Dcfi.pflash01,property=3Dsecure,value=3Don
>=20
> Affects *all* such devices, but fortunately we have at most two, and th=
e
> one we don't want to affect happens to ignore the property value.

Is this true?  I think both need secure=3Don, at least on x86.

> For libvirt, plumbing the base address from the firmware's descriptor t=
o
> QEMU would be the lesser mess (for the firmware, providing the base
> address there would be no mess at all).
>=20
> For human users, it's perhaps the greater mess.  They can continue to
> use -drive if=3Dpflash.
>=20
> Perhaps we *should* redo board configuration from the ground up.
> Perhaps a board should be a composite object that exposes properties of
> its own and its part, just like other composite devices, and so that
> "create, set properties, realize" works.  That would extend our common
> device configuration mechanism naturally to onboard devices.
>=20
> Of course, "we should" doesn't imply "I could".

Maybe we should just add pflash block properties to the machine?  And
then it can create the devices if the properties are set to a non-empty
value.

This doesn't remove the need to use -global to configure the "secure"
property, but it's not particularly an issue.

Paolo
