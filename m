Received: from eggs.gnu.org ([2001:4830:134:3::10]:47948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eX9lg-0004xN-U3
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:57:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eX9ld-0006MK-07
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:57:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eX9lc-0006Le-PW
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:57:24 -0500
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
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6e1a2a2-5246-c160-eb20-450d0598247c@redhat.com>
Date: Thu, 4 Jan 2018 18:57:18 +0100
MIME-Version: 1.0
In-Reply-To: <20180104174545.5p2aaypp2asbdoxx@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, kraxel@redhat.com, qemu-devel@nongnu.org

On 04/01/2018 18:45, Samuel Thibault wrote:
> Paolo Bonzini, on jeu. 04 janv. 2018 18:11:00 +0100, wrote:
>> On 04/01/2018 16:56, Samuel Thibault wrote:
>>>> However, adding magic to "-device usb-braille" that creates both a
>>>> front-end and a back-end is completely the opposite of sane...
>>> Well, this is also what happens with -device usb-mouse, usb-kbd etc.:
>>> they also plug with keyboard & mouse pipes of the qemu graphical
>>> frontend. braille is just the same vein for the user.
>>
>> No, they don't create a new UI object magically that wasn't there
>> before.  They just let you add a device, e.g. a USB tablet, that listens
>> on an _existing_ UI (GTK+ or SDL or similar).
> 
> Technically for the qemu developper, yes.
> 
> But for the user, no.

That's not true.   With or without "-usbdevice tablet", you use the same
mouse or keyboard device as the input source.

Paolo
