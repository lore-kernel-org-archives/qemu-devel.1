Received: from eggs.gnu.org ([2001:4830:134:3::10]:36150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eAI0Y-0007f5-6i
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1eAI0U-00054r-Tv
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:06:18 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:51734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1eAI0U-00052o-Ja
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:06:14 -0400
Date: Thu, 2 Nov 2017 17:06:06 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <385E45E2-3BC6-4501-91B1-44CA43718947@gmail.com>
Message-ID: <alpine.BSF.2.21.1711021700510.67752@zero.eik.bme.hu>
References: <20171005145557.5746-1-programmingkidx@gmail.com>
	<20171005145557.5746-2-programmingkidx@gmail.com>
	<CAFEAcA83iZs0T-rM24QZn1ttAsXjuWfsehW86kJBt52Up1p1Hw@mail.gmail.com>
	<385E45E2-3BC6-4501-91B1-44CA43718947@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
To: Programmingkid <programmingkidx@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 2 Nov 2017, Programmingkid wrote:
>> On Nov 2, 2017, at 5:10 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On 5 October 2017 at 15:55, John Arbuckle <programmingkidx@gmail.com> wrote:
>>> Currently the cocoa user interface relys on the user pushing control-alt to ungrab the mouse. This is patch changes the key combination to control-alt-g to be in line with the GTK user interface.
>>>
>>> signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>>> ---
>>
>>> +
>>> +                    // release the mouse grab
>>> +                    case Q_KEY_CODE_G:
>>> +                        [self ungrabMouse];
>>> +                        break;
>>>                 }
>>
>> Testing this I have found that it makes the grab key be
>> "ctrl+alt+ the key labelled 'g'", even if in the
>> OSX host keyboard mapping that key doesn't produce the
>> letter 'g'. This is in contrast to for instance the menu
>> accelerators which honour the host keyboard layout, and
>> it's also not what the GTK UI does. So I think we need
>> to fix that.
>
> I just realized that the cocoa interface does not consider the keyboard 
> layout. Switching from QWERTY to DVORK I still see the same keys 
> outputting the same characters in OpenBIOS. This is a separate patch but 
> sometime to take note.

Is it the cocoa interface or OpenBIOS? In case you are using an emulated 
USB keyboard, the very simple driver in OpenBIOS only has a US layout so 
this may be the reason (see openbios/drivers/usbhid.c). I'm not sure about 
ADB keyboards but you may want to try a few combinations to identify where 
the problem is before looking for it in QEMU's cocoa interface.

Regards,
BALATON Zoltan
