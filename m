Received: from eggs.gnu.org ([2001:4830:134:3::10]:50124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eX7Wt-00067E-GT
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eX7Wq-0007mz-Le
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:34:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eX7Wq-0007m1-GN
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:34:00 -0500
References: <1515071752-22961-1-git-send-email-thuth@redhat.com>
	<20180104140930.7hbtnen3lw7epmrh@var.youpi.perso.aquilenet.fr>
	<a78b6f7a-3eb2-6749-ccba-ad1ba4d525ae@redhat.com>
	<20180104141524.m5xy66jsn2hiajwl@var.youpi.perso.aquilenet.fr>
	<20180104142101.rivje5qn5dasb6jw@var.youpi.perso.aquilenet.fr>
	<aea97804-c6a9-d903-13d8-23bc6b46af86@redhat.com>
	<20180104152402.fv52umjmlb2g22wc@var.youpi.perso.aquilenet.fr>
	<b1a86fed-8a98-cc1d-46ca-5462f8be3fc7@redhat.com>
	<20180104153219.wsxtkzuznu2iwra7@var.youpi.perso.aquilenet.fr>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <44b5fa49-3a0b-1bea-9770-e4d06ce1ae5b@redhat.com>
Date: Thu, 4 Jan 2018 16:33:55 +0100
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
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, kraxel@redhat.com, qemu-devel@nongnu.org

On 04/01/2018 16:32, Samuel Thibault wrote:
>>> And anyway we need to be able to specify either -serial braille or
>>> -device usb-braille.
>> So "-braille serial" and "-braille usb"?
> Well, why not, it just doesn't seem to me much simpler than
> "-serial braille" and "-device usb-braille" :)

The difference is that "-device usb-braille" would have magic character
backend creation in usb_braille_realize.  *That* is what I really frown
upon.

Paolo
