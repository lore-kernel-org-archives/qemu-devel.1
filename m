Received: from eggs.gnu.org ([2001:4830:134:3::10]:43981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYsXl-0007Kk-Kq
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eYsXg-0001rT-PM
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:58:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eYsXg-0001qh-Gl
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:58:08 -0500
References: <1515071752-22961-1-git-send-email-thuth@redhat.com>
	<20180104140930.7hbtnen3lw7epmrh@var.youpi.perso.aquilenet.fr>
	<a78b6f7a-3eb2-6749-ccba-ad1ba4d525ae@redhat.com>
	<20180104141524.m5xy66jsn2hiajwl@var.youpi.perso.aquilenet.fr>
	<20180104142101.rivje5qn5dasb6jw@var.youpi.perso.aquilenet.fr>
	<aea97804-c6a9-d903-13d8-23bc6b46af86@redhat.com>
	<20180104152402.fv52umjmlb2g22wc@var.youpi.perso.aquilenet.fr>
	<b1a86fed-8a98-cc1d-46ca-5462f8be3fc7@redhat.com>
	<20180104153219.wsxtkzuznu2iwra7@var.youpi.perso.aquilenet.fr>
	<bb6eae87-85b2-4bf2-ad36-26fa95816315@redhat.com>
	<9b392599-a318-90c5-daa8-89ade40c64e5@redhat.com>
	<eba50062-de89-2091-8799-b6de3c88acaf@redhat.com>
	<64a364f0-3dc0-87c4-f0b0-a79365032a8e@redhat.com>
	<351493cf-fa56-491c-c646-49727e6611ed@redhat.com>
	<6900aa32-7774-366f-32a5-9e75b70350db@redhat.com>
	<b6a25497-5353-fe1f-6550-1479b5c4c1f4@redhat.com>
	<ff5a872c-9438-3fa9-6a65-9792c846b151@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <536d4bc3-8ad6-367e-5011-5e6fb9af1dec@redhat.com>
Date: Tue, 9 Jan 2018 12:57:58 +0100
MIME-Version: 1.0
In-Reply-To: <ff5a872c-9438-3fa9-6a65-9792c846b151@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Samuel Thibault <samuel.thibault@gnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, kraxel@redhat.com, qemu-devel@nongnu.org

On 09.01.2018 12:17, Paolo Bonzini wrote:
> On 09/01/2018 12:00, Thomas Huth wrote:
>> On 09.01.2018 10:58, Paolo Bonzini wrote:
>>> On 08/01/2018 08:23, Thomas Huth wrote:
>>>>>> But instead of introducing a new "-braille" parameter, maybe we should
>>>>>> rather keep some of the convenience "-usbdevice" possibilities around?
>>>>>> E.g. keep "-usbdevice braille", "-usbdevice mouse", etc. but remove
>>>>>> things like "-usbdevice serial" and "-usbdevice host" where the code is
>>>>>> rather ugly and the user do not gain much in comparison to "-device" ?
>>>>> That would work too.  But I'm not sure why keep all the usbdevice
>>>>> infrastructure when we can do the same (at the price of a small cmdline
>>>>> incompatibility) with only 50 lines of code.
>>>> I'm just afraid that we will end up with more new parameters in the end
>>>> than just "-braille" - or do we feel confident enough that "-usbdevice
>>>> braille" is the only one that would need a sugared replacement?
>>>
>>> I agree that we should plan for suboptions, so it could be "-braille
>>> [serial|usb]" for now.
>>
>> I'm rather afraid that someone else will also complain about the removal
>> of the other usbdevice options, so that we'll finally end up with new
>> -usbhost, -usbbt and -usbyounameit convenience options... in that case
>> it might be better to keep "-usbdevice" instead?
> 
> We can and should say no.  Sometimes we can also say yes though. :)
> 
> I just think that Braille is worth a special case because a subset of
> our user base (blind people) will use it 100% of the time, plus it is
> not supported by libvirt and hence virt-manager.

OK, then let's go forward and use your "-braille serial|usb" patch, and
nuke the -usbdevice option completely (assuming Gerd agrees, being the
USB maintainer).

 Thomas
