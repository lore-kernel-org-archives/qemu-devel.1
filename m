Received: from eggs.gnu.org ([2001:4830:134:3::10]:52916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEDkh-0003WA-P9
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:54:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEDkh-00013C-2g
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:54:27 -0400
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:38027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEDkg-000133-UL
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:54:27 -0400
Received: by mail-ot0-x236.google.com with SMTP id j27-v6so20462117ota.5
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 05:54:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEg67GkRTw=cXei3o9hvpxG_L4zSrNzR0bFyAgny+sSEUb_kPw@mail.gmail.com>
References: <CAEg67GkRTw=cXei3o9hvpxG_L4zSrNzR0bFyAgny+sSEUb_kPw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 13:54:05 +0100
Message-ID: <CAFEAcA-YvEo9WGrmLNAG8LoKhCmDT7WSvnamEEydT2qu+k5vuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/char/cmsdk-apb-uart.c: Accept more
 input after character read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Patrick Oppenlander <patrick.oppenlander@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 April 2018 at 00:50, Patrick Oppenlander
<patrick.oppenlander@gmail.com> wrote:
> The character frontend needs to be notified that the uart receive buffer
> is empty and ready to handle another character.
>
> Previously, the uart only worked correctly when receiving one character
> at a time.
>
> Signed-off-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>
> ---
>  hw/char/cmsdk-apb-uart.c | 1 +
>  1 file changed, 1 insertion(+)

Oops. Thanks for the patch, applied to target-arm.next.

-- PMM
