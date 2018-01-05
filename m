Received: from eggs.gnu.org ([2001:4830:134:3::10]:59005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXOCu-0002e9-5V
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 04:22:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eXOCq-0000mF-Vq
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 04:22:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eXOCq-0000ke-P9
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 04:22:28 -0500
References: <1515071752-22961-1-git-send-email-thuth@redhat.com>
	<20180104140930.7hbtnen3lw7epmrh@var.youpi.perso.aquilenet.fr>
	<a78b6f7a-3eb2-6749-ccba-ad1ba4d525ae@redhat.com>
	<20180104141524.m5xy66jsn2hiajwl@var.youpi.perso.aquilenet.fr>
	<20180104142101.rivje5qn5dasb6jw@var.youpi.perso.aquilenet.fr>
	<aea97804-c6a9-d903-13d8-23bc6b46af86@redhat.com>
	<87tvw0k9am.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f0cc3ad6-ecdc-20f8-ed62-423477417ec1@redhat.com>
Date: Fri, 5 Jan 2018 10:22:22 +0100
MIME-Version: 1.0
In-Reply-To: <87tvw0k9am.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Samuel Thibault <samuel.thibault@gnu.org>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, kraxel@redhat.com, qemu-devel@nongnu.org

On 05/01/2018 09:18, Markus Armbruster wrote:
>>> Would it be possible to make this automatic?  Before I could tell people
>>> "use -usbdevice braille to test braille", and now it would be
>>> "use -chardev braille,chardev=foobar -device usb-braille,chardev=foobar"
>> Maybe we can add "-braille" instead.  Something like this:
> More sugar, ugh!
> 
> What about giving braille property chardev a sensible default?
> Ideally in a self-documenting way, so that -device usb-braille,help
> shows the default.

That would mean automatically creating a back-end in a device's realize
property.  I'd rather avoid that, sugar is not bad per se.

Paolo
