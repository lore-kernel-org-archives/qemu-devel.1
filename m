Received: from eggs.gnu.org ([2001:4830:134:3::10]:34090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX7f9-0005El-II
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX7f6-0001wG-Mb
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:42:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eX7f6-0001uD-ER
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 10:42:32 -0500
References: <1515071752-22961-1-git-send-email-thuth@redhat.com>
	<20180104140930.7hbtnen3lw7epmrh@var.youpi.perso.aquilenet.fr>
	<a78b6f7a-3eb2-6749-ccba-ad1ba4d525ae@redhat.com>
	<20180104141524.m5xy66jsn2hiajwl@var.youpi.perso.aquilenet.fr>
	<20180104142101.rivje5qn5dasb6jw@var.youpi.perso.aquilenet.fr>
	<aea97804-c6a9-d903-13d8-23bc6b46af86@redhat.com>
	<20180104152402.fv52umjmlb2g22wc@var.youpi.perso.aquilenet.fr>
	<b1a86fed-8a98-cc1d-46ca-5462f8be3fc7@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2289a88d-ee7a-d6e9-6dfd-8f92d5c599dd@redhat.com>
Date: Thu, 4 Jan 2018 16:42:18 +0100
MIME-Version: 1.0
In-Reply-To: <b1a86fed-8a98-cc1d-46ca-5462f8be3fc7@redhat.com>
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

On 04.01.2018 16:28, Paolo Bonzini wrote:
> On 04/01/2018 16:24, Samuel Thibault wrote:
>>> Maybe we can add "-braille" instead.
>> I guess such legacy-looking option would be frowned up :)
> 
> Not really.  As long as it doesn't propagate everywhere in device code,
> it's fine.  We are not going to deprecate "-serial mon:stdio", so...

Hmm, maybe we could also introduce a "-serial usb:braille" command that
automagically also creates an usb-braille device, to avoid to introduce
a new "-braille" command? It's bending the meaning of "-serial" quite a
bit, though...

 Thomas
