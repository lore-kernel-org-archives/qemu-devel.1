Received: from eggs.gnu.org ([2001:4830:134:3::10]:44030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eX4ig-0007SN-8Y
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 07:34:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eX4if-0007JQ-Cp
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 07:34:02 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:35970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eX4if-0007Ij-8G
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 07:34:01 -0500
Received: by mail-ot0-x230.google.com with SMTP id w4so1181619otg.3
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 04:34:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515068847-20311-1-git-send-email-thuth@redhat.com>
References: <1515068847-20311-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jan 2018 12:33:40 +0000
Message-ID: <CAFEAcA-7+woO3ByXgJntLzg+yJd6YDS-tZXqZFjiHEW3tbgMUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Paolo Bonzini <pbonzini@redhat.com>

On 4 January 2018 at 12:27, Thomas Huth <thuth@redhat.com> wrote:
> The option has been marked as deprecated since QEMU 2.10, and so far
> nobody complained that it is urgently required anymore. So let's now
> get rid of this legacy pile, to simplify the usb code quite a bit.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

The diffstat is nice, but can we retain the "please use
$NEWOPTION instead of $OLDOPTION" message for a bit?
I'm pretty sure there will be users out there who've
been happily ignoring deprecation notices, and I think
we'll reduce the amount of support traffic if they
get a new QEMU with a specific error message telling them
what they need to fix, rather than one which just prints
a generic "unknown option" message.

thanks
-- PMM
