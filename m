Received: from eggs.gnu.org ([2001:4830:134:3::10]:43278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dV27U-0004Yh-Jj
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dV27Q-00011G-Ol
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:50:56 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dV27Q-00010u-HW
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:50:52 -0400
Received: by mail-wr0-f169.google.com with SMTP id r103so5550424wrb.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 13:50:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d9870097-46dc-40bf-49e9-7cf3276017f2@ilande.co.uk>
References: <1499803333-9052-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1499803333-9052-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170711201059.GA6020@localhost.localdomain>
	<20170711231709-mutt-send-email-mst@kernel.org>
	<d9870097-46dc-40bf-49e9-7cf3276017f2@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 21:49:30 +0100
Message-ID: <CAFEAcA_e6BjeLXdv=54yzqSvD_XdDKRiLYJeQS4NZY-Zr4vK4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCHv8 1/3] fw_cfg: switch fw_cfg_find() to
 locate the fw_cfg device by type rather than path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, "Gabriel L. Somlo" <somlo@cmu.edu>, Paolo Bonzini <pbonzini@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 11 July 2017 at 21:26, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 11/07/17 21:18, Michael S. Tsirkin wrote:
>
>> Multi-line comments also should formatted
>>
>> /*
>>  * like
>>  * this
>>  */
>>
>> not
>>
>> /* like
>>  * this */
>>
>
> Interesting, I never knew there was a preferred format for comments (I
> see both styles throughout the codebase).

It's basically GNU coding standard style vs Linux kernel style;
there's a mix because some contributors are more used to working
on the kernel, and some more used to working with gcc, glibc,
etc, and we haven't made a firm "comments must be like this"
statement (and of course historical practice in the codebase
is all over the place).

We also have both of the flavours the kernel style guide
documents:
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#commenting
(I usually use the style the kernel has for net/ personally.)

So I don't think that "we" the project have a preferred
format; but "we" individual contributors probably
have individual preferences ;-)

thanks
-- PMM
