Received: from eggs.gnu.org ([2001:4830:134:3::10]:41419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBgP6-0008W8-U5
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBgP6-0003kT-72
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:53:40 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fBgP6-0003jp-0r
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:53:40 -0400
Received: by mail-oi0-x244.google.com with SMTP id v2-v6so10217189oif.3
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 05:53:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <63483ae4-5a07-d1fa-af76-bd1566563833@redhat.com>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-3-peter.maydell@linaro.org>
	<63483ae4-5a07-d1fa-af76-bd1566563833@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 13:53:18 +0100
Message-ID: <CAFEAcA8q-LjmSq5C0EERW4xPk_2eg9bLfqhoBV=voVz0YrfA8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/13] hw/arm/fsl-imx*: Don't create "null"
 chardevs for serial devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 25 April 2018 at 15:36, Thomas Huth <thuth@redhat.com> wrote:
> On 20.04.2018 16:52, Peter Maydell wrote:
>> Following commit 12051d82f004024, UART devices should handle
>> being passed a NULL pointer chardev, so we don't need to
>> create "null" backends in board code. Remove the code that
>> does this and updates serial_hds[].
>
> ... maybe drop the "updates serial_hds" in this patch description since
> serial_hds is not updated here?

It is in the fsl-imx6 case:

-                serial_hds[i] = chr;

thanks
-- PMM
