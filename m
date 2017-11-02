Received: from eggs.gnu.org ([2001:4830:134:3::10]:50223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eANGC-0004bo-Nv
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eANG9-0003Fv-Kn
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:42:48 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:50211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eANG9-0003FF-FB
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:42:45 -0400
Received: by mail-io0-x242.google.com with SMTP id 97so2152781iok.7
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 14:42:45 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <alpine.BSF.2.21.1711021700510.67752@zero.eik.bme.hu>
Date: Thu, 2 Nov 2017 17:42:43 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1C61B38-D39D-4849-83AE-FA56D5F5B172@gmail.com>
References: <20171005145557.5746-1-programmingkidx@gmail.com>
	<20171005145557.5746-2-programmingkidx@gmail.com>
	<CAFEAcA83iZs0T-rM24QZn1ttAsXjuWfsehW86kJBt52Up1p1Hw@mail.gmail.com>
	<385E45E2-3BC6-4501-91B1-44CA43718947@gmail.com>
	<alpine.BSF.2.21.1711021700510.67752@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] ui/cocoa.m: move ungrab to
 ctrl-alt-g
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


> On Nov 2, 2017, at 12:06 PM, BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>=20
> On Thu, 2 Nov 2017, Programmingkid wrote:
>>> On Nov 2, 2017, at 5:10 AM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>>=20
>>> On 5 October 2017 at 15:55, John Arbuckle =
<programmingkidx@gmail.com> wrote:
>>>> Currently the cocoa user interface relys on the user pushing =
control-alt to ungrab the mouse. This is patch changes the key =
combination to control-alt-g to be in line with the GTK user interface.
>>>>=20
>>>> signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>>>> ---
>>>=20
>>>> +
>>>> +                    // release the mouse grab
>>>> +                    case Q_KEY_CODE_G:
>>>> +                        [self ungrabMouse];
>>>> +                        break;
>>>>                }
>>>=20
>>> Testing this I have found that it makes the grab key be
>>> "ctrl+alt+ the key labelled 'g'", even if in the
>>> OSX host keyboard mapping that key doesn't produce the
>>> letter 'g'. This is in contrast to for instance the menu
>>> accelerators which honour the host keyboard layout, and
>>> it's also not what the GTK UI does. So I think we need
>>> to fix that.
>>=20
>> I just realized that the cocoa interface does not consider the =
keyboard layout. Switching from QWERTY to DVORK I still see the same =
keys outputting the same characters in OpenBIOS. This is a separate =
patch but sometime to take note.
>=20
> Is it the cocoa interface or OpenBIOS?

It was with the cocoa interface.

> In case you are using an emulated USB keyboard, the very simple driver =
in OpenBIOS only has a US layout so this may be the reason (see =
openbios/drivers/usbhid.c). I'm not sure about ADB keyboards but you may =
want to try a few combinations to identify where the problem is before =
looking for it in QEMU's cocoa interface.

It looks like there is no problem with sending keys to the guest. The =
cocoa interface behaves as it should.=
