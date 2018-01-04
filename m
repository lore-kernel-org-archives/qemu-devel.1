Received: from eggs.gnu.org ([2001:4830:134:3::10]:52325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX7YQ-000808-Ls
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:35:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX7YN-00018R-S8
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:35:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eX7YN-00016o-49
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:35:35 -0500
References: <1515071752-22961-1-git-send-email-thuth@redhat.com>
	<20180104140930.7hbtnen3lw7epmrh@var.youpi.perso.aquilenet.fr>
	<a78b6f7a-3eb2-6749-ccba-ad1ba4d525ae@redhat.com>
	<20180104141524.m5xy66jsn2hiajwl@var.youpi.perso.aquilenet.fr>
	<20180104142101.rivje5qn5dasb6jw@var.youpi.perso.aquilenet.fr>
	<aea97804-c6a9-d903-13d8-23bc6b46af86@redhat.com>
	<20180104152402.fv52umjmlb2g22wc@var.youpi.perso.aquilenet.fr>
	<b1a86fed-8a98-cc1d-46ca-5462f8be3fc7@redhat.com>
	<20180104153219.wsxtkzuznu2iwra7@var.youpi.perso.aquilenet.fr>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bb6eae87-85b2-4bf2-ad36-26fa95816315@redhat.com>
Date: Thu, 4 Jan 2018 16:35:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180104153219.wsxtkzuznu2iwra7@var.youpi.perso.aquilenet.fr>
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
To: Samuel Thibault <samuel.thibault@gnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kraxel@redhat.com, qemu-devel@nongnu.org

On 04.01.2018 16:32, Samuel Thibault wrote:
> Paolo Bonzini, on jeu. 04 janv. 2018 16:28:27 +0100, wrote:
>> On 04/01/2018 16:24, Samuel Thibault wrote:
>>>> Maybe we can add "-braille" instead.
>>> I guess such legacy-looking option would be frowned up :)
>>
>> Not really.  As long as it doesn't propagate everywhere in device code,
>> it's fine.  We are not going to deprecate "-serial mon:stdio", so...
>>
>>> And anyway we need to be able to specify either -serial braille or
>>> -device usb-braille.
>>
>> So "-braille serial" and "-braille usb"?
> 
> Well, why not, it just doesn't seem to me much simpler than
> "-serial braille" and "-device usb-braille" :)

FWIW, I think I'd also rather prefer to add some little bit of "magic"
to "-device usb-braille" instead of introducing yet another command line
parameter. QEMU's command line interface is already way too much
overcrowded, so IMHO we should try to avoid new parameters if possible.

 Thomas
