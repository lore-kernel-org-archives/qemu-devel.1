Received: from eggs.gnu.org ([2001:4830:134:3::10]:33456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYS5r-0003Le-PU
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 02:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYS5o-0001XR-Ou
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 02:43:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eYS5o-0001Wp-Ip
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 02:43:36 -0500
References: <20180104141524.m5xy66jsn2hiajwl@var.youpi.perso.aquilenet.fr>
	<20180104142101.rivje5qn5dasb6jw@var.youpi.perso.aquilenet.fr>
	<aea97804-c6a9-d903-13d8-23bc6b46af86@redhat.com>
	<20180104152402.fv52umjmlb2g22wc@var.youpi.perso.aquilenet.fr>
	<b1a86fed-8a98-cc1d-46ca-5462f8be3fc7@redhat.com>
	<20180104153219.wsxtkzuznu2iwra7@var.youpi.perso.aquilenet.fr>
	<bb6eae87-85b2-4bf2-ad36-26fa95816315@redhat.com>
	<9b392599-a318-90c5-daa8-89ade40c64e5@redhat.com>
	<20180104155640.6rznzu4koy354pyn@var.youpi.perso.aquilenet.fr>
	<4055e106-b24f-09b5-29cd-a4927ecad433@redhat.com>
	<20180104174545.5p2aaypp2asbdoxx@var.youpi.perso.aquilenet.fr>
	<d6e1a2a2-5246-c160-eb20-450d0598247c@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1984712a-3077-71e1-4ff9-d8d9a91bf164@redhat.com>
Date: Mon, 8 Jan 2018 08:43:29 +0100
MIME-Version: 1.0
In-Reply-To: <d6e1a2a2-5246-c160-eb20-450d0598247c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@gnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, kraxel@redhat.com, qemu-devel@nongnu.org

On 04.01.2018 18:57, Paolo Bonzini wrote:
> On 04/01/2018 18:45, Samuel Thibault wrote:
>> Paolo Bonzini, on jeu. 04 janv. 2018 18:11:00 +0100, wrote:
>>> On 04/01/2018 16:56, Samuel Thibault wrote:
>>>>> However, adding magic to "-device usb-braille" that creates both a
>>>>> front-end and a back-end is completely the opposite of sane...
>>>> Well, this is also what happens with -device usb-mouse, usb-kbd etc.=
:
>>>> they also plug with keyboard & mouse pipes of the qemu graphical
>>>> frontend. braille is just the same vein for the user.
>>>
>>> No, they don't create a new UI object magically that wasn't there
>>> before.  They just let you add a device, e.g. a USB tablet, that list=
ens
>>> on an _existing_ UI (GTK+ or SDL or similar).
>>
>> Technically for the qemu developper, yes.
>>
>> But for the user, no.
>=20
> That's not true.   With or without "-usbdevice tablet", you use the sam=
e
> mouse or keyboard device as the input source.

But from a users point of view: Why are the mouse and keyboard input
sources available out of the box, while braille has to be specified
manually? I think Samuel has a point here...

So just another idea: Instead of adding the magic sugar code to the
usb-braille device, we could also add some code to vl.c or somewhere
else that checks whether a braille guest device is available and then
wires it up automatically with a braille host device (unless
-no-defaults has been specified, or the user already set chardev=3D...
there). Would that make more sense in your eyes than to put this code
into the usb-braille device directly?

 Thomas
