Received: from eggs.gnu.org ([2001:4830:134:3::10]:60822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOjxg-0008CG-Vr
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 08:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dOjxg-0000Ap-5l
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 08:14:48 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dOjxf-0000Ae-V2
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 08:14:48 -0400
Received: by mail-wr0-x231.google.com with SMTP id 77so96810359wrb.1
	for <qemu-devel@nongnu.org>; Sat, 24 Jun 2017 05:14:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <04A047CA-48D8-4381-B08C-0A91B135D7D0@gmail.com>
References: <04A047CA-48D8-4381-B08C-0A91B135D7D0@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 24 Jun 2017 13:14:26 +0100
Message-ID: <CAFEAcA8pJWX+3bE7AGT6FJCnCJGpnZ-_UeG2cC3CfrFMH+Taww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Improve Cocoa modifier key handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Ian McKellar <ianloic@google.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 23 June 2017 at 21:05, Programmingkid <programmingkidx@gmail.com> wrote:
> This patch is incompatible with anything below Mac OS 10.10.

Oops. Thanks for the report.

> We support Mac OS 10.5 and up. I was able to make this patch work
> on Mac OS 10.6 by changing this line:
>
> NSEventModifierFlags modifiers = [event modifierFlags];
>
> to this:
>
> NSUInteger modifiers = [event modifierFlags];
>
> This wouldn't be enough. The [event modifierFlags] code would have to
> be replaced because the modifierFlags function is not available on
> Mac OS 10.5.

Do you still use 10.5? It's a decade old now, and I notice that
in the QEMU 2.5 changelog we actually said we were going to
remove 10.5 support. So one option would be to simply remove
10.5 support entirely, if nobody needs it any more.

thanks
-- PMM
