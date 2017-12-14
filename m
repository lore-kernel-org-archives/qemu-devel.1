Received: from eggs.gnu.org ([2001:4830:134:3::10]:47085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePczT-0001MC-0q
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 18:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePczS-0005ea-6U
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 18:32:34 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:34918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePczS-0005eK-0K
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 18:32:34 -0500
Received: by mail-it0-x243.google.com with SMTP id f143so15028019itb.0
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 15:32:33 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAKmqyKPCfjm9Z6VBNBTKHeXdp4KLpbPWZT3UHmJj08bYNdp04Q@mail.gmail.com>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-13-f4bug@amsat.org>
	<CAKmqyKPCfjm9Z6VBNBTKHeXdp4KLpbPWZT3UHmJj08bYNdp04Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Dec 2017 20:32:32 -0300
Message-ID: <CAAdtpL5Ta2_N0ZQZ-jN3gFpTtuy5p-MoCHXh_SA=r2VwEGwiMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/14] sdhci: add a trace event for the LED
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Dec 14, 2017 at 2:55 PM, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
> <f4bug@amsat.org> wrote:
>> It blinks to caution the user not to remove the card while the SD card i=
s
>> being accessed.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> If you turn this on does it just fill the trace log?
>
> It seems like this will generate too much output if it happens on
> every LED blink.

You don't need to enable this trace event if you don't want it :)
It is supposed to turn ON previous to start write access, and then turn OFF=
.

Anyway you are right, I currently log it on each access while I should
just log the ON/OFF state changes, I'll fix this.
