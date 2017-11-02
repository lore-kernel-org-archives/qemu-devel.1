Received: from eggs.gnu.org ([2001:4830:134:3::10]:52380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eAHIW-0001uQ-BY
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eAHIT-0006aD-60
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:20:48 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:48106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eAHIT-0006Yt-0l
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:20:45 -0400
Received: by mail-io0-x244.google.com with SMTP id h70so14796337ioi.4
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 08:20:44 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAFEAcA83iZs0T-rM24QZn1ttAsXjuWfsehW86kJBt52Up1p1Hw@mail.gmail.com>
Date: Thu, 2 Nov 2017 11:20:42 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <385E45E2-3BC6-4501-91B1-44CA43718947@gmail.com>
References: <20171005145557.5746-1-programmingkidx@gmail.com>
	<20171005145557.5746-2-programmingkidx@gmail.com>
	<CAFEAcA83iZs0T-rM24QZn1ttAsXjuWfsehW86kJBt52Up1p1Hw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


> On Nov 2, 2017, at 5:10 AM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On 5 October 2017 at 15:55, John Arbuckle <programmingkidx@gmail.com> =
wrote:
>> Currently the cocoa user interface relys on the user pushing =
control-alt to ungrab the mouse. This is patch changes the key =
combination to control-alt-g to be in line with the GTK user interface.
>>=20
>> signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>> ---
>=20
>> +
>> +                    // release the mouse grab
>> +                    case Q_KEY_CODE_G:
>> +                        [self ungrabMouse];
>> +                        break;
>>                 }
>=20
> Testing this I have found that it makes the grab key be
> "ctrl+alt+ the key labelled 'g'", even if in the
> OSX host keyboard mapping that key doesn't produce the
> letter 'g'. This is in contrast to for instance the menu
> accelerators which honour the host keyboard layout, and
> it's also not what the GTK UI does. So I think we need
> to fix that.

I just realized that the cocoa interface does not consider the keyboard =
layout. Switching from QWERTY to DVORK I still see the same keys =
outputting the same characters in OpenBIOS. This is a separate patch but =
sometime to take note.=20
