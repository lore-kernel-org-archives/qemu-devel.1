Received: from eggs.gnu.org ([2001:4830:134:3::10]:45961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dejDW-0004J5-7o
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dejDR-0007gk-Fc
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:41:14 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:37071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dejDR-0007fm-7i
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:41:09 -0400
Received: by mail-wr0-x233.google.com with SMTP id 33so2575040wrz.4
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 07:41:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170807163121.797e7ad6@nial.brq.redhat.com>
References: <20170807163121.797e7ad6@nial.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Aug 2017 15:40:47 +0100
Message-ID: <CAFEAcA8=+8cPjKayq3Bre7y9=6jzFgjCCjRkNUeHxArJu9Ue6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] AVMF & OVMF blobs in QEMU tree???
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Laszlo Ersek <lersek@redhat.com>

On 7 August 2017 at 15:31, Igor Mammedov <imammedo@redhat.com> wrote:
> As I recall there were issues with FAT driver licensing in edk2,
> but I've heard there were some changes in that regard.
>
> Is there any other reasons why we are not putting subj.
> in QEMU tree like we do with SeaBIOS and other roms?

I suspect the primary answer is "nobody who's willing to
maintain, test and update the resulting binary blobs has
stepped forward to say they want to do so" :-)

(I think that shipping them in the QEMU tree would be
nice but is principally a convenience for our direct
users, since distros are going to want to build their
own ROM blobs from source anyway.)

thanks
-- PMM
