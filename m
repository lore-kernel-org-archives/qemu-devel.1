Received: from eggs.gnu.org ([2001:4830:134:3::10]:42210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eXNDW-0003xT-RU
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 03:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eXNDT-0004lQ-Iw
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 03:19:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eXNDT-0004hV-Cm
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 03:19:03 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1515071752-22961-1-git-send-email-thuth@redhat.com>
	<20180104140930.7hbtnen3lw7epmrh@var.youpi.perso.aquilenet.fr>
	<a78b6f7a-3eb2-6749-ccba-ad1ba4d525ae@redhat.com>
	<20180104141524.m5xy66jsn2hiajwl@var.youpi.perso.aquilenet.fr>
	<20180104142101.rivje5qn5dasb6jw@var.youpi.perso.aquilenet.fr>
	<aea97804-c6a9-d903-13d8-23bc6b46af86@redhat.com>
Date: Fri, 05 Jan 2018 09:18:57 +0100
In-Reply-To: <aea97804-c6a9-d903-13d8-23bc6b46af86@redhat.com> (Paolo
	Bonzini's message of "Thu, 4 Jan 2018 16:19:02 +0100")
Message-ID: <87tvw0k9am.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Samuel Thibault <samuel.thibault@gnu.org>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, kraxel@redhat.com, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 04/01/2018 15:21, Samuel Thibault wrote:
>> Samuel Thibault, on jeu. 04 janv. 2018 15:15:24 +0100, wrote:
>>> I'm however still unable to make usb-serial and usb-braille work, as
>>> mentioned in my other mail :)
>> 
>> Ah, now with the documentation I understand, one has to also pass
>> -chardev braille,chardev=foobar, and then
>> -device usb-braille,chardev=foobar works.
>> 
>> Would it be possible to make this automatic?  Before I could tell people
>> "use -usbdevice braille to test braille", and now it would be
>> "use -chardev braille,chardev=foobar -device usb-braille,chardev=foobar"
>
> Maybe we can add "-braille" instead.  Something like this:

More sugar, ugh!

What about giving braille property chardev a sensible default?
Ideally in a self-documenting way, so that -device usb-braille,help
shows the default.
